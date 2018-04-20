<!---
* =========================================================================
* IPN - CSII
* Sistema:		CVU
* Modulo:		Asignación de Responsables
* Fecha:		Marzo de 2017
* Descripcion:	DAO para la asignación de responsables.
* Autor: 		Roberto Cadena
* =========================================================================
--->
<cfcomponent <!--- accessors="true" singleton --->>

	<!--- *********************** Inicio de funciones de Analistas *********************** --->
	
	<cffunction name="getFormatos" access="public" hint="Obtiene los formatos">
		<cfargument name="dependencia" type="string" required="yes">
		<cfif dependencia eq 'todos'>
			<cfquery name="respuesta" datasource="DS_CVU">
				SELECT
					TFR.TFR_PK_FORMATO	AS PKFORMATO,
					CFT.CFT_NOMBRE		AS FORMATO,
					CFT.CFT_CLAVE		AS CLAVEFORMATO,
					TUR.TUR_PK_UR		AS PKDEPENDENCIA,
					TUR.TUR_NOMBRE		AS DEPENDENCIA,
					TUR.TUR_SIGLA		AS SIGLASDEPENDENCIA
				FROM
					CVU.EVTTFORMATO		TFR,
					CVU.CESCESTADO			CER,
					CVU.EVTCFORMATO		CFT,
					UR.TUR					TUR
				WHERE
					TFR.TFR_FK_CFORMATO = CFT.CFT_PK_FORMATO
				AND
					TFR.TFR_FK_CESTADO	= CER.CER_PK_ESTADO
				AND
					CER.CER_NUMERO_ESTADO > 0
				AND
					TUR.TUR_PK_UR = TFR.TFR_FK_UR
				GROUP BY
					TFR.TFR_PK_FORMATO,
					CFT.CFT_NOMBRE,
					CFT.CFT_CLAVE,
					TUR.TUR_PK_UR,
					TUR.TUR_NOMBRE,
					TUR.TUR_SIGLA
				ORDER BY
					DEPENDENCIA	ASC,
					PKFORMATO	ASC
			</cfquery>
		<cfelse>
			<cfquery name="respuesta" datasource="DS_CVU">
				SELECT
					TFR.TFR_PK_FORMATO	AS PKFORMATO,
					CFT.CFT_NOMBRE		AS FORMATO,
					CFT.CFT_CLAVE		AS CLAVEFORMATO,
					TUR.TUR_PK_UR		AS PKDEPENDENCIA,
					TUR.TUR_NOMBRE		AS DEPENDENCIA,
					TUR.TUR_SIGLA		AS SIGLASDEPENDENCIA
				FROM
					CVU.EVTTFORMATO		TFR,
					CVU.CESCESTADO			CER,
					CVU.EVTCFORMATO		CFT,
					UR.TUR					TUR
				WHERE
					TFR.TFR_FK_CFORMATO = CFT.CFT_PK_FORMATO
				AND
					TFR.TFR_FK_CESTADO	= CER.CER_PK_ESTADO
				AND
					CER.CER_NUMERO_ESTADO > 0
				AND
					TUR.TUR_PK_UR = TFR.TFR_FK_UR
				AND
					TUR.TUR_PK_UR = '#dependencia#'
				GROUP BY
					TFR.TFR_PK_FORMATO,
					CFT.CFT_NOMBRE,
					CFT.CFT_CLAVE,
					TUR.TUR_PK_UR,
					TUR.TUR_NOMBRE,
					TUR.TUR_SIGLA
				ORDER BY
					DEPENDENCIA		ASC,
					PKFORMATO		ASC
			</cfquery>
		</cfif>
		<cfreturn respuesta>
	</cffunction>

	<cffunction name="getAllAnalistas" access="public" hint="Obtiene todos los analistas">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT
				TUS.TUS_PK_USUARIO										AS PKUSUARIO,
				TUS.TUS_USUARIO_NOMBRE||' '||TUS.TUS_USUARIO_PATERNO	AS USUARIO
			FROM
				CVU.USRTUSUARIO TUS
			WHERE
				TUS.TUS_FK_ESTADO > 0
			AND
				TUS.TUS_FK_ROL = 3
			ORDER BY
				PKUSUARIO ASC
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<cffunction name="insertarAsociacionAnalistas" access="public" hint="Inserta un Analista a un formato">
		<cfargument name="idFormato"	type="numeric" required="yes">
		<cfargument name="idAnalista"	type="numeric" required="yes">
		<cfstoredproc procedure="CVU.P_ASIGNACION_RESPONSABLES.INSERTARASOCIACIONANALISTAS" datasource="DS_CVU">
			<cfprocparam value="#idFormato#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#idAnalista#"cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam variable="resultado"cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>

		<cfreturn resultado>
	</cffunction>

	<cffunction name="eliminarAsociacionAnalistas" access="public" hint="Elimina un Analista a un formato">
		<cfargument name="idFormato"	type="numeric" required="yes">
		<cfargument name="idAnalista"	type="numeric" required="yes">
		<cfstoredproc procedure="CVU.P_ASIGNACION_RESPONSABLES.ELIMINARASOCIACIONANALISTAS" datasource="DS_CVU">
			<cfprocparam value="#idFormato#"	cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#idAnalista#"	cfsqltype="cf_sql_numeric" type="in">
		</cfstoredproc>
		<cfreturn 1>
	</cffunction>

	<cffunction name="insertarTodosAnalistas" access="public" hint="Elimina un responsable a todos los formatos de una dependencia">
		<cfargument name="idAnalista"	type="numeric" required="yes">
		<cfargument name="idDependencia"type="string" required="yes">
			<cfstoredproc procedure="CVU.P_ASIGNACION_RESPONSABLES.INSERTARTODOSANALISTAS" datasource="DS_CVU">
				<cfprocparam value="#idAnalista#"	cfsqltype="cf_sql_numeric" type="in">
				<cfprocparam value="#idDependencia#"cfsqltype="CF_SQL_VARCHAR" type="in">
			</cfstoredproc>
		<cfreturn 1>
	</cffunction>

	<cffunction name="insertarTodosAnalistasNull" access="public" hint="Inserta un responsable a todos los formatos de una dependencia">
		<cfargument name="idAnalista" 	type="numeric" required="yes">
		<cfargument name="idDependencia"type="string" required="yes">
		<cfstoredproc procedure="CVU.P_ASIGNACION_RESPONSABLES.INSERTARTODOSANALISTASNULL" datasource="DS_CVU">
			<cfprocparam value="#idAnalista#"	cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#idDependencia#"cfsqltype="CF_SQL_VARCHAR" type="in">
		</cfstoredproc>
		<cfreturn 1>	
	</cffunction>

	<cffunction name="usrFor" access="public" hint="Obtiene los usuarios asociados a un formato">
		<cfargument name="dependencia" type="string" required="yes">
		<cfif dependencia eq 'todos'>
			<cfquery name="respuesta" datasource="DS_CVU">
				SELECT
					TRU.TRU_FK_FORMATO	AS PKFORMATO,
					TUR.TUR_PK_UR		AS PKDEPENDENCIA,
					TUR.TUR_NOMBRE		AS DEPENDENCIA,
					TRU.TRU_FK_USUARIO	AS PKUSUARIO
				FROM
					CVU.EVTRUSUARIOFORMATO TRU,
					CVU.EVTCFORMATO		CFT,
					CVU.EVTTFORMATO		TFR,
					CVU.CESCESTADO 		CER,
					UR.TUR					TUR
				WHERE
					TFR.TFR_PK_FORMATO = TRU.TRU_FK_FORMATO
				AND
					TFR.TFR_FK_CFORMATO = CFT.CFT_PK_FORMATO
				AND
					TFR.TFR_FK_CESTADO	= CER.CER_PK_ESTADO
				AND
					CER.CER_NUMERO_ESTADO > 0
				AND	
					TUR.TUR_PK_UR = TFR.TFR_FK_UR
				AND
					TRU.TRU_ESTADO > 0
				ORDER BY
					DEPENDENCIA		ASC,
					PKFORMATO		ASC,
					PKUSUARIO		ASC
			</cfquery>
		<cfelse>
			<cfquery name="respuesta" datasource="DS_CVU">
				SELECT
					TRU.TRU_FK_FORMATO	AS PKFORMATO,
					TUR.TUR_PK_UR		AS PKDEPENDENCIA,
					TUR.TUR_NOMBRE		AS DEPENDENCIA,
					TRU.TRU_FK_USUARIO	AS PKUSUARIO
				FROM
					CVU.EVTRUSUARIOFORMATO TRU,
					CVU.EVTCFORMATO		CFT,
					CVU.EVTTFORMATO		TFR,
					CVU.CESCESTADO 		CER,
					UR.TUR					TUR
				WHERE
					TFR.TFR_PK_FORMATO = TRU.TRU_FK_FORMATO
				AND
					TFR.TFR_FK_CFORMATO = CFT.CFT_PK_FORMATO
				AND	
					TUR.TUR_PK_UR = TFR.TFR_FK_UR
				AND
					TFR.TFR_FK_CESTADO	= CER.CER_PK_ESTADO
				AND
					CER.CER_NUMERO_ESTADO > 0
				AND
					TFR.TFR_FK_UR = '#dependencia#'
				AND
					TRU.TRU_ESTADO > 0
				ORDER BY
					DEPENDENCIA		ASC,
					PKFORMATO		ASC,
					PKUSUARIO		ASC
			</cfquery>
		</cfif>
		<cfreturn respuesta>
	</cffunction>

	<cffunction name="formatoNull" access="public" hint="Obtiene los formatos que no tienen asignado un analista">
		<cfargument name="dependencia" type="string" required="yes">
		<cfif dependencia eq 'todos'>
			<cfquery name="respuesta" datasource="DS_CVU">
				SELECT
					TFR.TFR_PK_FORMATO	AS PKFORMATO,
					CFT.CFT_NOMBRE		AS FORMATO,
					CFT.CFT_CLAVE		AS CLAVEFORMATO,
					TUR.TUR_NOMBRE		AS DEPENDENCIA,
					TUR.TUR_SIGLA		AS SIGLASDEPENDENCIA
				FROM
					CVU.EVTCFORMATO	CFT,
					CVU.EVTTFORMATO	TFR,
					CVU.CESCESTADO		CER,
					UR.TUR				TUR
				WHERE
					CFT.CFT_PK_FORMATO = TFR.TFR_FK_CFORMATO
				AND
					TUR.TUR_PK_UR = TFR.TFR_FK_UR
				AND
					TFR.TFR_FK_CESTADO = CER.CER_PK_ESTADO
				AND
					CER.CER_NUMERO_ESTADO > 0 
				AND
					TFR.TFR_PK_FORMATO NOT IN (
						SELECT
							TRU.TRU_FK_FORMATO
						FROM
							CVU.EVTRUSUARIOFORMATO TRU,
							CVU.USRTUSUARIO		TUS
						WHERE
							TUS.TUS_PK_USUARIO = TRU.TRU_FK_USUARIO	
						AND
							TUS.TUS_FK_ROL = 3
						AND
							TRU.TRU_ESTADO = 1)
				GROUP BY 
					TFR.TFR_PK_FORMATO,
					CFT.CFT_NOMBRE,
					CFT.CFT_CLAVE,
					TUR.TUR_NOMBRE,
					TUR.TUR_SIGLA
				ORDER BY
					DEPENDENCIA	ASC,
					PKFORMATO	ASC
			</cfquery>
		<cfelse>
			<cfquery name="respuesta" datasource="DS_CVU">
				SELECT
					TFR.TFR_PK_FORMATO	AS PKFORMATO,
					CFT.CFT_NOMBRE		AS FORMATO,
					CFT.CFT_CLAVE		AS CLAVEFORMATO,
					TUR.TUR_NOMBRE		AS DEPENDENCIA,
					TUR.TUR_SIGLA		AS SIGLASDEPENDENCIA
				FROM
					CVU.EVTCFORMATO	CFT,
					CVU.EVTTFORMATO	TFR,
					CVU.CESCESTADO		CER,
					UR.TUR				TUR
				WHERE
					CFT.CFT_PK_FORMATO = TFR.TFR_FK_CFORMATO
				AND
					TUR.TUR_PK_UR = TFR.TFR_FK_UR
				AND
					TFR.TFR_FK_CESTADO = CER.CER_PK_ESTADO
				AND
					CER.CER_NUMERO_ESTADO > 0 
				AND
					TFR.TFR_PK_FORMATO NOT IN (
						SELECT
							TRU.TRU_FK_FORMATO
						FROM
							CVU.EVTRUSUARIOFORMATO TRU,
							CVU.USRTUSUARIO		TUS
						WHERE
							TUS.TUS_PK_USUARIO = TRU.TRU_FK_USUARIO	
						AND
							TUS.TUS_FK_ROL = 3
						AND
							TRU.TRU_ESTADO = 1)
				AND
					TFR.TFR_FK_UR = '#dependencia#'
				GROUP BY 
					TFR.TFR_PK_FORMATO,
					CFT.CFT_NOMBRE,
					CFT.CFT_CLAVE,
					TUR.TUR_NOMBRE,
					TUR.TUR_SIGLA
				ORDER BY
					DEPENDENCIA	ASC,
					PKFORMATO	ASC
			</cfquery>
		</cfif>
		<cfreturn respuesta>
	</cffunction>

	<!--- *********************** Inicio de funciones de Responsables *********************** --->

	<cffunction name="getFormatosResponsables" access="public" hint="Obtiene los formatos, dependecias">
		<cfargument name="dependencia" type="string" required="yes">
		<cfargument name="pkUsuario">
		<cfif pkUsuario neq ''>
			<cfquery name="respuesta" datasource="DS_CVU">
				SELECT
					TFR.TFR_PK_FORMATO	AS PKFORMATO,
					CFT.CFT_NOMBRE		AS FORMATO,
					CFT.CFT_CLAVE		AS CLAVEFORMATO,
					TUR.TUR_PK_UR		AS PKDEPENDENCIA,
					TUR.TUR_NOMBRE		AS DEPENDENCIA,
					TUR.TUR_SIGLA		AS SIGLASDEPENDENCIA
				FROM
					CVU.EVTTFORMATO	TFR,			
					CVU.CESCESTADO		CER,
					CVU.EVTCFORMATO	CFT,
					CVU.USRTUSUARIO	TUS,
					UR.TUR				TUR,
					CVU.EVTRUSUARIOFORMATO	TRU
				WHERE
					TFR.TFR_FK_CFORMATO = CFT.CFT_PK_FORMATO
				AND
					TUR.TUR_PK_UR = TFR.TFR_FK_UR
				AND
					TFR.TFR_FK_CESTADO	= CER.CER_PK_ESTADO
				AND
					CER_NUMERO_ESTADO > 0
				AND				
					TUR.TUR_PK_UR = TUS.TUS_FK_UR (+)
				AND
					TUS.TUS_FK_ESTADO > 0
				AND 
					TUR.TUR_PK_UR = '#dependencia#'
				AND
					TRU.TRU_FK_FORMATO = TFR.TFR_PK_FORMATO
				AND
					TRU.TRU_FK_USUARIO = '#pkUsuario#'
				AND
					TRU.TRU_ESTADO > 0
				GROUP BY
					TFR.TFR_PK_FORMATO,
					CFT.CFT_NOMBRE,
					CFT.CFT_CLAVE,
					TUR.TUR_PK_UR,
					TUR.TUR_NOMBRE,
					TUR.TUR_SIGLA
				ORDER BY
					DEPENDENCIA		ASC,
					PKFORMATO		ASC
			</cfquery>
		<cfelse>
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT
				TFR.TFR_PK_FORMATO	AS PKFORMATO,
				CFT.CFT_NOMBRE		AS FORMATO,
				CFT.CFT_CLAVE		AS CLAVEFORMATO,
				TUR.TUR_PK_UR		AS PKDEPENDENCIA,
				TUR.TUR_NOMBRE		AS DEPENDENCIA,
				TUR.TUR_SIGLA		AS SIGLASDEPENDENCIA
			FROM
				CVU.EVTTFORMATO	TFR,			
				CVU.CESCESTADO		CER,
				CVU.EVTCFORMATO	CFT,
				CVU.USRTUSUARIO	TUS,
				UR.TUR				TUR
			WHERE
				TFR.TFR_FK_CFORMATO = CFT.CFT_PK_FORMATO
			AND
				TUR.TUR_PK_UR = TFR.TFR_FK_UR
			AND
				TFR.TFR_FK_CESTADO	= CER.CER_PK_ESTADO
			AND
				CER.CER_NUMERO_ESTADO > 0
			AND				
				TUR.TUR_PK_UR = TUS.TUS_FK_UR (+)
			AND
				TUS.TUS_FK_ESTADO > 0
			AND 
				TUR.TUR_PK_UR = '#dependencia#'
			GROUP BY
				TFR.TFR_PK_FORMATO,
				CFT.CFT_NOMBRE,
				CFT.CFT_CLAVE,
				TUR.TUR_PK_UR,
				TUR.TUR_NOMBRE,
				TUR.TUR_SIGLA
			ORDER BY
				DEPENDENCIA		ASC,
				PKFORMATO		ASC
		</cfquery>
		</cfif>
		<cfreturn respuesta>
	</cffunction>

	<cffunction name="getAllFormatosUsuarios" access="public" hint="Obtiene los formatos, dependecias y usuarios">
		<cfargument name="dependencia" type="string" required="yes">
		<cfargument name="pkUsuario">
		<cfif pkUsuario neq ''>
			<cfquery name="respuesta" datasource="DS_CVU">
				SELECT
					TFR.TFR_PK_FORMATO										AS PKFORMATO,
					TUR.TUR_PK_UR											AS PKDEPENDENCIA,
					TUR.TUR_NOMBRE 											AS DEPENDENCIA,
					TUS.TUS_PK_USUARIO										AS PKUSUARIO,
					TUS.TUS_USUARIO_NOMBRE||' '||TUS.TUS_USUARIO_PATERNO	AS USUARIO
				FROM
					CVU.EVTTFORMATO		TFR,			
					CVU.CESCESTADO			CER,
					CVU.EVTCFORMATO		CFT,
					CVU.USRTUSUARIO		TUS,
					UR.TUR					TUR,
					CVU.EVTRUSUARIOFORMATO	TRU
				WHERE
					TFR.TFR_FK_CFORMATO = CFT.CFT_PK_FORMATO
				AND
					TUR.TUR_PK_UR = TFR.TFR_FK_UR
				AND
					TFR.TFR_FK_CESTADO	= CER.CER_PK_ESTADO
				AND
					CER_NUMERO_ESTADO > 0
				AND
					TUR.TUR_PK_UR = TUS.TUS_FK_UR (+)
				AND
					TUS.TUS_FK_ESTADO > 0
				AND 
					TUR.TUR_PK_UR = '#dependencia#'
				AND
					TRU.TRU_FK_FORMATO = TFR.TFR_PK_FORMATO
				AND
					TRU.TRU_FK_USUARIO = '#pkUsuario#'
				AND
					TRU.TRU_ESTADO > 0
				ORDER BY
					DEPENDENCIA		ASC,
					PKFORMATO		ASC,
					PKUSUARIO		ASC
			</cfquery>
		<cfelse>
			<cfquery name="respuesta" datasource="DS_CVU">
				SELECT
					TFR.TFR_PK_FORMATO										AS PKFORMATO,
					TUR.TUR_PK_UR											AS PKDEPENDENCIA,
					TUR.TUR_NOMBRE 											AS DEPENDENCIA,
					TUS.TUS_PK_USUARIO										AS PKUSUARIO,
					TUS.TUS_USUARIO_NOMBRE||' '||TUS.TUS_USUARIO_PATERNO	AS USUARIO
				FROM
					CVU.EVTTFORMATO	TFR,			
					CVU.CESCESTADO		CER,
					CVU.EVTCFORMATO	CFT,
					CVU.USRTUSUARIO	TUS,
					UR.TUR				TUR
				WHERE
					TFR.TFR_FK_CFORMATO = CFT.CFT_PK_FORMATO
				AND
					TUR.TUR_PK_UR = TFR.TFR_FK_UR
				AND
					TFR.TFR_FK_CESTADO	= CER.CER_PK_ESTADO
				AND
					CER_NUMERO_ESTADO > 0
				AND
					TUR.TUR_PK_UR = TUS.TUS_FK_UR (+)
				AND
					TUS.TUS_FK_ESTADO > 0
				AND 
					TUR.TUR_PK_UR = '#dependencia#'
				ORDER BY
					DEPENDENCIA		ASC,
					PKFORMATO		ASC,
					PKUSUARIO		ASC
			</cfquery>
		</cfif>
		<cfreturn respuesta>
	</cffunction>

	<cffunction name="getAllDependenciasUsuarios" access="public" hint="Obtiene las dependecias y usuarios">
		<cfargument name="dependencia" type="string" required="yes">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT
				TUS.TUS_USUARIO_NOMBRE||' '||TUS.TUS_USUARIO_PATERNO	AS USUARIO,
				TUR.TUR_PK_UR											AS PKDEPENDENCIA,
				TUR.TUR_NOMBRE											AS DEPENDENCIA,
				TUS.TUS_PK_USUARIO										AS PKUSUARIO
			FROM
				CVU.EVTTFORMATO	TFR,
				CVU.CESCESTADO		CER,
				CVU.EVTCFORMATO	CFT,
				CVU.USRTUSUARIO	TUS,
				UR.TUR				TUR
			WHERE
				TFR.TFR_FK_CFORMATO = CFT.CFT_PK_FORMATO
			AND
				TUR.TUR_PK_UR = TFR.TFR_FK_UR
			AND
				TUR.TUR_PK_UR = TUS.TUS_FK_UR (+)
			AND
				TFR.TFR_FK_CESTADO	= CER.CER_PK_ESTADO
			AND
				CER.CER_NUMERO_ESTADO > 0
			AND
				TUS.TUS_FK_ESTADO > 0
			AND 
				TUR.TUR_PK_UR = '#dependencia#'
			GROUP BY
				TUS.TUS_USUARIO_NOMBRE||' '||TUS.TUS_USUARIO_PATERNO,
				TUR.TUR_PK_UR,
				TUR.TUR_NOMBRE,
				TUS.TUS_PK_USUARIO
			ORDER BY
				DEPENDENCIA		ASC,
				PKUSUARIO		ASC
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<cffunction name="usrForDependencia" access="public" hint="Obtiene los usuarios asociados a un formato">
		<cfargument name="dependencia" type="string" required="yes">
		<cfargument name="pkUsuario">
		<cfif pkUsuario neq ''>
			<cfquery name="respuesta" datasource="DS_CVU">
				SELECT
					TRU.TRU_FK_FORMATO	AS PKFORMATO,
					TRU.TRU_FK_USUARIO	AS PKUSUARIO
				FROM
					CVU.EVTRUSUARIOFORMATO TRU,
					CVU.EVTTFORMATO		TFR,
					CVU.CESCESTADO			CER,
					(	SELECT
							TFR.TFR_PK_FORMATO	AS PKFORMATO
						FROM
							CVU.EVTTFORMATO	TFR,
							CVU.USRTUSUARIO	TUS,
							CVU.EVTRUSUARIOFORMATO	TRU
						WHERE
							TFR.TFR_FK_UR = '#dependencia#'
						AND
							TUS.TUS_FK_ESTADO > 0
						AND
							TRU.TRU_FK_FORMATO = TFR.TFR_PK_FORMATO
						AND
							TRU.TRU_FK_USUARIO = '#pkUsuario#'
						AND
							TRU.TRU_ESTADO > 0
						GROUP BY
							TFR.TFR_PK_FORMATO
					) FILTRO
				WHERE
					TFR.TFR_PK_FORMATO = TRU.TRU_FK_FORMATO
				AND
					TFR.TFR_FK_CESTADO	= CER.CER_PK_ESTADO
				AND
					CER.CER_NUMERO_ESTADO > 0
				AND
					TFR.TFR_FK_UR = '#dependencia#'
				AND
					TRU.TRU_ESTADO > 0
				AND 
					TFR.TFR_PK_FORMATO = FILTRO.PKFORMATO
				ORDER BY
					PKFORMATO	ASC,
					PKUSUARIO	ASC
			</cfquery>
		<cfelse>		
			<cfquery name="respuesta" datasource="DS_CVU">
				SELECT
					TRU.TRU_FK_FORMATO	AS PKFORMATO,
					TRU.TRU_FK_USUARIO	AS PKUSUARIO
				FROM
					CVU.EVTRUSUARIOFORMATO TRU,
					CVU.EVTTFORMATO		TFR,
					CVU.CESCESTADO			CER
				WHERE
					TFR.TFR_PK_FORMATO = TRU.TRU_FK_FORMATO
				AND
					TFR.TFR_FK_CESTADO	= CER.CER_PK_ESTADO
				AND
					CER.CER_NUMERO_ESTADO > 0
				AND
					TFR.TFR_FK_UR = '#dependencia#'
				AND
					TRU.TRU_ESTADO > 0
				ORDER BY
					PKFORMATO	ASC,
					PKUSUARIO	ASC
			</cfquery>
		</cfif>
		<cfreturn respuesta>
	</cffunction>

	<cffunction name="getDependenciasAsociadas" access="public" hint="Obtiene los formatos, dependecias y usuarios">
		<cfargument name="pkUsuario">
		<cfif pkUsuario neq ''>
			<cfquery name="respuesta" datasource="DS_CVU">
				SELECT
					TUR.TUR_PK_UR	AS PKDEPENDENCIA,
					TUR.TUR_NOMBRE	AS DEPENDENCIA,
					TUR.TUR_SIGLA	AS SIGLASDEPENDENCIA
				FROM
					CVU.EVTTFORMATO		TFR,
					CVU.CESCESTADO			CER,
					CVU.EVTCFORMATO		CFT,
					UR.TUR					TUR,
					CVU.EVTRUSUARIOFORMATO	TRU
				WHERE
					TFR.TFR_PK_FORMATO = CFT.CFT_PK_FORMATO
				AND
					TUR.TUR_PK_UR = TFR.TFR_FK_UR
				AND
					TFR.TFR_FK_CESTADO	= CER.CER_PK_ESTADO
				AND
					TRU.TRU_FK_FORMATO = TFR.TFR_PK_FORMATO
				AND
					TRU.TRU_FK_USUARIO = '#pkUsuario#'
				AND
					TRU.TRU_ESTADO > 0
				AND
					CER.CER_NUMERO_ESTADO > 0
				GROUP BY
					TUR.TUR_PK_UR,
					TUR.TUR_NOMBRE,
					TUR.TUR_SIGLA
				ORDER BY
					SIGLASDEPENDENCIA
			</cfquery>
		<cfelse>
			<cfquery name="respuesta" datasource="DS_CVU">
				SELECT
					TUR.TUR_PK_UR	AS PKDEPENDENCIA,
					TUR.TUR_NOMBRE	AS DEPENDENCIA,
					TUR.TUR_SIGLA	AS SIGLASDEPENDENCIA
				FROM
					CVU.EVTTFORMATO	TFR,
					CVU.CESCESTADO		CER,
					CVU.EVTCFORMATO	CFT,
					UR.TUR				TUR
				WHERE
					TFR.TFR_PK_FORMATO = CFT.CFT_PK_FORMATO
				AND
					TUR.TUR_PK_UR = TFR.TFR_FK_UR
				AND
					TFR.TFR_FK_CESTADO	= CER.CER_PK_ESTADO
				AND
					CER.CER_NUMERO_ESTADO > 0
				GROUP BY
					TUR.TUR_PK_UR,
					TUR.TUR_NOMBRE,
					TUR.TUR_SIGLA
				ORDER BY
					SIGLASDEPENDENCIA
			</cfquery>
		</cfif>
		<cfreturn respuesta>
	</cffunction>

	<cffunction name="insertarTodosResponsables" access="public" hint="Inserta un responsable a todos los formatos de una dependencia">
		<cfargument name="idAnalista" 	type="numeric" required="yes">
		<cfargument name="idDependencia"type="string" required="yes">
		<cfargument name="pkUsuario"	type="numeric" required="yes">
		<cfstoredproc procedure="CVU.P_ASIGNACION_RESPONSABLES.INSERTARTODOSRESPONSABLES" datasource="DS_CVU">
			<cfprocparam value="#idAnalista#"	cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#idDependencia#"cfsqltype="CF_SQL_VARCHAR" type="in">
			<cfprocparam value="#pkUsuario#"	cfsqltype="cf_sql_numeric" type="in">
		</cfstoredproc>
		<cfreturn 1>	
	</cffunction>

	<cffunction name="eliminarTodosResponsables" access="public" hint="Elimina un usuario de todos los formatos de una dependencia ">
		<cfargument name="idAnalista"	type="numeric" required="yes">
		<cfargument name="idDependencia"type="string" required="yes">
		<cfargument name="pkUsuario"	type="numeric" required="yes">
		<cfstoredproc procedure="CVU.P_ASIGNACION_RESPONSABLES.ELIMINARTODOSRESPONSABLES" datasource="DS_CVU">
			<cfprocparam value="#idAnalista#"	cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#idDependencia#"cfsqltype="CF_SQL_VARCHAR" type="in">
			<cfprocparam value="#pkUsuario#"	cfsqltype="cf_sql_numeric" type="in">
		</cfstoredproc>
		<cfreturn 1>
	</cffunction>

</cfcomponent>