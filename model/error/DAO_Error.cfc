<!---
* =========================================================================
* IPN - CSII
* Sistema: PDIPIMP
* Modulo: ERROR
* Fecha: 30 de Marzo de 2015
* Descripcion: Componente de acceso al BD
* Autor : Sergio Eduardo Cuevas Olivares
* =========================================================================
--->

<cfcomponent>
	<!---
	* Modificacion : - Se incluye la columna "BST_MENSAJE" para almacenar el mensaje de error
					 - Se agrega el argumento mensajeError
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
		
		<cftry>
			<cfset separador = ''>
			<cfquery name="qError" datasource="DS_PDIPIMP">
				INSERT INTO PDIPIMP.MONBSTERROR (
					BST_CLAVE_ERROR,
					BST_DESCRIPCION, 
					BST_FK_USUARIO,
					BST_MENSAJE,
					BST_FK_ESTADO) 
				VALUES (
					'#claveError#' ,
					<cfloop from="1" to="#Len(descripcion)#" index="i" step="4000">
						#separador#
						<cfif i EQ 1>
							TO_CLOB('#Mid(descripcion,i,3999)#')
						<cfelse>
							TO_CLOB('#Mid(descripcion,(i-1),3999)#') <!--- PODRIA estar el detalle de los errores no analizables--->
						</cfif>
						<cfset separador = '||'>
					</cfloop>,
					#fkusuario#,
					'#mensajeError#',
					1)
			</cfquery>
			<cfreturn 1>
			<cfcatch type="any">
				<cfreturn 0>
			</cfcatch>
		</cftry>
	</cffunction>
	
	<!---
	* Fecha : Marzo 30, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="getPkErrorByDescripcion" access="public" hint="">
		<cfargument name="claveError"	type="string"	required="yes" hint="">
		<cfargument name="descripcion" type="string" required="yes" hint="">
		
		<cfset separador = ''>
		<cfquery name="qError" datasource="DS_PDIPIMP">
			  SELECT MAX (ERR.BST_PK_ERROR) AS PK_SEGUIMIENTO
				FROM PDIPIMP.MONBSTERROR ERR
			   WHERE ERR.BST_CLAVE_ERROR = '#claveError#' AND
				<cfloop from="1" to="#Len(descripcion)#" index="i" step="4000">
					#separador#
					<cfif i EQ 1>
						DBMS_LOB.INSTR (ERR.BST_DESCRIPCION,'#Mid(descripcion,i,3999)#') > 0
					<cfelse>
						  DBMS_LOB.INSTR (ERR.BST_DESCRIPCION,'#Mid(descripcion,(i-1),3999)#') > 0
					</cfif>
					<cfset separador = 'AND'>
				</cfloop>
				AND ERR.BST_FK_ESTADO > 0
		</cfquery>
		<cfreturn qError>
	</cffunction>
	
	<!---
	* Modificacion : - Se agrega el parametro de UR
					 - Se incluye en el cruce la vista de las UR's
	* Fecha mod : Junio 29, 2015
	* Autor mod : Sergio E. Cuevas Olivares
	---------------------------------------
	* Fecha : Abril 14, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="getErroresRegistrados" access="public" hint="">
		<cfargument name="numeroPagina"		type="numeric" required="yes" hint="">
		<cfargument name="tipoError"		type="string" required="no" default="" hint="">
		<cfargument name="ur"				type="string" required="no" default="" hint="">
		<cfargument name="fechaIni"			type="string" required="no" default="" hint="">
		<cfargument name="fechaFin"			type="string" required="no" default="" hint="">
		<cfquery name="qErrores" datasource="DS_PDIPIMP">
			SELECT LISTA_ERRORES.*
			  FROM (SELECT ERRORES.BST_PK_ERROR AS PK_ERROR,
					   ERRORES.BST_CLAVE_ERROR AS CLAVE_ERROR,
					   USUARIO.TUS_FK_UR AS UR,
					   DEPENDENCIA.TUR_SIGLA AS SIGLAS_DEPENDENCIA,
					   DEPENDENCIA.TUR_NOMBRE AS NOMBRE_DEPENDENCIA,
						  UPPER (USUARIO.TUS_USUARIO_NOMBRE)
					   || ' '
					   || UPPER (USUARIO.TUS_USUARIO_PATERNO)
					   || ' '
					   || UPPER (USUARIO.TUS_USUARIO_MATERNO)
						  AS NOMBRE_COMPLETO,
					   ERRORES.BST_FK_ESTADO,
					   TO_CHAR (ERRORES.BST_FECHAREGISTRO, 'DD/MM/YYYY hh24:mi:ss')
						  AS FECHA_REGISTRO
				  FROM PDIPIMP.MONBSTERROR ERRORES, PDIPIMP.USRTUSUARIO USUARIO,
					   UR.V_UR DEPENDENCIA
				 WHERE USUARIO.TUS_PK_USUARIO = ERRORES.BST_FK_USUARIO
					   AND DEPENDENCIA.TUR_PK_UR = USUARIO.TUS_FK_UR
					<cfif arguments.tipoError NEQ "">
					   AND TRIM (ERRORES.BST_CLAVE_ERROR) = TRIM ('#arguments.tipoError#')
					</cfif>
					<cfif arguments.ur NEQ "">
					   AND USUARIO.TUS_FK_UR = '#arguments.ur#'
					</cfif>
					   AND ERRORES.BST_FK_ESTADO > 0
					<cfif arguments.fechaIni NEQ "" AND arguments.fechaFin NEQ "">
					   AND TO_CHAR(ERRORES.BST_FECHAREGISTRO,'DD/MM/YYYY HH24:MI:SS') BETWEEN 
									 TO_CHAR (TO_DATE ( (TO_CHAR (TO_DATE('#arguments.fechaIni#', 'DD/MM/YYYY'), 'DD/MM/YYYY')  || ' 00:00:00'),
						   'DD/MM/YYYY HH24:MI:SS'), 'DD/MM/YYYY HH24:MI:SS')
					   AND TO_CHAR (TO_DATE ( (TO_CHAR (TO_DATE('#arguments.fechaFin#', 'DD/MM/YYYY'), 'DD/MM/YYYY') || ' 23:59:59'),
						   'DD/MM/YYYY HH24:MI:SS'), 'DD/MM/YYYY HH24:MI:SS')
					</cfif>
					ORDER BY ERRORES.BST_PK_ERROR DESC) LISTA_ERRORES
			 WHERE ROWNUM <= #arguments.numeroPagina#
		</cfquery>
		<cfreturn qErrores>
	</cffunction>
	
	<!---
	* Modificacion : Se incluye la columna "BST_MENSAJE"
	* Fecha mod : Abril 22, 2015
	* Autor mod : Sergio E. Cuevas Olivares
	----------------------------------------
	* Fecha : Abril 14, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="verDetalleError" access="public" hint="">
		<cfargument name="pkError"	type="numeric"	required="yes" hint="">
		<cfquery name="qError" datasource="DS_PDIPIMP">
			SELECT ERRORES.BST_PK_ERROR AS PK_ERROR,
				   ERRORES.BST_CLAVE_ERROR AS CLAVE_ERROR,
					  UPPER (USUARIO.TUS_USUARIO_NOMBRE)
				   || ' '
				   || UPPER (USUARIO.TUS_USUARIO_PATERNO)
				   || ' '
				   || UPPER (USUARIO.TUS_USUARIO_MATERNO)
					  AS NOMBRE_COMPLETO,
				   ERRORES.BST_FK_ESTADO,
				   TO_CHAR (ERRORES.BST_FECHAREGISTRO, 'DD/MM/YYYY hh24:mi:ss')
					  AS FECHA_REGISTRO,
				   ERRORES.BST_DESCRIPCION AS DESCRIPCION_ERROR,
				   ERRORES.BST_MENSAJE as MENSAJE_ERROR
			  FROM PDIPIMP.MONBSTERROR ERRORES, PDIPIMP.USRTUSUARIO USUARIO
			 WHERE     USUARIO.TUS_PK_USUARIO = ERRORES.BST_FK_USUARIO
				   AND ERRORES.BST_FK_ESTADO > 0
				   AND ERRORES.BST_PK_ERROR = #pkError#
		</cfquery>
		<cfreturn qError>
	</cffunction>
	
	<!---
	* Fecha : Abril 14, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="eliminarError" access="public" hint="">
		<cfargument name="pkError"	type="numeric"	required="yes" hint="">
		<cfquery name="delError" datasource="DS_PDIPIMP" result="resultado">
			UPDATE PDIPIMP.MONBSTERROR
			   SET BST_FK_ESTADO = 0
			 WHERE BST_PK_ERROR = #pkError# AND BST_FK_ESTADO > 0
		</cfquery>
		<cfreturn resultado.RECORDCOUNT>
	</cffunction>
	
	<!---
	* Fecha : Junio 04, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="getTiposError" access="public" hint="">
		<cfquery name="qTotal" datasource="DS_PDIPIMP">
			SELECT COUNT (*) AS TOTAL_REGISTRO
			  FROM PDIPIMP.MONBSTERROR ERRORES
			 WHERE ERRORES.BST_FK_ESTADO > 0
		</cfquery>
		<cfquery name="qTErrores" datasource="DS_PDIPIMP">
			  SELECT ERRORES.BST_CLAVE_ERROR AS CLAVE_ERROR
				FROM PDIPIMP.MONBSTERROR ERRORES
			   WHERE ERRORES.BST_FK_ESTADO > 0
			GROUP BY ERRORES.BST_CLAVE_ERROR
			ORDER BY ERRORES.BST_CLAVE_ERROR ASC
		</cfquery>
		<cfset informacion = StructNew()>
		<cfset informacion.TOTAL = qTotal.TOTAL_REGISTRO>
		<cfset informacion.TERRORES = qTErrores>
		<cfreturn informacion>
	</cffunction>
	
	<!---
	* Fecha : Junio 05, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="getConteoTipoError" access="public" hint="">
		<cfquery name="qTErrores" datasource="DS_PDIPIMP">
			  SELECT M.BST_CLAVE_ERROR AS CLAVE_ERROR, COUNT (M.BST_CLAVE_ERROR) AS TOTAL
				FROM PDIPIMP.MONBSTERROR M
			   WHERE M.BST_FK_ESTADO > 0
			GROUP BY M.BST_CLAVE_ERROR
			  HAVING COUNT (*) > 1
			ORDER BY M.BST_CLAVE_ERROR ASC
		</cfquery>
		<cfreturn qTErrores>
	</cffunction>
	
	<!---
	* Modificacion : - Se agrega el parametro de UR
					 - Se incluye en el cruce la vista de las UR's
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
		<cfquery name="qErrores" datasource="DS_PDIPIMP">
			SELECT LISTA_ERRORES.*
			  FROM (SELECT ERRORES.BST_PK_ERROR AS PK_ERROR,
					   ERRORES.BST_CLAVE_ERROR AS CLAVE_ERROR,
					   USUARIO.TUS_FK_UR AS UR,
					   DEPENDENCIA.TUR_SIGLA AS SIGLAS_DEPENDENCIA,
					   DEPENDENCIA.TUR_NOMBRE AS NOMBRE_DEPENDENCIA,
						  UPPER (USUARIO.TUS_USUARIO_NOMBRE)
					   || ' '
					   || UPPER (USUARIO.TUS_USUARIO_PATERNO)
					   || ' '
					   || UPPER (USUARIO.TUS_USUARIO_MATERNO)
						  AS NOMBRE_COMPLETO,
					   ERRORES.BST_DESCRIPCION AS DESCRIPCION_ERROR,
					   ERRORES.BST_FK_ESTADO,
					   TO_CHAR (ERRORES.BST_FECHAREGISTRO, 'DD/MM/YYYY hh24:mi:ss')
						  AS FECHA_REGISTRO
				  FROM PDIPIMP.MONBSTERROR ERRORES, PDIPIMP.USRTUSUARIO USUARIO,
				  UR.V_UR DEPENDENCIA
				 WHERE USUARIO.TUS_PK_USUARIO = ERRORES.BST_FK_USUARIO
					AND DEPENDENCIA.TUR_PK_UR = USUARIO.TUS_FK_UR
					AND ERRORES.BST_PK_ERROR IN (#pkRegistros#)
					<cfif arguments.tipoError NEQ "">
					   AND TRIM (ERRORES.BST_CLAVE_ERROR) = TRIM ('#arguments.tipoError#')
					</cfif>
					<cfif arguments.ur NEQ "">
					   AND USUARIO.TUS_FK_UR = '#arguments.ur#'
					</cfif>
					   AND ERRORES.BST_FK_ESTADO > 0
					<cfif arguments.fechaIni NEQ "" AND arguments.fechaFin NEQ "">
					   AND TO_CHAR(ERRORES.BST_FECHAREGISTRO,'DD/MM/YYYY HH24:MI:SS') BETWEEN 
									 TO_CHAR (TO_DATE ( (TO_CHAR (TO_DATE('#arguments.fechaIni#', 'DD/MM/YYYY'), 'DD/MM/YYYY')  || ' 00:00:00'),
						   'DD/MM/YYYY HH24:MI:SS'), 'DD/MM/YYYY HH24:MI:SS')
					   AND TO_CHAR (TO_DATE ( (TO_CHAR (TO_DATE('#arguments.fechaFin#', 'DD/MM/YYYY'), 'DD/MM/YYYY') || ' 23:59:59'),
						   'DD/MM/YYYY HH24:MI:SS'), 'DD/MM/YYYY HH24:MI:SS')
					</cfif>
					ORDER BY ERRORES.BST_PK_ERROR DESC) LISTA_ERRORES
			 WHERE ROWNUM <= #arguments.numeroPagina#
		</cfquery>
		<cfreturn qErrores>
	</cffunction>
	
	<!---
	* Fecha : Junio 16, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="obtenerListadoErrores" access="public" hint="">
		<cfargument name="pksRegistro"		type="string" required="yes" hint="">
		<cfquery name="qErrores" datasource="DS_PDIPIMP">
			SELECT ERRORES.BST_PK_ERROR AS PK_ERROR,
				   ERRORES.BST_CLAVE_ERROR AS CLAVE_ERROR,
					  UPPER (USUARIO.TUS_USUARIO_NOMBRE)
				   || ' '
				   || UPPER (USUARIO.TUS_USUARIO_PATERNO)
				   || ' '
				   || UPPER (USUARIO.TUS_USUARIO_MATERNO)
					  AS NOMBRE_COMPLETO,
				   ERRORES.BST_DESCRIPCION AS DESCRIPCION_ERROR,
				   ERRORES.BST_FK_ESTADO,
				   TO_CHAR (ERRORES.BST_FECHAREGISTRO, 'DD/MM/YYYY hh24:mi:ss')
					  AS FECHA_REGISTRO
			  FROM PDIPIMP.MONBSTERROR ERRORES, PDIPIMP.USRTUSUARIO USUARIO
			 WHERE USUARIO.TUS_PK_USUARIO = ERRORES.BST_FK_USUARIO
				AND ERRORES.BST_PK_ERROR IN (#pksRegistro#)
				AND ERRORES.BST_FK_ESTADO > 0
				ORDER BY ERRORES.BST_PK_ERROR DESC
		</cfquery>
		<cfreturn qErrores>
	</cffunction>
	
	<!---
	* Fecha : Julio 03, 2015
	* Autor : Sergio E. Cuevas Olivares
	--->
	<cffunction name="obtenerURs" access="public" hint="">
		<cfquery name="qUrs" datasource="DS_PDIPIMP">
			  SELECT USUARIO.TUS_FK_UR AS UR,
					 DEPENDENCIA.TUR_NOMBRE AS NOMBRE_DEPENDENCIA
				FROM PDIPIMP.MONBSTERROR ERRORES,
					 PDIPIMP.USRTUSUARIO USUARIO,
					 UR.V_UR DEPENDENCIA
			   WHERE     USUARIO.TUS_PK_USUARIO = ERRORES.BST_FK_USUARIO
					 AND DEPENDENCIA.TUR_PK_UR = USUARIO.TUS_FK_UR
					 AND ERRORES.BST_FK_ESTADO > 0
			GROUP BY USUARIO.TUS_FK_UR, DEPENDENCIA.TUR_NOMBRE
			ORDER BY USUARIO.TUS_FK_UR ASC
		</cfquery>
		<cfreturn qUrs>
	</cffunction>
</cfcomponent>