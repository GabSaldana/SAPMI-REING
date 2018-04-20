<cfcomponent output="false" singleton>

	<!--- Default Action --->
	<cffunction name="index" returntype="void" output="false" hint="Evento que se ejecuta por default al iniciar la aplicacion">
		<cfargument name="event">
		<cfset event.setView("login").noLayout()>
		<!--- <cfset event.setView("avisoMantenimiento").noLayout()> --->
	</cffunction> 

<!------------------------------------------- GLOBAL IMPLICIT EVENTS ONLY ------------------------------------------>
<!--- In order for these events to fire, you must declare them in the ColdBox.cfc --->
		
	<cffunction name="onAppInit" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
	</cffunction>

	<cffunction name="onRequestStart" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>

			if((rc.event EQ "adminCSII.autoRegistro.autoRegistro.index")){

				setNextEvent("adminCSII.autoRegistro.autoRegistro.registrar","");

			}else if((rc.event EQ "adminCSII.usuarios.usuarios.getEmail") OR (rc.event EQ "adminCSII.usuarios.usuarios.recuperarPwd") 
					OR (rc.event EQ "adminCSII.autoRegistro.autoRegistro.registrar") OR (rc.event EQ "adminCSII.autoRegistro.autoRegistro.getOferta") OR (rc.event EQ "adminCSII.autoRegistro.autoRegistro.registraParticipante") OR (rc.event EQ "adminCSII.autoRegistro.autoRegistro.getCaptcha")
					OR (rc.event EQ "CVU.registro.investigadorSinNumEmpleado") OR (rc.event EQ "CVU.registro.investigadorNumEmpleado") OR (rc.event EQ "CVU.registro.getUrByFechaClasif") OR (rc.event EQ "CVU.registro.obtenerDireccion") OR (rc.event EQ "CVU.registro.guardarInvestigadorNumEmpleado") OR (rc.event EQ "CVU.registro.guardarInvestigadorSinNumEmpleado")
					OR (rc.event EQ "ws.investigador.index")){		
			}
			else if((NOT isDefined("Session.cbstorage") OR isDefined("Session.cbstorage") 
					AND StructIsEmpty(Session.cbstorage))
				AND (rc.event NEQ "main.index" AND rc.event NEQ "login.autenticacion")){
					
					setNextEvent("main.index","");
						
			}else{
				if(IsDefined("session.cbstorage.usuario") AND NOT StructIsEmpty(session.cbstorage)){
					var MonitoreoID = getPlugin('SessionStorage').getVar('pkMonitoreo');
					if(NOT StructKeyExists(session.cbstorage,"pkMonitoreo") AND (MonitoreoID EQ 0 OR MonitoreoID EQ "")){
						var datosSistema = ArrayNew(1);
						
						var structInformacion				= StructNew();
							structInformacion.cadena		= CGI.HTTP_USER_AGENT;
							structInformacion.subcadena		= "Win";
							structInformacion.identificacion= "Windows";
						ArrayAppend(datosSistema, structInformacion);
						
						var structInformacion				= StructNew();
							structInformacion.cadena		= CGI.HTTP_USER_AGENT;
							structInformacion.subcadena		= "Mac";
							structInformacion.identificacion= "Mac";
						ArrayAppend(datosSistema, structInformacion);
						
						var structInformacion				= StructNew();
							structInformacion.cadena		= CGI.HTTP_USER_AGENT;
							structInformacion.subcadena		= "iPhone";
							structInformacion.identificacion= "iPhone/iPod";
						ArrayAppend(datosSistema, structInformacion);
						
						var structInformacion				= StructNew();
							structInformacion.cadena		= CGI.HTTP_USER_AGENT;
							structInformacion.subcadena		= "Linux";
							structInformacion.identificacion= "Linux";
						ArrayAppend(datosSistema, structInformacion);
						
						var datosNavegador = ArrayNew(1);
						
						var informacionStruct = StructNew();
							informacionStruct.cadena			= CGI.HTTP_USER_AGENT;
							informacionStruct.subcadena			= "Chrome";
							informacionStruct.identificacion	= "Chrome";
							informacionStruct.version			= "Chrome/";
							ArrayAppend(datosNavegador,informacionStruct);
							
						var informacionStruct = StructNew();
							informacionStruct.cadena			= CGI.HTTP_USER_AGENT;
							informacionStruct.subcadena			= "OmniWeb";
							informacionStruct.identificacion	= "OmniWeb";
							informacionStruct.version			= "OmniWeb/";
							ArrayAppend(datosNavegador,informacionStruct);
							
						var informacionStruct = StructNew();
							informacionStruct.cadena			= CGI.HTTP_USER_AGENT;
							informacionStruct.subcadena			= "Apple";
							informacionStruct.identificacion	= "Safari";
							informacionStruct.version			= "Version";
							ArrayAppend(datosNavegador,informacionStruct);
							
						var informacionStruct = StructNew();
							informacionStruct.cadena			= CGI.HTTP_USER_AGENT;
							informacionStruct.subcadena			= "iCab";
							informacionStruct.identificacion	= "iCab";
							informacionStruct.version			= "";
							ArrayAppend(datosNavegador,informacionStruct);
							
						var informacionStruct = StructNew();
							informacionStruct.cadena			= CGI.HTTP_USER_AGENT;
							informacionStruct.subcadena			= "KDE";
							informacionStruct.identificacion	= "Konqueror";
							informacionStruct.version			= "";
							ArrayAppend(datosNavegador,informacionStruct);
							
						var informacionStruct = StructNew();
							informacionStruct.cadena			= CGI.HTTP_USER_AGENT;
							informacionStruct.subcadena			= "Firefox";
							informacionStruct.identificacion	= "Firefox";
							informacionStruct.version			= "Firefox/";
							ArrayAppend(datosNavegador,informacionStruct);
							
						var informacionStruct = StructNew();
							informacionStruct.cadena			= CGI.HTTP_USER_AGENT;
							informacionStruct.subcadena			= "Camino";
							informacionStruct.identificacion	= "Camino";
							informacionStruct.version			= "";
							ArrayAppend(datosNavegador,informacionStruct);
							
						var informacionStruct = StructNew();
							informacionStruct.cadena			= CGI.HTTP_USER_AGENT;
							informacionStruct.subcadena			= "Netscape";
							informacionStruct.identificacion	= "Netscape";
							informacionStruct.version			= "";
							ArrayAppend(datosNavegador,informacionStruct);
							
						var informacionStruct = StructNew();
							informacionStruct.cadena			= CGI.HTTP_USER_AGENT;
							informacionStruct.subcadena			= "MSIE";
							informacionStruct.identificacion	= "Internet Explorer";
							informacionStruct.version			= "MSIE ";
							ArrayAppend(datosNavegador,informacionStruct);
							
						var informacionStruct = StructNew();
							informacionStruct.cadena			= CGI.HTTP_USER_AGENT;
							informacionStruct.subcadena			= "Gecko";
							informacionStruct.identificacion	= "Mozilla";
							informacionStruct.version			= "rv";
							ArrayAppend(datosNavegador,informacionStruct);
							
						var informacionStruct = StructNew();
							informacionStruct.cadena			= CGI.HTTP_USER_AGENT;
							informacionStruct.subcadena			= "Mozilla";
							informacionStruct.identificacion	= "Netscape";
							informacionStruct.version			= "Mozilla";
							ArrayAppend(datosNavegador,informacionStruct);
						
						var pkUsuario		= session.cbstorage.usuario.PK;
						cn					= CreateObject("component","model.adminCSII.interceptors.CN_Monitoreo");
						var ip_host			= cgi.REMOTE_ADDR & "/" & cgi.REMOTE_HOST;
						var navegador		= this.buscarCadena(datosNavegador) & " ver. " & this.versionNavegador(datosNavegador, CGI.HTTP_USER_AGENT);
						var idioma			= ListToArray(cgi.HTTP_ACCEPT_LANGUAGE,';');
						system				= CreateObject("java", "java.lang.System");
						var plataforma		= this.buscarCadena(datosSistema);
						var version			= this.versionSistema(CGI.HTTP_USER_AGENT);
						var arquitectura	= system.getProperty("os.arch");
						pkMonitoreo			= cn.registraAccesoUsuario(pkUsuario, ip_host, navegador, idioma[1], plataforma, version, arquitectura);
						
						getPlugin("SessionStorage").setVar("pkMonitoreo",pkMonitoreo);
					}
					
					if(MonitoreoID GT 0){
						if(cgi.CONTENT_LENGTH NEQ "" AND cgi.CONTENT_LENGTH GT 0){
							if(IsStruct(form)){
								var parametros = "";
								var separador = "";
								for(k in form) {
									if(IsSimpleValue(form[ k ]) AND form[ k ] NEQ ""){
										if(Trim(k) NEQ "FIELDNAMES"){
											if(Trim(k) EQ "INPUTPASSWORD"){
												parametros &= separador & Trim(k) &"=[****************]";
											}else{
												parametros &= separador & Trim(k) &"=["& Trim(htmlEditFormat( form[ k ] )) &"]";
											}
											separador = ",";
										}
									}
								}
								cn	= CreateObject("component","model.adminCSII.interceptors.CN_Monitoreo");
								pkAccion = cn.registraAccionesUsuario(MonitoreoID, cgi.REQUEST_METHOD, cgi.CONTENT_TYPE, cgi.HTTP_REFERER, cgi.PATH_INFO, parametros );
							}
						}
					}
				}
			}
			
			
						
		</cfscript>
	</cffunction>

	<cffunction name="onRequestEnd" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
	</cffunction>
	
	<cffunction name="onSessionStart" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
	</cffunction>
	
	<cffunction name="onSessionEnd" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
		<cfset var sessionScope = event.getValue("sessionReference")>
		<cfset var applicationScope = event.getValue("applicationReference")>
		
	</cffunction>

	<cffunction name="onException" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		
		<cfscript>
			//Grab Exception From request collection, placed by ColdBox
			var exceptionBean = event.getValue("ExceptionBean");
			//Place exception handler below:

		</cfscript>
	</cffunction>
	
	<cffunction name="onMissingTemplate" returntype="void" output="false">
		<cfargument name="event">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfscript>
			//Grab missingTemplate From request collection, placed by ColdBox
			var missingTemplate = event.getValue("missingTemplate");
			
		</cfscript>
	</cffunction>
	
	<!---
	* Descripción : Funcion que detecta el tipo de navegador / sistema operativo
	* Fecha : Junio 01, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="buscarCadena" hint="">
		<cfargument name="navegador" type="array" required="yes" hint="">
		<cfscript>
			for (var b = 1; b LTE ArrayLen(navegador); b++) {
				var c = "";
				if(StructKeyExists(navegador[b], "cadena")){
					c = navegador[b].cadena;
				}
				var cadenaVersion = "";
				if(StructKeyExists(navegador[b], "version") AND navegador[b].version NEQ ""){
					cadenaVersion = navegador[b].version;
				}else{
					if(StructKeyExists(navegador[b],"identificacion") AND navegador[b].identificacion NEQ ""){
						cadenaVersion = navegador[b].identificacion;
					}
				}
				
				if (c NEQ "") {
					if (c.indexOf(navegador[b].subcadena) NEQ -1){
						return navegador[b].identificacion;
					}
				}
			}
			return "";
		</cfscript>
	</cffunction>
	
	<!---
	* Descripción : Funcion que detecta la version del navegador
	* Fecha : Junio 01, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="versionNavegador" hint="">
		<cfargument name="navegador" type="array" required="yes" hint="">
		<cfargument name="a" type="string" required="yes" hint="">
		<cfscript>
			for (var b = 1; b LTE ArrayLen(navegador); b++) {
				var c = "";
				if(StructKeyExists(navegador[b], "cadena")){
					c = navegador[b].cadena;
				}
				var cadenaVersion = "";
				if(StructKeyExists(navegador[b], "version") AND navegador[b].version NEQ ""){
					cadenaVersion = navegador[b].version;
				}else{
					if(StructKeyExists(navegador[b],"identificacion") AND navegador[b].identificacion NEQ ""){
						cadenaVersion = navegador[b].identificacion;
					}
				}
				
				if (c NEQ "") {
					if (c.indexOf(navegador[b].subcadena) NEQ -1){
						var bv = a.indexOf(cadenaVersion);
						if (bv EQ -1) return "";
						var version = Mid(a,bv + Len(cadenaVersion) + 1,Len(cadenaVersion));
						if(Len(version) GT 2 AND IsArray(version)){
							return Replace(Replace(version[1],"/",""),";","");
						}else{
							return Replace(Replace(version,"/",""),";","");
						}
					}
				}
			}
		</cfscript>
	</cffunction>
	
	<!---
	* Descripción : Funcion que detecta la version del SO
	* Fecha : Junio 02, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="versionSistema" hint="">
		<cfargument name="agente" type="string" required="yes" hint="">
		<cfscript>
			var versionOS = '';
			
			if (agente.indexOf("Windows NT 10.0") NEQ -1){
				versionOS = "NT 10.0 / 10";
			}
			if (agente.indexOf("Windows NT 6.3") NEQ -1){
				versionOS = "NT 6.3 / 8.1";
			}
			if (agente.indexOf("Windows NT 6.2") NEQ -1){
				versionOS = "NT 6.2 / 8";
			}
			if (agente.indexOf("Windows NT 6.1") NEQ -1){
				versionOS = "NT 6.1 / 7";
			}
			if (agente.indexOf("Windows NT 6.0") NEQ -1){
				versionOS = "NT 6.0 / Vista";
			}
			if (agente.indexOf("Windows NT 5.1") NEQ -1){
				versionOS = "NT 5.1 / XP";
			}
			if (agente.indexOf("Windows NT 5.0") NEQ -1){
				versionOS = "NT 5.0 / 2000";
			}
			if (agente.indexOf("Intel Mac OS X 10_7_3") NEQ -1 OR agente.indexOf("Intel Mac OS X 10.7") NEQ -1){
				versionOS = "10.7";
			}
			if (agente.indexOf("Intel Mac OS X 10_5_6") NEQ -1 OR agente.indexOf("Intel Mac OS X 10.5") NEQ -1){
				versionOS = "10.5";
			}
			if (agente.indexOf("iPhone OS 4_1") NEQ -1){
				versionOS = "4.1";
			}
			return versionOS;
		</cfscript>
	</cffunction>

</cfcomponent>