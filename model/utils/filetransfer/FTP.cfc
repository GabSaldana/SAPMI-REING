<cfcomponent>
	<cfproperty name="connection" type="any">
	<cfproperty name="server"   type="string">
	<cfproperty name="username" type="string">
	<cfproperty name="password" type="string">

	<cffunction name="hasConnect" access="public" returntype="boolean" hint="Metodo Inicial que conecta a Coldfusion al Server FTP">
		<cfreturn isdefined("this.connection")>
	</cffunction>

	<cffunction name="disconnect" access="public" returntype="boolean" hint="Metodo que desconecta a Coldfusion al Server FTP">
		<cftry>
			<cfftp action="close" connection="this.connection" stopOnError="Yes">
			<cfreturn true>
		<cfcatch type="any">
			<cfreturn false>
		</cfcatch>
		</cftry>
		<cfreturn true>
	</cffunction>

	<cffunction name="connect" access="public" returntype="boolean" hint="Metodo Inicial que conecta a Coldfusion al Server FTP">
		<cfargument name="prefijo" default="" required="false">
		<cftry>
			<cfobject action="create" type="java" class="edu.ipn.sectecnica.utils.Resources.Resources" name="resources">
			<cfscript>
				propertyServer = "";
				propertyUser = "";
				propertyPassword = "";
				resources.init();
				if(isDefined('prefijo')){
					propertyServer = prefijo & ".ftp.server";
					propertyUser = prefijo & ".ftp.username";
					propertyPassword = prefijo & ".ftp.password";
				}
				this.server   = resources.getProperty(propertyServer);
				this.username = resources.getProperty(propertyUser);
				this.password = resources.getProperty(propertyPassword);
			</cfscript>
			<cfftp action="open" connection="this.connection" server="#this.server#" username="#this.username#" password="#this.password#">
			<cfcatch type="any">
				<cfreturn false>
			</cfcatch>
		</cftry>
		<cfreturn true>
	</cffunction>

	<cffunction name="changeToFolder" access="public" hint="Metodo que me cambia de carpeta en el servidor FTP">
		<cfargument name="path" type="string">
		<cfscript>
			dirs = ListToArray(path, '\');
			i=1;
			for(i=1; i LTE arraylen(dirs) ; i = i +1){
				verifyFolder(dirs[i]);
			}
		</cfscript>
	</cffunction>

	<cffunction name="verifyFolder" access="public">
		<cfargument name="directory" type="string">
		<cfftp action="ExistsDir" connection="this.connection" directory="#directory#">
		<cfif cfftp.returnValue EQ "NO">
			<cfftp action="createDir" connection="this.connection" directory="#directory#">
		</cfif>
		<cfftp action="changedir" connection="this.connection" directory="#directory#">
		<cfftp connection="this.connection" action="getCurrentDir" >
	</cffunction>

	<cffunction name="uploadFile" access="public" returntype="string">
		<cfargument name="localPath" type="string">
		<cfargument name="filename" type="string">
		<cfargument name="extension" type="string">
		<cfset counter = 0 >
		<cfset endFile = "" >
		<cfloop condition="true">
			<cfftp action="existsFile" retrycount="5" connection="this.connection" remotefile="#filename##endFile#.#extension#">
			<cfif cfftp.ReturnValue EQ false>
				<cfftp action="putFile" retrycount="5" connection="this.connection" localfile="#localPath#\#filename#.#extension#" remotefile="#filename##endFile#.#extension#">
				<cfbreak>
			<cfelse>
				<cfset counter = counter + 1 >
				<cfset endFile = "(" & counter & ")">
			</cfif>
		</cfloop>
		<cfreturn "#filename##endFile#.#extension#">
	</cffunction>

	<cffunction name="downloadFile" access="public">
		<cfargument name="remotefile" type="string">
		<cfargument name="localfile" type="string">
		<cftry>
			<cfftp action="getFile" connection="this.connection" remotefile="#remotefile#" localfile="#localfile#" retrycount="5" failIfExists="no">
			<cfcatch type="any">
				<cflog text="Repositorio.filetransfer.FTP :: downloadFile :: Error al cargar el archivo del ftp #cfcatch.Message#">
			</cfcatch>
		</cftry>
	</cffunction>

	<cffunction name="deleteFile" access="public">
		<cfargument name="remotefile" type="string">
		<cfftp action="existsFile" retrycount="5" connection="this.connection" remotefile="#remotefile#">
		<cfif cfftp.ReturnValue EQ false>
			<cfreturn false>
		<cfelse>
			<cfftp action="Remove" connection="this.connection" retrycount="5" item="#remotefile#" >
		</cfif>
		<cfreturn true>
	</cffunction>

	<cffunction name="validateExistFile" access="public" returntype="string">
		<cfargument name="filename" type="string">
		<cfargument name="extension" type="string">
		<cfftp action="existsFile" retrycount="5" connection="this.connection" remotefile="#filename#.#extension#">
		<cfreturn cfftp.ReturnValue>
	</cffunction>
</cfcomponent>
