<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author 	    :	Luis Majano
Date        :	January 18, 2007
Description :
	This service takes cares of exceptions

Modification History:
01/18/2007 - Created
----------------------------------------------------------------------->
<cfcomponent output="false" hint="The ColdBox exception service" extends="coldbox.system.web.services.BaseService">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

	<cffunction name="init" access="public" output="false" returntype="ExceptionService" hint="Constructor">
		<cfargument name="controller" type="any" required="true">
		<cfscript>
			setController(arguments.controller);
			return this;
		</cfscript>
	</cffunction>

<!------------------------------------------- PUBLIC ------------------------------------------->

	<!--- exception handler --->
	<cffunction name="exceptionHandler" access="public" hint="I handle a framework/application exception. I return a framework exception bean" returntype="any" output="false" colddoc:generic="coldbox.system.web.context.ExceptionBean">
		<!--- ************************************************************* --->
		<cfargument name="exception" 	 type="any"  	required="true"  hint="The exception structure. Passed as any due to CF glitch">
		<cfargument name="errorType" 	 type="string" 	required="false" default="application">
		<cfargument name="extraMessage"  type="string"  required="false" default="">
		<!--- ************************************************************* --->
		<cfscript>
		var bugReport 		= "";
		var exceptionBean 	= createObject("component","coldbox.system.web.context.ExceptionBean").init(errorStruct=arguments.exception,extramessage=arguments.extraMessage,errorType=arguments.errorType);
		var requestContext 	= controller.getRequestService().getContext();
		var appLogger 		= controller.getPlugin("Logger");
		
		// Test Error Type
		if ( not reFindnocase("(application|framework|coldboxproxy)",arguments.errorType) ){
			arguments.errorType = "application";
		}
		
		//Run custom Exception handler if Found, else run default exception routines
		if ( len(controller.getSetting("ExceptionHandler")) ){
			try{
				requestContext.setValue("exceptionBean",exceptionBean);
				controller.runEvent(controller.getSetting("Exceptionhandler"));
			}
			catch(Any e){
				// Log Original Error First
				appLogger.logErrorWithBean(exceptionBean);
				// Create new exception bean
				exceptionBean = createObject("component","coldbox.system.web.context.ExceptionBean").init(errorStruct=e,extramessage="Error Running Custom Exception handler",errorType="application");
				// Log it
				appLogger.logErrorWithBean(exceptionBean);
			}
		}
		else{
			// Log Error only
			appLogger.logErrorWithBean(exceptionBean);	
		}
		
		return exceptionBean;
		</cfscript>
	</cffunction>

	<!--- Render a Bug Report --->
	<cffunction name="renderBugReport" access="public" hint="Render a Bug Report." output="false" returntype="string">
		<!--- ************************************************************* --->
		<cfargument name="exceptionBean" type="any" required="true">
		<!--- ************************************************************* --->
		<cfset var cboxBugReport 	= "">
		<cfset var exception 		= arguments.exceptionBean>
		<cfset var event 			= controller.getRequestService().getContext()>
		<cfset var appLocPrefix				= "/">
		<cfset var bugReportTemplatePath	= "">
		<cfset var CustomErrorTemplate		= controller.getSetting("CustomErrorTemplate")>
		
		<!---	Se guarda la informacion de la excepcion en una estructura	--->
		<!---	{{		INICIO			--->
		<cfif application.cbbootstrap.DEBUGGING_FILE EQ 0 OR application.cbbootstrap.DEBUGGING_FILE EQ 1>
			<cfset sessionScopeExists = true>
			<cftry>
				<cfset StructKeyExists(session ,'x')>
				<cfcatch type="any">
					<cfset sessionScopeExists = false>
				</cfcatch>
			</cftry>
			<cfset cn	= CreateObject("component","model.AdminCSII.error.CN_Error")>
			<cfset ERROR_TYPE = exception.gettype() & IIf(exception.geterrorCode() EQ "",DE(""),DE(":" & HTMLEditFormat(exception.getErrorCode())))>
			<cfset ERROR_NAME = "">
			<cfset EXCEPTIONS = StructNew()>
			
			<cfif IsStruct(exception.getexceptionStruct()) >
				<cfset ERROR_NAME = exception.getmessage()>
			</cfif>
			
			<cfset EXCEPTIONS.TAG_CONTEXT = exception.getTagContext()>
			<cfset APPLICATION_ERROR = StructNew()>
			
			<cfif exception.getErrorType() eq "Application">
				<cfset APPLICATION_ERROR.CURRENT_EVENT = IIf(Event.getCurrentEvent() NEQ "",DE(Event.getCurrentEvent()),DE('N/A'))>
				<cfset APPLICATION_ERROR.CURRENT_LAYOUT = IIf(Event.getCurrentLayout() NEQ "",DE(Event.getCurrentLayout()),DE('N/A'))>
				<cfset APPLICATION_ERROR.CURRENT_VIEW = IIf(Event.getCurrentView() NEQ "",DE(Event.getCurrentView()),DE('N/A'))>
			</cfif>
			
			<cfset APPLICATION_ERROR.BUG_DATE = DateFormat(Now(), "MM/DD/YYYY") & " " & TimeFormat(Now(),"hh:MM:SS TT")>
			<cfset STRUCT_CF = StructNew()>
			
			<cfif sessionScopeExists>
				<cfset STRUCT_CF.SESSION = ''>
				<cfif IsDefined("session") AND StructKeyExists(session, "cfid")>
					<cfset STRUCT_CF.CFID = session.CFID>
				<cfelseif IsDefined("client") AND StructKeyExists(client,"cfid")>
					<cfset STRUCT_CF.CFID = client.CFID>
				</cfif>
				<cfif IsDefined("session") AND StructKeyExists(session,"CFToken")>
					<cfset STRUCT_CF.CFTOKEN = session.CFToken>
				<cfelseif IsDefined("client") AND StructKeyExists(client,"CFToken")>
					<cfset STRUCT_CF.CFTOKEN = client.CFToken>
				</cfif>
				<cfif isDefined("session") and structkeyExists(session,"sessionID")>
					<cfset STRUCT_CF.JSESSIONID = session.sessionID>
				</cfif>
			<cfelse>
				<cfset STRUCT_CF.SESSION = 'Session Scope Not Enabled'>
			</cfif>
			
			<cfset APPLICATION_ERROR.COLDFUSION_ID = STRUCT_CF>
			<cfset APPLICATION_ERROR.TEMPLATE_PATH = HTMLEditFormat(CGI.CF_TEMPLATE_PATH)>
			<cfset APPLICATION_ERROR.PATH_INFO = HTMLEditFormat(CGI.PATH_INFO)>
			<cfset APPLICATION_ERROR.HOST_SERVER = HTMLEditFormat(cgi.http_host) & " " & controller.getPlugin("JVMUtils").getInetHost()>
			<cfset APPLICATION_ERROR.QUERY_STRING = HTMLEditFormat(cgi.QUERY_STRING)>
			<cfif Len(cgi.HTTP_REFERER)>
				<cfset APPLICATION_ERROR.REFERRER = HTMLEditFormat(cgi.HTTP_REFERER)>
			</cfif>
			<cfset APPLICATION_ERROR.BROWSER = HTMLEditFormat(cgi.HTTP_USER_AGENT)>
			<cfset APPLICATION_ERROR.REMOTE_ADDRESS = HTMLEditFormat(cgi.remote_addr)>
			
			<cfif IsStruct(exception.getexceptionStruct())>
				<cfif exception.getmissingFileName() NEQ  "">
					<cfset APPLICATION_ERROR.MISSING_FILE = HTMLEditFormat(exception.getmissingFileName())>
				</cfif>
				
				<cfif FindNoCase("database", exception.getType())>
					<cfset APPLICATION_ERROR.DATABASE_INFORMATION = StructNew()>
					<cfset APPLICATION_ERROR.DATABASE_INFORMATION.NATIVEERRORCODE = HTMLEditFormat(JavaCast("String",exception.getNativeErrorCode()))>
					<cfset APPLICATION_ERROR.DATABASE_INFORMATION.SQL_STATE = HTMLEditFormat(exception.getSQLState())>
					<cfset APPLICATION_ERROR.DATABASE_INFORMATION.SQL_SENT = HTMLEditFormat(exception.getSQL())>
					<cfset APPLICATION_ERROR.DATABASE_INFORMATION.DRIVER_ERROR_MSG = HTMLEditFormat(exception.getqueryError())>
					<cfset APPLICATION_ERROR.DATABASE_INFORMATION.NAME_VALUE_PAIRS = HTMLEditFormat(exception.getWhere())>
				</cfif>
			</cfif>
			
			<cfset EXCEPTIONS.FORM_VARS = form>
			
			<cfset session_usuario = ''>
	 		<cfset sessioncbstorage = controller.getPlugin('SessionStorage').getStorage()>
			<cfloop collection="#sessioncbstorage#" item="key">
				<cfif key EQ 'usuario'>
					<cfset session_usuario = sessioncbstorage[ key ]>
				</cfif>
			</cfloop>
			<cfset EXCEPTIONS.SESSION_STORAGE = session_usuario>
			<cfset EXCEPTIONS.EXTRA_INFO = exception.getExtraInfo()>
			<cfset EXCEPTIONS.APPLICATION =  APPLICATION_ERROR>
			<cfset EXCEPTIONS.STACK_TRACE =  ListToArray(Trim(HTMLEditFormat(exception.getstackTrace())),"	")>
			<cfset jsonException = SerializeJSON(EXCEPTIONS,true)>
			
			<cfif IsJSON(jsonException)>
				<cfif StructKeyExists(session.cbstorage, "usuario")>
					<cfset pkSeguimiento = cn.guardaError( ERROR_TYPE, jsonException, session.cbstorage.usuario.PK, ERROR_NAME)>
				<cfelse>
					<cfset pkSeguimiento = cn.guardaError( ERROR_TYPE, jsonException, 1, ERROR_NAME)>
				</cfif>
			<cfelse>
				<cflog text="No se pudo guardar la información...">
				<cfset pkSeguimiento = 0>
			</cfif>
		</cfif>
		<!---			FIN		}}	--->
		
		<!--- test for custom bug report --->
		<cfif Exception.getErrortype() eq "application" and CustomErrorTemplate neq "">
			<cftry>
					
				<!--- App location prefix --->
				<cfif len(controller.getSetting('AppMapping')) >
						<cfset appLocPrefix = appLocPrefix & controller.getSetting('AppMapping') & "/">
				</cfif>
		
				<!--- Setup the bugReport template Path for relative location first. --->
				<cfset bugReportTemplatePath = appLocPrefix & reReplace(CustomErrorTemplate,"^/","")>
					<cfif NOT fileExists(expandPath(bugReportTemplatePath))>
						<!--- Assume absolute location as not found inside our app --->
						<cfset bugReportTemplatePath = CustomErrorTemplate>
						<cfif NOT fileExists(expandPath(bugReportTemplatePath))>
							<cfthrow message="CustomErrorTemplate cannot be found.  #expandPath(bugReportTemplatePath)#">
						</cfif>
					</cfif>

				<!--- Place exception in the requset Collection --->
				<cfset event.setvalue("exceptionBean",Exception)>
				<!--- Save the Custom Report --->
				<cfsavecontent variable="cboxBugReport"><cfinclude template="#bugReportTemplatePath#"></cfsavecontent>
				<cfcatch type="any">
					<cfset exception = ExceptionHandler(cfcatch,"Application","Error creating custom error template.")>
					<!--- Save the Bug Report --->
					<cfsavecontent variable="cboxBugReport">
						<cfif application.cbbootstrap.DEBUGGING_FILE GT 0>
							<cfset prc.pkSeguimiento = pkSeguimiento>
							<cfinclude template="/views/error/Alerta.cfm">
						<cfelse>
							<cfinclude template="/coldbox/system/includes/BugReport.cfm">
						</cfif>
					</cfsavecontent>
				</cfcatch>
			</cftry>
		<cfelse>
			<!--- Save the Bug Report --->
			<cfsavecontent variable="cboxBugReport">
				<cfif application.cbbootstrap.DEBUGGING_FILE GT 0>
					<cfset prc.pkSeguimiento = pkSeguimiento>
					<cfinclude template="/views/error/Alerta.cfm">
				<cfelse>
					<cfinclude template="/coldbox/system/includes/BugReport.cfm">
				</cfif>
			</cfsavecontent>
		</cfif>
		<cfreturn cboxBugReport>
	</cffunction>
		
<!------------------------------------------- PRIVATE ------------------------------------------->


</cfcomponent>