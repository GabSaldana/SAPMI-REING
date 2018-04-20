<cfcomponent>	
	

	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>	

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
	<cffunction name="getCatalogoNacionalidad" hint="Obtiene el catalogo de nacionalidades">
		<cfquery name="res" datasource="DS_SIGADGCH">
			SELECT  CNA_PK_NACIONALIDAD AS PK_NACIONALIDAD,
	       	 		CNA_NACIONALIDAD    AS NACIONALIDAD
			FROM    SIGADGCH.CNACIONALIDAD
			ORDER BY CNA_PK_NACIONALIDAD
		</cfquery>
		<cfreturn res>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
	<cffunction name="getCatalogoPaises" hint="Obtiene el catalogo de paises">
		<cfquery name="res" datasource="DS_SIGADGCH">
			SELECT 	CPAISES.CPA_PK_PAIS AS PK_PAIS, 
					  	CPAISES.CPA_NOMBRE  AS NOMBRE_PAIS
		  FROM 		UR.CUR_PAIS CPAISES
     	WHERE 	CPAISES.CPA_PK_PAIS <> 244
		  ORDER BY CPAISES.CPA_PK_PAIS
		</cfquery>
		<cfreturn res>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
	<cffunction name="getClasificacionByFecha">
		<cfargument name="fecha" type="date" required="yes"> 
		<cfstoredproc procedure="UR.UNIDADESRESPONSABLES.loadClasifByFecha" datasource="DS_UR">
			<cfprocparam cfsqltype="cf_sql_date" type="in" value="#arguments.fecha#">
			<cfprocresult name="resultado">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
	<cffunction name="getUrByFechaClasif" hint="Obtiene el catalogo de dependencias con respecto a una clasificacion">				
		<cfargument name="fecha" type="date" required="yes">
		<cfargument name="nivel" type="string" required="yes">
		<cfstoredproc procedure="UR.UNIDADESRESPONSABLES.loadUrByFechaClasif" datasource="DS_UR">
			<cfprocparam cfsqltype="cf_sql_date" type="in" value="#arguments.fecha#">
			<cfprocparam cfsqltype="cf_sql_varchar" type="in" value="#arguments.nivel#">
			<cfprocresult name="resultado">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="obtenerDireccion" hint="Obtiene la direccion usando el codigo postal">
    <cfargument name="codigoPostal" hint="Codigo postal">
      <!--- <cfquery name="respuesta" datasource="DS_URS"> --->
      <cfquery name="respuesta" datasource="DS_UR">
        <!---SELECT  CCO.CCO_PK_COLONIA    AS PK_COLONIA,
                  CCO.CCO_FK_DELOMNCP   AS PK_DELMUN,
                  CDM.CDM_FK_ESTADO     AS PK_ESTADO,
                  UPPER(CCO.CCO_NOMBRE) AS COLONIA,
                  UPPER(CDM.CDM_NOMBRE) AS DELMUNICIPIO,
                  UPPER(CES.CES_NOMBRE) AS ESTADO
            FROM  URS.URSCCOLONIA        CCO,
                  URS.URSCDELOMNCP       CDM,
                  URS.URSCESTADO         CES
           WHERE  CCO.CCO_CP = <cfqueryparam value="#codigoPostal#" cfsqltype="cf_sql_varchar">
                  AND CDM.CDM_PK_DELOMNCP = CCO.CCO_FK_DELOMNCP
                  AND CDM.CDM_FK_ESTADO   = CES.CES_PK_ESTADO
        ORDER BY  COLONIA--->
				SELECT  COL.CCO_PK_COLONIA    AS PK_COLONIA,
								COL.CCO_FK_DELOMNCP   AS PK_DELMUN,
								DEL.CDM_FK_ESTADO     AS PK_ESTADO,
								UPPER(COL.CCO_NOMBRE) AS COLONIA,
								UPPER(DEL.CDM_NOMBRE) AS DELMUNICIPIO,
								UPPER(EDO.CES_NOMBRE) AS ESTADO
				FROM    UR.CUR_COLONIA COL,
				        UR.CUR_DELOMNCP DEL,
				        UR.CUR_ESTADO   EDO
				WHERE   EDO.CES_PK_ESTADO = DEL.CDM_FK_ESTADO
				AND     DEL.CDM_PK_DELOMNCP = COL.CCO_FK_DELOMNCP
				AND     COL.CCO_CP = <cfqueryparam value="#codigoPostal#" cfsqltype="cf_sql_varchar">
				ORDER BY COLONIA
      </cfquery>
      <cfreturn respuesta>
  </cffunction>

  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getCPbyColonia" hint="Obtiene el cp usando el pk de la colonia">
    <cfargument name="pkColonia" hint="pk de la Colonia">
      <cfquery name="respuesta" datasource="DS_UR">
      <!---<cfquery name="respuesta" datasource="DS_URS">--->
      <!---	SELECT 	to_char(CCO.CCO_CP,'FM00000') AS CP				      	
				FROM  	URS.URSCCOLONIA        CCO				      	
				WHERE 	CCO.CCO_PK_COLONIA 	= <cfqueryparam value="#pkColonia#" cfsqltype="cf_sql_varchar">	      --->
				SELECT 	to_char(COL.CCO_CP ,'FM00000') AS CP				      	
				FROM  	UR.CUR_COLONIA COL				      	
				WHERE 	COL.CCO_PK_COLONIA = <cfqueryparam value="#pkColonia#" cfsqltype="cf_sql_varchar">
      </cfquery>
      <cfreturn respuesta>
  </cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getPersona" hint="obtiene el pk de una persona">
		<cfargument name="pkUsuario" hint="pk del usuario">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT	TPS_PK_PERSONA	AS PKPERSONA
			 FROM	CVUTPERSONA
			WHERE	TPS_FK_USUARIO = <cfqueryparam value="#pkUsuario#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEscolaridad" hint="Obtiene la escolaridad con base en un pk">
	<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT
				TES.TES_PK_TESCOLARIDAD		AS PKESCOLARIDAD,
				CES.CES_ESCOLARIDAD			AS NIVEL,
				TES.TES_CAMPO_CONOCIMIENTO	AS CAMPO_CONOCIMIENTO,
				TES.TES_ESCUELA				AS INSTITUCION,
				TES.TES_FK_ESTADO			AS ESTADO
			 FROM
			 	CVUTESCOLARIDAD TES,
			 	CVUCESCOLARIDAD CES
			WHERE
				TES.TES_FK_CESCOLARIDAD = CES_PK_ESCOLARIDAD
			 AND
			 	TES.TES_FK_PERSONA = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			 AND
			 	CES.CES_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			 AND
			 	(TES.TES_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		     OR
		     	TES.TES_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.EDICION#" cfsqltype="cf_sql_numeric">)
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEmpleos" hint="Obtiene los Empleos con base en un pk">
	<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT
				TEM_PK_EMPLEOS								AS PKEMLEOS,
				TEM_FK_PERSONA								AS PKPERSONA,
				TEM_PUESTO									AS PUESTO,
				TEM_LUGAR									AS LUGAR,
				TO_CHAR(TEM_FECHAINICIO,	'DD/MM/YYYY')	AS INICIO,
				TO_CHAR(TEM_FECHATERMINO,	'DD/MM/YYYY')	AS TERMINO
			 FROM
			 	CVUTEMPLEOS
			WHERE
				TEM_FK_PERSONA = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			 AND
			 	(TEM_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			 OR
			 	TEM_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.EDICION#" cfsqltype="cf_sql_numeric">)
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getBecas" hint="Obtiene los Becas con base en un pk">
	<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT	TBE.TBE_FK_PERSONA								AS PKPERSONA,
					TBE.TBE_PK_TBECAS								AS PKREGISTRO,
					TO_CHAR(TBE.TBE_FECHAINICIO,	'DD/MM/YYYY')	AS INICIO,
					TO_CHAR(TBE.TBE_FECHATERMINO,	'DD/MM/YYYY')	AS TERMINO,
					TBE.TBE_PK_TBECAS								AS PKREGISTRO,
					TBE.TBE_FK_CBECASNIVEL							AS PKNIVEL,
					CBN.CBN_NIVEL									AS NIVEL,
					CBN.CBN_FK_CBECAS								AS PKBECA,
					CBE.CBE_BECAS									AS BECA,
					TBE.TBE_FK_ESTADO								AS ESTADO
			 FROM	CVUTBECAS		TBE,
			 		CVUCBECASNIVEL	CBN,
			 		CVUCBECAS		CBE
			WHERE	TBE.TBE_FK_CBECASNIVEL	= CBN.CBN_PK_BECASNIVEL
			 AND	CBN.CBN_FK_CBECAS 		= CBE.CBE_PK_BECAS
			 AND	TBE.TBE_FK_PERSONA		= <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			 AND 	CBN.CBN_FK_ESTADO		= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			 AND	CBE.CBE_FK_ESTADO		= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			 AND 	(TBE.TBE_FK_ESTADO		= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			  OR	TBE.TBE_FK_ESTADO		= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.EDICION#" cfsqltype="cf_sql_numeric">)
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getNiveles" hint="Obtiene todos los niveles educativos existentes">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT	CES_ESCOLARIDAD		AS NIVEL,
					CES_PK_ESCOLARIDAD	AS PKNIVEL
			 FROM	CVUCESCOLARIDAD
			WHERE	CES_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getNivelesBecas" hint="Obtiene todos los niveles de becas existentes">
	<cfargument name="pkBeca" type="numeric" required="yes" hint="pk de la Beca">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT	CBN_NIVEL 			AS NIVEL,
					CBN_PK_BECASNIVEL	AS PKNIVEL
			 FROM	CVUCBECASNIVEL
			WHERE	CBN_FK_CBECAS = <cfqueryparam value="#pkBeca#" cfsqltype="cf_sql_numeric">
			 AND	CBN_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getCatalogoBecas" hint="Obtiene todas las becas existentes">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT	CBE_BECAS		AS BECA,
					CBE_PK_BECAS	AS PKBECA
			 FROM	CVUCBECAS	
			WHERE	CBE_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getPaises" hint="Obtiene todos los paises">
		<cfquery name="respuesta" datasource="DS_URS">
			SELECT	CPA_PK_PAIS AS PK_PAIS,
					CPA_NOMBRE	AS NOMBRE_PAIS
			FROM	URSCPAIS
			ORDER BY CPA_PK_PAIS
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getPais" hint="Obtiene un pais con base a su pk">
		<cfargument name="pkPais" type="numeric"	required="yes" hint="pk del pais">
		<cfquery name="respuesta" datasource="DS_URS">
			SELECT	CPA_PK_PAIS AS PK_PAIS,
					CPA_NOMBRE	AS NOMBRE_PAIS
			FROM	URSCPAIS
			WHERE	CPA_PK_PAIS = <cfqueryparam value="#pkPais#" cfsqltype="cf_sql_numeric">
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addEscolaridad" hint="agrega escolaridad a una persona">
		<cfargument name="pkPersona"			type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="inNivel"				type="numeric"	required="yes" hint="pk del nivel educatuvo">
		<cfargument name="inInstitucion"		type="string"	required="yes" hint="escuela">
		<cfargument name="inPais"				type="numeric"	required="yes" hint="pk del pais">
		<cfargument name="inCampoConocimiento"	type="string"	required="yes" hint="campo de conocimiento">
		<cfargument name="inCheckPNPC"			type="numeric"	required="yes" hint="pertenece a PNPC">
		<cfargument name="inInicio"				type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"				type="date"		required="yes" hint="fecha de fin">
		<cfargument name="inObtencion"			type="date"		required="yes" hint="fecha de optencion">
		<cfargument name="inCedula"				type="numeric"	required="yes" hint="cedula obtenida">
		<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.ADDESCOLARIDAD" datasource="DS_CVU">
			<cfprocparam value="#pkPersona#"			cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inNivel#"				cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inInstitucion#"		cfsqltype="CF_SQL_VARCHAR"	type="in">
			<cfprocparam value="#inPais#"				cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inCampoConocimiento#"	cfsqltype="CF_SQL_VARCHAR"	type="in">
			<cfprocparam value="#inCheckPNPC#"			cfsqltype="CF_SQL_VARCHAR"	type="in">
			<cfprocparam value="#dateFormat(inInicio,"dd/mm/yyyy")#"				cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#dateFormat(inFin,"dd/mm/yyyy")#"				cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#dateFormat(inObtencion,"dd/mm/yyyy")#"			cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#inCedula#"				cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#application.SIIIP_CTES.ESTADO.EDICION#" cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"			cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addValidarEscolaridad" hint="agrega Becas a una persona">
		<cfargument name="pkEscolaridad"		type="numeric"	required="yes" hint="pk del registro">
		<cfargument name="pkPersona"			type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="pkProceso"			type="numeric"	required="yes" hint="pk del proceso">
		<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.ELIMINARESCOLARIDAD" datasource="DS_CVU">
			<cfprocparam value="#pkEscolaridad#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkPersona#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkProceso#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"		cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addSNI" hint="agrega SNI a una persona">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="inNivel"		type="numeric"	required="yes" hint="pk del nivel educatuvo">
		<cfargument name="inInicio"		type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"		type="date"		required="yes" hint="fecha de fin">
		<cfargument name="inAreaSNI"	type="numeric"	required="yes" hint="pk del area">
		<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.ADDSNI" datasource="DS_CVU">
			<cfprocparam value="#pkPersona#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inNivel#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#dateFormat(inInicio,"dd/mm/yyyy")#"		cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#dateFormat(inFin,"dd/mm/yyyy")#"		cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#application.SIIIP_CTES.ESTADO.EDICION#" cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inAreaSNI#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addValidarSNI" hint="agrega Becas a una persona">
		<cfargument name="pkPersona"		type="numeric"	required="yes" hint="pk de la persona">
		<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.ELIMINARSNI" datasource="DS_CVU">
			<cfprocparam value="#pkPersona#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"		cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addEmpleos" hint="agrega Empleos a una persona">
		<cfargument name="pkPersona"			type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="inPuesto"				type="string"	required="yes" hint="pk lugar">
		<cfargument name="inLugar"				type="string"	required="yes" hint="pk lugar">
		<cfargument name="inInicio"				type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"				type="date"		required="yes" hint="fecha de fin">
		<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.ADDEMPLEOS" datasource="DS_CVU">
			<cfprocparam value="#pkPersona#"			cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inPuesto#"				cfsqltype="CF_SQL_VARCHAR"	type="in">
			<cfprocparam value="#inLugar#"				cfsqltype="CF_SQL_VARCHAR"	type="in">
			<cfprocparam value="#dateFormat(inInicio,"dd/mm/yyyy")#"				cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#dateFormat(inFin,"dd/mm/yyyy")#"				cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#application.SIIIP_CTES.ESTADO.EDICION#" cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"			cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>


	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addBecas" hint="agrega Becas a una persona">
		<cfargument name="pkPersona"		type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="inTipoBeca"		type="numeric"	required="yes" hint="pk tipo beca">
		<cfargument name="inNivelBeca"		type="numeric"	required="yes" hint="pk nivel beca">
		<cfargument name="inCheckReceso"	type="numeric"	required="yes" hint="esta en receso">
		<cfargument name="inInicio"			type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"			type="date"		required="yes" hint="fecha de fin">
		<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.ADDBECAS" datasource="DS_CVU">
			<cfprocparam value="#pkPersona#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inTipoBeca#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inNivelBeca#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inCheckReceso#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#dateFormat(inInicio,"dd/mm/yyyy")#"			cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#dateFormat(inFin,"dd/mm/yyyy")#"			cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#application.SIIIP_CTES.ESTADO.EDICION#" cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"		cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addValidarBecas" hint="agrega Becas a una persona">
		<cfargument name="pkPersona"		type="numeric"	required="yes" hint="pk de la persona">
		<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.ELIMINARBECA" datasource="DS_CVU">
			<cfprocparam value="#pkPersona#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"		cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarEscolaridad" hint="eliminar escolaridad a una persona">
		<cfargument name="pkEscolaridad"	type="numeric"	required="yes" hint="pk de la escolaridad">
		<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.ELIMINARESCOLARIDAD" datasource="DS_CVU">
			<cfprocparam value="#pkEscolaridad#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#application.SIIIP_CTES.ESTADO.CANCELADO#" cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"		cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarSNI" access="public" hint="Obtiene el tiempo transcurrido de un convenio">
		<cfargument name="pkSNI"	type="numeric"	required="yes" hint="pk del SNI">
		<cfstoredproc procedure="P_CVUDATOSGENERALES.ELIMINARSNI" datasource="DS_CVU">
			<cfprocparam value="#pkSNI#"	cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#application.SIIIP_CTES.ESTADO.CANCELADO#"	cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam variable="respuesta"	cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn respuesta>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarEmpleo" access="public" hint="Obtiene el tiempo transcurrido de un convenio">
		<cfargument name="pkEmpleo"	type="numeric"	required="yes" hint="pk del Empleo ">
		<cfstoredproc procedure="P_CVUDATOSGENERALES.eliminarEMPLEO" datasource="DS_CVU">
			<cfprocparam value="#pkEmpleo#"	cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#application.SIIIP_CTES.ESTADO.CANCELADO#"	cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam variable="respuesta"	cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn respuesta>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarBeca" access="public" hint="Obtiene el tiempo transcurrido de un convenio">
		<cfargument name="pkBeca"	type="numeric"	required="yes" hint="pk del Beca">
		<cfstoredproc procedure="P_CVUDATOSGENERALES.ELIMINARBECA" datasource="DS_CVU">
			<cfprocparam value="#pkBeca#"		cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#application.SIIIP_CTES.ESTADO.CANCELADO#"	cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam variable="respuesta"	cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarEscolaridad" hint="consulta una escolaridad con base a un pk de Escolaridad">
		<cfargument name="pkEscolaridad"	type="numeric"	required="yes" hint="pk de la escolaridad">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT	CES.CES_ESCOLARIDAD								AS NIVEL,
					CES.CES_PK_ESCOLARIDAD							AS PKNIVEL,
					TES.TES_CAMPO_CONOCIMIENTO						AS CAMPO_CONOCIMIENTO,
					TES.TES_ESCUELA									AS INSTITUCION,
					TO_CHAR(TES.TES_FECHAINICIO,	'DD/MM/YYYY')	AS INICIO,
					TO_CHAR(TES.TES_FECHATERMINO,	'DD/MM/YYYY')	AS TERMINO,
					TO_CHAR(TES.TES_FECHAOBTENCION,	'DD/MM/YYYY')	AS OBTENCION,
					TES.TES_CEDULAPROFECIONAL						AS CEDULA,
					TES.TES_PNCP									AS PNCP,
					TES_FK_PAIS										AS PAIS 
			 FROM	CVUTESCOLARIDAD TES,
			 		CVUCESCOLARIDAD CES
			WHERE	TES.TES_FK_CESCOLARIDAD = CES.CES_PK_ESCOLARIDAD
			 AND	TES.TES_PK_TESCOLARIDAD = <cfqueryparam value="#pkEscolaridad#" cfsqltype="cf_sql_numeric">
			 AND	CES.CES_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			 AND	(TES.TES_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			 OR		TES.TES_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.EDICION#" cfsqltype="cf_sql_numeric">)
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarEmpleo" hint="consulta un Empleo con base a un pk de Empleo">
		<cfargument name="pkEmpleo"	type="numeric"	required="yes" hint="pk del Empleo">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT
				TEM_PK_EMPLEOS								AS PKEMLEOS,
				TEM_FK_PERSONA								AS PKPERSONA,
				TEM_PUESTO									AS PUESTO,
				TEM_LUGAR									AS LUGAR,
				TO_CHAR(TEM_FECHAINICIO,	'DD/MM/YYYY')	AS INICIO,
				TO_CHAR(TEM_FECHATERMINO,	'DD/MM/YYYY')	AS TERMINO
			 FROM
			 	CVUTEMPLEOS
			WHERE
				TEM_PK_EMPLEOS = <cfqueryparam value="#pkEmpleo#" cfsqltype="cf_sql_numeric">
			 AND
			 	TEM_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarBeca" hint="consulta un Beca con base a un pk de Beca">
		<cfargument name="pkBeca"	type="numeric"	required="yes" hint="pk del Beca">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT
				TBE.TBE_PK_TBECAS								AS PKBECA,
				CBN.CBN_FK_CBECAS								AS PKTIPOBECA,
				CBE.CBE_BECAS									AS TIPOBECA,
				TBE.TBE_FK_PERSONA								AS PKPERSONA,
				TBE.TBE_FK_CBECASNIVEL							AS PKNIVEL,
				CBN.CBN_NIVEL									AS NIVEL,
				TBE.TBE_RECESO									AS RECESO,
				TO_CHAR(TBE.TBE_FECHAINICIO,	'DD/MM/YYYY')	AS INICIO,
				TO_CHAR(TBE.TBE_FECHATERMINO,	'DD/MM/YYYY')	AS TERMINO
			 FROM
			 	CVUTBECAS		TBE,
			 	CVUCBECASNIVEL	CBN,
			 	CVUCBECAS		CBE
			WHERE
				CBN.CBN_PK_BECASNIVEL	= TBE.TBE_FK_CBECASNIVEL
			 AND
				CBN.CBN_FK_CBECAS		= CBE.CBE_PK_BECAS
			 AND
				TBE.TBE_PK_TBECAS		= <cfqueryparam value="#pkBeca#" cfsqltype="cf_sql_numeric">
			 AND
				CBN_FK_ESTADO			= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			 AND
			 	CBE_FK_ESTADO			= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			 AND
			 	(TBE_FK_ESTADO			= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			 OR			 	
			 	TBE_FK_ESTADO			= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.EDICION#" cfsqltype="cf_sql_numeric">)
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="updateEscolaridad" hint="agrega escolaridad a una persona">
		<cfargument name="pkPersona"			type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="inNivel"				type="numeric"	required="yes" hint="pk del nivel educatuvo">
		<cfargument name="inInstitucion"		type="string"	required="yes" hint="escuela">
		<cfargument name="inPais"				type="numeric"	required="yes" hint="pk del pais">
		<cfargument name="inCampoConocimiento"	type="string"	required="yes" hint="campo de conocimiento">
		<cfargument name="inCheckPNPC"			type="numeric"	required="yes" hint="pertenece a PNPC">
		<cfargument name="inInicio"				type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"				type="date"		required="yes" hint="fecha de fin">
		<cfargument name="inObtencion"			type="date"		required="yes" hint="fecha de optencion">
		<cfargument name="inCedula"				type="numeric"	required="yes" hint="cedula obtenida">
		<cfargument name="pkEscolaridad"		type="numeric"	required="yes" hint="pk de la escolaridad">
		<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.UPDATEESCOLARIDAD" datasource="DS_CVU">
			<cfprocparam value="#pkPersona#"			cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inNivel#"				cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inInstitucion#"		cfsqltype="CF_SQL_VARCHAR"	type="in">
			<cfprocparam value="#inPais#"				cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inCampoConocimiento#"	cfsqltype="CF_SQL_VARCHAR"	type="in">
			<cfprocparam value="#inCheckPNPC#"			cfsqltype="CF_SQL_VARCHAR"	type="in">
			<cfprocparam value="#dateFormat(inInicio,"dd/mm/yyyy")#"				cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#dateFormat(inFin,"dd/mm/yyyy")#"				cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#dateFormat(inObtencion,"dd/mm/yyyy")#"			cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#inCedula#"				cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkEscolaridad#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"			cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="updateSNI" hint="agrega SNI a una persona">
		<cfargument name="inNivel"		type="numeric"	required="yes" hint="pk del nivel educatuvo">
		<cfargument name="inInicio"		type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"		type="date"		required="yes" hint="fecha de fin">
		<cfargument name="pkSNI"		type="numeric"	required="yes" hint="pk de la SNI">
		<cfargument name="inAreaSNI"	type="numeric"	required="yes" hint="pk del area">
		<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.UPDATESNI" datasource="DS_CVU">
			<cfprocparam value="#inNivel#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#dateFormat(inInicio,"dd/mm/yyyy")#"		cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#dateFormat(inFin,"dd/mm/yyyy")#"		cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#pkSNI#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inAreaSNI#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="updateEmpleo" hint="actualiza Empleo a una persona">
		<cfargument name="inLugar"		type="string"	required="yes" hint="lugar donde fue empleado">
		<cfargument name="inPuesto"		type="string"	required="yes" hint="puesto del empleado">
		<cfargument name="inInicio"		type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"		type="date"		required="yes" hint="fecha de fin">
		<cfargument name="pkEmpleo"		type="numeric"	required="yes" hint="pk de la Empleo">
			<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.UPDATEEMPLEO" datasource="DS_CVU">
			<cfprocparam value="#inLugar#"		cfsqltype="CF_SQL_VARCHAR"	type="in">
			<cfprocparam value="#inPuesto#"		cfsqltype="CF_SQL_VARCHAR"	type="in">
			<cfprocparam value="#dateFormat(inInicio,"dd/mm/yyyy")#"		cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#dateFormat(inFin,"dd/mm/yyyy")#"		cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#pkEmpleo#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="updateBeca" hint="actualiza Beca a una persona">
		<cfargument name="inTipoBeca"	type="numeric"	required="yes" hint="lugar donde fue empleado">
		<cfargument name="inNivelBeca"	type="numeric"	required="yes" hint="puesto del empleado">
		<cfargument name="receso"		type="numeric"	required="yes" hint="Esta en receso">
		<cfargument name="inInicio"		type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"		type="date"		required="yes" hint="fecha de fin">
		<cfargument name="pkBeca"		type="numeric"	required="yes" hint="pk de la Beca">
			<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.UPDATEBECA" datasource="DS_CVU">
			<cfprocparam value="#inTipoBeca#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#inNivelBeca#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#receso#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#dateFormat(inInicio,"dd/mm/yyyy")#"		cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#dateFormat(inFin,"dd/mm/yyyy")#"		cfsqltype="CF_SQL_DATE"		type="in">
			<cfprocparam value="#pkBeca#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getHistorialSNI" hint="obtiene el historial de SNI">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de la persona">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT	TSN.TSN_PK_TSNI									AS PKSNI,
					TSN.TSN_FK_PERSONA								AS PKPERSONA,
					TO_CHAR(TSN.TSN_FECHAINICIO,	'DD/MM/YYYY')	AS INICIO,
					TO_CHAR(TSN.TSN_FECHATERMINO,	'DD/MM/YYYY')	AS TERMINO,
					CSN.CSN_NOMBRE_SNI								AS NIVEL,
					TSA.TSA_PK_SNIAREA								AS PKAREASNI,
					TSA.TSA_NOMBREAREA								AS NOMBREAREA,
					TSN.TSN_FK_ESTADO								AS ESTADO
			 FROM	CVUTSNI	TSN,
			 		CVUCSNI	CSN,
			 		CVUTSNIAREA	TSA
			WHERE	CSN.CSN_PK_SNI = TSN.TSN_FK_CSNI
			 AND	TSA.TSA_PK_SNIAREA = TSN.TSN_FK_SNIAREA
			 AND 	TSN.TSN_FECHATERMINO IS NOT NULL
			 AND 	TSN.TSN_FK_PERSONA = <cfqueryparam cfsqltype="cf_sql_numeric" value="#pkPersona#">
			 AND	CSN.CSN_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			 AND	TSA.TSA_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			 AND	(TSN.TSN_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			  OR	TSN.TSN_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.EDICION#" cfsqltype="cf_sql_numeric">)
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarSNI" hint="obtiene el historial de SNI">
		<cfargument name="pkSNI"	type="numeric"	required="yes" hint="pk del SNI">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT	TSN.TSN_PK_TSNI									AS PKSNI,
					TSN.TSN_FK_PERSONA								AS PKPERSONA,
					TO_CHAR(TSN.TSN_FECHAINICIO,	'DD/MM/YYYY')	AS INICIO,
					TO_CHAR(TSN.TSN_FECHATERMINO,	'DD/MM/YYYY')	AS TERMINO,
					CSN.CSN_PK_SNI									AS PKNIVEL,
					CSN.CSN_NOMBRE_SNI								AS NIVEL,
					TSA.TSA_PK_SNIAREA								AS PKAREASNI,
					TSA.TSA_NOMBREAREA								AS NOMBREAREA
			 FROM	CVUTSNI		TSN,
			 		CVUCSNI		CSN,
			 		CVUTSNIAREA	TSA
			WHERE	TSN.TSN_PK_TSNI = <cfqueryparam value="#pkSNI#" cfsqltype="cf_sql_numeric">
			 AND	CSN.CSN_PK_SNI = TSN.TSN_FK_CSNI
			 AND	TSA.TSA_PK_SNIAREA = TSN.TSN_FK_SNIAREA
			 AND	CSN.CSN_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			 AND	TSA.TSA_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			 AND	(TSN.TSN_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			  OR	TSN.TSN_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.EDICION#" cfsqltype="cf_sql_numeric">)
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAreaSNI" hint="obtiene el area de SNI">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT	TSA_PK_SNIAREA	AS PKAREASNI,
					TSA_NOMBREAREA	AS NOMBREAREA
			 FROM	CVUTSNIAREA
			WHERE	TSA_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getRedesCheck" hint="obtiene las redes de investigación de un SNI de una persona">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de la persona">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT	CRE.CRE_PK_REDESINV	AS PKRED,
					CRE.CRE_DESCRIPCION	AS RED
			 FROM	CVU.CVUTREDESINV	TRE,
			 		CVU.CVUCREDESINV	CRE
			WHERE	TRE.TRE_FK_CREDESINV = CRE.CRE_PK_REDESINV
			 AND		TRE.TRE_FK_PERSONA	= <cfqueryparam cfsqltype="cf_sql_numeric" value="#pkPersona#">
			 AND		CRE.CRE_FK_ESTADO	= <cfqueryparam cfsqltype="cf_sql_numeric" value="#application.SIIIP_CTES.ESTADO.VALIDADO#">
			 AND		TRE.TRE_FK_ESTADO	= <cfqueryparam cfsqltype="cf_sql_numeric" value="#application.SIIIP_CTES.ESTADO.VALIDADO#">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getRedesInv" hint="obtiene las redes de investigación">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT	CRE_PK_REDESINV	AS PKRED,
					CRE_DESCRIPCION	AS RED
			 FROM	CVUCREDESINV
			WHERE	CRE_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getNivelSNI" hint="obtiene los niveles de SNI">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT	CSN_PK_SNI 		AS PKNIVEL,
					CSN_NOMBRE_SNI	AS NIVEL
			 FROM	CVUCSNI
			WHERE	CSN_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="updateRed" access="public" hint="Obtiene el tiempo transcurrido de un convenio">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="pkRed"		type="numeric"	required="yes" hint="pk de la red de investigacion">
		<cfargument name="contenido"	type="numeric"	required="yes" hint="contenido de la red">
		<cfstoredproc procedure="P_CVUDATOSGENERALES.UPDATERED" datasource="DS_CVU">
			<cfprocparam value="#pkPersona#"	cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#pkRed#"		cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#contenido#"	cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam variable="respuesta"	cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn respuesta>
	</cffunction>

  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="registrar_investigador" hint="Llama al procedure para registrar un investigador en TPERSONA">
  	<cfargument name="numEmpleado" 		type="string" required="true" hint="Numero de Empleado">
  	<cfargument name="curpEmpleado" 	type="string" required="true" hint="CURP del Empleado">
  	<cfargument name="tipoPlaza" 			type="string" required="true" hint="Categoria de la Plaza">
  	<cfargument name="correoEmpleado" type="string" required="true" hint="Correo del empleado">
  	<cfstoredproc procedure="CVU.P_CVUREGISTRO.REG_INVESTIGADOR" datasource="DS_CVU">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#numEmpleado#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#curpEmpleado#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#tipoPlaza#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#correoEmpleado#">
  		<cfprocparam cfsqltype="CF_SQL_NUMERIC" type="out" 	variable="respuesta">  		
  	</cfstoredproc>
  	<cfreturn respuesta>
  </cffunction>

  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="registrar_investigador_sin_ne" hint="Llama al procedure para registrar un investigador sin numero de empleado en TPERSONA">
  	<cfargument name="rfc" 							type="string" required="true" hint="rfc del empleado">
  	<cfargument name="homoclave" 				type="string" required="true" hint="homoclave del empleado">
  	<cfargument name="curp" 						type="string" required="true" hint="curp del empleado">
  	<cfargument name="nombre" 					type="string" required="true" hint="nombre del empleado">
  	<cfargument name="apPat" 						type="string" required="true" hint="apPat del empleado">
  	<cfargument name="apMat" 						type="string" required="true" hint="apMat del empleado">
  	<cfargument name="dependencia"			type="string" required="true" hint="dependencia del empleado">
  	<cfargument name="pais" 						type="string" required="true" hint="pais del empleado">
  	<cfargument name="nacionalidad" 		type="string" required="true" hint="nacionalidad del empleado">
  	<cfargument name="entidad" 					type="string" required="true" hint="entidad del empleado">
  	<cfargument name="genero" 					type="string" required="true" hint="genero del empleado">
  	<cfargument name="fechaNacimiento" 	type="string" required="true" hint="fechaNacimiento del empleado">
  	<cfargument name="correo" 					type="string" required="true" hint="correo del empleado">
  	<cfstoredproc procedure="CVU.P_CVUREGISTRO.REG_INVESTIGADOR_SIN_NE" datasource="DS_CVU">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#rfc#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#homoclave#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#curp#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#nombre#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#apPat#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#apMat#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#dependencia#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#pais#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#nacionalidad#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#entidad#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#genero#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#fechaNacimiento#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" 	value="#correo#">
  		<cfprocparam cfsqltype="CF_SQL_NUMERIC" type="out" 	variable="respuesta">  		
  	</cfstoredproc>
  	<cfreturn respuesta>
  </cffunction>

  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="setUsuarioPersona" hint="Asocia el pk de un usuario a una persona">
  	<cfargument name="pkPersona" 	type="string" required="true" hint="pk de la persona">
  	<cfargument name="pkUsuario"	type="string" required="true" hint="pk del usuario">  
  	<cfstoredproc procedure="CVU.P_CVUREGISTRO.SETPKUSUARIOPERSONA" datasource="DS_CVU">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#pkPersona#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#pkUsuario#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="out"	variable="respuesta">
  	</cfstoredproc>
  	<cfreturn respuesta>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="setDomocilioPersona" hint="Guarda el domicilio de una persona">
		<cfargument name="pkPersona" 	type="string" required="true" hint="pk de la persona">
		<cfargument name="calle"    	type="string" required="true">
		<cfargument name="fkPais"    	type="string" required="true">
		<cfargument name="estado"    	type="string" required="true">
		<cfargument name="municipio" 	type="string" required="true">
		<cfargument name="cp"        	type="string" required="true">
		<cfargument name="colonia"   	type="string" required="true">
		<cfargument name="noExt"     	type="string" required="true">
		<cfargument name="noInt"     	type="string" required="true">  		
  	<cfstoredproc procedure="CVU.P_CVUREGISTRO.GUARDARDOMICILIO" datasource="DS_CVU">
			<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#pkPersona#">
			<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#calle#">			
			<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#fkPais#">     		 	
			<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#estado#">
			<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#municipio#">
			<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#cp#">         		 	
			<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#colonia#">
			<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#noExt#">      		 	
			<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#noInt#">      		 	
			<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="out"	variable="respuesta">
  	</cfstoredproc>
  	<cfreturn respuesta>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getInformacionPersona" hint="Obtiene la informacion de una persona con su pk">
  	<cfargument name="pkPersona" hint="Pk de la persona">
  	<cfquery name="respuesta" datasource="DS_CVU">
  		SELECT  *
			FROM    CVU.CVUTPERSONA TPS
			WHERE   TPS.TPS_PK_PERSONA = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pkPersona#">
			AND     TPS.TPS_CESESTADO > 1
  	</cfquery>
  	<cfreturn respuesta>
  </cffunction>

  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getInformacionPersonaSiga" hint="Obtiene la informacion de una persona con su pk">
  	<cfargument name="pkPersonaSiga" hint="Pk de la persona">
  	<cfquery name="respuesta" datasource="DS_SIGADGCH">
			SELECT 	TPE_PK_PERSONA AS PK_PERSONAL,
							TPE_NOMBRE AS NOMBRE,
							TPE_PATERNO AS APATERNO,
							TPE_MATERNO AS AMATERNO,
							TPE_FK_PAIS_NAC AS PK_PAIS_NAC,
							TPE_FK_NACIONALIDAD AS PK_NACIONALIDAD,
							TPE_FK_ENTIDAD_MEX AS PK_ENTIDAD_MEX,
							CPA_NOMBRE AS PAIS_NAC,
							CNA_NACIONALIDAD AS NACIONALIDAD,
							CES_NOMBRE AS ESTADO,
							TPE_OTRA_ENTIDAD AS OTRA_ENTIDAD,
							TPE_FECHA_NAC AS FECHA_NAC,
							TRUNC (MONTHS_BETWEEN (SYSDATE, TPE_FECHA_NAC) / 12) AS EDAD,
							TPE_FK_SEXO AS PK_GENERO,
							TPC_FK_ESTADOCIVIL AS PK_EDO_CIVIL,
							TPS_DESCRIPCION AS GENERO,
							CEC_DESCRIPCION AS ESTADO_CIVIL,
							TPE_RFC AS RFC,
							TPE_RFCHOMOCLAVE AS HOMOCLAVE,
							TPE_CURP AS CURP,
							TPE_NUM_PASAPORTE AS NUM_PASAPORTE,
							TPE_NUM_IFE AS NUM_IFE,
							TPE_NUM_CARTILLA AS NUM_CARTILLA,
							TPE_NUM_EMPLEADO AS NUM_EMPLEADO,
							TPE_RUSP AS RUSP,
							TPE_FK_TIPO_EMPLEADO AS TIPO_EMPLEADO,
							TPE_FK_UR_CAPTURA AS UR,
							TPE_NUM_ISSSTE AS NO_ISSSTE,
							TPE_NUM_SS AS NO_SEGUROSOCIAL,
							TPE_CTA_SAR AS CUENTA_SAR
			FROM 		SIGADGCH.TPERSONA,
							SIGADGCH.TSEXO,
							SIGADGCH.TPERSONA_ESTADO_CIVIL,
							SIGADGCH.CESTADO_CIVIL,
							SIGADGCH.CNACIONALIDAD,
							UR.CUR_PAIS,
							UR.CUR_ESTADO
			WHERE   TPE_PK_PERSONA = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pkPersonaSiga#">
			AND 		TPE_FK_ESTATUS > 0
			AND 		TPC_FK_FECHA_FIN(+) IS NULL
			AND 		TPE_FK_SEXO = TPS_PK_SEXO(+)
			AND 		TPE_PK_PERSONA = TPC_FK_PERSONA(+)
			AND 		TPC_FK_ESTADOCIVIL = CEC_PK_ESTADOCIVIL(+)
			AND 		TPE_FK_NACIONALIDAD = CNA_PK_NACIONALIDAD(+)
			AND 		TPE_FK_PAIS_NAC = CPA_PK_PAIS
			AND 		TPE_FK_ENTIDAD_MEX = CES_PK_ESTADO(+)
		</cfquery>
  	<cfreturn respuesta>
  </cffunction>  

  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getDomicilioPersona" hint="Obtiene la informacion del domicilio de una persona con su pk">
  	<cfargument name="pkPersona" hint="Pk de la persona">
  	<cfquery name="respuesta" datasource="DS_CVU">
	  	SELECT  	  	
							TDO.TDO_PK_DOMICILIO AS PK_DOMICILIO,
							TDO.TDO_CALLE		     AS CALLE,
							TDO.TDO_PAIS         AS PAIS,
							TDO.TDO_CP           AS CP,
							TDO.TDO_ESTADO       AS PK_ESTADO,
							TDO.TDO_MUNICIPIO    AS PK_MUNICIPIO,
							TDO.TDO_COLONIA      AS PK_COLONIA,
							TDO.TDO_NUM_EXT      AS NUM_EXT,
							TDO.TDO_NUM_INT      AS NUM_INT
			FROM    CVU.CVUTDOMICILIO TDO
			WHERE   TDO.TDO_FK_PERSONA = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pkPersona#">
  	</cfquery>  	
  	<cfreturn respuesta>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getObjetoPersona" hint="Obtiene la informacion de una persona (CVU)">
  	<cfargument name="pkPersona" hint="Pk de la persona">
  	<cfquery name="respuesta" datasource="DS_CVU">
	  	SELECT 
	  	    TPS_PK_PERSONA         AS PK_PERSONA,
	  	    CGN.CGE_GENERO_NOMBRE  AS GENERO,
	  	    TPS_PERSONA_NOMBRE     AS NOMBRE,
	  	    TPS_PERSONA_PATERNO    AS APPAT,
	  	    TPS_CURP               AS CURP,
	  	    CNA.CNA_NACIONALIDAD   AS NACIONALIDAD,
	  	    TPS_CLAVE_LADA         AS CLAVE_LADA,
	  	    TPS_PERSONA_MATERNO    AS APMAT,
	  	    TPS_RFC                AS RFC,
	  	    TPS_CORREO_IPN         AS CORREO_IPN,
	  	    TPS_CORREO_ALTERNATIVO AS CORREO_ALTERNO,
	  	    TPS_FK_UR              AS FK_UR,
	  	    TPS_FK_TRAYECTORIAIPN  AS FK_TRAYECTORIA,
	  	    TPS_FECHA_CAPTURA      AS FECHA_CAPTURA,
	  	    TPS_FK_PERSONA_SIGA    AS FK_PERSONASIGA,
	  	    TPS_EXTENSION_OFICINA  AS EXT_OFICINA,
	  	    TPS_NUMERO_EMPLEADO    AS NUM_EMPLEADO,
	  	    TPS_FK_USUARIO         AS FK_USUARIO,
	  	    TPS_FK_EDI             AS FK_EDI,
	  	    TPS_CESESTADO          AS ESTADO,
	  	    TPS_CESRUTA            AS RUTA
	  	FROM 	CVU.CVUTPERSONA TPS,
	  	        GRAL.GRALCGENERO CGN,
	  	        CVU.CVUCNACIONALIDAD CNA
	  	WHERE CGN.CGE_PK_GENERO = TPS.TPS_FK_GENERO
	  	AND   CNA.CNA_PK_NACIONALIDAD = TPS.TPS_FK_NACIONALIDAD
	  	AND   TPS.TPS_PK_PERSONA = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pkPersona#">
	  	AND   TPS.TPS_CESESTADO > 1
  	</cfquery>  	
  	<cfreturn respuesta>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getListaTelefonos" hint="Obtiene la lista de telefonos de una persona">
  	<cfargument name="pkPersona" hint="Pk de la persona">
  	<cfquery name="respuesta" datasource="DS_CVU">
  		SELECT  
				  		TTA_PK_TELEFONO                 AS PK_TELEFONO,
				  		TTA_FK_PERSONA                  AS PK_PERSONA,
				  		NVL(to_char(TTA_LADA),'-')      AS LADA,
				  		TTA_TELEFONO                    AS TELEFONO,
				  		NVL(to_char(TTA_EXTENSION),'-') AS EXTENSION
			        -- ,TTA_FK_TIPO_TELEFONO ,
			        -- TTA_FK_ESTADO
			FROM    CVU.CVUTTELEFONO TTA
			WHERE   TTA.TTA_FK_PERSONA = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pkPersona#">
			AND 		TTA.TTA_FK_ESTADO > 1
			ORDER BY PK_TELEFONO
  	</cfquery>  	
  	<cfreturn respuesta>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="guardarTelefonoPersona" hint="Guarda un telefono de una persona">
		<cfargument name="pkPersona" 	type="string" required="true" hint="pk de la persona">
		<cfargument name="lada"      	type="string" required="true" hint="lada"> 	
		<cfargument name="telefono"  	type="string" required="true" hint="telefono"> 	
		<cfargument name="extension" 	type="string" required="true" hint="extension"> 	
  	<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.GUARDARTELEFONO" datasource="DS_CVU">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#pkPersona#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#lada#">  		
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#telefono#">  		
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#extension#">  		  		  	
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="out"	variable="respuesta">
  	</cfstoredproc>
  	<cfreturn respuesta>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="eliminarTelefono" hint="Elimina un telefono por su pk">
		<cfargument name="pkTelefono" type="string" required="true" hint="pk del telefono">		
  	<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.ELIMINARTELEFONO" datasource="DS_CVU">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#pkTelefono#">  		
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="out"	variable="respuesta">
  	</cfstoredproc>
  	<cfreturn respuesta>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="editarCorreosLocalizacion" hint="Modifica los correos de localizacion de una persona">
		<cfargument name="pkPersonaSIGA"  type="string" required="true" hint="pk de la persona">
		<cfargument name="correoIPN"  		type="string" required="true" hint="correo institucional">					
		<cfargument name="correoAlt"  		type="string" required="true" hint="correo alternativo">					
  	<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.EDITARCORREOSLOCALIZACION" datasource="DS_CVU">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#pkPersonaSIGA#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#correoIPN#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="in"		value="#correoAlt#">
  		<cfprocparam cfsqltype="CF_SQL_VARCHAR"	type="out"	variable="respuesta">
  	</cfstoredproc>
  	<cfreturn respuesta>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getDatosLocalizacion" hint="Obtiene la informacion de localizacion (SIGA) de una persona con su pk">
  	<cfargument name="pkPersonaSIGA" hint="Pk de la persona (SIGA)">
  	<cfquery name="respuesta" datasource="DS_CVU">
	  	SELECT  LOC.TPL_FK_PERSONA AS PK_PERSONA,
			        LOC.TPL_PK_LOCALIZACION AS PK_DATOSLOC,
			        DIR.TPE_CALLE AS CALLE,
			        DIR.TPE_NUMERO_EXT AS NUMERO_EXT,
			        DIR.TPE_NUMERO_INT AS NUMERO_INT,
			        DIR.TPE_LOCALIDAD_SECCION AS LOCALIDAD_SECCION,
			        DIR.TPE_FK_COLONIA AS PK_COLONIA,                
			        LOC.TPL_TELEFONO AS TELEFONO_PARTICULAR,
			        LOC.TPL_TELEFONO_OFICINA AS TELEFONO_OFICINA,
			        LOC.TPL_EXT_TELF AS EXT_TELF,
			        LOC.TPL_TELF_RECADOS AS TELF_RECADOS,
			        LOC.TPL_CORREO_ELECT AS CORREO_INSTITUCIONAL,
			        LOC.TPL_CORREO_ALTERNATIVO AS CORREO_ALTERNATIVO,
			        LOC.TPL_NUM_CELULAR AS NUM_CELULAR,
			        LOC.TPL_FK_ESTADOREGISTRO AS ESTADO_REGISTRO,
			        LOC.TPL_OBSERVACIONVALIDACION AS OBSERVACION_RECHAZO,
			        CESTADO.CER_DESCRIPCION AS DEDSCRIPCION_ESTADO
			FROM    SIGADGCH.TPERSONA_DIRECCION@DBL_SIGADGCH DIR,
			        SIGADGCH.TPERSONA_LOCALIZACION@DBL_SIGADGCH LOC,                
			        SIGADGCH.HUMCESTADORESGISTRO@DBL_SIGADGCH CESTADO
			WHERE   DIR.TPE_FK_PERSONA = <cfqueryparam value="#pkPersonaSIGA#">
			AND     DIR.TPE_FK_ESTATUS <> 0
			AND     LOC.TPL_FK_ESTATUS(+) > 0
			AND     LOC.TPL_FK_ESTADOREGISTRO > 0
			AND     DIR.TPE_FK_FECHA_FIN IS NULL
			AND     DIR.TPE_FK_PERSONA = LOC.TPL_FK_PERSONA(+)                                
			AND     CESTADO.CER_PK_ESTADO = LOC.TPL_FK_ESTADOREGISTRO
  	</cfquery>  	
  	<cfreturn respuesta>
	</cffunction>


<!---
  * Fecha creacion: Diciembre de 2017
  * @author: Alejandro Rosales
  --->
	<cffunction name="getEstadoInvestigador" hint="Obtiene el estado de un investigador actual">
  		<cfargument name="curp" hint="curp de la persona a consultar">
  		<cfquery name="respuesta" datasource="DS_CVU">
   			SELECT CASE WHEN COUNT(TPS_PK_PERSONA) > 0 THEN 1 ELSE 0 END AS INVESTIGADOR,
    				CSN_NOMBRE_SNI AS NIVELSNI,
    				TPS_CURP AS CURP
  				FROM CVUTPERSONA, CVUTSNI, CVUCSNI
 				WHERE     TPS_CURP = '#curp#'
       			AND TPS_PK_PERSONA = TSN_FK_PERSONA(+)
       			AND TSN_FK_CSNI = CSN_PK_SNI(+)
       			AND TPS_CESESTADO > 0
       			AND TSN_FK_ESTADO(+) > 0
       			AND TSN_FECHATERMINO IS NULL
       		GROUP BY CSN_NOMBRE_SNI, TPS_CURP
  		</cfquery>
  		<cfreturn respuesta>
	</cffunction>

	<!---
  * Fecha creacion: Enero de 2018
  * @author: Daniel Memije
  --->
  <cffunction name="getTraysActivas" hint="Obtiene las trayectorias activas.">
  	<cfargument name="pkPersonaSIGA" hint="pk de la persona a consultar">
		<cfquery name="respuesta" datasource="DS_SIGADGCH">  		
			SELECT TRAYECTORIA.*, TUR.TUR_FK_UR_PADRE UR_PADRE, TUR.TUR_NOMBRE AREA
		    FROM SIGADGCH.TPERSONAL_TRAYECTORIAIPN TRAYECTORIA, UR.TUR TUR
		   WHERE TUR.TUR_PK_UR = TRAYECTORIA.TPT_FK_CLAVEUR
		         AND (   TRAYECTORIA.TPT_FK_DWFECHAFIN IS NULL
		              OR TRAYECTORIA.TPT_FK_DWFECHAFIN >
		                    SIGADGCH.CONTROLTIEMPOS.GETPKTIMEF (SYSDATE))
		         AND TRAYECTORIA.TPT_FK_PERSONA = <cfqueryparam value="#pkPersonaSIGA#">
		         AND TRAYECTORIA.TPT_FK_ESTATUS > 0
		ORDER BY TRAYECTORIA.TPT_FK_DWFECHAINICIO DESC,
		         TRAYECTORIA.TPT_FECHAINICIO DESC
		</cfquery>
		<cfreturn respuesta>  	
	</cffunction>

	<!---
  	* Fecha creacion: Enero de 2018
  	* @author: Daniel Memije
  	--->
	<cffunction name="getPlazasActivas" hint="Obtiene las plazas activas de una persona.">
		<cfargument name="pkPersonaSIGA" hint="pk de la persona a consultar">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT DISTINCT(MVPP.PK_PLAZA),
			       MVPP.NOMBRE_PLAZA,
			       MVPP.ESTADO_PLAZA,
			       MVPP.HORAS,
			       TAS.TPS_FK_PERSONA_SIGA,
			       TO_CHAR(MVPP.FECHA_INICIO, 'DD/MM/YYYY')  AS FECHA_INICIO,
			       TO_CHAR(MVPP.FECHA_TERMINO, 'DD/MM/YYYY') AS FECHA_TERMINO,
			       UR.TUR_NOMBRE
			  FROM SIGADGCH.MV_PLAZAS_PERSONAL@DBL_SIGADGCH MVPP,
			       CVU.CVUTPERSONA TAS,
			       UR.TUR@DBL_URSIGA UR
			 WHERE MVPP.PK_PERSONA = TPS_FK_PERSONA_SIGA    
			       AND TAS.TPS_FK_PERSONA_SIGA = <cfqueryparam value="#pkPersonaSIGA#">
			       AND MVPP.ESTADO_PLAZA = 'A'
			       AND MVPP.PK_UR = UR.TUR_PK_UR
		</cfquery>
		<cfreturn respuesta>  	
	</cffunction>

	<!---
  * Fecha creacion: Enero de 2018
  * @author: Daniel Memije
  --->
  <cffunction name="getInfoPlazas" hint="Obtiene los datos de la dependencia.">
  	<cfargument name="pkPersonaSIGA" hint="pk de la persona a consultar">
		<cfquery name="respuesta" datasource="DS_SIGADGCH">  		
			SELECT TUR.TUR_NOMBRE AS DEPENDENCIA,
		         PPLAZA.TPI_FK_ZONAPAGO AS ZONA_PAGO,
		         PPLAZA.TPI_CLAVE_PUESTO AS CLAVE_PUESTO,
		         PPLAZA.TPI_CATEGORIA AS CATEGORIA,
		         PPLAZA.TPI_NUMERO_PLAZA AS NUM_PLAZA,
		         PPLAZA.TPI_FK_FECHA_INI AS FECHA_INICIO,
		         PPLAZA.TPI_FK_FECHA_FIN AS FECHA_FIN,
		         DECODE (tpt_tipo,  1, 3,  '', cpe_pk_cpersonal,  tpt_tipo)
		            AS PK_PERSONAL,
		         DECODE (tpt_tipo,
		                 1, 'Funcionario / Plaza puesto',
		                 '', cpe_descripcion)
		            AS tipo_servidor_publico,
		         SII.PRE_CPLAZA.CPL_NOMBRE AS NOMBRE_PLAZA,
		         CEDULA.TFC_FECHA_GOBIERNO AS FECHA_GOB,
		         CEDULA.TFC_FECHA_SEP AS FECHA_SEP,
		         CEDULA.TFC_FECHA_IPN AS FECHA_IPN,
		         PERSONA.TPE_NUM_EMPLEADO AS NUMERO_EMPLEADO,
		         PERSONA.TPE_RUSP AS RUSP,
		         TUR_DATOS.TUD_DOMICILIO AS DOMICILIO_DEPENDENCIA,
		         TUR_DATOS.TUD_TELEFONO AS TELEFONO_DEPENDENCIA,
		         TUR_DATOS.TUD_TELEXTENSION AS EXTENSION_TELEF,
		         PPLAZA.TPI_ESTADO_PLAZA ESTADO_PLAZA,
		         TUR.TUR_PK_UR AS PK_DEPENDENCIA,
		         PPLAZA.TPI_HORAS AS HORAS,
		         PPLAZA.TPI_FECHA_FIN AS FECHA_FIN_D
		    FROM SIGADGCH.TPERSONA_PLAZA PPLAZA,
		         SIGADGCH.TPERSONA PERSONA,
		         SIGADGCH.TFCEDULA_REGISTRO CEDULA,
		         SIGADGCH.TPERSONAL_TRAYECTORIAIPN TRAYECTORIA_IPN,
		         UR.TUR_TZONAPAGO TZP,
		         UR.TUR TUR,
		         UR.TUR_TURDATOS TUR_DATOS,
		         SII.PRE_CPLAZA,
		         SII.PRE_CPERSONAL
		   WHERE                                     --PPLAZA.TPI_PK_PLAZA = :PK_PLAZA
        		 PPLAZA.TPI_FK_PERSONA = <cfqueryparam value="#pkPersonaSIGA#">
         AND PERSONA.TPE_PK_PERSONA = PPLAZA.TPI_FK_PERSONA
         AND CEDULA.TFC_FK_PERSONA(+) = PPLAZA.TPI_FK_PERSONA
         AND TZP.TZP_CLAVE = PPLAZA.TPI_FK_ZONAPAGO
         AND TUR.TUR_PK_UR(+) = TZP.TZP_FK_UR
         AND SII.PRE_CPLAZA.CPL_CLAVE(+) = PPLAZA.TPI_CATEGORIA
         AND SII.PRE_CPERSONAL.CPE_PK_CPERSONAL(+) =
                SII.PRE_CPLAZA.CPL_FK_CPERSONAL
         AND TRAYECTORIA_IPN.TPT_FK_ESTATUS(+) <> 0
         AND TRAYECTORIA_IPN.TPT_FK_DWFECHAFIN(+) IS NULL
         AND TRAYECTORIA_IPN.TPT_FK_PERSONA(+) = PPLAZA.TPI_FK_PERSONA
         AND PPLAZA.TPI_ESTADO_PLAZA IN ('A', 'L')
		GROUP BY TUR.TUR_NOMBRE,
		         PPLAZA.TPI_FK_ZONAPAGO,
		         PPLAZA.TPI_CLAVE_PUESTO,
		         PPLAZA.TPI_CATEGORIA,
		         PPLAZA.TPI_NUMERO_PLAZA,
		         PPLAZA.TPI_FK_FECHA_INI,
		         PPLAZA.TPI_FK_FECHA_FIN,
		         tpt_tipo,
		         cpe_pk_cpersonal,
		         cpe_descripcion,
		         SII.PRE_CPLAZA.CPL_NOMBRE,
		         CEDULA.TFC_FECHA_GOBIERNO,
		         CEDULA.TFC_FECHA_SEP,
		         CEDULA.TFC_FECHA_IPN,
		         PERSONA.TPE_NUM_EMPLEADO,
		         PERSONA.TPE_RUSP,
		         TUR_DATOS.TUD_DOMICILIO,
		         TUR_DATOS.TUD_TELEFONO,
		         TUR_DATOS.TUD_TELEXTENSION,
		         PPLAZA.TPI_ESTADO_PLAZA,
		         TUR.TUR_PK_UR,
		         PPLAZA.TPI_HORAS,
		         PPLAZA.TPI_FECHA_FIN
		</cfquery>
		<cfreturn respuesta>  	
	</cffunction>

	<!---
  * Fecha creacion: Enero de 2018
  * @author: Daniel Memije
  --->
  <cffunction name="getDatosDependenciaPkPlaza" hint="Obtiene los datos de la dependencia.">
  	<cfargument name="pkPlaza" hint="pk de la plaza">
		<cfquery name="respuesta" datasource="DS_SIGADGCH">  		
			SELECT  TUR.TUR_NOMBRE AS DEPENDENCIA,
	            PPLAZA.TPI_FK_ZONAPAGO AS ZONA_PAGO,
	            PPLAZA.TPI_CLAVE_PUESTO AS CLAVE_PUESTO,
	            PPLAZA.TPI_CATEGORIA AS CATEGORIA,
	            PPLAZA.TPI_NUMERO_PLAZA AS NUM_PLAZA,
	            PPLAZA.TPI_FK_FECHA_INI AS FECHA_INICIO,
	            PPLAZA.TPI_FK_FECHA_FIN AS FECHA_FIN,
	            DECODE (tpt_tipo,  1, 3,  '', cpe_pk_cpersonal,  tpt_tipo)
	               AS PK_PERSONAL,
	            DECODE (tpt_tipo,
	                    1, 'Funcionario / Plaza puesto',
	                    '', cpe_descripcion)
	               AS tipo_servidor_publico,
	            SII.PRE_CPLAZA.CPL_NOMBRE AS NOMBRE_PLAZA,
	            CEDULA.TFC_FECHA_GOBIERNO AS FECHA_GOB,
	            CEDULA.TFC_FECHA_SEP AS FECHA_SEP,
	            CEDULA.TFC_FECHA_IPN AS FECHA_IPN,
	            PERSONA.TPE_NUM_EMPLEADO AS NUMERO_EMPLEADO,
	            PERSONA.TPE_RUSP AS RUSP,
	            TUR_DATOS.TUD_DOMICILIO AS DOMICILIO_DEPENDENCIA,
	            TUR_DATOS.TUD_TELEFONO AS TELEFONO_DEPENDENCIA,
	            TUR_DATOS.TUD_TELEXTENSION AS EXTENSION_TELEF,
	            TRAYECTORIA_IPN.TPT_PK_TRAYECTORIAIPN,
	            PPLAZA.TPI_ESTADO_PLAZA ESTADO_PLAZA,
	            TUR.TUR_PK_UR AS PK_DEPENDENCIA
	       FROM SIGADGCH.TPERSONA_PLAZA PPLAZA,
	            SIGADGCH.TPERSONA PERSONA,
	            SIGADGCH.TFCEDULA_REGISTRO CEDULA,
	            SIGADGCH.TPERSONAL_TRAYECTORIAIPN TRAYECTORIA_IPN,
	            UR.TUR_TZONAPAGO TZP,
	            UR.TUR TUR,
	            UR.TUR_TURDATOS TUR_DATOS,
	            SII.PRE_CPLAZA,
	            SII.PRE_CPERSONAL
	      WHERE PPLAZA.TPI_PK_PLAZA = <cfqueryparam value="#pkPlaza#">
	            AND PERSONA.TPE_PK_PERSONA = PPLAZA.TPI_FK_PERSONA
	            AND CEDULA.TFC_FK_PERSONA(+) = PPLAZA.TPI_FK_PERSONA
	            AND TZP.TZP_CLAVE = PPLAZA.TPI_FK_ZONAPAGO
	            AND TUR.TUR_PK_UR(+) = TZP.TZP_FK_UR
	            AND SII.PRE_CPLAZA.CPL_CLAVE(+) = PPLAZA.TPI_CATEGORIA
	            AND SII.PRE_CPERSONAL.CPE_PK_CPERSONAL(+) =
	                   SII.PRE_CPLAZA.CPL_FK_CPERSONAL
	            AND TRAYECTORIA_IPN.TPT_FK_ESTATUS(+) <> 0
	            AND TRAYECTORIA_IPN.TPT_FK_DWFECHAFIN(+) IS NULL
	            AND TRAYECTORIA_IPN.TPT_FK_PERSONA(+) = PPLAZA.TPI_FK_PERSONA
	   GROUP BY TUR.TUR_NOMBRE,
	            PPLAZA.TPI_FK_ZONAPAGO,
	            PPLAZA.TPI_CATEGORIA,
	            PPLAZA.TPI_FK_FECHA_INI,
	            PPLAZA.TPI_FK_FECHA_FIN,
	            PPLAZA.TPI_CLAVE_PUESTO,
	            PPLAZA.TPI_CATEGORIA,
	            PPLAZA.TPI_NUMERO_PLAZA,
	            cpe_pk_cpersonal,
	            SII.PRE_CPLAZA.CPL_NOMBRE,
	            CEDULA.TFC_FECHA_GOBIERNO,
	            CEDULA.TFC_FECHA_SEP,
	            CEDULA.TFC_FECHA_IPN,
	            PERSONA.TPE_NUM_EMPLEADO,
	            PERSONA.TPE_RUSP,
	            TUR_DATOS.TUD_DOMICILIO,
	            TUR_DATOS.TUD_TELEFONO,
	            TUR_DATOS.TUD_TELEXTENSION,
	            tpt_tipo,
	            TRAYECTORIA_IPN.TPT_PK_TRAYECTORIAIPN,
	            cpe_descripcion,
	            TPT_FK_DWFECHAINICIO,
	            TPI_ESTADO_PLAZA,
	            TUR.TUR_PK_UR
	   ORDER BY TRAYECTORIA_IPN.TPT_FK_DWFECHAINICIO DESC
		</cfquery>
		<cfreturn respuesta>  	
	</cffunction>

	<!---
  * Fecha creacion: Enero de 2018
  * @author: Daniel Memije
  --->
  <cffunction name="getArbolDependencia" hint="Funcion que devuelve el arbol hacia arriba hasta nivel de dependencia.">
  	<cfargument name="departamento">
  	<cfargument name="ramaFinal">
		<cfquery name="respuesta" datasource="DS_SIGADGCH">  		
		SELECT TUR_PK_UR UR,
		       TUR_NOMBRE NOMBRE,
		       TUR_FK_PADRE_INMEDIATO AS URPADREDIR,
		       CASE
		          WHEN TU.TUR_PK_UR = <cfqueryparam value="#ramaFinal#" cfsqltype="cf_sql_varchar"> THEN 'Área:'
		          ELSE 'Dependiente Superior Orgánico:'
		       END
		          AS CATEGORIA,
		       TUR_FK_UR_PADRE AS DEPENDENCIA
		  FROM UR.TUR TU
		 WHERE TUR_PK_UR = <cfqueryparam value="#departamento#" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfreturn respuesta>  	
	</cffunction>	

</cfcomponent>