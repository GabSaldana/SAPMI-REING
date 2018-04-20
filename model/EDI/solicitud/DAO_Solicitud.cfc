<cfcomponent>

	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="getSolcitudesDisponibles" hint="Obtiene todos los productos">
		<cfargument name="pkPersona" type="numeric" required="no" hint="pk de la persona" default="0">
		<cfargument name="reglamento" type="numeric" required="no" hint="pk de la persona" default="0">
		<cfquery name="respuesta" datasource="DS_EDI">
            SELECT  TMO.TMO_PK_MOVIMIENTO   AS PK_MOVIMIENTO,
                    TMO.TMO_NOMBRE          AS NOMBRE,
                    TMO.TMO_DESCRIPCION     AS DESCRIPCION,
                    TMO.TMO_OBSERVACION     AS OBSERVACION,
                    TMO.TMO_FK_REGLAMENTO   AS PKREGAMENTO,
                    NVL(TAP.TAS_FK_CESTADO,208)      AS CESESTADO,
                    NVL(TAP.TAS_FK_CRUTA,65)        AS CESRUTA,
					NVL(TAP.TAS_PK_ASPIRANTEPROCESO,0)	AS PKASPIRANTEPROCESO
              FROM  EDI.EDITMOVIMIENTO      TMO,
                    EDI.EDITPERSONAESTADO   TPE,
                    EDI.EDIRMOVIMIENTOESTADO TME,
                    EDI.EDITASPIRANTEPROCESO TAP
        	WHERE   TMO.TMO_PK_MOVIMIENTO = TME.TME_FK_MOVIMIENTO
                    AND TME.TME_FK_CESTADO = TPE.TPE_FK_CESTADO
                    AND TMO.TMO_PK_MOVIMIENTO = TAP.TAS_FK_MOVIMIENTO(+)
                    AND TAP.TAS_FK_PERSONA(+) = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
                    AND TMO.TMO_FK_ESTADO = 2
                    AND TPE.TPE_FK_PERSONA = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
                    AND TMO.TMO_FK_REGLAMENTO = <cfqueryparam value="#reglamento#" cfsqltype="cf_sql_numeric">
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>
	
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="getPestaniasSolicitud" hint="Obtiene todos los productos">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la persona">
		<cfquery name="respuesta" datasource="DS_EDI">
			   SELECT  TMO.TMO_NOMBRE       AS MOVIMIENTO,
			   		   TMO.TMO_PK_MOVIMIENTO AS PK_MOVIMIENTO,
			   		   PT.CPE_NOMBRE        AS NOMBRE,
		               PT.CPE_CLAVE		    AS CLAVE,
		               PT.CPE_PK_PESTANIA   AS PK_PESTANIA  
		         FROM  EDI.EDITMOVIMIENTO TMO,
		               EDI.EDITMOVIMIENTOREQUISITO TMR,
		               EDI.EDICREQUISITO   CR,
		               EDI.EDICPESTANIA PT
		        WHERE  TMO.TMO_PK_MOVIMIENTO = TMR.TMR_FK_MOVIMIENTO
		               AND CR.CRE_PK_CREQUISITO = TMR.TMR_FK_CREQUISITO
		               AND PT.CPE_PK_PESTANIA = CR.CRE_FK_PESTANIA
					   AND TMO.TMO_PK_MOVIMIENTO = <cfqueryparam value="#pkMovimiento#" cfsqltype="cf_sql_numeric">
		               AND TMO.TMO_FK_ESTADO = 2
		               AND TMR.TMR_FK_ESTADO = 2
		               AND CR.CRE_FK_ESTADO = 2
		               AND CPE_FK_ESTADO = 2
		     GROUP BY  TMO.TMO_NOMBRE ,
			   		   TMO.TMO_PK_MOVIMIENTO,
		               TMO.TMO_NOMBRE,
					   PT.CPE_NOMBRE,
		               PT.CPE_CLAVE,
		               PT.CPE_PK_PESTANIA,
		               PT.CPE_ORDEN
		      ORDER BY PT.CPE_ORDEN
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>
	
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="getRequisitosPestania" hint="Obtiene todos los productos">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkPestania" type="numeric" required="yes" hint="pk de la persona">
		<cfquery name="respuesta" datasource="DS_EDI">
			   SELECT  CR.CRE_ARTICULO         AS ARTICULO,
		               CR.CRE_SECCION          AS SECCION,
		               TR.TRE_NOMBREREQUISITO  AS REQUISITO,
		               TR.TRE_OBLIGATORIO      				AS OBLIGATORIO	  
		         FROM  EDI.EDITMOVIMIENTOREQUISITO TMR,
		               EDI.EDITREQUISITO   TR,
		               EDI.EDICREQUISITO   CR
		        WHERE  CR.CRE_PK_CREQUISITO = TMR.TMR_FK_CREQUISITO
		               AND CR.CRE_PK_CREQUISITO = TR.TRE_FK_CREQUISITO
		               AND CR.CRE_FK_PESTANIA = <cfqueryparam value="#pkPestania#" cfsqltype="cf_sql_numeric">
		               AND TMR.TMR_FK_MOVIMIENTO =<cfqueryparam value="#pkMovimiento#" cfsqltype="cf_sql_numeric">
		               AND TMR.TMR_FK_ESTADO = 2
		               AND TR.TRE_FK_ESTADO = 2
		               AND CR.CRE_FK_ESTADO = 2 
		      ORDER BY CR.CRE_ARTICULO,
		               CR.CRE_SECCION
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Marco Torres
	--->
	<cffunction name="getRequisitosPersona" hint="Obtiene los requisitos cumplidos por la persona">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfquery name="respuesta" datasource="DS_EDI">
			           
	        SELECT  REQUISITOS.ARTICULO,
	                REQUISITOS.SECCION,
	                REQUISITOS.REQUISITO,
	                REQUISITOS.T_OBLIGATORIO,
	                REQUISITOS.C_OBLIGATORIO,
	                REQUISITOS.PK_TREQUISITO,
	                REQUISITOS.PK_CREQUISITO,
	                NVL(REVISADOS.TIENEREQUISITO,0) AS TIENEREQUISITO
	          FROM  (
		                SELECT  CR.CRE_ARTICULO         AS ARTICULO,
				               CR.CRE_SECCION           AS SECCION,
				               TR.TRE_NOMBREREQUISITO   AS REQUISITO,
				               TR.TRE_OBLIGATORIO       AS T_OBLIGATORIO,
				               TR.TRE_PK_TREQUISITO     AS PK_TREQUISITO,
				               CR.CRE_OBLIGATORIO       AS C_OBLIGATORIO,
				               CR.CRE_PK_CREQUISITO		AS PK_CREQUISITO
				         FROM  EDI.EDITMOVIMIENTOREQUISITO TMR,
				               EDI.EDITREQUISITO   TR,
				               EDI.EDICREQUISITO   CR
				        WHERE  CR.CRE_PK_CREQUISITO = TMR.TMR_FK_CREQUISITO
				               AND CR.CRE_PK_CREQUISITO = TR.TRE_FK_CREQUISITO
				               AND TMR.TMR_FK_MOVIMIENTO =<cfqueryparam value="#pkMovimiento#" cfsqltype="cf_sql_numeric">
				               AND TMR.TMR_FK_ESTADO = 2
				               AND TR.TRE_FK_ESTADO = 2
				               AND CR.CRE_FK_ESTADO = 2
				               AND CR.CRE_INSOLICITUD = 1
			        )REQUISITOS,
			        (       
		                SELECT AR.TAR_FK_REQUISITO  AS PKREQUISITO,
		                        AR.TAR_CUENTA    AS TIENEREQUISITO
				          FROM  EDI.EDITASPIRANTEREQUISITO AR,
		                        EDI.EDITASPIRANTEPROCESO AP
				         WHERE  AR.TAR_FK_ASPIRANTEPROCESO = AP.TAS_PK_ASPIRANTEPROCESO
		                        AND AP.TAS_FK_PERSONA = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
		                        AND AP.TAS_FK_MOVIMIENTO = <cfqueryparam value="#pkMovimiento#" cfsqltype="cf_sql_numeric">
			        )REVISADOS
			 WHERE  REQUISITOS.PK_TREQUISITO = REVISADOS.PKREQUISITO(+)
		  ORDER BY	ARTICULO,SECCION
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>
	
	
	<!---
	*Fecha: Enero de 2018
	*Modificacion: Daniel Memije
	--->
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="obtenerProcesoActual" hint="Obtiene el proceso actual">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT	TPR_PK_PROCESO		AS PKPROCESO,
					TPR_NOMBREPROCESO	AS NOMBREPROCESO,
					TPR_FECHAINI	AS FECHAINICIO,
					TPR_FECHAFIN	AS FECHAFIN,
					TPR_FK_ESTADO		AS ESTADOPROCESO,
					TPR_FK_REGLAMENTO   AS PKREGLAMENTO,
					TPR_RI_FECHAINI AS RIFECHAINI,
					TPR_RI_FECHAFIN AS RIFECHAFIN,
					TPR_ANIO_EVAL_INICIO       AS FECHAINIPROC,
			    TPR_ANIO_EVAL_FIN          AS FECHAFINPROC
			FROM	EDITPROCESO
			WHERE	TPR_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarAspiranteRequisito" hint="agrega escolaridad a una persona">
		<cfargument name="pkAspirante"	type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="pkRequisito"	type="numeric"	required="yes" hint="pk del requisito">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.CONSULTARASPIRANTEREQUISITO" datasource="DS_EDI">
			<cfprocparam value="#pkAspirante#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkRequisito#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cuentaBeca" hint="Muestra si se tiene registrado la beca EDD">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="PKEDD"		type="numeric"	required="yes" hint="pk del proceso vigente">
		<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.CUENTAEDD" datasource="DS_CVU">
			<cfprocparam value="#pkPersona#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#PKEDD#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cuentasni" hint="Muestra si se tiene registrado la beca EDD">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de la persona">
		<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.CUENTASNI" datasource="DS_CVU">
			<cfprocparam value="#pkPersona#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="cuentaformAc" hint="Muestra si se tiene registrado la beca EDD">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="pkMaestria"	type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="pkDoctorado"	type="numeric"	required="yes" hint="pk de la persona">
		<cfstoredproc procedure="CVU.P_CVUDATOSGENERALES.CUENTAFORMAC" datasource="DS_CVU">
			<cfprocparam value="#pkPersona#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkMaestria#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkDoctorado#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addAspiranteRequisito" hint="Muestra si se tiene registrado la beca EDD">
		<cfargument name="pkAspirante"	type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="pkRequisito"	type="numeric"	required="yes" hint="pk del requisito">
		<cfargument name="estadoReq"	type="numeric"	required="yes" hint="estado del requisito">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.ADDASPIRANTEREQUISITO" datasource="DS_EDI">
			<cfprocparam value="#pkAspirante#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkRequisito#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#estadoReq#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<cffunction name="getAspirante" hint="Obtiene el pkAspirante con base al pkPersona y al pkProceso">
		<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkProceso" type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la persona">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.GETASPIRANTE" datasource="DS_EDI">
			<cfprocparam value="#pkPersona#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkProceso#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkMovimiento#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEstadoCapturaMovimiento" hint="Obtiene todos los productos">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la persona">
		<cfquery name="respuesta" datasource="DS_EDI">
            SELECT  TMO.TMO_CESRUTA     AS PKRUTA,
                    CER.CER_PK_ESTADO   AS PKESTADO
        	 FROM   EDI.EDITMOVIMIENTO  TMO,
                    GRAL.CESRRUTA       RPR,
                    GRAL.CESCESTADO     CER
        	WHERE   TMO.TMO_CESRUTA     = RPR.RPR_PK_RUTA
             AND    RPR.RPR_PK_RUTA     = CER.CER_FK_RUTA
             AND    TMO.TMO_FK_ESTADO   = 2
             AND    CER.CER_FK_ESTADO   = 2
             AND    RPR.RPR_FK_ESTADO	= 2
             AND    TMO_PK_MOVIMIENTO   = <cfqueryparam value="#pkMovimiento#" cfsqltype="cf_sql_numeric">
             AND    CER_NUMERO_ESTADO   = 1
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addAspiranteProceso" hint="Obtiene el pkAspirante con base al pkPersona y al pkProceso">
		<cfargument name="pkPersona" 	type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="pkProceso" 	type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="pkMovimiento"	type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="cEstado"		type="numeric"	required="yes" hint="pk del cestado">
		<cfargument name="ruta"			type="numeric"	required="yes" hint="pk de la ruta">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.ADDASPIRANTEPROCESO" datasource="DS_EDI">
			<cfprocparam value="#pkPersona#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkProceso#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkMovimiento#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#cEstado#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#ruta#"			cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addEvaluacionProducto" hint="agrega escolaridad a una persona">
		<cfargument name="pkFila"		type="numeric"	required="yes" hint="pk de las filas">
		<cfargument name="pkProducto"	type="numeric"	required="yes" hint="pk del los productos">
		<cfargument name="pkEstado"		type="numeric"	required="yes" hint="pk del los productos">
		<cfargument name="pkProceso" 	type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="pkCEstado"	type="numeric"	required="yes" hint="pk del los productos">
		<cfargument name="pkRuta" 		type="numeric"	required="yes" hint="pk de la persona">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.ADDEVALUACIONPRODUCTO" datasource="DS_EDI">
			<cfprocparam value="#pkProducto#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkFila#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkEstado#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkProceso#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkCEstado#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkRuta#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>	

	<!--- 
	*Fecha:	Diciembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAspiranteRequisitoProducto" hint="Obtiene los requisitos que cumple una persona">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la movimiento">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de las persona">
		<cfargument name="pkProceso"	type="numeric"	required="yes" hint="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TRE.TRE_PK_TREQUISITO      		AS PKTREQUISITO,
			       	TRE.TRE_NOMBREREQUISITO     	AS NOMBREREQUISITO
			 FROM  	EDI.EDITEVALUACIONPRODUCTOEDI	EPE,
			       	CVU.CVUCTPRODUCTOPERSONA    	PP,
			      	CVU.CVUCCPRODUCTO               CP,
			       	EDI.EDITPRODUCTOEDI         	PE,
			       	EDI.EDITPRODUCTOREQUISITO   	PR,
			       	EDI.EDICPRODUCTOEDI         	CPE,
			       	EDI.EDITREQUISITO           	TRE,
			       	EDI.EDITMOVIMIENTOREQUISITO		MRE
			WHERE	PP.TPP_PK_TPRODUCTOPERSONA		= EPE.TEP_FK_CVUCCPRODUCTOPERSONA
			 AND	EPE.TEP_FK_TPRODUCTOEDI 		= PE.TPE_PK_TPRODUCTOEDI
			 AND	PR.TPR_FK_PRODUCTOEDI 			= CPE.CPE_PK_CPRODUCTOEDI
			 AND	PE.TPE_FK_CPRODUCTOEDI 			= CPE.CPE_PK_CPRODUCTOEDI
			 AND	PR.TPR_FK_REQUISITO 			= TRE.TRE_PK_TREQUISITO
			 AND	MRE.TMR_FK_CREQUISITO			= TRE.TRE_FK_CREQUISITO
			 AND 	CP.CPD_PK_CPRODUCTO           	= PP.TPP_FK_CPRODUCTO
			 AND	PP.TPP_FK_PERSONA 				= <cfqueryparam value="#pkPersona#"		cfsqltype="cf_sql_numeric">  
			 AND	EPE.TEP_FK_PROCESO 				= <cfqueryparam value="#pkProceso#"		cfsqltype="cf_sql_numeric">
			 AND	MRE.TMR_FK_MOVIMIENTO 			= <cfqueryparam value="#pkMovimiento#"	cfsqltype="cf_sql_numeric">
			 AND 	TPR_FK_ESTADO               	= 2
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>


	<!--- 
	*Fecha:	Diciembre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAspiranteRequisitoProductoNumero" hint="Obtiene los requisitos que cumple una persona">
		<cfargument name="pkMovimiento" type="numeric" required="yes" hint="pk de la movimiento">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de las persona">
		<cfargument name="pkProceso"	type="numeric"	required="yes" hint="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT	TRE.TRE_PK_TREQUISITO      		AS PKTREQUISITO,
			      	TPR_NUMERO                 		AS MAXIMOPROD
			 FROM  	EDI.EDITEVALUACIONPRODUCTOEDI	EPE,
			       	CVU.CVUCTPRODUCTOPERSONA    	PP,
			       	EDI.EDITPRODUCTOEDI         	PE,
			       	EDI.EDITPRODUCTOREQUISITO   	PR,
			       	EDI.EDICPRODUCTOEDI         	CPE,
			       	EDI.EDITREQUISITO           	TRE,
			       	EDI.EDITMOVIMIENTOREQUISITO		MRE
			WHERE  	PP.TPP_PK_TPRODUCTOPERSONA		= EPE.TEP_FK_CVUCCPRODUCTOPERSONA
			 AND 	EPE.TEP_FK_TPRODUCTOEDI 		= PE.TPE_PK_TPRODUCTOEDI
			 AND 	PR.TPR_FK_PRODUCTOEDI 			= CPE.CPE_PK_CPRODUCTOEDI
			 AND 	PE.TPE_FK_CPRODUCTOEDI 			= CPE.CPE_PK_CPRODUCTOEDI
			 AND 	PR.TPR_FK_REQUISITO 			= TRE.TRE_PK_TREQUISITO
			 AND 	MRE.TMR_FK_CREQUISITO			= TRE.TRE_FK_CREQUISITO
			 AND 	PP.TPP_FK_PERSONA 				= <cfqueryparam value="#pkPersona#"		cfsqltype="cf_sql_numeric">  
			 AND 	EPE.TEP_FK_PROCESO 				= <cfqueryparam value="#pkProceso#"		cfsqltype="cf_sql_numeric">
			 AND 	MRE.TMR_FK_MOVIMIENTO 			= <cfqueryparam value="#pkMovimiento#"	cfsqltype="cf_sql_numeric">
			 AND 	TPR_FK_ESTADO               	= 2
			GROUP BY	TRE.TRE_PK_TREQUISITO, TPR_NUMERO
			ORDER BY	PKTREQUISITO
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	* Descripcion: Obtiene todos los estatos de movimientos sin el filtro de personas (copia de getSolcitudesDisponibles)
	* Fecha:	   Diciembre de 2017
	* Autor:	   JLGC
	--->
	<cffunction name="getSolcitudesDisponiblesSinPersona" hint="Obtiene todos los estatos de movimientos sin el filtro de personas">
		<cfargument name="reglamento" type="numeric" required="no" hint="pk de la persona" default="0">
		<cfquery name="respuesta" datasource="DS_EDI">
             SELECT TMO.TMO_PK_MOVIMIENTO AS PK_MOVIMIENTO,
                    TMO.TMO_NOMBRE        AS NOMBRE,
                    TMO.TMO_DESCRIPCION   AS DESCRIPCION,
                    TMO.TMO_OBSERVACION   AS OBSERVACION,
                    TMO.TMO_FK_REGLAMENTO AS PKREGAMENTO,
                    209                   AS CESESTADO,
                    65                    AS CESRUTA,
					0					  AS PKASPIRANTEPROCESO
               FROM EDI.EDITMOVIMIENTO    TMO
              WHERE TMO.TMO_FK_ESTADO     = 2
                AND TMO.TMO_FK_REGLAMENTO = <cfqueryparam value="#reglamento#" cfsqltype="cf_sql_numeric">
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!---
    * Descripcion:    Edita el nombre del movimiento
    * Fecha creacion: 08 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarMovimientoNombre" access="public" returntype="numeric" hint="Edita el nombre del movimiento">
        <cfargument name="pkMovimiento"     type="numeric" required="yes" hint="Pk del movimiento">
        <cfargument name="movimientoNombre" type="string"  required="yes" hint="Nombre del movimiento">
        <cfstoredproc procedure="EDI.P_EDIMOVIMIENTOS.UPDATEMOVIMIENTO_NOMBRE" datasource="DS_EDI">
            <cfprocparam value="#pkMovimiento#"      cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#movimientoNombre#"  cfsqltype="cf_sql_string"  type="in">
            <cfprocparam variable="resultado"        cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Descripcion:    Edita la observacion del movimiento
    * Fecha creacion: 08 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarMovimientoObservacion" access="public" returntype="numeric" hint="Edita la observacion del movimiento">
        <cfargument name="pkMovimiento"          type="numeric" required="yes" hint="Pk del movimiento">
        <cfargument name="movimientoObservacion" type="string"  required="yes" hint="Observacion del movimiento">
        <cfstoredproc procedure="EDI.P_EDIMOVIMIENTOS.UPDATEMOVIMIENTO_OBSERVACION" datasource="DS_EDI">
            <cfprocparam value="#pkMovimiento#"          cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#movimientoObservacion#" cfsqltype="cf_sql_string"  type="in">
            <cfprocparam variable="resultado"            cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Descripcion:    Edita la descripcion del movimiento
    * Fecha creacion: 08 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarMovimientoDescripcion" access="public" returntype="numeric" hint="Edita la descripcion del movimiento">
        <cfargument name="pkMovimiento"          type="numeric" required="yes" hint="Pk del movimiento">
        <cfargument name="movimientoDescripcion" type="string"  required="yes" hint="Descripcion del movimiento">
        <cfstoredproc procedure="EDI.P_EDIMOVIMIENTOS.UPDATEMOVIMIENTO_DESCRIPCION" datasource="DS_EDI">
            <cfprocparam value="#pkMovimiento#"           cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#movimientoDescripcion#"  cfsqltype="cf_sql_string"  type="in">
            <cfprocparam variable="resultado"             cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Fecha:	Diciembre de 2017
    * autor:	Roberto Cadena
    --->
    <cffunction name="getEstadoPersona" hint="Obtiene el estado de la persona">
        <cfargument name="pkPersona" type="numeric"  required="yes" hint="Pk de la persona">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  CER_NOMBRE			AS ESTADO
			 FROM   EDITPERSONAESTADO  	TPE,
			        GRAL.CESCESTADO		CES
			WHERE   CES.CER_PK_ESTADO 	= TPE.TPE_FK_CESTADO
			 AND    TPE.TPE_FK_PERSONA	= <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			 AND    CER_FK_ESTADO 		= 2
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

    <!---
    * Fecha:	Diciembre de 2017
    * autor:	Roberto Cadena
    --->
    <cffunction name="getDatosPersona" hint="Obtiene el estado de la persona">
        <cfargument name="pkPersona" type="numeric"  required="yes" hint="Pk de la persona">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TPS_PERSONA_NOMBRE  AS NOMBRE,
			        TPS_PERSONA_PATERNO AS APPAT,
			        TPS_PERSONA_MATERNO AS APMAT,
			        TPS_NUMERO_EMPLEADO AS NUMEMPLEADO,
			        TPS.TPS_FK_UR       AS PKUR
			FROM    CVU.CVUTPERSONA     TPS
			WHERE   TPS.TPS_PK_PERSONA  = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha:	Diciembre de 2017
    * autor:	Roberto Cadena
    --->
    <cffunction name="getDatosUR" hint="Obtiene los datos de UR">
        <cfargument name="pkUR" type="string"  required="yes" hint="Pk de la UR">
		<cfquery name="respuesta" datasource="DS_URS">
			SELECT  TUR_PK_UR       AS PKUR,
		        	TUR.TUR_NOMBRE  AS NOMBRE
			FROM    URSTURS TUR
			WHERE   TUR.TUR_CLAVE = <cfqueryparam value="#pkUR#" cfsqltype="cf_sql_varchar">
		</cfquery>
		<cfreturn respuesta>
    </cffunction>


	<!---
    * Descripcion: Obtiene los investigadores y llena la tabla de la vista
    * Fecha:       11 de diciembre de 2017
    * @Author:     JLGC
    --->
    <cffunction name="getTablaInvestigadores" access="public" returntype="query" hint="Obtiene los investigadores y llena la tabla de la vista">
        <cfquery name="resultado" datasource="DS_EDI">
			SELECT EDOPER.TPE_PK_PERSONAESTADO AS PKEDOPER, 
			       EDOPER.TPE_FK_PERSONA       AS PKPERSON, 
			       EDOPER.TPE_FK_CESTADO       AS PKESTADO, 
			       PERSON.TPS_PERSONA_NOMBRE   AS INNOMBRE,
			       PERSON.TPS_PERSONA_PATERNO  AS INPATERNO,
			       PERSON.TPS_PERSONA_MATERNO  AS INMATERNO,
			       ESTADO.CER_NOMBRE           AS ESTADOPER
			  FROM EDI.EDITPERSONAESTADO EDOPER, 
			       CVU.CVUTPERSONA       PERSON,    
			       GRAL.CESCESTADO       ESTADO    
			 WHERE EDOPER.TPE_FK_PERSONA = PERSON.TPS_PK_PERSONA
			   AND EDOPER.TPE_FK_CESTADO = ESTADO.CER_PK_ESTADO  
        </cfquery>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Descripcion:    Obtiene los estados para llenar el combo estados de los investigadores
    * Fecha creacion: 11 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="getEstados" access="public" returntype="query" hint="Obtiene los estados para llenar el combo estados de los investigadores">
        <cfquery name="resultado" datasource="DS_EDI">
            SELECT ESTADO.CER_PK_ESTADO AS PK,
			       ESTADO.CER_NOMBRE    AS NOMBRE
			  FROM GRAL.CESCESTADO      ESTADO
			 WHERE ESTADO.CER_FK_RUTA = 63  
        </cfquery>
        <cfreturn resultado>
    </cffunction>

    <!--- 
    * Descripcion:    Edita la estado del investigador
    * Fecha creacion: 11 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarEstadoInvestigador" access="public" returntype="numeric" hint="Edita la estado del investigador">
        <cfargument name="pkEstadoInvestigador" type="numeric" required="yes" hint="Pk del investigador">
        <cfargument name="estado"               type="numeric" required="yes" hint="Nuevo estado">
        <cfstoredproc procedure="EDI.P_EDIMOVIMIENTOS.UPDATEINVESTIGADOR_ESTADO" datasource="DS_EDI">
            <cfprocparam value="#pkEstadoInvestigador#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#estado#"               cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado"           cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Fecha:	Diciembre de 2017
    * autor:	Roberto Cadena
    --->
    <cffunction name="getFecha" hint="Obtiene la fecha actual">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  EXTRACT(DAY FROM SYSDATE) || ' de ' ||
                    TO_CHAR(SYSDATE, 'Month', 'nls_date_language=Spanish')|| ' de '||
                    EXTRACT(YEAR FROM SYSDATE) AS FECHA
			 FROM DUAL
		</cfquery>
		<cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha:	Diciembre de 2017
    * autor:	Roberto Cadena
    --->
    <cffunction name="getaspiranteProceso" hint="Obtiene el aspirante proceso con base a un movimiento y una persona">
        <cfargument name="pkPersona" 	type="numeric" required="yes" hint="Pk del investigador">
        <cfargument name="pkMovimiento"	type="numeric" required="yes" hint="pk del movimiento">
		<cfargument name="pkProceso" 	type="numeric" required="yes" hint="pk de la persona">
        <cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TAS.TAS_PK_ASPIRANTEPROCESO AS PKASPIRANTE,
					TAS_MENSAJESOLICITUD		AS MENSAJE
			 FROM   EDI.EDITASPIRANTEPROCESO    TAS
			WHERE   TAS.TAS_FK_PERSONA          = <cfqueryparam value="#pkPersona#"		cfsqltype="CF_SQL_NUMERIC">
			 AND    TAS.TAS_FK_MOVIMIENTO       = <cfqueryparam value="#pkMovimiento#"	cfsqltype="CF_SQL_NUMERIC">
			 AND    TAS.TAS_FK_PROCESO          = <cfqueryparam value="#pkProceso#"		cfsqltype="CF_SQL_NUMERIC">
		</cfquery>
		<cfreturn respuesta>
    </cffunction>	

    <cffunction name="addMensajeAspiranteProceso" hint="Agrega un mesake a la tabla aspirante proceso">
        <cfargument name="pkAspirante" 	type="numeric"	required="yes" hint="Pk del aspirante">
        <cfargument name="mensaje" 		type="string"	required="yes" hint="Pk del aspirante">
        <cfstoredproc procedure="EDI.P_EVALUACIONEDI.ADDMENSAJEASPIRANTEPROCESO" datasource="DS_EDI">
            <cfprocparam value="#pkAspirante#"	cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#mensaje#"		cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam variable="resultado"	cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
		<cfreturn resultado>
    </cffunction>	

    <!---
    * Descripcion:    Obtiene los tipos de solicitud para llenar el combo en solicitudes al comite
    * Fecha creacion: 28 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="getTiposSolComite" access="public" returntype="query" hint="Obtiene los tipos de solicitud para llenar el combo en solicitudes al comite">
        <cfquery name="resultado" datasource="DS_EDI">
            SELECT TIPO.CTS_PK_SOLICITUDTIPO AS PK,
			       TIPO.CTS_NOMBRESOLICITUD    AS NOMBRE
			  FROM EDI.EDICSOLICITUDTIPO TIPO
			 WHERE TIPO.CTS_FK_ESTADO = 1
	      ORDER BY TIPO.CTS_ORDEN  
        </cfquery>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Descripcion: Obtiene las solicitudes al comite y llena la tabla de la vista
    * Fecha:       28 de diciembre de 2017
    * @Author:     JLGC
    --->
    <cffunction name="getTablaComite" access="public" returntype="query" hint="Obtiene las solicitudes al comite y llena la tabla de la vista">
        <cfargument name="fkPersona"   type="numeric" required="yes" hint="FK de la persona">
        <cfquery name="resultado" datasource="DS_EDI">
			SELECT SOLICITUD.TSO_PK_SOLICITUD  AS PK,
			       SOLICITUD.TSO_DESCRIPCION   AS DESCRIPCION,
			       SOLICITUD.TSO_FK_SOLICITUDTIPO  AS IDTIPO,
			       PERSONA.TPS_PERSONA_NOMBRE  AS NOMBRE,
			       PERSONA.TPS_PERSONA_PATERNO AS PATERNO,
			       PERSONA.TPS_PERSONA_MATERNO AS MATERNO,
			       TIPO.CTS_NOMBRESOLICITUD    AS TIPO
			  FROM EDI.EDITSOLICITUD     SOLICITUD,
			       CVU.CVUTPERSONA       PERSONA,
			       EDI.EDITPROCESO       PROCESO,
			       EDI.EDICSOLICITUDTIPO TIPO
			 WHERE SOLICITUD.TSO_FK_PERSONA       = PERSONA.TPS_PK_PERSONA
			   AND SOLICITUD.TSO_FK_PROCESO       = PROCESO.TPR_PK_PROCESO  
			   AND SOLICITUD.TSO_FK_SOLICITUDTIPO = TIPO.CTS_PK_SOLICITUDTIPO 
			   AND SOLICITUD.TSO_FK_PERSONA       = <cfqueryparam value="#fkPersona#" cfsqltype="CF_SQL_NUMERIC"> 
			   AND SOLICITUD.TSO_FK_ESTADO        = 1
		  ORDER BY SOLICITUD.TSO_PK_SOLICITUD DESC
        </cfquery>
        <cfreturn resultado>
    </cffunction>


    <!--- 
    * Descripcion:    Guarda nueva solicitud al comite
    * Fecha creacion: 28 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="agregarComite" access="public" returntype="numeric" hint="Guarda nueva solicitud al comite">
        <cfargument name="fkPersona"   type="numeric" required="yes" hint="FK de la persona">
        <cfargument name="fkProceso"   type="numeric" required="yes" hint="FK del proceso">
        <cfargument name="descripcion" type="string"  required="yes" hint="Descripcion de la solicitud">
        <cfargument name="fkTipo"      type="numeric" required="yes" hint="FK del tipo">
        <cfargument name="fkEstado"    type="numeric" required="yes" hint="FK del estado inicial">
        <cfstoredproc procedure="EDI.P_SOLICITUDCOMITE.ADDSOLICITUDCOMITE" datasource="DS_EDI">
            <cfprocparam value="#fkPersona#"   cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#fkProceso#"   cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#descripcion#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#fkTipo#"      cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#fkEstado#"    cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado"  cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!--- 
    * Descripcion:    Edita solicitud al comite
    * Fecha creacion: 29 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="editarComite" access="public" returntype="numeric" hint="Edita solicitud al comite">
        <cfargument name="PkSolicitud" type="numeric" required="yes" hint="PK de la solicitud al comite">
        <cfargument name="fkPersona"   type="numeric" required="yes" hint="FK de la persona">
        <cfargument name="fkProceso"   type="numeric" required="yes" hint="FK del proceso">
        <cfargument name="descripcion" type="string"  required="yes" hint="Descripcion de la solicitud">
        <cfargument name="fkTipo"      type="numeric" required="yes" hint="FK del tipo">
        <cfstoredproc procedure="EDI.P_SOLICITUDCOMITE.EDITSOLICITUDCOMITE" datasource="DS_EDI">
            <cfprocparam value="#PkSolicitud#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#fkPersona#"   cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#fkProceso#"   cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#descripcion#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#fkTipo#"      cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado"  cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!--- 
    * Descripcion:    Elimina solicitud al comite seleccionada
    * Fecha creacion: 28 de diciembre de 2017
    * @author:        JLGC
    --->
    <cffunction name="eliminarComite" access="public" returntype="numeric" hint="Elimina solicitud al comite seleccionada">
        <cfargument name="PkSolicitud" type="numeric" required="yes" hint="PK de la solicitud al comite">
        <cfargument name="fkEstado"    type="numeric" required="yes" hint="FK del estado inicial">
        <cfstoredproc procedure="EDI.P_SOLICITUDCOMITE.EDITESTADOSOLICITUDCOMITE" datasource="DS_EDI">
            <cfprocparam value="#PkSolicitud#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#fkEstado#"    cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado"  cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Descripcion:    Obtiene fechas para aplicar al recurso de inconformidad.
    * Fecha creacion: 17/Enero /2018
    * @author:        Alejandro Tovar
    --->
    <cffunction name="comparaFechasRI" hint="Obtiene fechas para aplicar al recurso de inconformidad.">    
        <cfquery name="qClasificacion" datasource="DS_EDI">
            SELECT TO_CHAR(PROC.TPR_RI_FECHAINI, 'DD/MM/YYYY') AS FECHAINI,
                   TO_CHAR(PROC.TPR_RI_FECHAFIN, 'DD/MM/YYYY') AS FECHAFIN
              FROM EDI.EDITPROCESO PROC
             WHERE TO_DATE(SYSDATE, 'DD/MM/YYYY') >= TO_DATE(PROC.TPR_RI_FECHAINI, 'DD/MM/YYYY')
               AND TO_DATE(SYSDATE, 'DD/MM/YYYY') <= TO_DATE(PROC.TPR_RI_FECHAFIN, 'DD/MM/YYYY')
               AND PROC.TPR_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
        </cfquery>
        <cfreturn qClasificacion>
    </cffunction>

	<!--- 
    * Descripcion:    Realiza el registro nuevo del recurso de inconformidad
    * Fecha creacion: Enero 2018
    * @author:        JLGC
    --->
    <cffunction name="guardaRecursoInconformidad" access="public" returntype="numeric" hint="Realiza el registro nuevo del recurso de inconformidad">
        <cfargument name="PkProducto"               type="numeric" required="yes" hint="PK del Producto">
        <cfargument name="fkTipo"                   type="numeric" required="yes" hint="Tipo de la inconformidad">
        <cfargument name="descripcionInconformidad" type="string"  required="yes" hint="Descripcion de la inconformidad">
        <cfstoredproc procedure="EDI.P_RECURSOINCONFORMIDAD.INSERTRECURSO" datasource="DS_EDI">
            <cfprocparam value="#PkProducto#"               cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#fkTipo#"                   cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#descripcionInconformidad#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam variable="resultado"               cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!--- 
    * Descripcion:    Realiza el guardado y cambio de estado al recurso de inconformidad
    * Fecha creacion: Enero 2018
    * @author:        JLGC
    --->
    <cffunction name="editaRecursoInconformidad" access="public" returntype="numeric" hint="Realiza guardado y cambio de estado al recurso de inconformidad">
        <cfargument name="PkProducto"               type="numeric" required="yes" hint="PK del Producto">
        <cfargument name="descripcionInconformidad" type="string"  required="yes" hint="Descripcion de la inconformidad">
        <cfstoredproc procedure="EDI.P_RECURSOINCONFORMIDAD.EDITRECURSO" datasource="DS_EDI">
            <cfprocparam value="#PkProducto#"               cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#descripcionInconformidad#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!--- 
    * Descripcion:    Realiza el cambio de estado al recurso de inconformidad a cero
    * Fecha creacion: Enero 2018
    * @author:        JLGC
    --->
    <cffunction name="eliminaRecursoInconformidad" access="public" returntype="numeric" hint="Realiza el cambio de estado al recurso de inconformidad a cero">
        <cfargument name="PkProducto" type="numeric" required="yes" hint="PK del Producto">
        <cfargument name="fkEstado"   type="numeric" required="yes" hint="FK del estado">
        <cfstoredproc procedure="EDI.P_RECURSOINCONFORMIDAD.EDITESTADORECURSO" datasource="DS_EDI">
            <cfprocparam value="#PkProducto#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#fkEstado#"   cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!--- 
    * Descripcion:    Regresa registro de Inconformidad
    * Fecha creacion: Enero 2018
    * @author:        JLGC
    --->
    <cffunction name="getRegistroInconformidad" hint="Regresa registro de Inconformidad">
            <cfargument name="PkProducto" type="numeric" required="yes" hint="PK del Producto">
            <cfquery name="result" datasource="DS_EDI">
                SELECT COUNT(TEE.TEE_FK_EVALUACIONPRODUCTOEDI) AS EXISTE 
                  FROM EDI.EDITEVALUACIONETAPA TEE
                 WHERE TEE.TEE_FK_EVALUACIONPRODUCTOEDI = <cfqueryparam value="#PkProducto#" cfsqltype="cf_sql_numeric">
                   AND TEE.TEE_FK_EVALUACIONTIPO        = #application.SIIIP_CTES.TIPOEVALUACION.RI#
                   AND TEE.TEE_FK_ESTADO                = 2
            </cfquery>
            <cfreturn result>
    </cffunction>

    <!--- 
    * Descripcion:    Regresa registro del Evaluador contenido en la etapa de la evaluacion 
    * Fecha creacion: Enero 2018
    * @author:        JLGC
    --->
    <cffunction name="getEvaluadorRegistroInconformidad" hint="Regresa registro del Evaluador contenido en la etapa de la evaluacion">
            <cfargument name="pkUsuario" type="numeric" required="yes" hint="PK del Usuario">
            <cfquery name="result" datasource="DS_EDI">
               SELECT ETAPA.TEE_FK_EVALUADOR AS EVALUADOR    
                 FROM CVU.CVUTPERSONA               PERSONA,  
                      CVU.CVUCTPRODUCTOPERSONA      PRODUCTOPERSONA, 
                      EDI.EDITEVALUACIONPRODUCTOEDI PRODUCTOEDI,
                      EDI.EDITEVALUACIONETAPA       ETAPA
                WHERE PERSONA.TPS_FK_USUARIO                   = <cfqueryparam value="#pkUsuario#" cfsqltype="cf_sql_numeric">
                  AND PERSONA.TPS_PK_PERSONA                   = PRODUCTOPERSONA.TPP_FK_PERSONA    
                  AND PRODUCTOPERSONA.TPP_PK_TPRODUCTOPERSONA  = PRODUCTOEDI.TEP_FK_CVUCCPRODUCTOPERSONA
                  AND PRODUCTOEDI.TEP_PK_EVALUACIONPRODUCTOEDI = ETAPA.TEE_FK_EVALUACIONPRODUCTOEDI
                  AND ETAPA.TEE_FK_EVALUACIONTIPO              = 4
                  AND ETAPA.TEE_FK_ESTADO                      = 1
             GROUP BY ETAPA.TEE_FK_EVALUADOR
            </cfquery>
            <cfreturn result>
    </cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getPlatillaReporte" hint="Muestra todos los usuarios para asignar a evaluar con un tipo de evaluacion">
		<cfargument name="pkClasificacion"	type="numeric" hint ="pk de la clasificacion">
		<cfargument name="ANIOINI"		type="numeric"	hint ="A�o de inicio del proceso">
		<cfargument name="ANIOFIN"		type="numeric"	hint ="A�o de fin del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT	TPE_CLASIFICACION|| '.' ||TPE_SUBCLASIFICACION	AS ACTIVIDAD
			<cfloop index = "i" from="#arguments.ANIOINI#" to="#arguments.ANIOFIN#">
					,'0'												AS ANIO#i#
			</cfloop>
					,'0'												AS PUNTOS
			 FROM	EDI.EDITPRODUCTOEDI
			WHERE	TPE_CLASIFICACION	= <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pkClasificacion#">
			 AND	TPE_FK_ESTADO		= 2
			GROUP BY TPE_CLASIFICACION|| '.' ||TPE_SUBCLASIFICACION
			ORDER BY TPE_CLASIFICACION|| '.' ||TPE_SUBCLASIFICACION
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAllProductosEvaluados" hint="Muestra todos los productos de una persona de una clasificacion">
        <cfargument name="pkPersona" 		type="numeric" required="yes" hint="Pk del investigador">
		<cfargument name="pkProceso" 		type="numeric" required="yes" hint="pk de la persona">
		<cfargument name="pkClasificacion"	type="numeric" hint ="pk de la clasificacion">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT	TEE_FK_EVALUACIONPRODUCTOEDI	AS PRODUCTOEVALUADO
			 FROM	EDI.EDICPRODUCTOEDI				CPE,
					EDI.EDITPRODUCTOEDI				TPE,
					EDI.EDITEVALUACIONETAPA			TEE,
					EDI.EDITEVALUACIONPRODUCTOEDI	TEP,
					CVU.CVUCTPRODUCTOPERSONA		TPP,
					CVU.CVUTPERSONA					TPS
			WHERE	TEP.TEP_PK_EVALUACIONPRODUCTOEDI= TEE.TEE_FK_EVALUACIONPRODUCTOEDI
			 AND	CPE.CPE_PK_CPRODUCTOEDI			= TPE.TPE_FK_CPRODUCTOEDI
			 AND	TPE.TPE_PK_TPRODUCTOEDI			= TEP.TEP_FK_TPRODUCTOEDI
			 AND	TPP.TPP_PK_TPRODUCTOPERSONA		= TEP.TEP_FK_CVUCCPRODUCTOPERSONA
			 AND	TPS.TPS_PK_PERSONA				= TPP.TPP_FK_PERSONA
			 AND	CPE.CPE_CLASIFICACION			= <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pkClasificacion#">
			 AND	TPS.TPS_PK_PERSONA				= <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			 AND	TEP.TEP_FK_PROCESO				= <cfqueryparam value="#pkProceso#"		cfsqltype="cf_sql_numeric">
			 AND	CPE.CPE_FK_ESTADO				= 2
			 AND	TEP.TEP_FK_ESTADO				= 2
			 AND	TEE.TEE_FK_ESTADO				= 2
			GROUP BY TEE_FK_EVALUACIONPRODUCTOEDI
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getpuntajeUltimosProductos" hint="Obtiene el puntaje de los utlimos productos">
		<cfargument name="pkProducto"	type="numeric" hint ="pk del producto">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.GETPUNTAJEULTIMOSPRODUCTOS" datasource="DS_EDI">
			<cfprocparam value="#pkProducto#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="puntaje"			cfsqltype="CF_SQL_NUMERIC"	type="out">
			<cfprocparam variable="clasificacion"	cfsqltype="CF_SQL_VARCHAR"	type="out">
			<cfprocparam variable="fila"			cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfscript>
			var resultado			= structNew();
			resultado.puntaje		= len(puntaje) eq 0 ? 0 : puntaje;
			resultado.clasificacion	= clasificacion;
			resultado.fila			= fila;
			resultado.anio			= '';
			return resultado;
		</cfscript>
	</cffunction>

	<!--- 
    *Fecha:	Enero 2018
	*Autor:	JLGC
    --->
    <cffunction name="guardaNarracion" access="public" returntype="numeric" hint="Realiza guardado de la narraci�n de los hechos de la Inconformidad">
        <cfargument name="PkPersona" type="numeric" required="yes" hint="PK de la Persona">
        <cfargument name="PkProceso" type="numeric" required="yes" hint="PK del proceso">
        <cfargument name="hechos"    type="string"  required="yes" hint="Descripcion de los hechos">
        <cfstoredproc procedure="EDI.P_RECURSOINCONFORMIDAD.EDITNARRACION" datasource="DS_EDI">
            <cfprocparam value="#PkPersona#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#PkProceso#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#hechos#"    cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam variable="resultado"  cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!---
	*Fecha:	Enero 2018
	*Autor:	JLGC
	--->
	<cffunction name="getNarracion" hint="MMuestra el contenido de la narraci�n de los hechos de la Inconformidad">
        <cfargument name="PkPersona" type="numeric" required="yes" hint="PK de la Persona">
        <cfargument name="PkProceso" type="numeric" required="yes" hint="PK del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT TAS_NARRACION_RI AS NARRACION
			  FROM EDI.EDITASPIRANTEPROCESO
			 WHERE TAS_FK_PERSONA  = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			   AND TAS_FK_PROCESO  = <cfqueryparam value="#PkProceso#" cfsqltype="cf_sql_numeric">
			   AND TAS_FK_ESTADO   = 2
			   AND TAS_FK_CESTADO  >= 211
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Febrero 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getObservacionCA" hint="Obtiene la observacion del CA sobre la solicitud">
		<cfargument name="pkPersona" hint="Pk de la persona">
		<cfargument name="pkProceso" hint="Proceso al que corresponde la solicitud">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TEA.TEA_OBSERVACION AS OBSERVACION_CA
			FROM    EDI.EDITEVALUACIONASPIRANTE TEA,
			        EDI.EDITASPIRANTEPROCESO TAS
			WHERE   TEA.TEA_FK_ASPIRANTEPROC = TAS.TAS_PK_ASPIRANTEPROCESO
			AND     TEA.TEA_FK_TIPOEVALUACION = 3
			AND     TAS.TAS_FK_PERSONA = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			AND     TAS.TAS_FK_PROCESO = <cfqueryparam value="#pkProceso#" cfsqltype="cf_sql_numeric">
			AND     TEA.TEA_FK_ESTADO > 0
			AND     TAS.TAS_FK_ESTADO > 0
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
    * Fecha creacion: Marzo /2018
    * @author:        Alejandro Tovar
    --->
    <cffunction name="getEdoAspiranteProceso" hint="obtiene el estado y ruta del aspiranteproceso">
    	<cfargument name="pkPersona" type="numeric"	hint ="pk del aspirante">
    	<cfargument name="pkProceso" type="numeric"	hint ="pk del proceso">
        <cfquery name="qClasificacion" datasource="DS_EDI">
			SELECT 	ASPROC.TAS_FK_CESTADO			AS CESESTADO,
					ASPROC.TAS_FK_CRUTA				AS CESRUTA,
					ASPROC.TAS_FK_PERSONA			AS PK_PERSONA,
					ASPROC.TAS_PK_ASPIRANTEPROCESO 	AS PK_ASCPROC
			  FROM 	EDI.EDITASPIRANTEPROCESO ASPROC
			 WHERE 	ASPROC.TAS_FK_PERSONA = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			   AND 	ASPROC.TAS_FK_ESTADO  = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			   AND 	ASPROC.TAS_FK_PROCESO = <cfqueryparam value="#pkProceso#" cfsqltype="cf_sql_numeric">
        </cfquery>
        <cfreturn qClasificacion>
    </cffunction>

    <!---
    * Fecha creacion: Marzo /2018
    * @author:        Alejandro Tovar
    --->
    <cffunction name="getBecaByAspiranteProceso" hint="obtiene la beca que se asigno a la pesona">
    	<cfargument name="pkPersona" type="numeric"	hint ="pk del aspirante">
    	<cfargument name="pkProceso" type="numeric"	hint ="pk del proceso">
    	<cfargument name="tipoEval"  type="numeric"	hint ="pk del tipo de evaluacion">
        <cfquery name="qClasificacion" datasource="DS_EDI">
			SELECT 	TEA.TEA_ANIOGRACIA 		AS GRACIA,
					TEA.TEA_RESIDENCIA 		AS RESIDENCIA,
					PROC.TPR_FECHAINIBECA 	AS INI_BECA,
					PROC.TPR_FECHAFINBECA 	AS FIN_BECA,
					PROC.TPR_FECHAFINGRACIA AS FIN_GRACIA
			  FROM 	EDI.EDITASPIRANTEPROCESO 	ASPROC,
			  		EDI.EDITEVALUACIONASPIRANTE TEA,
			  		EDI.EDITPROCESO 			PROC
			 WHERE 	TEA.TEA_FK_ASPIRANTEPROC 	= ASPROC.TAS_PK_ASPIRANTEPROCESO
			   AND  ASPROC.TAS_FK_PROCESO		= PROC.TPR_PK_PROCESO
			   AND 	ASPROC.TAS_FK_PERSONA 		= <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			   AND 	ASPROC.TAS_FK_PROCESO 		= <cfqueryparam value="#pkProceso#" cfsqltype="cf_sql_numeric">
			   AND 	ASPROC.TAS_FK_ESTADO 		= 2
			   AND 	TEA.TEA_FK_TIPOEVALUACION 	= <cfqueryparam value="#tipoEval#" cfsqltype="cf_sql_numeric">
			   AND 	TEA.TEA_FK_NIVEL 			<> 21
        </cfquery>
        <cfreturn qClasificacion>
    </cffunction>

    <!---
    * Fecha creacion: Marzo /2018
    * @author:        Alejandro Tovar
    --->
	<cffunction name="getTablaInvestigadoresNomina" hint="obtiene la nomina">
		<cfargument name="mayorCero" 	 type="boolean" hint="Nivel mayor a cero">
		<cfargument name="tipoEval"  	 type="numeric" hint="pk del tipo de evaluacion">
		<cfargument name="cveOficio" 	 type="any" 	hint="clave del oficio">
		<cfargument name="pkProceso" 	 type="numeric" hint="pk del proceso">
		<cfargument name="listadoNomina" type="string"  hint="listado de investigadores en nomina">
		<cfargument name="solAt"  	 	 type="boolean" hint="solicitud atendida">
		<cfargument name="solRI"  	 	 type="boolean" hint="solicito RI">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT 	PERS.TPS_PK_PERSONA AS PK_PERSONA,
					PERS.TPS_PERSONA_NOMBRE || ' ' || PERS.TPS_PERSONA_PATERNO || ' ' || PERS.TPS_PERSONA_MATERNO AS NOMBRE,
					PERS.TPS_RFC 		AS RFC,
					NIV.CED_NOMBRE_EDI 	AS NIVEL,
					TEA.TEA_RESIDENCIA 	AS RESIDENCIA,
					TEA.TEA_ANIOGRACIA 	AS ANIOGRACIA,
					TUR.TZP_PK_ZONAPAGO AS ZONA_PAGO,
					PERS.TPS_FK_UR 		AS UR_PERSONA,
					'#cveOficio#'		AS CVEOFICIO,
					ASP.TAS_PK_ASPIRANTEPROCESO	 AS PK_ASPROC
			  FROM  CVU.CVUTPERSONA 			PERS,
					EDI.EDITEVALUACIONASPIRANTE TEA,
					EDI.EDITASPIRANTEPROCESO 	ASP,
					UR.TUR_TZONAPAGO@DBL_UR		TUR,
					EDI.EDICEDI 				NIV
			 WHERE 	PERS.TPS_PK_PERSONA 		= ASP.TAS_FK_PERSONA
				AND ASP.TAS_PK_ASPIRANTEPROCESO = TEA.TEA_FK_ASPIRANTEPROC
				AND TEA.TEA_FK_TIPOEVALUACION 	= #tipoEval#

				<cfif mayorCero>
					AND TEA.TEA_FK_NIVEL <> #application.SIIIP_CTES.NIVEL.CERO#
				</cfif>

				<cfif solRI AND solAT>
					AND ASP.TAS_FK_CESTADO IN (#application.SIIIP_CTES.ESTADO.APLICO_RI#, #application.SIIIP_CTES.ESTADO.SOLICITUD_ATENDIDA#)
				<cfelseif solRI>
					AND ASP.TAS_FK_CESTADO = #application.SIIIP_CTES.ESTADO.APLICO_RI#
				<cfelseif solAt>
					AND ASP.TAS_FK_CESTADO = #application.SIIIP_CTES.ESTADO.SOLICITUD_ATENDIDA#
				</cfif>

				AND ASP.TAS_FK_ESTADO 	= 2
				AND PERS.TPS_FK_UR 		= TUR.TZP_FK_UR
				AND TEA.TEA_FK_NIVEL 	= NIV.CED_PK_EDI
				AND ASP.TAS_FK_PROCESO 	= #pkProceso#
				AND ASP.TAS_PK_ASPIRANTEPROCESO NOT IN(#listadoNomina#)
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

    <!---
    * Fecha creacion: Marzo /2018
    * @author:        Alejandro Tovar
    --->
	<cffunction name="guardaClaves" access="public" returntype="numeric" hint="Guarda las claves de nomina">
		<cfargument name="clave" 		 type="string" required="yes" hint="clave">
		<cfargument name="cveGracia" 	 type="string" required="yes" hint="clave del año de gracia">
		<cfargument name="cveResidencia" type="string" required="yes" hint="clave de la residencia">
		<cfargument name="cveOficio"     type="string" required="yes" hint="clave del oficio">
		<cfstoredproc procedure="EDI.P_NOMINA.GUARDACLAVES" datasource="DS_EDI">
			<cfprocparam value="#clave#" 		 cfsqltype="cf_sql_varchar" type="in">
			<cfprocparam value="#cveGracia#" 	 cfsqltype="cf_sql_varchar" type="in">
			<cfprocparam value="#cveResidencia#" cfsqltype="cf_sql_varchar" type="in">
			<cfprocparam value="#cveOficio#"     cfsqltype="cf_sql_varchar" type="in">
			<cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!---
    * Fecha creacion: Marzo /2018
    * @author:        Alejandro Tovar
    --->
	<cffunction name="guardaNomina" access="public" returntype="numeric" hint="Relaciona las claves con el aspirante proceso">
		<cfargument name="pkAspirante" type="numeric" required="yes" hint="pk de aspirante proceso">
		<cfargument name="nivel" 	   type="numeric" required="yes" hint="clave">
		<cfargument name="clave" 	   type="string"  required="yes" hint="clave del año de gracia">
		<cfargument name="pago" 	   type="string"  required="yes" hint="clave de la residencia">
		<cfargument name="oficio"      type="string"  required="yes" hint="clave del oficio">
		<cfargument name="rfc"         type="string"  required="yes" hint="clave del oficio">
		<cfargument name="pkClaves"    type="numeric" required="yes" hint="pk de claves">
		<cfstoredproc procedure="EDI.P_NOMINA.RELACIONA_ASPIRANTE_CLAVE" datasource="DS_EDI">
			<cfprocparam value="#pkAspirante#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#nivel#" 	   cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#clave#" 	   cfsqltype="cf_sql_varchar" type="in">
			<cfprocparam value="#pago#"	 	   cfsqltype="cf_sql_varchar" type="in">
			<cfprocparam value="#oficio#"	   cfsqltype="cf_sql_varchar" type="in">
			<cfprocparam value="#rfc#" 		   cfsqltype="cf_sql_varchar" type="in">
			<cfprocparam value="#pkClaves#"	   cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!---
	* Fecha creacion: Marzo /2018
	* @author:        Alejandro Tovar
	--->
	<cffunction name="getInvestigadoresNomina" hint="obtiene la nomina">
		<cfargument name="pkProceso" type="numeric" hint="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT RAC.RAC_FK_ASPROC AS PK_ASPROC
			  FROM EDI.EDIRASPIRANTECLAVE   RAC,
				   EDI.EDITASPIRANTEPROCESO TAP
			 WHERE TAP.TAS_PK_ASPIRANTEPROCESO = RAC.RAC_FK_ASPROC
			   AND TAP.TAS_FK_PROCESO = #pkProceso#
			   AND RAC.RAC_FK_ESTADO = 2
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	* Fecha creacion: Marzo /2018
	* @author:        Alejandro Tovar
	--->
	<cffunction name="getEnviadosNomina" hint="Muestra listado de investigadores enviados a nomina">
		<cfargument name="pkProceso" type="numeric" hint="pk del proceso actual">
		<cfargument name="oficio"    type="any"	hint="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  PERS.TPS_PERSONA_NOMBRE || ' ' || PERS.TPS_PERSONA_PATERNO || ' ' || PERS.TPS_PERSONA_MATERNO AS NOMBRE,
					RAC.RAC_RFC 	 AS RFC,
					ASP.TAS_PK_ASPIRANTEPROCESO AS PK_ASPROC,
					RAC.RAC_NIVEL	 AS NIVEL,
					RAC.RAC_CLAVE 	 AS CLAVE,
					RAC.RAC_ZONAPAGO AS ZONA_PAGO,
					RAC.RAC_OFICIO 	 AS OFICIO,
					RAC.RAC_RFC||' '|| rpad( PERS.TPS_PERSONA_NOMBRE || ' ' || PERS.TPS_PERSONA_PATERNO || ' ' || PERS.TPS_PERSONA_MATERNO ,39 , ' ') || nvl(RAC.RAC_NIVEL,0) || ' ' || RAC.RAC_CLAVE || RAC.RAC_ZONAPAGO || RAC.RAC_OFICIO AS DATOS
			  FROM  EDI.EDITASPIRANTEPROCESO ASP,
					EDI.EDIRASPIRANTECLAVE	 RAC,
					CVU.CVUTPERSONA 		 PERS
			 WHERE ASP.TAS_FK_PERSONA = PERS.TPS_PK_PERSONA
			   AND ASP.TAS_FK_PROCESO = #pkProceso#
			   AND ASP.TAS_PK_ASPIRANTEPROCESO = RAC.RAC_FK_ASPROC
			   AND RAC.RAC_FK_ESTADO = 2
			   <cfif oficio NEQ -1>
			   		AND RAC.RAC_OFICIO = #oficio#
			   </cfif>
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
    * Fecha creacion: Marzo /2018
    * @author:        Alejandro Tovar
    --->
	<cffunction name="cambiaEstadoNomina" hint="Cambia el estado de la nomina por aspirante">
		<cfargument name="pkAspirante" type="numeric" hint="pk del asprante proceso">
		<cfstoredproc procedure="EDI.P_NOMINA.CAMBIAESTADONOMINA" datasource="DS_EDI">
			<cfprocparam value="#pkAspirante#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!---
	* Fecha creacion: Marzo /2018
	* @author:        Alejandro Tovar
	--->
	<cffunction name="getOficios" hint="Obtiene los oficios capturados en el proceso actual">
		<cfargument name="pkProceso" type="numeric"	hint="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT 	DISTINCT(RAC.RAC_OFICIO) AS PK_ASPCLAVE
			  FROM 	EDI.EDIRASPIRANTECLAVE 	 RAC,
					EDI.EDITASPIRANTEPROCESO ASP
			 WHERE 	RAC.RAC_FK_ESTADO 	= 2
			   AND 	RAC.RAC_FK_ASPROC 	= ASP.TAS_PK_ASPIRANTEPROCESO
			   AND 	ASP.TAS_FK_PROCESO 	= #pkProceso#
		  ORDER BY 	RAC.RAC_OFICIO ASC
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Rosales
	--->
	<cffunction name="obtenerProcesoSeleccionado" hint="Obtiene el seleccionado">
		<cfargument name="pkProceso" hint="pk del proceso seleccionado">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT	TPR_PK_PROCESO		AS PKPROCESO,
					TPR_NOMBREPROCESO	AS NOMBREPROCESO,
					TPR_FECHAINI	AS FECHAINICIO,
					TPR_FECHAFIN	AS FECHAFIN,
					TPR_FK_ESTADO		AS ESTADOPROCESO,
					TPR_FK_REGLAMENTO   AS PKREGLAMENTO,
					TPR_RI_FECHAINI AS RIFECHAINI,
					TPR_RI_FECHAFIN AS RIFECHAFIN,
					TPR_ANIO_EVAL_INICIO       AS FECHAINIPROC,
			    TPR_ANIO_EVAL_FIN          AS FECHAFINPROC
			FROM	EDITPROCESO
			WHERE	TPR_PK_PROCESO = #pkProceso#
		</cfquery>
		<cfreturn respuesta>
	</cffunction>


</cfcomponent>
