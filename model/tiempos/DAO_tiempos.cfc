<!---
* =========================================================================
* IPN - CSII
* Sistema:		SIIIS
* Modulo:		Tiempos
* Fecha:		Agosto de 2017
* Descripcion:	DAO de los tiempos de los convenios
* Autor:		Roberto Cadena
* =========================================================================
--->
<cfcomponent>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getProced" access="public" hint="Obtiene todos los procedimientos">
		<cfquery name="qConvenios" datasource="DS_PDIPIMP">
			SELECT	CPR_PK_PROCEDIMIENTO	AS PKPROCED,
					CPR_NOMBRE				AS PROCED
			FROM	CESCPROCEDIMIENTO
			WHERE	CPR_FK_ESTADO = 2
			ORDER BY PROCED DESC
		</cfquery>
		<cfreturn qConvenios>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="obtenerTablaModificacion" hint="Obtiene los datos de la tabla a modificar.">
		<cfargument name="pkProcedimiento" type="numeric" required="yes" hint="Clave del procedimiento que sigue el registro a modificar.">
		<cfquery name="qTablaModificacion" datasource="DS_PDIPIMP">
			SELECT	CPR.CPR_TABLA_MODIFICACION			TABLA,
					CPR.CPR_CAMPO_DESCRIPCION_REGISTRO	CAMPO_DESCRIPCION,
					CPR.CPR_PK_REGISTRO_MODIFICACION	CAMPO_PK,
					CPR.CPR_CAMPO_NOMBRE_REGISTRO		CAMPO_NOMBRE
			FROM	CESCPROCEDIMIENTO					CPR
			WHERE	CPR.CPR_PK_PROCEDIMIENTO = <cfqueryparam value="#arguments.pkProcedimiento#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn qTablaModificacion>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getAllDatos" access="public" hint="Obtiene todos los datos de los procedimientos">
		<cfargument name="proced"	type="numeric" required="yes" hint="procedimiento">
		<cfset qTablaModificacion = this.obtenerTablaModificacion(#proced#)>
		<cfset tabla			= qTablaModificacion.TABLA[1]>
		<cfset campoDescripcion = qTablaModificacion.CAMPO_DESCRIPCION[1]>
		<cfset campoPK			= qTablaModificacion.CAMPO_PK[1]>
		<cfset campoNombre		= qTablaModificacion.CAMPO_NOMBRE[1]>
		<cfquery name="qConvenios" datasource="DS_PDIPIMP">
			SELECT	#campoPK#					AS PKCONVENIO,
					#campoNombre#				AS CONVENIO,
					TO_char(#campoDescripcion#)	AS OBJCONVENIO
			FROM	#tabla#,
					CESBHISTORIAL	BHI
			WHERE	BHI.BHI_REGISTRO_MODIFICACION = #campoPK#	
			AND		BHI.BHI_FK_PROCEDIMIENTO = <cfqueryparam value="#proced#" cfsqltype="cf_sql_numeric">
			AND		BHI.BHI_FK_ESTADO = 2
			GROUP BY #campoPK#, #campoNombre#, TO_char(#campoDescripcion#)
			ORDER BY PKCONVENIO DESC
		</cfquery>
		<cfreturn qConvenios>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getAllFormatos" access="public" hint="Obtiene todos los formatos (Caso especial)">
		<cfargument name="proced"	type="numeric" required="yes" hint="procedimiento">
		<cfquery name="qConvenios" datasource="DS_PDIPIMP">
			SELECT	TFR.TFR_PK_FORMATO	AS PKCONVENIO,
					CFT.CFT_NOMBRE		AS CONVENIO,
					CFT.CFT_CLAVE		AS OBJCONVENIO
			FROM	EVTTFORMATO TFR,
					EVTCFORMATO CFT,
					CESBHISTORIAL	BHI
			WHERE	BHI.BHI_REGISTRO_MODIFICACION = TFR.TFR_PK_FORMATO
			AND		TFR.TFR_FK_CFORMATO = CFT.CFT_PK_FORMATO
			AND		BHI.BHI_FK_PROCEDIMIENTO = <cfqueryparam value="#proced#" cfsqltype="cf_sql_numeric">
			AND		BHI.BHI_FK_ESTADO = 2
			GROUP BY TFR.TFR_PK_FORMATO,
					CFT.CFT_NOMBRE,
					CFT.CFT_CLAVE
			ORDER BY PKCONVENIO
		</cfquery>
		<cfreturn qConvenios>
	</cffunction>	

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getAlltrim" access="public" hint="Obtiene todos los periodos de formatos (Caso especial)">
		<cfargument name="proced"	type="numeric" required="yes" hint="procedimiento">
		<cfquery name="qConvenios" datasource="DS_PDIPIMP">
			SELECT	TRP.TRP_PK_REPORTE	AS PKCONVENIO,
					CFT.CFT_NOMBRE		AS CONVENIO,
					TPE.TPE_NOMBRE		AS OBJCONVENIO
			FROM	EVTTREPORTE		TRP,
					EVTTFORMATO		TFR,
					EVTCFORMATO		CFT,
					EVTTPERIODO		TPE,
					CESBHISTORIAL	BHI
			WHERE	BHI.BHI_REGISTRO_MODIFICACION = TRP.TRP_PK_REPORTE
			AND		TFR.TFR_FK_CFORMATO = CFT.CFT_PK_FORMATO
			AND		TRP.TRP_FK_FORMATO = TFR.TFR_PK_FORMATO
			AND		TRP.TRP_FK_PERIODO =  TPE.TPE_PK_PERIODO
			AND		BHI.BHI_FK_PROCEDIMIENTO = <cfqueryparam value="#proced#" cfsqltype="cf_sql_numeric">
			AND		BHI.BHI_FK_ESTADO = 2
			GROUP BY TRP.TRP_PK_REPORTE,
					CFT.CFT_NOMBRE,
					TPE.TPE_NOMBRE
			ORDER BY PKCONVENIO
		</cfquery>
		<cfreturn qConvenios>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getAllAreas" access="public" hint="Obtiene todas las areas">
		<cfargument name="proced"	type="numeric" required="yes" hint="procedimiento">
		<cfquery name="qAreas" datasource="DS_PDIPIMP">
			SELECT	CAR.CAR_PK_AREA		AS PKAREA,
					CAR.CAR_NOMBRE_AREA	AS AREA
			FROM	CESCAREA		CAR,
					CESCESTADO		CER,
					CESBHISTORIAL	BHI,
					CESRRUTA		RPR
			WHERE	CER.CER_FK_AREA = CAR.CAR_PK_AREA
			AND		CER.CER_PK_ESTADO = BHI.BHI_NUMERO_ESTADO_ACTUAL
			AND		CAR.CAR_FK_ESTADO	<> 1
			AND		RPR.RPR_FK_PROCEDIMIENTO = BHI.BHI_FK_PROCEDIMIENTO
			AND		CER.CER_FK_RUTA = RPR.RPR_PK_RUTA
			AND		BHI.BHI_FK_PROCEDIMIENTO = <cfqueryparam value="#proced#" cfsqltype="cf_sql_numeric">
			AND		BHI.BHI_FK_ESTADO = 2
			GROUP BY CAR_PK_AREA, CAR_NOMBRE_AREA
			ORDER BY AREA
		</cfquery>
		<cfreturn qAreas>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getAllEstados" access="public" hint="Obtiene todos los estados de los convenios">
		<cfargument name="proced"	type="numeric" required="yes" hint="procedimiento">
		<cfquery name="qEstados" datasource="DS_PDIPIMP">
			SELECT	CER.CER_PK_ESTADO		AS PKESTADO,
					CER.CER_NUMERO_ESTADO	AS NUMESTADO,
					CER.CER_NOMBRE			AS ESTADO
			FROM	CESCESTADO		CER,
					CESBHISTORIAL	BHI,
					CESRRUTA		RPR
			WHERE	BHI.BHI_NUMERO_ESTADO_ACTUAL = CER.CER_PK_ESTADO
			AND		CER.CER_FK_ESTADO = 2
			AND		RPR.RPR_FK_PROCEDIMIENTO = BHI.BHI_FK_PROCEDIMIENTO
			AND		CER.CER_FK_RUTA = RPR.RPR_PK_RUTA
			AND		BHI.BHI_FK_PROCEDIMIENTO = <cfqueryparam value="#proced#" cfsqltype="cf_sql_numeric">
			AND		BHI.BHI_FK_ESTADO = 2
			GROUP BY CER.CER_PK_ESTADO, CER.CER_NUMERO_ESTADO, CER.CER_NOMBRE
			ORDER BY NUMESTADO
		</cfquery>
		<cfreturn qEstados>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getAllRoles" access="public" hint="Obtiene todos los roles de los convenios">
		<cfargument name="proced"	type="numeric" required="yes" hint="procedimiento">
		<cfquery name="qEstados" datasource="DS_PDIPIMP">
			SELECT	TRO.TRO_PK_ROL		AS PKROL,
					TRO.TRO_ROL_NOMBRE	AS ROL
			FROM	USRTROL		TRO,
					USRTUSUARIO	TUS,
					CESBHISTORIAL	BHI,
					CESCESTADO		CER,
					CESRRUTA		RPR
			WHERE	TRO.TRO_PK_ROL = TUS.TUS_FK_ROL
			AND		TUS.TUS_PK_USUARIO = BHI.BHI_USUARIO_MODIFICACION
			AND		CER.CER_PK_ESTADO = BHI.BHI_NUMERO_ESTADO_ACTUAL
			AND		RPR.RPR_FK_PROCEDIMIENTO = BHI.BHI_FK_PROCEDIMIENTO
			AND		CER.CER_FK_RUTA = RPR.RPR_PK_RUTA
			AND		BHI.BHI_FK_PROCEDIMIENTO = <cfqueryparam value="#proced#" cfsqltype="cf_sql_numeric">
			AND		BHI.BHI_FK_ESTADO =2
			GROUP BY TRO.TRO_PK_ROL, TRO.TRO_ROL_NOMBRE
			ORDER BY ROL
		</cfquery>
		<cfreturn qEstados>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getTiempo" access="public" hint="Obtiene el tiempo transcurrido de un convenio">
		<cfargument name="proced"		type="numeric"	required="yes" hint="filtra el tiempo por procedimiento">
		<cfargument name="convenio"		type="numeric"	required="yes" hint="filtra el tiempo por convenio">
		<cfargument name="area"			type="numeric"	required="yes" hint="filtra el tiempo por areas">
		<cfargument name="estado"		type="numeric"	required="yes" hint="filtra el tiempo por estados">
		<cfargument name="rol"			type="numeric"	required="yes" hint="filtra el tiempo por rol">
		<cfargument name="fechaInicio"	type="string"	required="yes" hint="filtra el tiempo por fecha de inicio">
		<cfargument name="fechaFin"		type="string"	required="yes" hint="filtra el tiempo por fecha de fin">
<!--- 		<cfquery name="qEstados" datasource="DS_PDIPIMP">
			SELECT SUM(TEMPFECHA) AS TEMPFECHA
			FROM(
				SELECT
					CASE
						WHEN BHI.BHI_FECHA_TERMINO IS NULL THEN 
							SYSDATE - BHI.BHI_FECHA_MODIFICACION
						WHEN BHI.BHI_FECHA_TERMINO IS NOT NULL THEN
							BHI.BHI_FECHA_TERMINO - BHI.BHI_FECHA_MODIFICACION
					END TEMPFECHA
				FROM	CESBHISTORIAL	BHI,
						CESCESTADO		CER,
						CESCAREA		CAR,
						USRTUSUARIO		TUS
				WHERE	CER.CER_FK_AREA = CAR.CAR_PK_AREA
				AND		BHI.BHI_NUMERO_ESTADO_ACTUAL = CER.CER_PK_ESTADO
				AND		TUS.TUS_PK_USUARIO = BHI.BHI_USUARIO_MODIFICACION
				AND		BHI.BHI_FK_ESTADO = 2
				AND		BHI.BHI_FK_PROCEDIMIENTO = <cfqueryparam value="#application.SIIIS_CTES.PROCEDIMIENTO.CONVENIOS_INV#" cfsqltype="cf_sql_numeric">
				AND		BHI.BHI_REGISTRO_MODIFICACION = <cfqueryparam value="#convenio#" cfsqltype="cf_sql_numeric">
				<cfif area neq 0>
					AND	CER.CER_FK_AREA = <cfqueryparam value="#area#" cfsqltype="cf_sql_numeric">
				</cfif>
				<cfif estado neq 0>
					AND	BHI.BHI_NUMERO_ESTADO_ACTUAL = <cfqueryparam value="#estado#" cfsqltype="cf_sql_numeric">
				</cfif>
				<cfif rol neq 0>
					AND	TUS.TUS_FK_ROL = <cfqueryparam value="#rol#" cfsqltype="cf_sql_numeric">
				</cfif>
				)
		</cfquery>
		<cfreturn qEstados> --->
		<cfstoredproc procedure="P_ADMON_ESTADOS.TIEMPO_TRANSCURRIDO" datasource="DS_PDIPIMP">
			<cfprocparam value="#proced#"		cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#convenio#"		cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#area#"			cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#estado#"		cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#rol#"			cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#fechaInicio#"	cfsqltype="cf_sql_varchar" type="in">
			<cfprocparam value="#fechaFin#"		cfsqltype="cf_sql_varchar" type="in">
			<cfprocparam variable="respuesta"	cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn respuesta>
	</cffunction>

</cfcomponent>