<!---
* =========================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: MONITOREO
* Fecha: Mayo 29, 2015
* Descripcion: Componente de acceso a la BD
* Autor : Sergio Eduardo Cuevas Olivares
* =========================================================================
--->
<cfcomponent>
	
	<!---
	* Fecha : Mayo 29, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="registraAccesoUsuario" access="public">
		<cfargument name="pkUsuario"	type="numeric" required="yes" hint="">
		<cfargument name="ipHost"		type="string" required="yes" hint="">
		<cfargument name="navegador"	type="string" required="yes" hint="">
		<cfargument name="idioma"		type="string" required="yes" hint="">
		<cfargument name="plataforma"	type="string" required="yes" hint="">
		<cfargument name="version"		type="string" required="yes" hint="">
		<cfargument name="arquitectura" type="string" required="yes" hint="">

		<cfstoredproc procedure="GRAL.P_MONITOREO.GUARDA_ACCESO" datasource="DS_GRAL">
			<cfprocparam cfsqltype="cf_sql_numeric" value="#pkUsuario#">
			<cfprocparam cfsqltype="cf_sql_varchar" value="#ipHost#">
			<cfprocparam cfsqltype="cf_sql_varchar" value="#navegador#">
			<cfprocparam cfsqltype="cf_sql_varchar" value="#idioma#">
			<cfprocparam cfsqltype="cf_sql_varchar" value="#plataforma#">
			<cfprocparam cfsqltype="cf_sql_varchar" value="#version#">
			<cfprocparam cfsqltype="cf_sql_varchar" value="#arquitectura#">
			<cfprocparam cfsqltype="cf_sql_numeric" type="out" variable="pkRegistro">
		</cfstoredproc>
		
		<cfreturn pkRegistro>
	</cffunction>
	
	<!---
	* Fecha : Mayo 29, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="registraAccionesUsuario" access="public">
		<cfargument name="pkMonitoreo"		type="numeric" required="yes" hint="">
		<cfargument name="metodoForm"		type="string" required="yes" hint="">
		<cfargument name="tContenido"		type="string" required="yes" hint="">
		<cfargument name="urlReferencia"	type="string" required="yes" hint="">
		<cfargument name="urlSolicitada"	type="string" required="yes" hint="">
		<cfargument name="parametros"		type="string" required="yes" hint="">
		<cfstoredproc procedure="GRAL.P_MONITOREO.GUARDA_ACCIONES" datasource="DS_GRAL">
			<cfprocparam cfsqltype="cf_sql_numeric" value="#pkMonitoreo#">
			<cfif arguments.metodoForm NEQ "">
				<cfprocparam cfsqltype="cf_sql_varchar" value="#metodoForm#">
			<cfelse>
				<cfprocparam cfsqltype="cf_sql_varchar" null="yes">
			</cfif>
			<cfif arguments.tContenido NEQ "">
				<cfprocparam cfsqltype="cf_sql_varchar" value="#tContenido#">
			<cfelse>
				<cfprocparam cfsqltype="cf_sql_varchar" null="yes">
			</cfif>
			<cfif arguments.urlReferencia NEQ "">
				<cfprocparam cfsqltype="cf_sql_varchar" value="#arguments.urlReferencia#">
			<cfelse>
				<cfprocparam cfsqltype="cf_sql_varchar" null="yes">
			</cfif>
			
			<cfif arguments.urlSolicitada NEQ "">
				<cfprocparam cfsqltype="cf_sql_varchar" value="#arguments.urlSolicitada#">
			<cfelse>
				<cfprocparam cfsqltype="cf_sql_varchar" null="yes">
			</cfif>
			
			<cfif arguments.parametros NEQ "">
				<cfif Len(arguments.parametros) gt 4000 >
					<cfprocparam cfsqltype="cf_sql_varchar" value="#left(parametros,500)#">
				<cfelse>
					<cfprocparam cfsqltype="cf_sql_varchar" value="#parametros#">
				</cfif>
			<cfelse>
				<cfprocparam cfsqltype="cf_sql_varchar" null="yes">
			</cfif>
			<cfprocparam cfsqltype="cf_sql_numeric" type="out" variable="pkRegistro">
		</cfstoredproc>
		<cfreturn pkRegistro>
	</cffunction>
	
	<!---
	* Fecha : Junio 02, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="getAccesosRegistrados" access="public">
		<cfargument name="numeroPagina"		type="numeric" required="yes" hint="">
		<cfargument name="ur"				type="string" required="no" default="" hint="">
		<cfargument name="fechaIni"			type="string" required="no" default="" hint="">
		<cfargument name="fechaFin"			type="string" required="no" default="" hint="">
		<cfquery name="qRegistroAcceso" datasource="DS_GRAL">
			SELECT LISTA_ACCESOS.*
			FROM (
				SELECT USUARIO.TUS_FK_UR AS UR,
					   DEPENDENCIA.TUR_SIGLAS AS SIGLAS_DEPENDENCIA,
					   DEPENDENCIA.TUR_NOMBRE AS NOMBRE_DEPENDENCIA,
					     UPPER (USUARIO.TUS_USUARIO_NOMBRE)
					   || ' '
					   || UPPER (USUARIO.TUS_USUARIO_PATERNO)
					   || ' '
					   || UPPER (USUARIO.TUS_USUARIO_MATERNO)
						  AS NOMBRE_COMPLETO,
					   ACCESO.BAC_PK_ACCESO AS PK_ACCESO,
					   USUARIO.TUS_FK_GENERO AS FK_GENERO,
					   USUARIO.TUS_USUARIO_TELEFONO AS TELEFONO,
					   USUARIO.TUS_USUARIO_EXTENSION AS EXTENSION,
					   USUARIO.TUS_USUARIO_EMAIL AS CORREO_ELECTRONICO,
					   USUARIO.TUS_USUARIO_USERNAME AS NOMBRE_USUARIO,
					   ACCESO.BAC_ACCESO_IP_HOST AS IP_HOST,
					   ACCESO.BAC_ACCESO_NAVEGADOR AS NAVEGADOR,
					   ACCESO.BAC_ACCESO_IDIOMA AS IDIOMA_NAVEGADOR,
					   ACCESO.BAC_ACCESO_ARQUITECTURA AS ARQUITECTURA_OS,
					   ACCESO.BAC_ACCESO_PLATAFORMA AS SISTEMA_OPERATIVO,
					   ACCESO.BAC_ACCESO_VERSION AS VERSION_OS,
					   TO_CHAR (ACCESO.BAC_ACCESO_FECHA_REGISTRO, 'DD/MM/YYYY hh24:mi:ss')
						  AS FECHA_REGISTRO
				  FROM GRAL.MONBACCESO ACCESO,
					   GRAL.USRTUSUARIO USUARIO,
					  URS.URSTURS@DBL_URS DEPENDENCIA
				 WHERE     USUARIO.TUS_PK_USUARIO = ACCESO.BAC_FK_ACCESO_USUARIO
					   AND DEPENDENCIA.TUR_CLAVE = USUARIO.TUS_FK_UR
					<cfif arguments.ur NEQ "">
					   AND USUARIO.TUS_FK_UR = '#arguments.ur#'
					</cfif>
					<cfif arguments.fechaIni NEQ "" AND arguments.fechaFin NEQ "">
					   AND TO_CHAR(ACCESO.BAC_ACCESO_FECHA_REGISTRO,'DD/MM/YYYY HH24:MI:SS') BETWEEN 
									 TO_CHAR (TO_DATE ( (TO_CHAR (TO_DATE('#arguments.fechaIni#', 'DD/MM/YYYY'), 'DD/MM/YYYY')  || ' 00:00:00'),
						   'DD/MM/YYYY HH24:MI:SS'), 'DD/MM/YYYY HH24:MI:SS')
					   AND TO_CHAR (TO_DATE ( (TO_CHAR (TO_DATE('#arguments.fechaFin#', 'DD/MM/YYYY'), 'DD/MM/YYYY') || ' 23:59:59'),
						   'DD/MM/YYYY HH24:MI:SS'), 'DD/MM/YYYY HH24:MI:SS')
					</cfif>
				  ORDER BY ACCESO.BAC_PK_ACCESO DESC
			) LISTA_ACCESOS
			 WHERE ROWNUM <= #arguments.numeroPagina#
		</cfquery>
		<!---
		<cfstoredproc procedure="GRAL.P_MONITOREO.GET_REGISTROSACCESOS" datasource="DS_GRAL">
			<cfprocresult name="qRegistros">
		</cfstoredproc>
		--->
		<cfreturn qRegistroAcceso>
	</cffunction>
	
	<!---
	* Fecha : Junio 02, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="verDetalleAcceso" access="public">
		<cfargument name="pkAcceso"		type="numeric" required="yes" hint="">
		<cfquery name="qRegistroAcceso" datasource="DS_GRAL">
			SELECT USUARIO.TUS_FK_UR AS UR,
				   DEPENDENCIA.TUR_SIGLAS AS SIGLAS_DEPENDENCIA,
				   DEPENDENCIA.TUR_NOMBRE AS NOMBRE_DEPENDENCIA,
					  UPPER (USUARIO.TUS_USUARIO_NOMBRE)
				   || ' '
				   || UPPER (USUARIO.TUS_USUARIO_PATERNO)
				   || ' '
				   || UPPER (USUARIO.TUS_USUARIO_MATERNO)
					  AS NOMBRE_COMPLETO,
				   USUARIO.TUS_FK_GENERO AS FK_GENERO,
				   USUARIO.TUS_USUARIO_TELEFONO AS TELEFONO,
				   USUARIO.TUS_USUARIO_EXTENSION AS EXTENSION,
				   USUARIO.TUS_USUARIO_EMAIL AS CORREO_ELECTRONICO,
				   USUARIO.TUS_USUARIO_USERNAME AS NOMBRE_USUARIO,
				   ACCESO.BAC_ACCESO_IP_HOST AS IP_HOST,
				   ACCESO.BAC_ACCESO_NAVEGADOR AS NAVEGADOR,
				   ACCESO.BAC_ACCESO_IDIOMA AS IDIOMA_NAVEGADOR,
				   ACCESO.BAC_ACCESO_ARQUITECTURA AS ARQUITECTURA_OS,
				   ACCESO.BAC_ACCESO_PLATAFORMA AS SISTEMA_OPERATIVO,
				   ACCESO.BAC_ACCESO_VERSION AS VERSION_OS,
				   TO_CHAR (ACCESO.BAC_ACCESO_FECHA_REGISTRO, 'DD/MM/YYYY hh24:mi:ss')
					  AS FECHA_REGISTRO
			  FROM GRAL.MONBACCESO ACCESO,
				   GRAL.USRTUSUARIO USUARIO,
				   URS.URSTURS@DBL_URS DEPENDENCIA
			 WHERE     USUARIO.TUS_PK_USUARIO = ACCESO.BAC_FK_ACCESO_USUARIO
				   AND DEPENDENCIA.TUR_CLAVE = USUARIO.TUS_FK_UR
				   AND ACCESO.BAC_PK_ACCESO = #arguments.pkAcceso#
		</cfquery>
		<cfstoredproc procedure="GRAL.P_MONITOREO.GET_DETALLEACCESO" datasource="DS_GRAL">
			<cfprocparam cfsqltype="cf_sql_numeric" value="#arguments.pkAcceso#">
			<cfprocresult name="qRegistrosAcciones">
		</cfstoredproc>
		<cfset informacion = StructNew()>
		<cfset informacion.ACCESO = qRegistroAcceso>
		<cfset informacion.ACCIONES = qRegistrosAcciones>
		<cfreturn informacion>
	</cffunction>
	
	<!---
	* Fecha : Julio 03, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="getNombresUR" access="public" hint="">
		<cfquery name="qTotal" datasource="DS_GRAL">
			SELECT COUNT (*) AS TOTAL_REGISTRO
			  FROM GRAL.MONBACCESO ACCESOS
			 WHERE ACCESOS.BAC_FK_ACCESO_USUARIO > 0
		</cfquery>
		<cfquery name="qURs" datasource="DS_GRAL">
			  SELECT USUARIO.TUS_FK_UR AS UR,
					 DEPENDENCIA.TUR_NOMBRE AS NOMBRE_DEPENDENCIA
				FROM GRAL.MONBACCESO ACCESO,
					 GRAL.USRTUSUARIO USUARIO,
					 URS.URSTURS@DBL_URS DEPENDENCIA
			   WHERE USUARIO.TUS_PK_USUARIO = ACCESO.BAC_FK_ACCESO_USUARIO
					 AND DEPENDENCIA.TUR_CLAVE = USUARIO.TUS_FK_UR
			GROUP BY USUARIO.TUS_FK_UR, DEPENDENCIA.TUR_NOMBRE
			ORDER BY USUARIO.TUS_FK_UR ASC
		</cfquery>
		<cfset informacion = StructNew()>
		<cfset informacion.TOTAL	= qTotal.TOTAL_REGISTRO>
		<cfset informacion.UR_DATA	= qURs>
		<cfreturn informacion>
	</cffunction>
</cfcomponent>