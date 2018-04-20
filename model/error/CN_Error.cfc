<!---
* =========================================================================
* IPN - CSII
* Sistema: SIPIFIFE
* Modulo: ERROR
* Fecha: 30 de Marzo de 2015
* Descripcion: Componente de Negocio
* Autor: Sergio Eduardo Cuevas Olivares
* =========================================================================
--->

<cfcomponent>
	
	<cfscript>
		DAO =  CreateObject( 'component' , 'DAO_Error');
	</cfscript>
	
	<!---
	* Modificacion : - Se agrega el argumento mensajeError
	* Fecha mod : Abril 22, 2015
	* Autor mod : Sergio E. Cuevas Olivares
	----------------------------------------
	* Fecha : Marzo 30, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="guardaError" access="public">
		<cfargument name="claveError"	type="string"	required="yes" hint="">
		<cfargument name="descripcion"	type="string"	required="yes" hint="">
		<cfargument name="fkusuario"	type="string"	required="yes" hint="">
		<cfargument name="mensajeError" type="string"	required="yes" hint="">
		<cfscript>
			resultado = DAO.guardaError(claveError, descripcion, fkusuario, mensajeError);
			if(resultado GT 0){
				return DAO.getPkErrorByDescripcion(claveError, descripcion).PK_SEGUIMIENTO[1];
			}
		</cfscript>
	</cffunction>
	
	<!---
	* modificacion : Se agregan los parametros para reducir la cantidad de registros a obtener
	* Fecha mod : Junio 06, 2015
	* Autor mod : Sergio E. Cuevas Olivares
	-----------------------------------------
	* Fecha : Abril 14, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="getErroresRegistrados" access="public" hint="">
		<cfargument name="numeroPagina"		type="numeric" required="yes" hint="">
		<cfargument name="tipoError"		type="string" required="no" default="" hint="">
		<cfargument name="ur"				type="string" required="no" default="" hint="">
		<cfargument name="fechaIni"			type="string" required="no" default="" hint="">
		<cfargument name="fechaFin"			type="string" required="no" default="" hint="">
		<cfscript>
			return DAO.getErroresRegistrados(arguments.numeroPagina, arguments.tipoError, arguments.ur, arguments.fechaIni, arguments.fechaFin);
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Abril 14, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="verDetalleError" access="public" hint="">
		<cfargument name="pkError"	type="numeric"	required="yes" hint="">
		<cfscript>
			return DAO.verDetalleError(pkError);
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Abril 14, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="eliminarError" access="public" hint="">
		<cfargument name="pkError"	type="numeric"	required="yes" hint="">
		<cfscript>
			return DAO.eliminarError(arguments.pkError);
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Junio 04, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="getTiposError" access="public" hint="">
		<cfscript>
			return DAO.getTiposError();
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Junio 05, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="getConteoTipoError" access="public" hint="">
		<cfscript>
			return DAO.getConteoTipoError();
		</cfscript>
	</cffunction>
	
	<!---
	* Modificacion : Se agrega el parametro de UR
	* Fecha mod : Junio 29, 2015
	* Autor mod : Sergio E. Cuevas Olivares
	---------------------------------------
	* Fecha : Junio 09, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="getListadoErrores" access="public" hint="">
		<cfargument name="pkRegistros"		type="string" required="yes" hint="">
		<cfargument name="numeroPagina"		type="numeric" required="yes" hint="">
		<cfargument name="tipoError"		type="string" required="no" default="" hint="">
		<cfargument name="ur"				type="string" required="no" default="" hint="">
		<cfargument name="fechaIni"			type="string" required="no" default="" hint="">
		<cfargument name="fechaFin"			type="string" required="no" default="" hint="">
		<cfscript>
			var structInformacion = StructNew();
			var resultado = DAO.getListadoErrores(arguments.pkRegistros, arguments.numeroPagina, arguments.tipoError, arguments.ur, arguments.fechaIni, arguments.fechaFin);
			
			structInformacion.CANTIDAD_USUARIO	= this.conteoUsuario(resultado);
			structInformacion.NAVEGADORES		= this.conteoNavegador(resultado);
			structInformacion.RESUMEN			= this.muestraResumen(resultado);
			structInformacion.PATHS				= this.conteoPath(resultado);
			
			if(arguments.tipoError EQ ""){
				structInformacion.CANTIDAD_ERROR  = this.conteoError(resultado);
				structInformacion.ERRORES_USUARIO = this.verErrorUsuario(resultado);
			}else{
				structInformacion.CANTIDAD_ERROR  = "";
				structInformacion.ERRORES_USUARIO = "";
			}
			
			return structInformacion;
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha mod: Junio 19, 2015
	* Autor mod: Sergio E. Cuevas Olivares
	-----------------------------------------------------------
	* Fecha : Junio 09, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="conteoError" access="public" hint="">
		<cfargument name="qRegistros" type="query" hint="">
		<cfquery name="qError" dbtype="query">
			SELECT CLAVE_ERROR, COUNT(CLAVE_ERROR) AS TOTAL
			FROM qRegistros
			GROUP BY CLAVE_ERROR
			ORDER BY CLAVE_ERROR ASC
		</cfquery>
		
		<cfset arrayStruct = ArrayNew(1)>
		<cfloop index="w" from="1" to="#qError.recordCount#">
			<cfset strucInfo = StructNew()>
			<cfquery name="qErrorPk" dbtype="query">
				SELECT PK_ERROR
				FROM qRegistros
				WHERE CLAVE_ERROR = '#qError.CLAVE_ERROR[w]#'
				ORDER BY PK_ERROR ASC
			</cfquery>
			<cfset strucInfo.ELEMENTO = qError.CLAVE_ERROR[w]>
			<cfset strucInfo.PK_ELEMENTS = ListToArray(ValueList(qErrorPk.PK_ERROR,','),',')>
			<cfset ArrayAppend(arrayStruct, strucInfo)>
		</cfloop>
		<cfreturn arrayStruct>
	</cffunction>
	
	<!---
	* Fecha : Junio 09, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="conteoUsuario" access="public" hint="">
		<cfargument name="qRegistros" type="query" hint="">
		<cfquery name="qInfo" dbtype="query">
			SELECT NOMBRE_COMPLETO, COUNT(NOMBRE_COMPLETO) AS TOTAL
			FROM qRegistros
			GROUP BY NOMBRE_COMPLETO
			ORDER BY NOMBRE_COMPLETO ASC
		</cfquery>
		<cfreturn qInfo>
	</cffunction>
	
	<!---
	* Fecha : Junio 09, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="verErrorUsuario" access="public" hint="">
		<cfargument name="qRegistros" type="query" hint="">
		<cfquery name="qInfo" dbtype="query">
			SELECT NOMBRE_COMPLETO, CLAVE_ERROR, COUNT(CLAVE_ERROR) AS TOTAL
			FROM qRegistros
			GROUP BY NOMBRE_COMPLETO, CLAVE_ERROR
			ORDER BY NOMBRE_COMPLETO ASC, CLAVE_ERROR ASC
		</cfquery>
		<cfreturn qInfo>
	</cffunction>
	
	<!---
	* Fecha : Junio 09, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="conteoNavegador" access="public" hint="">
		<cfargument name="qRegistros" type="query" hint="">
		<cfscript>
			var qNavegadores = QueryNew("NAVEGADOR,VERSION,USUARIO","VARCHAR,VARCHAR,VARCHAR");
			for(var q = 1; q LTE qRegistros.recordCount; q++){
				if(IsJSON(qRegistros.DESCRIPCION_ERROR[q])){
					DESC_ERROR = DeserializeJSON(qRegistros.DESCRIPCION_ERROR[q]);
					
					var NAME_BROWSER = DESC_ERROR.APPLICATION.BROWSER;
					var datosNavegador = ArrayNew(1);
					var informacionStruct = StructNew();
						informacionStruct.cadena			= NAME_BROWSER;
						informacionStruct.subcadena			= "Chrome";
						informacionStruct.identificacion	= "Chrome";
						informacionStruct.version			= "Chrome/";
						ArrayAppend(datosNavegador,informacionStruct);
						
					var informacionStruct = StructNew();
						informacionStruct.cadena			= NAME_BROWSER;
						informacionStruct.subcadena			= "OmniWeb";
						informacionStruct.identificacion	= "OmniWeb";
						informacionStruct.version			= "OmniWeb/";
						ArrayAppend(datosNavegador,informacionStruct);
						
					var informacionStruct = StructNew();
						informacionStruct.cadena			= NAME_BROWSER;
						informacionStruct.subcadena			= "Apple";
						informacionStruct.identificacion	= "Safari";
						informacionStruct.version			= "Version";
						ArrayAppend(datosNavegador,informacionStruct);
						
					var informacionStruct = StructNew();
						informacionStruct.cadena			= NAME_BROWSER;
						informacionStruct.subcadena			= "iCab";
						informacionStruct.identificacion	= "iCab";
						informacionStruct.version			= "";
						ArrayAppend(datosNavegador,informacionStruct);
						
					var informacionStruct = StructNew();
						informacionStruct.cadena			= NAME_BROWSER;
						informacionStruct.subcadena			= "KDE";
						informacionStruct.identificacion	= "Konqueror";
						informacionStruct.version			= "";
						ArrayAppend(datosNavegador,informacionStruct);
						
					var informacionStruct = StructNew();
						informacionStruct.cadena			= NAME_BROWSER;
						informacionStruct.subcadena			= "Firefox";
						informacionStruct.identificacion	= "Firefox";
						informacionStruct.version			= "Firefox/";
						ArrayAppend(datosNavegador,informacionStruct);
						
					var informacionStruct = StructNew();
						informacionStruct.cadena			= NAME_BROWSER;
						informacionStruct.subcadena			= "Camino";
						informacionStruct.identificacion	= "Camino";
						informacionStruct.version			= "";
						ArrayAppend(datosNavegador,informacionStruct);
						
					var informacionStruct = StructNew();
						informacionStruct.cadena			= NAME_BROWSER;
						informacionStruct.subcadena			= "Netscape";
						informacionStruct.identificacion	= "Netscape";
						informacionStruct.version			= "";
						ArrayAppend(datosNavegador,informacionStruct);
						
					var informacionStruct = StructNew();
						informacionStruct.cadena			= NAME_BROWSER;
						informacionStruct.subcadena			= "MSIE";
						informacionStruct.identificacion	= "Internet Explorer";
						informacionStruct.version			= "MSIE ";
						ArrayAppend(datosNavegador,informacionStruct);
						
					var informacionStruct = StructNew();
						informacionStruct.cadena			= NAME_BROWSER;
						informacionStruct.subcadena			= "Gecko";
						informacionStruct.identificacion	= "Mozilla";
						informacionStruct.version			= "rv";
						ArrayAppend(datosNavegador,informacionStruct);
						
					var informacionStruct = StructNew();
						informacionStruct.cadena			= NAME_BROWSER;
						informacionStruct.subcadena			= "Mozilla";
						informacionStruct.identificacion	= "Netscape";
						informacionStruct.version			= "Mozilla";
						ArrayAppend(datosNavegador,informacionStruct);
						
						QueryAddRow(qNavegadores);
						QuerySetCell(qNavegadores,"NAVEGADOR",this.detectaNavegador(datosNavegador));
						QuerySetCell(qNavegadores,"VERSION",this.versionNavegador(datosNavegador, NAME_BROWSER));
						QuerySetCell(qNavegadores,"USUARIO",qRegistros.NOMBRE_COMPLETO[q]);
				}
			}
			var structN = StructNew();
			structN.USADOS = this.contarNavegadores(qNavegadores);
			structN.POR_USUARIO = this.conteoNavegadorByUsuario(qNavegadores);
			
			return structN;
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Junio 09, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="conteoNavegadorByUsuario" access="public" hint="">
		<cfargument name="qRegistros" type="query" hint="">
		<cfquery name="qInformacion" dbtype="query">
			SELECT USUARIO, NAVEGADOR, VERSION, COUNT(NAVEGADOR|| ' ' || VERSION) AS TOTAL_NAVEGADOR
			FROM qRegistros
			GROUP BY USUARIO, NAVEGADOR, VERSION
			ORDER BY USUARIO ASC, NAVEGADOR ASC, VERSION ASC
		</cfquery>
		<cfreturn qInformacion>
	</cffunction>
	
	<!---
	* Descripción : Funcion que detecta el tipo de navegador
	* Fecha : Junio 09, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="detectaNavegador" hint="">
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
	* Fecha : Junio 09, 2015
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
	* Fecha : Junio 10, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="contarNavegadores" access="public" hint="">
		<cfargument name="qRegistros" type="query" hint="">
		<cfquery name="qInformacion" dbtype="query">
			SELECT NAVEGADOR, VERSION, COUNT(VERSION) AS TOTAL_VERSIONES
			FROM qRegistros
			GROUP BY NAVEGADOR, VERSION
			ORDER BY NAVEGADOR ASC, VERSION ASC
		</cfquery>
		<cfreturn qInformacion>
	</cffunction>
	
	<!---
	* Fecha : Junio 15, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="muestraResumen" access="public" hint="">
		<cfargument name="qRegistros" type="query" hint="">
		<cfscript>
			var pkNoJson	= ArrayNew(1);
			var pkJson		= ArrayNew(1);
			for(var q = 1; q LTE qRegistros.recordCount; q++){
				if(IsJSON(qRegistros.DESCRIPCION_ERROR[q])){
					ArrayAppend(pkJson, qRegistros.PK_ERROR[q]);
				}else{
					ArrayAppend(pkNoJson,qRegistros.PK_ERROR[q]);
				}
			}
			
			var structN = StructNew();
			structN.REGISTROS_SIN_ANALIZAR		= pkNoJson;
			structN.REGISTROS_ANALIZADOS		= pkJson;
			structN.REGISTROS_TOTAL_ANALIZAR	= qRegistros.recordCount;
			
			return structN;
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Junio 16, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="obtenerListadoErrores" access="public" hint="">
		<cfargument name="pksRegistro"		type="string" required="yes" hint="">
		<cfscript>
			return DAO.obtenerListadoErrores(arguments.pksRegistro);
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha : Junio 22, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="conteoPath" access="public" hint="">
		<cfargument name="qRegistros" type="query" hint="">
		<cfscript>
			var qRutas = QueryNew("PK_ERROR,USUARIO,P_SOLICITADO, P_REFERENCIA, IP_REFERENCIA","Integer,VARCHAR,VARCHAR,VARCHAR,VARCHAR");
			for(var q = 1; q LTE qRegistros.recordCount; q++){
				if(IsJSON(qRegistros.DESCRIPCION_ERROR[q])){
					DESC_ERROR = DeserializeJSON(qRegistros.DESCRIPCION_ERROR[q]);
					var PATH_SOLICITADO = DESC_ERROR.APPLICATION.PATH_INFO;
					
					QueryAddRow(qRutas);
					QuerySetCell(qRutas,"PK_ERROR", qRegistros.PK_ERROR[q]);
					QuerySetCell(qRutas,"USUARIO",qRegistros.NOMBRE_COMPLETO[q]);
					QuerySetCell(qRutas,"P_SOLICITADO",PATH_SOLICITADO);
					if(StructKeyExists(DESC_ERROR.APPLICATION,"REFERRER")){
						var PATH_REFERENCIA = DESC_ERROR.APPLICATION.REFERRER;
						var template = "index.cfm";
						var informacion = PATH_REFERENCIA.indexOf(template);
						
						if(informacion GT 0){
							QuerySetCell(qRutas,"P_REFERENCIA",Mid(PATH_REFERENCIA,(informacion+Len(template)+1),Len(PATH_REFERENCIA)));
						}else{
							QuerySetCell(qRutas,"P_REFERENCIA",'');
						}
					}else{
						QuerySetCell(qRutas,"P_REFERENCIA",'');
					}
					if(StructKeyExists(DESC_ERROR.APPLICATION,"REMOTE_ADDRESS")){
						QuerySetCell(qRutas,"IP_REFERENCIA","http://"&DESC_ERROR.APPLICATION.REMOTE_ADDRESS&"/");
					}else{
						var IP_SERVER = ListToArray(DESC_ERROR.APPLICATION.HOST_SERVER," ");
						QuerySetCell(qRutas,"IP_REFERENCIA","http://" & Trim(IP_SERVER[1]) & "/");
					}
				}
			}
			var structN = StructNew();
			structN.PATH_REF = this.contarPathReferencias(qRutas);
			structN.PATH_SOL = this.contarPathSolicitado(qRutas);
			structN.PATH_USR = this.conteoPathsByUsuario(qRutas);
			
			return structN;
		</cfscript>
	</cffunction><cffunction name="setAbort" access="public"><cfabort></cffunction>
	
	<!---
	* Fecha : Junio 23, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="contarPathReferencias" access="public" hint="">
		<cfargument name="qRegistros" type="query" required="yes" hint="">
		<cfquery name="qError" dbtype="query">
			SELECT P_REFERENCIA, COUNT(P_REFERENCIA) AS TOTAL
			FROM qRegistros
			WHERE P_REFERENCIA != '/' AND P_REFERENCIA != ''
			GROUP BY P_REFERENCIA
			ORDER BY P_REFERENCIA ASC
		</cfquery>
		
		<cfset arrayStruct = ArrayNew(1)>
		<cfloop index="w" from="1" to="#qError.recordCount#">
			<cfset strucInfo = StructNew()>
			<cfquery name="qErrorPk" dbtype="query">
				SELECT PK_ERROR
				FROM qRegistros
				WHERE P_REFERENCIA = '#qError.P_REFERENCIA[w]#'
				ORDER BY PK_ERROR ASC
			</cfquery>
			<cfset strucInfo.ELEMENTO = qError.P_REFERENCIA[w]>
			<cfset strucInfo.PK_ELEMENTS = ListToArray(ValueList(qErrorPk.PK_ERROR,','),',')>
			<cfset ArrayAppend(arrayStruct, strucInfo)>
		</cfloop>
		<cfreturn arrayStruct>
	</cffunction>
	
	<!---
	* Fecha : Junio 23, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="contarPathSolicitado" access="public" hint="">
		<cfargument name="qRegistros" type="query" required="yes" hint="">
		<cfquery name="qError" dbtype="query">
			SELECT P_SOLICITADO, COUNT(P_SOLICITADO) AS TOTAL
			FROM qRegistros
			WHERE P_SOLICITADO != '/' AND P_SOLICITADO != ''
			GROUP BY P_SOLICITADO
			ORDER BY P_SOLICITADO ASC
		</cfquery>
		
		<cfset arrayStruct = ArrayNew(1)>
		<cfloop index="w" from="1" to="#qError.recordCount#">
			<cfset strucInfo = StructNew()>
			<cfquery name="qErrorPk" dbtype="query">
				SELECT PK_ERROR
				FROM qRegistros
				WHERE P_SOLICITADO = '#qError.P_SOLICITADO[w]#'
				ORDER BY PK_ERROR ASC
			</cfquery>
			<cfset strucInfo.ELEMENTO = qError.P_SOLICITADO[w]>
			<cfset strucInfo.PK_ELEMENTS = ListToArray(ValueList(qErrorPk.PK_ERROR,','),',')>
			<cfset ArrayAppend(arrayStruct, strucInfo)>
		</cfloop>
		<cfreturn arrayStruct>
	</cffunction>
	
	<!---
	* Fecha : Junio 23, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="conteoPathsByUsuario" access="public" hint="">
		<cfargument name="qInformacion" type="query" required="yes" hint="">
		<cfquery name="qFiltroError" dbtype="query">
			SELECT USUARIO, COUNT(P_SOLICITADO) AS TOTAL_SOLICITADO
			FROM qInformacion
			WHERE P_SOLICITADO != '/' AND P_SOLICITADO != ''
			GROUP BY USUARIO, P_SOLICITADO
			ORDER BY USUARIO, P_SOLICITADO ASC
		</cfquery>
		<cfquery name="qRefError" dbtype="query">
			SELECT USUARIO, COUNT(P_REFERENCIA) AS TOTAL_REFERENCIA
			FROM qInformacion
			WHERE P_REFERENCIA != '/' AND P_REFERENCIA != ''
			GROUP BY USUARIO, P_REFERENCIA
			ORDER BY USUARIO, P_REFERENCIA ASC
		</cfquery>
		<cfset strucQuery = StructNew()>
		<cfset strucQuery.P_SOL = qFiltroError>
		<cfset strucQuery.P_REF = qRefError>
		<cfreturn strucQuery>
	</cffunction>
	
	<!---
	* Fecha : Julio 03, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="obtenerURs" access="public" hint="">
		<cfscript>
			return DAO.obtenerURs();
		</cfscript>
	</cffunction>
</cfcomponent>