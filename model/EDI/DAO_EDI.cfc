<cfcomponent>

	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAllProductos" hint="Obtiene todos los productos">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT	CPD.CPD_PK_CPRODUCTO	AS PKPRODUCTO,
					CPD.CPD_CPRODUCTO		AS PRODUCTO,
					CPD.CPD_PRODUCTO_ICONO	AS ICONO,
					CPD_FK_PADRE			AS PKPADRE
			 FROM	CVUCCPRODUCTO	CPD
			WHERE	CPD.CPD_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getAllProductosEDI" hint="Obtiene todos los productos de EDI">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TPR.TPE_PK_TPRODUCTOEDI	 		AS PK_PROD,
			        TPR.TPE_PUNTUACION 		 		AS PUNTAJE_MAX,
			        TPR.TPE_CLASIFICACION_ROMANO 	AS CLASIF,
			        TPE_SUBCLASIFICACION 		AS SUBCLA,
			        CPO.CPD_CPRODUCTO ||' '||TPR.TPE_NOMBREADICIONAL 		 		AS NOMBRE_PROD,
         			TPR.TPE_FK_PUNTUACIONTIPO 		AS TIPO_PUNTAJE
			  FROM  EDI.EDITPRODUCTOEDI TPR,
				    EDI.EDICPRODUCTOEDI CPE,
				    CVU.CVUCCPRODUCTO   CPO
			 WHERE 	TPR.TPE_FK_CPRODUCTOEDI = CPE.CPE_PK_CPRODUCTOEDI
			   AND 	CPE.CPE_FK_CVUCPRODUCTO = CPO.CPD_PK_CPRODUCTO
			   AND 	CPO.CPD_ESTADO = 2
			   AND 	TPR.TPE_PK_TPRODUCTOEDI <> 43
			   AND CPO.CPD_PK_CPRODUCTO NOT IN(
                    SELECT CPO.CPD_FK_PADRE 
                      FROM CVU.CVUCCPRODUCTO CPO
                     WHERE CPO.CPD_ESTADO > 0
                       AND CPO.CPD_FK_PADRE IS NOT NULL
                    GROUP BY   CPD_FK_PADRE 
			   )
			   ORDER BY TPE_CLASIFICACION, TPE_SUBCLASIFICACION
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getArbolProductosNoEvaluados" hint="Obtiene el arbol de productos que esta en EDI">
		<cfargument name="pkUsuario" hint="pk del usuario">							
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT DISTINCT
									CPD_PK_CPRODUCTO 	AS PKPRODUCTO,
									CPD_FK_PADRE        AS PKPADRE,
									CPD_CPRODUCTO       AS PRODUCTO,
									CPD_FK_REPORTE 		AS REPORTE, 
									RPT.TRP_FK_FORMATO 	AS FORMATO, 
									RPT.TRP_FK_PERIODO	AS PERIODO,
									CPE.TPE_CLASIFICACION AS CLASIFICACION,
									CPE.TPE_CLASIFICACION_ROMANO AS CLASIFICACION_ROMANO,
									CPE.TPE_SUBCLASIFICACION AS SUBCLASIFICACION,
									CPE.TPE_SUBCLASIFICACION_ROMANO AS SUBCLASIFICACION_ROMANO,  
									PRODUCTOS.RUTAPRODUCTOS
			FROM(SELECT CPD_FK_REPORTE,
									CPD_FK_PADRE,
									CPD_CPRODUCTO,
									SYS_CONNECT_BY_PATH(CPD_CPRODUCTO, '$$') AS RUTAPRODUCTOS, 
									CPD_PK_CPRODUCTO 
							FROM  	CVU.CVUCCPRODUCTO
							WHERE 	CPD_PK_CPRODUCTO <> 126
							START WITH 
															CPD_FK_PADRE IS NULL
							CONNECT BY NOCYCLE
															CPD_FK_PADRE = prior CPD_PK_CPRODUCTO  
							ORDER BY 
															LEVEL,CPD_PK_CPRODUCTO) PRODUCTOS,
							CVU.EVTTREPORTE RPT,
							CVU.CVUCTPRODUCTOPERSONA TPP,
							EDI.EDITEVALUACIONPRODUCTOEDI TPE,
							EDI.EDITPRODUCTOEDI CPE,
							CVU.CVUTPERSONA TPS,
							EDI.EDITPROCESO	TPR
			WHERE PRODUCTOS.CPD_FK_REPORTE IS NOT NULL
			AND TPE.TEP_FK_TPRODUCTOEDI = CPE.TPE_PK_TPRODUCTOEDI
			AND PRODUCTOS.CPD_PK_CPRODUCTO = TPP.TPP_FK_CPRODUCTO
			AND TPP.TPP_PK_TPRODUCTOPERSONA = TPE.TEP_FK_CVUCCPRODUCTOPERSONA
			AND PRODUCTOS.CPD_FK_REPORTE = RPT.TRP_PK_REPORTE
			AND TPP.TPP_FK_PERSONA = TPS.TPS_PK_PERSONA
			AND TPS.TPS_FK_USUARIO = <cfqueryparam value="#pkUsuario#">
			--AND TPE.TEP_FK_CESTADO < 220
			AND TPE.TEP_FK_PROCESO = TPR.TPR_PK_PROCESO
			AND TPR.TPR_FK_ESTADO = 2
			AND TPE.TEP_FK_ESTADO > 0
			ORDER BY CLASIFICACION
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>
	
	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getArbolProductosEvaluados" hint="Obtiene el arbol de productos que esta en EDI">
		<cfargument name="pkUsuario" hint="pk del usuario">							
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT DISTINCT
									CPD_PK_CPRODUCTO 	AS PKPRODUCTO,
									CPD_FK_PADRE        AS PKPADRE,
									CPD_CPRODUCTO       AS PRODUCTO,
									CPD_FK_REPORTE 		AS REPORTE, 
									RPT.TRP_FK_FORMATO 	AS FORMATO, 
									RPT.TRP_FK_PERIODO	AS PERIODO,
									CPE.TPE_CLASIFICACION AS CLASIFICACION,
									CPE.TPE_CLASIFICACION_ROMANO AS CLASIFICACION_ROMANO,
									CPE.TPE_SUBCLASIFICACION AS SUBCLASIFICACION,
									CPE.TPE_SUBCLASIFICACION_ROMANO AS SUBCLASIFICACION_ROMANO,  
									PRODUCTOS.RUTAPRODUCTOS
			FROM(SELECT CPD_FK_REPORTE,
									CPD_FK_PADRE,
									CPD_CPRODUCTO,
									SYS_CONNECT_BY_PATH(CPD_CPRODUCTO, '$$') AS RUTAPRODUCTOS, 
									CPD_PK_CPRODUCTO 
							FROM  	CVUCCPRODUCTO
							WHERE 	CPD_PK_CPRODUCTO <> 126
							START WITH 
															CPD_FK_PADRE IS NULL
							CONNECT BY NOCYCLE
															CPD_FK_PADRE = prior CPD_PK_CPRODUCTO  
							ORDER BY 
															LEVEL,CPD_PK_CPRODUCTO) PRODUCTOS,
							CVU.EVTTREPORTE RPT,
							CVU.CVUCTPRODUCTOPERSONA TPP,
							EDI.EDITEVALUACIONPRODUCTOEDI TPE,
							EDI.EDITPRODUCTOEDI CPE,
							CVU.CVUTPERSONA TPS,
							EDI.EDITPROCESO	TPR
			WHERE PRODUCTOS.CPD_FK_REPORTE IS NOT NULL
			AND TPE.TEP_FK_TPRODUCTOEDI = CPE.TPE_PK_TPRODUCTOEDI
			AND PRODUCTOS.CPD_PK_CPRODUCTO = TPP.TPP_FK_CPRODUCTO
			AND TPP.TPP_PK_TPRODUCTOPERSONA = TPE.TEP_FK_CVUCCPRODUCTOPERSONA
			AND PRODUCTOS.CPD_FK_REPORTE = RPT.TRP_PK_REPORTE
			AND TPP.TPP_FK_PERSONA = TPS.TPS_PK_PERSONA
			AND TPS.TPS_FK_USUARIO = <cfqueryparam value="#pkUsuario#">
			--AND TPE.TEP_FK_CESTADO >= 220
			AND TPE.TEP_FK_PROCESO = TPR.TPR_PK_PROCESO
			AND TPR.TPR_FK_ESTADO > 2
			AND TPE.TEP_FK_ESTADO > 0
			ORDER BY CLASIFICACION
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>		

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getProductosEDI" hint="Obtiene el listado de productos que estan en EDI">
		<cfargument name="pkPersona" hint="pk de la persona">		
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT  CPD.CPD_PK_CPRODUCTO AS PKPRODUCTO,
							CPD.CPD_CPRODUCTO AS PRODUCTO,
							CPD.CPD_PRODUCTO_ICONO AS ICONO,
							CPD.CPD_FK_PADRE           AS PKPADRE
			FROM  	CVU.CVUCCPRODUCTO             CPD,
							CVU.CVUCTPRODUCTOPERSONA      TPP,
							EDI.EDITEVALUACIONPRODUCTOEDI TPE,
							CVU.CVUTPERSONA               TPS
			WHERE   TPP.TPP_PK_TPRODUCTOPERSONA = TPE.TEP_FK_CVUCCPRODUCTOPERSONA
			AND     CPD.CPD_PK_CPRODUCTO        = TPP.TPP_FK_CPRODUCTO
			AND     TPS.TPS_PK_PERSONA          = TPP.TPP_FK_PERSONA
			AND     TPS.TPS_FK_USUARIO          = <cfqueryparam value="#pkPersona#" cfsqltype="CF_SQL_NUMERIC">
			AND     TPE.TEP_FK_ESTADO           > 0
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Noviembre de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getCatalogoProductosCVU" hint="Obtiene el catalogo de productos que estan en cvu">	
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT  CPD.CPD_PK_CPRODUCTO AS PKPRODUCTO,
							CPD.CPD_CPRODUCTO AS PRODUCTO,
							CPD.CPD_FK_PADRE AS PKPADRE
			FROM		CVU.CVUCCPRODUCTO CPD
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>


	<!--- 
	*Fecha:	Noviemrbe de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getNodosRaiz" hint="obtiene los nodos raiz (sin padres) de los productos">		
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TCE.CPE_PK_CPRODUCTOEDI AS PK_PRODUCTO,
							TCE.CPE_FK_CVUCPRODUCTO AS FK_PRODUCTOCVU,
							TCE.CPE_CLASIFICACION   AS CLASIFICACION,
							TCE.CPE_FK_ESTADO       AS ESTADO
			FROM    EDI.EDICPRODUCTOEDI TCE
			WHERE   TCE.CPE_FK_PADRE IS NULL
			AND     TCE.CPE_FK_ESTADO > 1
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Noviemrbe de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getEtapasEvaluacionProductoPersona" hint="obtiene las etapas de evaluacion de un producto">
		<cfargument name="pkEvaluacion" hint="pk de EVALUACIONPRODUCTOEDI">		
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TEE.TEE_PK_EVALUACIONETAPA AS PK_EVALUACION,
							TEE.TEE_FECHACAPTURA       AS FECHA_CAPTURA,
							TEE.TEE_PUNTAJE_OBTENIDO   AS PUNTAJE_OBTENIDO,
							TEE.TEE_FK_RECLASIFICACION AS FK_RECLASIFICACION,
							TEE.TEE_FK_EVALUADOR       AS FK_EVALUADOR,
							TEE.TEE_FK_EVALUACIONTIPO  AS FK_TIPO_EVALUACION,
							CET.CET_NOMBRE             AS NOMBRE_TIPO_EVALUACION,
							TEE.TEE_FK_ESTADO          AS ESTADO
			FROM    CVU.CVUCTPRODUCTOPERSONA      TPP,
							EDI.EDITEVALUACIONETAPA       TEE,
							EDI.EDITEVALUACIONPRODUCTOEDI TEP,
							EDI.EDICEVALUACIONTIPO        CET
			WHERE   TEP.TEP_PK_EVALUACIONPRODUCTOEDI = TEE.TEE_FK_EVALUACIONPRODUCTOEDI
			AND     TPP.TPP_PK_TPRODUCTOPERSONA      = TEP.TEP_FK_CVUCCPRODUCTOPERSONA
			AND     CET.CET_PK_EVALUACIONTIPO        = TEE.TEE_FK_EVALUACIONTIPO
			/*PK DE LA EVALUACION (PRODUCTO MANDADO A EVALUAR A EDI)*/
			AND     TEP.TEP_PK_EVALUACIONPRODUCTOEDI = <cfqueryparam value="#pkEvaluacion#" cfsqltype="cf_sql_numeric">			
			/*ESTADO DE LA ETAPA DE EVALUACION*/
			AND     TEE.TEE_FK_ESTADO > 1
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Noviemrbe de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getEvaluacionProductoPersona" hint="obtiene la evaluacion de un producto">
		<cfargument name="pkProductoEDI" hint ="pk del producto de EDI">		
		<cfargument name="pkPersona"     hint ="pk de la persona">		
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  -- EVALUACION
							CPE_PK_CPRODUCTOEDI              AS PK_CPRODUCTOEDI,
							CPE_FK_CVUCPRODUCTO              AS PK_CPRODUCTOCVU,
							CPE_FK_ESTADO                    AS ESTADO_PRODUCTO,
							CPD_CPRODUCTO                    AS NOMBRE_PRODUCTO,
							CPD_DESCRIPCION                  AS DESCRIPCION_PRODUCTO,
							CPD_FK_REPORTE                   AS PK_REPORTE,
							CPD_PRODUCTO_ICONO               AS ICONO_PRODUCTO,
			        RUTA_PRODUCTOS,			        
			        -- EVALUACION PRODUCTO
							TPP_PK_TPRODUCTOPERSONA          AS PK_PRODUCTOPERSONA,
							TPP_FK_PERSONA                   AS PK_PERSONA,
							TPP_FK_FILA                      AS PK_FILA,
							TPP_ESTADO                       AS ESTADO_PRODUCTOPERSONA,
							TEP.TEP_PK_EVALUACIONPRODUCTOEDI AS PK_EVALUACIONPRODUCTO
			FROM    (SELECT TPE.*,
			                CCP.*
			                ,SYS_CONNECT_BY_PATH(CPD_CPRODUCTO, '$$') AS RUTA_PRODUCTOS
			        FROM    EDI.EDICPRODUCTOEDI TPE,
			                CVU.CVUCCPRODUCTO   CCP                
			        WHERE   CCP.CPD_PK_CPRODUCTO         = TPE.CPE_FK_CVUCPRODUCTO
			        START WITH TPE.CPE_PK_CPRODUCTOEDI   = <cfqueryparam value="#pkProductoEDI#" cfsqltype="cf_sql_numeric">
			        CONNECT BY NOCYCLE  TPE.CPE_FK_PADRE = PRIOR TPE.CPE_PK_CPRODUCTOEDI
			        ORDER BY LEVEL,TPE.CPE_PK_CPRODUCTOEDI) PRODUCTOS,
			        CVU.CVUCTPRODUCTOPERSONA TPP,
			        EDI.EDITEVALUACIONPRODUCTOEDI TEP            
			WHERE   TPP.TPP_FK_CPRODUCTO        = PRODUCTOS.CPD_PK_CPRODUCTO
			AND     TPP.TPP_PK_TPRODUCTOPERSONA = TEP.TEP_FK_CVUCCPRODUCTOPERSONA
			AND     TPP.TPP_FK_PERSONA          = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">			
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Noviemrbe de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getTiposEvaluacion" hint="obtiene los tipos de evaluacion">		
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  CET.CET_PK_EVALUACIONTIPO AS PK_TIPOEVALUACION,
							CET.CET_NOMBRE            AS NOMBRE_TIPOEVALUACION,
							CET.CET_FK_ESTADO         AS ESTADO_TIPOEVALUACION
			FROM    EDI.EDICEVALUACIONTIPO CET
			WHERE   CET.CET_FK_ESTADO > 0
			ORDER BY PK_TIPOEVALUACION
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Noviemrbe de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getPersonasConProductosEDI" hint="obtiene las personas con productos en EDI">		
		<cfquery name="respuesta" datasource="DS_CVU">						
			SELECT  TPR.TPS_PK_PERSONA AS PK,
			        TPR.TPS_PERSONA_NOMBRE||' '||TPR.TPS_PERSONA_PATERNO||' '||TPR.TPS_PERSONA_MATERNO AS NOMBRE,
			        TPR.TPS_RFC AS RFC,
			        TPR.TPS_NUMERO_EMPLEADO AS NUM_EMPLEADO,
			        TPR.TPS_FK_USUARIO AS PK_USUARIO,
			        COUNT(*) AS NUM_PRODUCTOS        
			FROM    CVU.CVUTPERSONA TPR,
			        CVU.CVUCTPRODUCTOPERSONA TPP,
			        EDI.EDITEVALUACIONPRODUCTOEDI TPE        
			WHERE   TPP.TPP_PK_TPRODUCTOPERSONA = TPE.TEP_FK_CVUCCPRODUCTOPERSONA
			AND     TPR.TPS_PK_PERSONA = TPP.TPP_FK_PERSONA
			GROUP BY 
			        TPR.TPS_PK_PERSONA,
			        TPR.TPS_PERSONA_NOMBRE,
			        TPR.TPS_PERSONA_PATERNO,
			        TPR.TPS_PERSONA_MATERNO,
			        TPR.TPS_RFC,
			        TPR.TPS_NUMERO_EMPLEADO,
			        TPR.TPS_FK_USUARIO
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Noviemrbe de 2017
	*Autor:	Daniel Memije
	--->
	<cffunction name="getTablaAspiranteProceso" hint="obtiene la tabla de movimientos de aspiranteproceso">
		<cfargument name="pkProceso"   type="numeric" hint="Pk del proceso">
		<cfargument name="pkEvaluador" type="numeric" hint="Pk del evaluador">
		<cfargument name="pkRol"       type="numeric" hint="Pk del rol">
		<cfquery name="respuesta" datasource="DS_EDI">						
			SELECT DISTINCT(MOV.TMO_PK_MOVIMIENTO) AS PK_MOVIMIENTO,
			       MOV.TMO_NOMBRE				   AS MOVIMIENTO,
			       EDO.CER_PK_ESTADO               AS PK_ESTADO,
				   EDO.CER_NUMERO_ESTADO           AS NUM_ESTADO,
				   EDO.CER_NOMBRE                  AS ESTADO,
				   EDO.CER_COLOR				   AS COLOR,
			       PERS.TPS_PK_PERSONA             AS PK_PERSONA,
				   PERS.TPS_FK_USUARIO             AS FK_USUARIO,
				   PERS.TPS_RFC                    AS RFC,
				   PERS.TPS_NUMERO_EMPLEADO        AS NUM_EMPLEADO,
			       PERS.TPS_PERSONA_NOMBRE||' '||PERS.TPS_PERSONA_PATERNO||' '||PERS.TPS_PERSONA_MATERNO AS NOMBRE,
			       PERS.TPS_CORREO_IPN             AS CORREO,
			       ROL.TRO_FK_VERTIENTE 		   AS VERTIENTE,
			       TUR.TUR_SIGLA				   	AS UR,
			       TUR.TUR_PK_UR  					AS PK_UR,
			       ASPROC.TAS_PK_ASPIRANTEPROCESO  AS PK_ASPIRANTEPROCESO,
				   ASPROC.TAS_FK_CESTADO		   AS CESESTADO,
				   ASPROC.TAS_FK_CRUTA			   AS CESRUTA,
			        EVAL_SIP.CED_NOMBRE_EDI AS NIVEL_ASIGNADO_SIP, 
			        EVAL_CE.CED_NOMBRE_EDI AS NIVEL_ASIGNADO_CE, 
			        EVAL_CA.CED_NOMBRE_EDI AS NIVEL_ASIGNADO_CA
			  FROM EDI.EDITEVALUACIONETAPA       ETAPA,
			  	   EDI.EDITEVALUACIONPRODUCTOEDI EVALP,
			  	   EDI.EDITASPIRANTEPROCESO      ASPROC,
			  	   EDI.EDITMOVIMIENTO            MOV,
			  	   GRAL.CESCESTADO               EDO,
			  	   CVU.CVUCTPRODUCTOPERSONA      PROP,
			  	   CVU.CVUTPERSONA               PERS,
       			   GRAL.USRTUSUARIO 			 USR,
       			   GRAL.USRTROL 				 ROL,
			       UR.TURIPN@DBL_URSIGA TUR,
			       (SELECT NIV.CED_NOMBRE_EDI,
			               EVA.TEA_FK_ASPIRANTEPROC 
			          FROM EDI.EDICEDI NIV,
			               EDI.EDITEVALUACIONASPIRANTE EVA
			         WHERE EVA.TEA_FK_NIVEL = NIV.CED_PK_EDI
			           AND EVA.TEA_FK_TIPOEVALUACION = 1
			           AND EVA.TEA_FK_ESTADO = 2
			       )EVAL_SIP,
			       (SELECT NIV.CED_NOMBRE_EDI,
			                EVA.TEA_FK_ASPIRANTEPROC 
			              FROM EDI.EDICEDI NIV,
			                   EDI.EDITEVALUACIONASPIRANTE EVA
			             WHERE EVA.TEA_FK_NIVEL = NIV.CED_PK_EDI
			               AND EVA.TEA_FK_TIPOEVALUACION = 2
			               AND EVA.TEA_FK_ESTADO = 2
			       )EVAL_CE,
			       (SELECT NIV.CED_NOMBRE_EDI,
			                EVA.TEA_FK_ASPIRANTEPROC
			              FROM EDI.EDICEDI NIV,
			                   EDI.EDITEVALUACIONASPIRANTE EVA
			             WHERE EVA.TEA_FK_NIVEL = NIV.CED_PK_EDI
			               AND EVA.TEA_FK_TIPOEVALUACION = 3
			               AND EVA.TEA_FK_ESTADO = 2
			       )EVAL_CA
			 WHERE ETAPA.TEE_FK_EVALUACIONPRODUCTOEDI(+) = EVALP.TEP_PK_EVALUACIONPRODUCTOEDI
			   AND EVALP.TEP_FK_CVUCCPRODUCTOPERSONA(+)  = PROP.TPP_PK_TPRODUCTOPERSONA
			   AND PROP.TPP_FK_PERSONA 				  	 = PERS.TPS_PK_PERSONA
			   AND PERS.TPS_PK_PERSONA 				  	 = ASPROC.TAS_FK_PERSONA
			   AND ASPROC.TAS_FK_MOVIMIENTO 		  	 = MOV.TMO_PK_MOVIMIENTO
			   AND EDO.CER_PK_ESTADO     			  	 = ASPROC.TAS_FK_CESTADO
			   AND ASPROC.TAS_FK_CESTADO     		  	 >= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.SOLICITUDENVIADASIP#" cfsqltype="cf_sql_numeric">
			   AND ETAPA.TEE_FK_ESTADO(+)				 = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			   AND ASPROC.TAS_FK_PROCESO   = <cfqueryparam value="#arguments.pkProceso#" cfsqltype="cf_sql_numeric">
			   AND EVALP.TEP_FK_PROCESO(+) = <cfqueryparam value="#arguments.pkProceso#" cfsqltype="cf_sql_numeric">
			   <cfif not arraycontains(session.cbstorage.grant,'evalEDI.verTodos')>
			   		AND ETAPA.TEE_FK_EVALUADOR 		= <cfqueryparam value="#arguments.pkEvaluador#" cfsqltype="cf_sql_numeric">
			   </cfif>
			   AND ASPROC.TAS_FK_ESTADO 			= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			   AND PERS.TPS_FK_USUARIO 				= USR.TUS_PK_USUARIO
       		   AND USR.TUS_FK_ROL 	   				= ROL.TRO_PK_ROL
       		   AND PERS.TPS_FK_UR 	   				= TUR.TUR_PK_UR
		       AND ASPROC.TAS_PK_ASPIRANTEPROCESO =  EVAL_SIP.TEA_FK_ASPIRANTEPROC(+)
		       AND ASPROC.TAS_PK_ASPIRANTEPROCESO =  EVAL_CE.TEA_FK_ASPIRANTEPROC(+) 
		       AND ASPROC.TAS_PK_ASPIRANTEPROCESO =  EVAL_CA.TEA_FK_ASPIRANTEPROC(+)
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	--->
	<cffunction name="getProcesos" hint="obtiene los procesos existentes">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  PROC.TPR_PK_PROCESO    AS PKPROCESO,
			        PROC.TPR_NOMBREPROCESO AS NOMBREPPROCESO
			 FROM   EDI.EDITPROCESO PROC
			WHERE   PROC.TPR_FK_ESTADO = 2
			ORDER BY PROC.TPR_FECHAINI DESC
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEvaluadores" hint="Muestra todos los usuarios para asignar a evaluar">
		<cfargument name="pkProceso"	type="numeric"	hint ="pk del proceso">
		<cfargument name="roles"		type="array"	hint ="Roles permitidos">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TUS.TUS_PK_USUARIO          AS PKUSUARIO,
			        TUS.TUS_USUARIO_NOMBRE      AS NOMBRE,
			        TUS.TUS_USUARIO_PATERNO     AS PATERNO,
			        TUS.TUS_USUARIO_MATERNO     AS MATERNO,
			        TEP.TEP_FK_EVALUACIONTIPO   AS EVALTIPO
			 FROM   GRAL.USRTUSUARIO            TUS,
			        (SELECT	TEP_FK_USUARIO,
			        		TEP_FK_EVALUACIONTIPO
		             FROM	EDI.EDITEVALUADORPROCESO
		            WHERE 	TEP_FK_PROCESO		= <cfqueryparam value="#arguments.pkProceso#" cfsqltype="cf_sql_numeric">
		             AND 	TEP_FK_ESTADO 		= 2
			        ) TEP
			WHERE   TEP.TEP_FK_USUARIO (+)      = TUS.TUS_PK_USUARIO
			 AND(
			 <cfloop index = "i" from="1" to="#arrayLen(arguments.roles)#">
				<cfif i neq 1>
	                OR 
	            </cfif>
				TUS.TUS_FK_ROL					= <cfqueryparam value="#arguments.roles[i]#" cfsqltype="cf_sql_numeric">
             </cfloop>
             )
			 AND    TUS.TUS_FK_ESTADO           = 2
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getUsuariosRoles" hint="Muestra todos los usuarios para asignar a evaluar">
		<cfargument name="roles"		type="array"	hint ="Roles permitidos">
		<cfquery name="respuesta" datasource="DS_GRAL">
			SELECT  TUS.TUS_PK_USUARIO          AS PKUSUARIO,
			        TUS.TUS_USUARIO_NOMBRE      AS NOMBRE,
			        TUS.TUS_USUARIO_PATERNO     AS PATERNO,
			        TUS.TUS_USUARIO_MATERNO		AS MATERNO,
			        TUR.TUR_SIGLA              AS DEPENDENCIA,
			        ''                          AS EVALSIP,
			        ''                          AS EVALCA,
			        '' 							AS EVALCE
			 FROM   GRAL.USRTUSUARIO            TUS,
                    UR.TURIPN@DBL_URSIGA         TUR 
			WHERE   TUR.TUR_PK_UR = TUS.TUS_FK_UR
			 AND    TUS.TUS_FK_ESTADO           = 2
			 AND(
			 <cfloop index = "i" from="1" to="#arrayLen(arguments.roles)#">
				<cfif i neq 1>
	                OR 
	            </cfif>
				TUS.TUS_FK_ROL					= <cfqueryparam value="#arguments.roles[i]#" cfsqltype="cf_sql_numeric">
             </cfloop>
             )
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEvaluadoresProceso" hint="Muestra todos los usuarios que hayan sido evaluadores">
		<cfargument name="pkProceso"	type="numeric"	hint ="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT	TEP_FK_USUARIO			AS FKUSUARIO,
					TEP_FK_EVALUACIONTIPO	AS EVALTIPO
			 FROM	EDI.EDITEVALUADORPROCESO
			WHERE 	TEP_FK_PROCESO			= <cfqueryparam value="#arguments.pkProceso#" cfsqltype="cf_sql_numeric">
			 AND 	TEP_FK_ESTADO 			= 2
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setTipoEvaluador" hint="Asigna un tipo de evaluacion a un evaluador">
		<cfargument name="pkUsuario"	required="yes"	type="numeric" hint ="pk del usuario">
		<cfargument name="pkTipoEval"	required="yes"	type="numeric" hint ="pk del tipo de evaluacion">
		<cfargument name="pkProceso"	required="yes"	type="numeric" hint ="pk del proceso">
		<cfargument name="estado"		required="yes"	type="numeric" hint ="estado">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.SETTIPOEVALUADOR" datasource="DS_EDI">
			<cfprocparam value="#pkUsuario#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkTipoEval#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkProceso#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#estado#"		cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getPersonasSolicitudEDI" hint="Muestra todos los usuarios para asignar a evaluar">
		<cfargument name="pkProceso"	type="numeric"	hint ="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TPS.TPS_PK_PERSONA              AS PKPERSONA,
			        TPS.TPS_NUMERO_EMPLEADO         AS NUMEMPLEADO,
			        TPS.TPS_PERSONA_NOMBRE          AS NOMBRE,
			        TPS.TPS_PERSONA_PATERNO         AS PATERNO,
			        TPS.TPS_PERSONA_MATERNO         AS MATERNO,
			        TUR.TUR_SIGLA             		AS DEPENDENCIA,
			        ' '								AS EVALSIP,
			        ' '								AS EVALCA,
			        ' '								AS EVALCE,
			        ' '								AS EVALRI,
			        ''								AS PKEVALSIP,
			        ''								AS PKEVALCA,
			        ''								AS PKEVALCE,
			        ''								AS PKEVALRI,
			        'fa-user-plus'					AS BOTONEVALSIP,
			        'fa-user-plus'					AS BOTONEVALCA,
			        'fa-user-plus'					AS BOTONEVALCE,
			        'fa-user-plus'					AS BOTONEVALRI,
			        'btn-primary'					AS CLASEEVALSIP,
			        'btn-primary'					AS CLASEEVALCA,
			        'btn-primary'					AS CLASEEVALCE,
			        'btn-primary'					AS CLASEEVALRI,
			        ''								AS COMPLETAEVALSIP,
			        ''								AS COMPLETAEVALCA,
			        ''								AS COMPLETAEVALCE,
			        ''								AS COMPLETAEVALRI

			    FROM CVU.CVUTPERSONA TPS,
                     EDI.EDITASPIRANTEPROCESO TEP,
                     UR.TURIPN@DBL_URSIGA TUR
               WHERE     TEP.TAS_FK_PERSONA= TPS.TPS_PK_PERSONA
                     AND TUR.TUR_PK_UR = TPS.TPS_FK_UR
                     AND TEP.TAS_FK_CESTADO >= <cfqueryparam cfsqltype="cf_sql_numeric" value="#application.SIIIP_CTES.ESTADO.SOLICITUDENVIADASIP#">
                     AND TEP.TAS_FK_PROCESO = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pkProceso#">
			GROUP BY TPS.TPS_PK_PERSONA, TPS_NUMERO_EMPLEADO,
			        TPS.TPS_PERSONA_NOMBRE,
			        TPS.TPS_PERSONA_PATERNO,
			        TPS.TPS_PERSONA_MATERNO,
			        TUR.TUR_SIGLA
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEvaluadoresActivos" hint="Muestra todos los usuarios para asignar a evaluar">
		<cfargument name="pkProceso"	type="numeric"	hint ="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TUS_PK_USUARIO                      AS PKEVALUADOR,
			        TUS_USUARIO_NOMBRE                  AS NOMBRE,
			        TUS_USUARIO_PATERNO                 AS PATERNO,
			        TUS_USUARIO_MATERNO                 AS MATERNO,
			        TEE_FK_EVALUACIONTIPO               AS PKEVALUACIONTIPO,
			        TPS.TPS_PK_PERSONA                  AS PKPERSONA
			 FROM   EDI.EDITEVALUACIONETAPA             TEE,
			        EDI.EDITEVALUACIONPRODUCTOEDI       TEP,
			        GRAL.USRTUSUARIO                    TUS,
			        CVU.CVUCTPRODUCTOPERSONA	        TPP,
			        CVU.CVUTPERSONA                     TPS
			WHERE   TUS.TUS_PK_USUARIO                  = TEE.TEE_FK_EVALUADOR
			 AND    TEP.TEP_PK_EVALUACIONPRODUCTOEDI    = TEE.TEE_FK_EVALUACIONPRODUCTOEDI
			 AND    TPP.TPP_PK_TPRODUCTOPERSONA         = TEP.TEP_FK_CVUCCPRODUCTOPERSONA
			 AND    TPS.TPS_PK_PERSONA                  = TPP.TPP_FK_PERSONA
			 AND    TEP_FK_PROCESO                      = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pkProceso#">
			 AND    TEE.TEE_FK_ESTADO                   > 0
			 AND    TEP.TEP_FK_ESTADO                   = 2
			  group by TUS_PK_USUARIO,
			       TUS_USUARIO_NOMBRE,
			       TUS_USUARIO_PATERNO,
			       TUS_USUARIO_MATERNO,
			       TEE_FK_EVALUACIONTIPO,
			       TPS.TPS_PK_PERSONA
		</cfquery>
		<cfreturn respuesta>		
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarEvaluador" hint="Elimina al evaluador que va a evaluar los productos de un investigador">
		<cfargument name="pkPersona"	type="numeric" hint ="pk del usuario">
		<cfargument name="pkEvaluador"	type="numeric" hint ="pk del usuario">
		<cfargument name="pkTipoEval"	type="numeric" hint ="pk del usuario">
		<cfargument name="pkProceso"	type="numeric" hint ="pk del proceso">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.ELIMINAREVALUADOR" datasource="DS_EDI">
			<cfprocparam value="#pkPersona#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkEvaluador#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkTipoEval#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkProceso#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEvaluadoresTipo" hint="Muestra todos los usuarios para asignar a evaluar con base a un tipo de evaluacion">
		<cfargument name="pkTipoEval"	type="numeric" hint ="pk del usuario">
		<cfargument name="pkProceso"	type="numeric"	hint ="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TUS_PK_USUARIO                      AS PKEVALUADOR,
			        TUS_USUARIO_NOMBRE                  AS NOMBRE,
			        TUS_USUARIO_PATERNO                 AS PATERNO,
			        TUS_USUARIO_MATERNO                 AS MATERNO,
			        TUR.TUR_SIGLA						AS DEPENDENCIA
			 FROM   EDI.EDITEVALUADORPROCESO            TEP,
			        GRAL.USRTUSUARIO                    TUS,
			        UR.TURIPN@DBL_URSIGA         		TUR 
			WHERE   TUS.TUS_PK_USUARIO = TEP.TEP_FK_USUARIO
			 AND	TUR.TUR_PK_UR(+) 					= TUS.TUS_FK_UR
			 AND    TEP_FK_PROCESO                      = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pkProceso#">
			 AND    TEP.TEP_FK_EVALUACIONTIPO           = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pkTipoEval#">
			 AND    TEP.TEP_FK_ESTADO                   = 2
			 AND	TUS.TUS_FK_ESTADO					= 2
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="setEvaluadorInvestigador" hint="Asigna un evaluador a un investigador">
		<cfargument name="pkPersona"	type="numeric" hint ="pk del usuario">
		<cfargument name="pkEvaluador"	type="numeric" hint ="pk del usuario">
		<cfargument name="pkTipoEval"	type="numeric" hint ="pk del usuario">
		<cfargument name="pkProceso"	type="numeric" hint ="pk del proceso">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.SETEVALUADORINVESTIGADOR" datasource="DS_EDI">
			<cfprocparam value="#pkPersona#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkEvaluador#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkTipoEval#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkProceso#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAllEvaluadores" hint="Muestra todos los usuarios para asignar a evaluar">
		<cfargument name="pkProceso"	type="numeric"	hint ="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TUS.TUS_PK_USUARIO          AS PKEVALUADOR,
			        TUS.TUS_USUARIO_NOMBRE      AS NOMBRE,
			        TUS.TUS_USUARIO_PATERNO     AS PATERNO,
			        TUS.TUS_USUARIO_MATERNO     AS MATERNO,
			        TUR.TUR_SIGLA             	AS DEPENDENCIA,
					''							AS EVALSIP,
					''							AS EVALCA,
					''							AS EVALCE,
					''							AS EVALRI
			 FROM   EDI.EDITEVALUADORPROCESO    TEP,
			        GRAL.USRTUSUARIO            TUS,
			        UR.TURIPN@DBL_URSIGA        	TUR
			WHERE   TUS.TUS_PK_USUARIO          = TEP.TEP_FK_USUARIO
			 AND	TUR.TUR_PK_UR 				= TUS.TUS_FK_UR
			 AND    TEP_FK_PROCESO              = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pkProceso#">
			 AND    TEP.TEP_FK_ESTADO           = 2
			 AND	TUS.TUS_FK_ESTADO			= 2
			GROUP BY TUS.TUS_PK_USUARIO,
					TUS.TUS_USUARIO_NOMBRE,
					TUS.TUS_USUARIO_PATERNO,
					TUS.TUS_USUARIO_MATERNO,
			        TUR.TUR_SIGLA
			ORDER BY TUS.TUS_USUARIO_NOMBRE,
			 		TUS.TUS_USUARIO_PATERNO,
			 		TUS.TUS_USUARIO_MATERNO,
			        TUR.TUR_SIGLA
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEvaluadoresTiposEvaluadores" hint="Muestra todos los usuarios para asignar a evaluar">
		<cfargument name="pkProceso"	type="numeric"	hint ="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TEP.TEP_FK_USUARIO          AS PKEVALUADOR,
			        TEP.TEP_FK_EVALUACIONTIPO   AS EVALTIPO
			 FROM   EDI.EDITEVALUADORPROCESO	TEP
			WHERE   TEP.TEP_FK_PROCESO	        = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pkProceso#">
			 AND    TEP.TEP_FK_ESTADO           = 2
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAllInvestigadoresTipoEval" hint="Muestra todos los usuarios para asignar a evaluar">
		<cfargument name="tipoInvest"	type="array"	hint ="nombres de los tipos de investigadores que puede ser un evaluador">
		<cfargument name="pkProceso"	type="numeric"	hint ="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			  SELECT TPS.TPS_PK_PERSONA AS PKPERSONA,
			         TPS.TPS_NUMERO_EMPLEADO AS NUMEMPLEADO,
			         TPS.TPS_PERSONA_NOMBRE AS NOMBRE,
			         TPS.TPS_PERSONA_PATERNO AS PATERNO,
			         TPS.TPS_PERSONA_MATERNO AS MATERNO,
			         TUR.TUR_SIGLA AS DEPENDENCIA,
			         '' AS CHECKEDEVALSIP,
			         '' AS CHECKEDEVALCA,
			         '' AS CHECKEDEVALCE,
			         '' AS CHECKEDEVALRI
			        <cfloop index = "i" from="1" to="#arrayLen(arguments.tipoInvest)#">
			            ,''							AS #arguments.tipoInvest[i]# 
		             </cfloop>
			    FROM CVU.CVUTPERSONA TPS,
			         EDI.EDITASPIRANTEPROCESO TEP,
			         UR.TURIPN@DBL_URSIGA TUR
			   WHERE     TEP.TAS_FK_PERSONA= TPS.TPS_PK_PERSONA
			         AND TUR.TUR_PK_UR = TPS.TPS_FK_UR
			         AND TEP.TAS_FK_CESTADO >= <cfqueryparam cfsqltype="cf_sql_numeric" value="#application.SIIIP_CTES.ESTADO.SOLICITUDENVIADASIP#">
			         AND TEP.TAS_FK_PROCESO = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pkProceso#">
			GROUP BY TPS.TPS_PK_PERSONA,
			         TPS_NUMERO_EMPLEADO,
			         TPS.TPS_PERSONA_NOMBRE,
			         TPS.TPS_PERSONA_PATERNO,
			         TPS.TPS_PERSONA_MATERNO,
			         TUR.TUR_SIGLA
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEvaluadoresTiposEvaluadoresTipoEval" hint="Muestra todos los usuarios para asignar a evaluar con un tipo de evaluacion">
		<cfargument name="pkEvaluador"	type="numeric" hint ="pk del usuario">
		<cfargument name="pktipoInvest"	type="array"	hint ="pk de los tipos de investigadores que puede ser un evaluador">
		<cfargument name="pkProceso"	type="numeric"	hint ="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT	TPP.TPP_FK_PERSONA					AS FKPERSONA,
					TEE.TEE_FK_EVALUACIONTIPO			AS EVALTIPO
			 FROM	EDI.EDITEVALUACIONETAPA				TEE,
					EDI.EDITEVALUACIONPRODUCTOEDI		TEP,
					CVU.CVUCTPRODUCTOPERSONA			TPP
			WHERE	TEP.TEP_PK_EVALUACIONPRODUCTOEDI	= TEE.TEE_FK_EVALUACIONPRODUCTOEDI
			 AND	TPP.TPP_PK_TPRODUCTOPERSONA			= TEP.TEP_FK_CVUCCPRODUCTOPERSONA
			 AND	TEP.TEP_FK_PROCESO					= <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pkProceso#">
			 AND	TEE.TEE_FK_EVALUADOR				= <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pkEvaluador#">
			 AND	TEE.TEE_FK_ESTADO					> 0
			 AND	TEP.TEP_FK_ESTADO					= 2
			GROUP BY TPP.TPP_FK_PERSONA,
					TEE.TEE_FK_EVALUACIONTIPO
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getInformacionAutoEvaluacion" hint="Obtiene la informacion de los productos en evaluacion de EDI">
		<cfargument name="pkPersona"	type="numeric" hint ="pk de la persona">
		<cfquery name="respuesta" datasource="DS_EDI">
			  SELECT TPE.TPE_PK_TPRODUCTOEDI        AS PK_TPRODUCTOEDI,
			  			 CPE.CPE_PK_CPRODUCTOEDI        AS PK_CPRODUCTOEDI,
			  			 TPP.TPP_FK_PERSONA             AS PK_PERSONA,
			  			 TPP.TPP_PK_TPRODUCTOPERSONA    AS PK_PRODUCTOPERSONA,
			  			 TPP.TPP_FK_FILA                AS PK_FILA,
			  			 TPE.TPE_FK_REGLAMENTO          AS PK_REGLAMENTO,
			  			 CPR.CPD_CPRODUCTO              AS PRODUCTO,
			  			 CPR.CPD_DESCRIPCION            AS DESCRIPCION,
			  			 TPE.TPE_MAXIMOPRODUCTOS        AS MAX_PRODUCTOS,
			  			 TPE.TPE_PUNTUACION             AS MAX_PUNTUACION,
			  			 TPE.TPE_CLASIFICACION          AS CLASIFICACION,
			  			 TPE.TPE_SUBCLASIFICACION       AS SUBCLASIFICACION
			    FROM EDI.EDITEVALUACIONPRODUCTOEDI  TEE,
			    		 EDI.EDITPRODUCTOEDI            TPE,
			    		 EDI.EDICPRODUCTOEDI            CPE,
			    		 CVU.CVUCCPRODUCTO              CPR,
			    		 CVU.CVUCTPRODUCTOPERSONA       TPP
			   WHERE TPE.TPE_PK_TPRODUCTOEDI        = TEE.TEP_FK_TPRODUCTOEDI
	   			 AND CPE.CPE_PK_CPRODUCTOEDI        = TPE.TPE_FK_CPRODUCTOEDI
	   			 AND CPR.CPD_PK_CPRODUCTO           = CPE.CPE_FK_CVUCPRODUCTO
	   			 AND TPP.TPP_PK_TPRODUCTOPERSONA    = TEE.TEP_FK_CVUCCPRODUCTOPERSONA
	   			 AND TPP.TPP_FK_PERSONA             = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_integer">
			     AND TEE.TEP_FK_ESTADO              > 0
			     AND TPE.TPE_CLASIFICACION          IS NOT NULL
			ORDER BY TPE_FK_REGLAMENTO DESC,TPE_CLASIFICACION ASC, TPE_SUBCLASIFICACION ASC
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Enero 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getClasificacionProductos" hint="Obtiene el primer nivel de clasificacion">		
		<cfargument name="pkClasif"	type="numeric" hint ="pk de la clasificacion">
		<cfquery name="respuesta" datasource="DS_CVU">
			  SELECT  CPP.CCP_CLASIFICACIONPRODUCTO AS CLASIFICACION
			  FROM    CVU.CVUCCLASIFICACIONPRODUCTO CPP
			  WHERE   CPP.CCP_PK_CLASIFICACIONPRODUCTO = <cfqueryparam value="#pkClasif#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>	
	
	<!---
	*Fecha:	Diciembre de 2018
	*Autor:	JLGC
	--->
	<cffunction name="getEvaluacionDatosInvestigador" hint="Trae los Datos del Investigador para la Evaluacin">
		<cfargument name="pkPersona"	type="numeric" hint ="pk de la persona">
		<cfargument name="pkMovimiento"	type="numeric" hint ="pk del movimiento">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT PROCESOASPIRANTE.TAS_PK_ASPIRANTEPROCESO AS PK,
			       PROCESOASPIRANTE.TAS_FK_PERSONA          AS FK_PERSONA,
			       PROCESOASPIRANTE.TAS_FK_MOVIMIENTO       AS FK_MOVIMIENTO,
			       PROCESOASPIRANTE.TAS_FK_PROCESO          AS FK_PROCESO,
			       PERSONAESTADO.TPE_FK_CESTADO             AS FK_ESTADOPERSONA,
			       PERSONA.TPS_PERSONA_NOMBRE               AS NOMBRE,
			       PERSONA.TPS_PERSONA_PATERNO              AS APPAT,
			       PERSONA.TPS_PERSONA_MATERNO              AS APMAT,
			       MOVIMIENTO.TMO_NOMBRE                    AS MOVIMIENTO,
			       ESTADO.CER_NOMBRE                        AS ESTADOPERSONA,
			       PROCESO.TPR_NOMBREPROCESO                AS NOMBREPROCESO,
			       PROCESO.TPR_RI_FECHAINI                  AS FECHAINI,
			       PROCESO.TPR_RI_FECHAFIN                  AS FECHAFIN
			  FROM EDI.EDITASPIRANTEPROCESO PROCESOASPIRANTE,
			       CVU.CVUTPERSONA          PERSONA,
			       EDI.EDITMOVIMIENTO       MOVIMIENTO,
			       EDI.EDITPERSONAESTADO    PERSONAESTADO,
			       GRAL.CESCESTADO          ESTADO,
			       EDI.EDITPROCESO          PROCESO
			 WHERE PROCESOASPIRANTE.TAS_FK_PERSONA    = PERSONA.TPS_PK_PERSONA 
			   AND PROCESOASPIRANTE.TAS_FK_MOVIMIENTO = MOVIMIENTO.TMO_PK_MOVIMIENTO
			   AND PROCESOASPIRANTE.TAS_FK_PERSONA    = PERSONAESTADO.TPE_FK_PERSONA
			   AND PERSONAESTADO.TPE_FK_CESTADO       = ESTADO.CER_PK_ESTADO
			   AND PROCESOASPIRANTE.TAS_FK_PROCESO    = PROCESO.TPR_PK_PROCESO 
			   AND PROCESOASPIRANTE.TAS_FK_PERSONA    = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pkPersona#">
			   AND PROCESOASPIRANTE.TAS_FK_MOVIMIENTO = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.pkMovimiento#">
			   AND PROCESOASPIRANTE.TAS_FK_ESTADO     > 1
			   AND PERSONA.TPS_CESESTADO              > 1
			   AND MOVIMIENTO.TMO_FK_ESTADO           > 1        
			   AND PERSONAESTADO.TPE_FK_ESTADO        > 1     
			   AND ESTADO.CER_FK_ESTADO               > 1     
			   AND PROCESO.TPR_FK_ESTADO              > 1      
		  ORDER BY FECHAFIN DESC FETCH FIRST 1 ROWS ONLY
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Diciembre de 2018
	*Autor:	JLGC
	--->
	<cffunction name="getEvaluacionDatosInvestigadorNivel" hint="Trae el Nivel en la evaluacion del investigador">
		<cfargument name="pkPersona" type="numeric" hint ="pk de la persona">
		<cfquery name="respuesta" datasource="DS_CVU">
		       SELECT TSN.TSN_PK_TSNI AS PKSNI,
		            TO_CHAR (TSN.TSN_FECHAINICIO, 'DD/MM/YYYY') AS INICIO,
		            TO_CHAR (TSN.TSN_FECHATERMINO, 'DD/MM/YYYY') AS TERMINO,
		            CSN.CSN_NOMBRE_SNI AS NIVEL,
		            TSA.TSA_NOMBREAREA AS NOMBREAREA,
		            EDINIVEL.CED_NOMBRE_EDI AS EDI
		       FROM CVU.CVUTSNI TSN,
		            CVU.CVUCSNI CSN,
		            CVU.CVUTSNIAREA TSA,
		            CVU.CVUTPERSONAEDI PERSONAEDI,
		            EDI.EDICEDI EDINIVEL,
		            CVU.CVUTPERSONA TPE
		      WHERE 
		            TPE.TPS_PK_PERSONA = TSN.TSN_FK_PERSONA(+)
		            AND TPE.TPS_PK_PERSONA = PERSONAEDI.TPE_FK_PERSONA(+)
		            AND TSN.TSN_FK_CSNI = CSN.CSN_PK_SNI(+)
		            AND TSN.TSN_FK_SNIAREA =TSA.TSA_PK_SNIAREA(+)
		            AND TSN.TSN_FECHATERMINO(+) IS NOT NULL
		            AND PERSONAEDI.TPE_FK_EDI = EDINIVEL.CED_PK_EDI(+)
		            AND TPE.TPS_PK_PERSONA = <cfqueryparam cfsqltype="cf_sql_numeric" value="#pkPersona#">
		            AND CSN.CSN_FK_ESTADO(+) = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		            AND TSA.TSA_FK_ESTADO(+) = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		            AND (TSN.TSN_FK_ESTADO(+) = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		             OR TSN.TSN_FK_ESTADO(+) = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.EDICION#"  cfsqltype="cf_sql_numeric">)
				   ORDER BY TSN.TSN_FECHATERMINO DESC
				FETCH FIRST 1 ROWS ONLY
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Diciembre de 2018
	*Autor:	JLGC
	--->
	<cffunction name="getEvaluacionDatosInvestigadorRed" hint="Trae la Red en la evaluacion del investigador">
		<cfargument name="pkPersona" type="numeric" hint ="pk de la persona">
		<cfquery name="respuesta" datasource="DS_CVU">
            SELECT LISTAGG(CRE_DESCRIPCION, ', ') WITHIN GROUP (ORDER BY CRE_DESCRIPCION) "REDLISTA"
			  FROM (
			        SELECT UNIQUE
			               CRE.CRE_DESCRIPCION
			          FROM CVU.CVUTREDESINV	TRE,
			               CVU.CVUCREDESINV	CRE
			         WHERE TRE.TRE_FK_CREDESINV = CRE.CRE_PK_REDESINV
			           AND TRE.TRE_FK_PERSONA	= <cfqueryparam cfsqltype="cf_sql_numeric" value="#pkPersona#">
                       AND CRE.CRE_FK_ESTADO	= <cfqueryparam cfsqltype="cf_sql_numeric" value="#application.SIIIP_CTES.ESTADO.VALIDADO#">
                       AND TRE.TRE_FK_ESTADO	= <cfqueryparam cfsqltype="cf_sql_numeric" value="#application.SIIIP_CTES.ESTADO.VALIDADO#">
			       )
        </cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	24 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getPersonaSiga" hint="obtiene el pk de la persona siga">
		<cfargument name="pkPersona" type="numeric"	hint="Pk de la persona">
		<cfquery name="respuesta" datasource="DS_CVU">						
			SELECT PER.TPS_FK_PERSONA_SIGA AS PK_PERSONASIGA
			 FROM  CVU.CVUTPERSONA PER
			WHERE  PER.TPS_PK_PERSONA = #pkPersona#
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Enero 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAllProductosEvaluados" hint="Elimina al evaluador que va a evaluar los productos de un investigador">
		<cfargument name="pkPersona"	type="numeric" hint ="pk de la persona">
		<cfargument name="pkEvaluador"	type="numeric" hint ="pk del evaluador">
		<cfargument name="pkTipoEval"	type="numeric" hint ="pk del tipo de evaluacion">
		<cfargument name="pkProceso"	type="numeric" hint ="pk del proceso">	
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.GETALLPRODUCTOSEVALUADOS" datasource="DS_EDI">
			<cfprocparam value="#pkPersona#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkEvaluador#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkTipoEval#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam value="#pkProceso#"	cfsqltype="CF_SQL_NUMERIC"	type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!---
	*Fecha:	Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="setRolEvaluador" hint="Asigna rol de evaluador">
		<cfargument name="pkEvaluador"	  type="numeric" hint="pk del evaluador">
		<cfargument name="pkRolEvaluador" type="numeric" hint="pk del rol para evaluadores">
		<cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.SET_ROL_EVALUADOR" datasource="DS_GRAL">
			<cfprocparam value="#pkEvaluador#"	  cfsqltype="CF_SQL_NUMERIC" type="in">
			<cfprocparam value="#pkRolEvaluador#" cfsqltype="CF_SQL_NUMERIC" type="in">
			<cfprocparam variable="resultado"	cfsqltype="CF_SQL_NUMERIC"	type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="usuarioIsEvaluador" hint="Verifica si el usuario es evaluador de algun tipo">
		<cfargument name="pkUsuario" type="numeric"	hint="Pk del usuario">
		<cfquery name="respuesta" datasource="DS_EDI">						
			SELECT COUNT(EVA.TEP_PK_EVALUADORPROCESO) AS EVALUADOR
			 FROM  EDI.EDITEVALUADORPROCESO EVA
			WHERE  EVA.TEP_FK_USUARIO = #pkUsuario#
			  AND  EVA.TEP_FK_ESTADO  = 2
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getCorreoUsuario" hint="Obtiene el correo de un evaluador">
		<cfargument name="pkUsuario" type="numeric"	hint="Pk del usuario">
		<cfquery name="respuesta" datasource="DS_GRAL">
			SELECT	TUS_USUARIO_EMAIL	AS CORREO
			 FROM	GRAL.USRTUSUARIO
			WHERE	TUS_PK_USUARIO		= <cfqueryparam cfsqltype="cf_sql_numeric" value="#pkUsuario#">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	30 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="guardaPuntajeProducto" hint="Guarda el puntaje de la evaluacion de un producto">
		<cfargument name="pkEtapa" type="numeric" hint="pk de la etapa">
		<cfargument name="puntaje" type="numeric" hint="puntaje obtenido">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.GUARDA_PUNTAJE_EVALUACION" datasource="DS_EDI">
			<cfprocparam value="#pkEtapa#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#puntaje#" cfsqltype="cf_sql_decimal" scale="2" type="in">
			<cfprocparam variable="resultado" cfsqltype="cf_sql_string" type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	30 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="guardaPuntajeProductoCero" hint="Guarda el puntaje de la evaluacion de un producto">
		<cfargument name="pkEtapa" type="numeric" hint="pk de la etapa">
		<cfargument name="puntaje" type="numeric" hint="puntaje obtenido">
		<cfargument name="motivo"  type="numeric" hint="puntaje obtenido">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.GUARDA_PUNTAJE_EVALUACION_CERO" datasource="DS_EDI">
			<cfprocparam value="#pkEtapa#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#puntaje#" cfsqltype="cf_sql_decimal" scale="2" type="in">
			<cfprocparam value="#motivo#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam variable="resultado" cfsqltype="cf_sql_string" type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>


	<!--- 
	*Fecha:	31 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="guardaComentarioEvaluacion" hint="Guarda el comentario en una evaluacion">
		<cfargument name="pkEvaluacion" type="numeric" hint="Pk de la evaluacion etapa">
		<cfargument name="contenido" 	type="string"  hint="Contenido del comentario">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.GUARDA_COMENTARIO_EVALUACION" datasource="DS_EDI">
			<cfprocparam value="#pkEvaluacion#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#contenido#" 	cfsqltype="cf_sql_string" type="in">
			<cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	31 de Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="reclasificacionProducto" hint="Cambia la clasificacion de un producto">
		<cfargument name="pkProdRecla" type="numeric" hint="Pk de la clasificacion">
		<cfargument name="pkEvalEtapa" type="numeric" hint="Pk de la etapa evaluacion">	
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.RECLASIFICA_PRODUCTO" datasource="DS_EDI">
			<cfprocparam value="#pkProdRecla#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#pkEvalEtapa#" cfsqltype="cf_sql_string" type="in">
			<cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getValidacionesByAspitanteProceso">
		<cfargument name="pkEvaluado" type="numeric">
		<cfargument name="pkProceso" type="numeric">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT TAP.TAS_PK_ASPIRANTEPROCESO 	AS PK_ASPROC,
			       TAP.TAS_FK_CESTADO 			AS CESESTADO,
			       TAP.TAS_FK_CRUTA 			AS CESRUTA
			  FROM EDI.EDITASPIRANTEPROCESO TAP,
			        CVU.CVUTPERSONA 		PERS
			 WHERE TAP.TAS_FK_ESTADO   = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			   AND TAP.TAS_FK_PERSONA  = PERS.TPS_PK_PERSONA
			   AND TAP.TAS_FK_CESTADO  >= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.SOLICITUDENVIADASIP#" cfsqltype="cf_sql_numeric">
			   AND PERS.TPS_FK_USUARIO = <cfqueryparam value="#pkEvaluado#" cfsqltype="cf_sql_numeric">
			   AND TAP.TAS_FK_PROCESO  = <cfqueryparam value="#pkProceso#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>


	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getValidacionesByEvaluacionEscolaridad">
		<cfargument name="pkEvaluado" type="numeric">
		<cfargument name="pkProceso" type="numeric">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TOG.TOG_PK_OBTENCIONGRADO AS PK_TOG,
			        TOG.TOG_FK_CESTADO AS CESESTADO,
			        TOG.TOG_FK_RUTA AS CESRUTA
			FROM    EDI.EDITOBTENCIONGRADOESCOLAR TOG,
			        CVU.CVUTESCOLARIDAD TES,
			        CVU.CVUTPERSONA TPS        
			WHERE   TES.TES_PK_TESCOLARIDAD = TOG.TOG_FK_TESCOLARIDAD
			AND     TPS.TPS_PK_PERSONA = TES.TES_FK_PERSONA
			AND     TOG.TOG_FK_ESTADO = 2
			AND     TOG.TOG_FK_CESTADO >= 309
			AND     TPS.TPS_PK_PERSONA = <cfqueryparam value="#pkEvaluado#" cfsqltype="cf_sql_numeric">
			AND     TOG.TOG_FK_PROCESO = <cfqueryparam value="#pkProceso#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>
	
	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="verificaProductosEvaluados">
		<cfargument name="pkEvaluador" 		type="numeric" hint="pk del">
		<cfargument name="pkEvaluado" 		type="numeric" hint="pk del">
		<cfargument name="pkTipoEvaluacion" type="numeric" hint="pk del">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT 	TEE.TEE_PUNTAJE_OBTENIDO,
					TEE.TEE_FK_EVALUACIONTIPO,
					TEP.TEP_FK_CESTADO,
					TEP.TEP_FK_TPRODUCTOEDI
			  FROM 	EDI.EDITEVALUACIONETAPA TEE,
				 	EDI.EDITEVALUACIONPRODUCTOEDI TEP,
				 	EDI.EDITPRODUCTOEDI TPE,
				 	EDI.EDICPRODUCTOEDI CPE,
				 	CVU.CVUCTPRODUCTOPERSONA CPP,
				 	CVU.CVUTPERSONA PERS
			 WHERE 	PERS.TPS_FK_USUARIO = <cfqueryparam value="#pkEvaluado#" cfsqltype="cf_sql_numeric">
		       AND 	TEE.TEE_FK_EVALUADOR = <cfqueryparam value="#pkEvaluador#" cfsqltype="cf_sql_numeric">
			   AND 	PERS.TPS_PK_PERSONA = CPP.TPP_FK_PERSONA
			   AND 	CPP.TPP_PK_TPRODUCTOPERSONA = TEP.TEP_FK_CVUCCPRODUCTOPERSONA
			   AND 	TEP.TEP_PK_EVALUACIONPRODUCTOEDI = TEE.TEE_FK_EVALUACIONPRODUCTOEDI
		       AND  TPE.TPE_PK_TPRODUCTOEDI = TEP.TEP_FK_TPRODUCTOEDI
		       AND  CPE.CPE_PK_CPRODUCTOEDI = TPE.TPE_FK_CPRODUCTOEDI
			   AND 	TEE.TEE_FK_EVALUACIONTIPO = <cfqueryparam value="#pkTipoEvaluacion#" cfsqltype="cf_sql_numeric">
			   AND 	TEE.TEE_PUNTAJE_OBTENIDO IS NOT NULL
			   
		        AND TEP.TEP_FK_ESTADO = 2
			   AND  TEE.TEE_FK_ESTADO = 2
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="verificaProductosParaEvaluar">
		<cfargument name="pkEvaluador" 		type="numeric" hint="pk del">
		<cfargument name="pkEvaluado" 		type="numeric" hint="pk del">
		<cfargument name="pkTipoEvaluacion" type="numeric" hint="pk del">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT 	TEE.TEE_PUNTAJE_OBTENIDO,
					TEE.TEE_FK_EVALUACIONTIPO,
					TEP.TEP_FK_CESTADO,
					TEP.TEP_FK_TPRODUCTOEDI
			  FROM 	EDI.EDITEVALUACIONETAPA 	  TEE,
				 	EDI.EDITEVALUACIONPRODUCTOEDI TEP,
				 	EDI.EDITPRODUCTOEDI 		  TPE,
				 	EDI.EDICPRODUCTOEDI 		  CPE,
				 	CVU.CVUCTPRODUCTOPERSONA 	  CPP,
				 	CVU.CVUTPERSONA 			  PERS
			  WHERE TEE.TEE_FK_EVALUADOR = <cfqueryparam value="#pkEvaluador#" cfsqltype="cf_sql_numeric">
		        AND TEE.TEE_FK_EVALUACIONPRODUCTOEDI = TEP.TEP_PK_EVALUACIONPRODUCTOEDI
		        AND TEP.TEP_FK_CVUCCPRODUCTOPERSONA = CPP.TPP_PK_TPRODUCTOPERSONA
		        AND TPE.TPE_PK_TPRODUCTOEDI = TEP.TEP_FK_TPRODUCTOEDI
		        AND CPE.CPE_PK_CPRODUCTOEDI = TPE.TPE_FK_CPRODUCTOEDI
		        AND CPP.TPP_FK_PERSONA = PERS.TPS_PK_PERSONA
		        AND PERS.TPS_FK_USUARIO = <cfqueryparam value="#pkEvaluado#" cfsqltype="cf_sql_numeric">
		        AND TEE.TEE_FK_EVALUACIONTIPO = <cfqueryparam value="#pkTipoEvaluacion#" cfsqltype="cf_sql_numeric">
		        AND TEE.TEE_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		        AND TEP.TEP_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		        
		        AND CPE.CPE_FK_CVUCPRODUCTO <> 126 /*SE QUITAN LOS PROYECTOS*/
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Febrero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="quitarReclasificacion" hint="Elimina la relcasificacion de un producto">
		<cfargument name="pkEtapa" type="numeric" hint="Pk de la evaluacion etapa">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.DES_RECLASIFICA_PRODUCTO" datasource="DS_EDI">
			<cfprocparam value="#pkEtapa#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Febrero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getMotivoCalificacion" hint="Obtiene los motivos de calificar con '0' un producto">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT 	TNC.TNC_PK_MOTIVO AS PK_MOTIVO,
					TNC.TNC_MOTIVO 	  AS DESC_MOTIVO
			  FROM 	EDI.EDICPRODUCTONOCALIFICADO TNC
			  WHERE TNC.TNC_FK_ESTADO = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>
	
	<!--- 
	*Fecha:	Febrero de 2018
	*Autor:	JLGC
	--->
	<cffunction name="getNivelEDI" hint="Obtiene la llista de los niveles por EDI">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT NIVEL.CED_PK_EDI     AS PK,
        		   NIVEL.CED_NOMBRE_EDI AS NOMBRE
			  FROM EDI.EDICEDI NIVEL
			 WHERE NIVEL.CED_FK_ESTADO = 2
		</cfquery>
		<cfreturn respuesta>
	</cffunction>	

	<!--- 
    *Fecha:	Febrero de 2018
	*Autor:	JLGC
    --->
    <cffunction name="guardarObservacion" access="public" returntype="numeric" hint="Realiza guardado de la observacion de la evaluacion del investigador">
        <cfargument name="PkAspProc"     type="numeric" required="yes" hint="PK del Aspirante">
        <cfargument name="PkEvaluador"   type="numeric" required="yes" hint="PK del Evaluador">
        <cfargument name="PkTipoEva"     type="numeric" required="yes" hint="PK del Tipo evaluacion">
        <cfargument name="observaciones" type="string"  required="yes" hint="Observaciones">
        <cfstoredproc procedure="EDI.P_EVALUACIONEDI.ADD_OBS_EVAL_ASP" datasource="DS_EDI">
            <cfprocparam value="#PkAspProc#"     cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#PkEvaluador#"   cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#PkTipoEva#"     cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#observaciones#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam variable="resultado"    cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!---
	*Fecha:	Febrero de 2018
	*Autor:	JLGC
	--->
	<cffunction name="getObservacion" hint="Muestra observacion de la evaluacion del investigador">
        <cfargument name="PkAspProc"     type="numeric" required="yes" hint="PK del Aspirante">
        <cfargument name="PkEvaluador"   type="numeric" required="yes" hint="PK del Evaluador">
        <cfargument name="PkTipoEva"     type="numeric" required="yes" hint="PK del Tipo evaluacion">
        <cfquery name="respuesta" datasource="DS_EDI">
			SELECT TEA.TEA_OBSERVACION AS OBSERVACION
        	  FROM EDI.EDITEVALUACIONASPIRANTE TEA
        	 WHERE TEA.TEA_FK_ASPIRANTEPROC  = <cfqueryparam value="#PkAspProc#"   cfsqltype="cf_sql_numeric">
        	   AND TEA.TEA_FK_EVALUADOR      = <cfqueryparam value="#PkEvaluador#" cfsqltype="cf_sql_numeric">
        	   AND TEA.TEA_FK_TIPOEVALUACION = <cfqueryparam value="#PkTipoEva#"   cfsqltype="cf_sql_numeric">
        	   AND TEA.TEA_FK_ESTADO         = 2
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Febrero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="asignarNivelEvaluador" hint="Asigna el nivel a un investigador">
		<cfargument name="PkAspProc"    type="numeric" hint="Pk del aspirante proceso">
		<cfargument name="pkEvaluador"  type="numeric" hint="Pk del evaluador">
		<cfargument name="pkTipoEval"   type="numeric" hint="tipo de evaluacion">
		<cfargument name="pkNivel"		type="numeric" hint="nivel edi asignado">
		<cfargument name="observacion"  type="string"  hint="observacion de la evaluacion">
		<cfargument name="residencia"   type="numeric" hint="Asignacion de año de residencia">
		<cfargument name="anioGracia"   type="numeric" hint="Asignacion de año de gracia">
		<cfargument name="dispensa"     type="numeric" required="yes" hint="Asignacion de dispensa">
		<cfargument name="artDispensa"  type="string"  required="yes" hint="articulo de dispensa">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.ASIGNA_NIVEL_EVALUADOR" datasource="DS_EDI">
			<cfprocparam value="#PkAspProc#"   cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#pkEvaluador#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#pkTipoEval#"  cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#pkNivel#" 	   cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#observacion#" cfsqltype="cf_sql_string"  type="in">
			<cfprocparam value="#residencia#"  cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#anioGracia#"  cfsqltype="cf_sql_numeric" type="in"> 
			<cfprocparam value="#dispensa#"    cfsqltype="cf_sql_numeric" type="in"> 
			<cfprocparam value="#artDispensa#" cfsqltype="cf_sql_string"  type="in">  
			<cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!---
	*Fecha:	Febrero de 2018
	*Autor:	JLGC
	--->
	<cffunction name="getSolicitudResidenciaInv" hint="Muestra la solicitud de residencia del investigador">
        <cfargument name="PkAspProc" type="numeric" required="yes" hint="PK del Aspirante">
        <cfquery name="respuesta" datasource="DS_EDI">
			SELECT ASP.TAS_MENSAJESOLICITUD AS SOLICITUD
        	  FROM EDI.EDITASPIRANTEPROCESO ASP
        	 WHERE ASP.TAS_PK_ASPIRANTEPROCESO = <cfqueryparam value="#PkAspProc#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Febrero de 2018
	*Autor:	Ana Belem Juárez Méndez
	--->
	<cffunction name="obtenerEvaluadorCAdeSolicitud" hint="obtiene el pkUsuario y el email del evaluador CA de una solicitud">
        <cfargument name="pkRegistro"  type="numeric" required="yes" hint="PK de un registro en EVALUACIONASPIRANTEPROCESO">
        <cfquery name="respuesta" datasource="DS_EDI">
			SELECT TUS.TUS_PK_USUARIO 	 AS USUARIO,
       			   TUS.TUS_USUARIO_EMAIL AS EMAIL
			  FROM GRAL.USRTUSUARIO 			 TUS,
			       EDI.EDITEVALUACIONETAPA 		 TEE,
			       EDI.EDITEVALUACIONPRODUCTOEDI TEP,
			       CVU.CVUCTPRODUCTOPERSONA 	 CPP,
			       EDI.EDITASPIRANTEPROCESO 	 TAP
			 WHERE TEE.TEE_FK_EVALUADOR      		= TUS.TUS_PK_USUARIO
			   AND TEE.TEE_FK_EVALUACIONTIPO 		= <cfqueryparam cfsqltype="cf_sql_numeric" value="#application.SIIIP_CTES.TIPOEVALUACION.CA#">     
			   AND TEP.TEP_PK_EVALUACIONPRODUCTOEDI = TEE.TEE_FK_EVALUACIONPRODUCTOEDI   
			   AND TEP.TEP_FK_CVUCCPRODUCTOPERSONA 	= CPP.TPP_PK_TPRODUCTOPERSONA
			   AND CPP.TPP_FK_PERSONA 				= TAP.TAS_FK_PERSONA
			   AND TEP.TEP_FK_PROCESO 				= TAP.TAS_FK_PROCESO
			   AND TAP.TAS_PK_ASPIRANTEPROCESO 		= <cfqueryparam value="#pkRegistro#" cfsqltype="cf_sql_numeric">
		     GROUP BY TUS_PK_USUARIO,TUS_USUARIO_EMAIL   
		     ORDER BY TUS_USUARIO_EMAIL   
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	*Fecha:	Febrero 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="getEscolaridadByPkUsuarioANDPkEvaluadorANDPkProceso" hint="obtiene las evaluaciones disponibles con el pk del usuario, el pk del evaluador y el pk del proceso">
		<cfargument name="pkPersona" hint="pk de la persona">
		<cfargument name="pkEvaluador" hint="pk del evaluador">
		<cfargument name="proceso" hint="baen del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  *
			FROM    EDI.EDITEVALUACIONESCOLARIDAD TEE,
			        EDI.EDITOBTENCIONGRADOESCOLAR TOG,
			        CVU.CVUTESCOLARIDAD TES,
			        CVU.CVUCESCOLARIDAD CES,
			        EDI.EDICEVALUACIONTIPO CET        
			WHERE   TES.TES_PK_TESCOLARIDAD = TOG.TOG_FK_TESCOLARIDAD
			AND     TOG.TOG_PK_OBTENCIONGRADO = TEE.TES_FK_OBTENCIONGRADO(+)
			AND     CET.CET_PK_EVALUACIONTIPO(+) = TEE.TES_FK_EVALUACIONTIPO
			AND     CES.CES_PK_ESCOLARIDAD = TES.TES_FK_CESCOLARIDAD
			<!--- AND     TOG.TOG_FK_PROCESO   = <cfqueryparam value="#pkProceso#"   cfsqltype ="cf_sql_numeric"> --->
			AND     TEE.TES_FK_EVALUADOR(+) = <cfqueryparam value="#pkEvaluador#" cfsqltype ="cf_sql_numeric">
			AND     TES.TES_FK_PERSONA   = <cfqueryparam value="#pkPersona#"   cfsqltype ="cf_sql_numeric">
			AND     TES.TES_FK_ESTADO > 0
			AND     TOG.TOG_FK_ESTADO > 0
			AND     TEE.TES_FK_ESTADO(+) > 1
			-- Filtrar por anio del proceso
			AND     EXTRACT(YEAR FROM TES.TES_FECHAOBTENCION) >= <cfqueryparam value="#proceso.getFECHAINIPROC()#" cfsqltype="cf_sql_numeric">
			AND     EXTRACT(YEAR FROM TES.TES_FECHAOBTENCION) <= <cfqueryparam value="#proceso.getFECHAFINPROC()#" cfsqltype="cf_sql_numeric">
			ORDER BY CES_CLASIFICACION, CES_SUBCLASIFICACION, TES_FK_EVALUACIONTIPO
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Febrero de 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="guardaPuntajeEvaluacionEsc" hint="Guarda el puntaje de la evaluacion de escolaridad">
		<cfargument name="pkEvaluacion"  type="numeric" hint="Pk de la evaluacion etapa">
		<cfargument name="puntaje" 				type="numeric" hint="puntaje obtenido">		
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.GUARDA_PUNTAJE_EVALUACION_ESC" datasource="DS_EDI">			
			<cfprocparam value="#pkEvaluacion#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#puntaje#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam variable="resultado"  cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Febrero de 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="guardaPuntajeEvaluacionEscCero" hint="Guarda el motivo de la evaluacion en cero">
		<cfargument name="pkEvaluacion"  type="numeric" hint="Pk de la evaluacion etapa">
		<cfargument name="puntaje" 				type="numeric" hint="puntaje obtenido">
		<cfargument name="motivo" 				type="numeric" hint="motivo">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.GUARDA_PUNTAJE_EVAL_ESC_CERO" datasource="DS_EDI">
			<cfprocparam value="#pkEvaluacion#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#puntaje#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#motivo#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam variable="resultado"  cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>
	
	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="solicitoAnioGracia" hint="Devuelve si el usuario solicito año de gracia">
        <cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
        <cfargument name="pkProceso" type="numeric" required="yes" hint="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT TSO.TSO_PK_SOLICITUD AS SOLICITUD
			  FROM EDI.EDITSOLICITUD TSO
			 WHERE TSO.TSO_FK_PERSONA = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			   AND TSO.TSO_FK_SOLICITUDTIPO = <cfqueryparam value="#application.SIIIP_CTES.TIPOSOLICITUD.ANIO_GRACIA#" cfsqltype="cf_sql_numeric">
			   AND TSO.TSO_FK_ESTADO  > <cfqueryparam value="#application.SIIIP_CTES.ESTADO.CANCELADO#" cfsqltype="cf_sql_numeric">
			   AND TSO.TSO_FK_PROCESO = <cfqueryparam value="#pkProceso#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Febrero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="terminarEvaluacion" hint="Se asigna el año de gracia y/o residencia el evaluador CA">
        <cfargument name="pkRegistro"  type="numeric" required="yes" hint="pk del registro">
        <cfargument name="residencia"  type="numeric" required="yes" hint="asigna residencia">
        <cfargument name="anioGracia"  type="numeric" required="yes" hint="asigna anio de gracia">
        <cfargument name="dispensa"    type="numeric" required="yes" hint="asigna dispensa">
        <cfargument name="artDispensa" type="string"  required="yes" hint="articulo de dispensa">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.TERMINA_EVALUACION" datasource="DS_EDI">
			<cfprocparam value="#pkRegistro#"  cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#residencia#"  cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#anioGracia#"  cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#dispensa#"    cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#artDispensa#" cfsqltype="cf_sql_string"  type="in">
			<cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="tieneInconformidad" hint="Verifica si el investigador tiene inconformidad en productos">
		<cfargument name="pkTipoEval" type="numeric" hint="tipo de la evaluacion">
		<cfargument name="pkPersona"  type="numeric" hint="pk de la persona (investigador)">
		<cfargument name="proceso"	  type="numeric" hint="pk del proceso actual">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT	COUNT(TEE.TEE_PK_EVALUACIONETAPA) AS PRODUCTOS
			 FROM	EDI.EDITEVALUACIONETAPA 		TEE,
					EDI.EDITEVALUACIONPRODUCTOEDI 	TEP,
					CVU.CVUCTPRODUCTOPERSONA 		TPP
			WHERE	TEE.TEE_FK_EVALUACIONPRODUCTOEDI = TEP.TEP_PK_EVALUACIONPRODUCTOEDI
			  AND  	TEE.TEE_FK_EVALUACIONTIPO 		 = <cfqueryparam value="#pkTipoEval#" cfsqltype="cf_sql_numeric">
			  AND 	TEP.TEP_FK_PROCESO 				 = <cfqueryparam value="#proceso#" 	  cfsqltype="cf_sql_numeric">
			  AND 	TEP.TEP_FK_CVUCCPRODUCTOPERSONA  = TPP.TPP_PK_TPRODUCTOPERSONA
			  AND 	TPP.TPP_FK_PERSONA 	= <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			  AND 	TEE.TEE_FK_ESTADO 	= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			  AND 	TEP.TEP_FK_ESTADO 	= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>
	
	<!--- 
	*Fecha:	Marzo 2018
	*Autor:	Marco Torres
	--->
	<cffunction name="enviarToEvaluacion" hint="envia un producto evaluado a la evaluacion actual">
		<cfargument name="pkFila" type="numeric" hint="">	
		<cfargument name="pkProceso" type="numeric" hint="proceso al que se envia">
			<cfstoredproc procedure="EDI.P_EVALUACIONEDI.enviarToEvaluacion" datasource="DS_EDI">
			<cfprocparam value="#pkFila#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam value="#pkProceso#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam variable="resultado" cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn resultado>
	</cffunction>
	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getNivelesSIPCE" hint="Obtiene los niveles asignados por el evaluador SIP y CE">
		<cfargument name="pkPersona" 	type="numeric" hint="pk de la persona">
		<cfargument name="pkProceso" 	type="numeric" hint="pk del proceso actual">
		<cfargument name="pkEvaluador" 	type="numeric" hint="pk del evaluador">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT	CED.CED_NOMBRE_EDI 	AS NIVEL,
					TEA.TEA_OBSERVACION AS OBSERVACION,
					CET.CET_NOMBRE 		AS TIPO
			 FROM	EDI.EDITEVALUACIONASPIRANTE TEA,
			 		EDI.EDITASPIRANTEPROCESO	TAP,
			 		EDI.EDICEVALUACIONTIPO      CET,
			 		EDI.EDICEDI                 CED	
			WHERE	TEA.TEA_FK_ASPIRANTEPROC  = TAP.TAS_PK_ASPIRANTEPROCESO
			  AND   TAP.TAS_FK_PROCESO 		  = <cfqueryparam value="#pkProceso#" cfsqltype="cf_sql_numeric">
			  AND   TAP.TAS_FK_PERSONA 		  = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			  AND 	TEA.TEA_FK_TIPOEVALUACION IN (1, 2)
			  AND   TEA.TEA_FK_ESTADO 		  = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			  AND   TEA.TEA_FK_TIPOEVALUACION = CET.CET_PK_EVALUACIONTIPO
			  AND   CED.CED_PK_EDI = TEA.TEA_FK_NIVEL
		</cfquery> 
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getNivelesSIPCECA" hint="Obtiene los niveles asignados por el evaluador SIP, CE y CA">
		<cfargument name="pkPersona" 	type="numeric" hint="pk de la persona">
		<cfargument name="pkProceso" 	type="numeric" hint="pk del proceso actual">
		<cfargument name="pkEvaluador" 	type="numeric" hint="pk del evaluador">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT	CED.CED_NOMBRE_EDI 	AS NIVEL,
					TEA.TEA_OBSERVACION AS OBSERVACION,
					CET.CET_NOMBRE 		AS TIPO
			 FROM	EDI.EDITEVALUACIONASPIRANTE TEA,
			 		EDI.EDITASPIRANTEPROCESO	TAP,
			 		EDI.EDICEVALUACIONTIPO      CET,
			 		EDI.EDICEDI                 CED	
			WHERE	TEA.TEA_FK_ASPIRANTEPROC  = TAP.TAS_PK_ASPIRANTEPROCESO
			  AND   TAP.TAS_FK_PROCESO 		  = <cfqueryparam value="#pkProceso#" cfsqltype="cf_sql_numeric">
			  AND   TAP.TAS_FK_PERSONA 		  = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			  AND 	TEA.TEA_FK_TIPOEVALUACION IN (1, 2, 3)
			  AND   TEA.TEA_FK_ESTADO 		  = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			  AND   TEA.TEA_FK_TIPOEVALUACION = CET.CET_PK_EVALUACIONTIPO
			  AND   CED.CED_PK_EDI = TEA.TEA_FK_NIVEL
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="getNivelEdiActual" hint="Obtiene el nivel actual de una persona">
		<cfargument name="pkPersona" type="numeric" hint="pk de la persona">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT 	TPE.TPE_FK_EDI AS NIVEL
			  FROM 	CVU.CVUTPERSONAEDI TPE
			  WHERE TPE.TPE_FK_PERSONA = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Enero de 2018
	*Autor:	Alejandro Tovar
	--->
	<cffunction name="solicitoDispensa" hint="Devuelve si el usuario solicito dispensa">
        <cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
        <cfargument name="pkProceso" type="numeric" required="yes" hint="pk del proceso">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT TSO.TSO_PK_SOLICITUD AS SOLICITUD
			  FROM EDI.EDITSOLICITUD TSO
			 WHERE TSO.TSO_FK_PERSONA = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			   AND TSO.TSO_FK_SOLICITUDTIPO = <cfqueryparam value="#application.SIIIP_CTES.TIPOSOLICITUD.DISPENSA#" cfsqltype="cf_sql_numeric">
			   AND TSO.TSO_FK_ESTADO  > <cfqueryparam value="#application.SIIIP_CTES.ESTADO.CANCELADO#" cfsqltype="cf_sql_numeric">
			   AND TSO.TSO_FK_PROCESO = <cfqueryparam value="#pkProceso#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
		*Fecha:	Febrero 2018
		*Autor:	Daniel Memije
	--->
	<cffunction name="getAllEscolaridadByPkPersona" hint="obtiene la tabla de escolaridad validada con el pk de la persona">
		<cfargument name="pkPersona" hint="pk de la persona">		
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT  TES.TES_PK_TESCOLARIDAD AS PK_ESCOLARIDAD,
			        TES.TES_FECHAINICIO AS FECHA_INICIO,
			        TES.TES_FECHATERMINO AS FECHA_TERMINO,
			        TES.TES_FECHAOBTENCION AS FECHA_OBTENCION,
			        TES.TES_ESCUELA AS ESCUELA,
			        TES.TES_CEDULAPROFECIONAL AS CEDULA_PROFESIONAL,
			        TES.TES_PNCP AS PNPC,
			        TES.TES_CAMPO_CONOCIMIENTO AS CAMPO_CONOCIMIENTO,
			        CES.CES_ESCOLARIDAD AS GRADO
			FROM    CVU.CVUTESCOLARIDAD TES,
			        CVU.CVUCESCOLARIDAD CES
			WHERE   CES.CES_PK_ESCOLARIDAD = TES.TES_FK_CESCOLARIDAD
			AND     TES.TES_FK_ESTADO > 1
			AND     TES.TES_FK_PERSONA = <cfqueryparam value="#pkPersona#" cfsqltype="cf_sql_numeric">
			ORDER BY TES.TES_FK_CESCOLARIDAD DESC, TES.TES_FECHAOBTENCION DESC			
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
		*Fecha:	Marzo 2018
		*Autor:	Daniel Memije
	--->
	<cffunction name="getObtencionGradoEscolarByPkPersona" hint="obtiene las obtenciones de grado escolar de una persona">
		<cfargument name="pkUsuario" hint="pk del usuario">				
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TES_PK_TESCOLARIDAD AS PK_ESCOLARIDAD,
			        TOG_PK_OBTENCIONGRADO AS PK_OBTENCIONGRADO,
			        TPS_PK_PERSONA AS PK_PERSONA,
			        TPS_FK_USUARIO AS PK_USUARIO,
			        TOG_FK_PROCESO AS PROCESO,
			        TOG_FK_CESTADO AS EDO_EVALUACION,
			        TES_FECHAINICIO AS FECHA_INICIO,
			        TES_FECHATERMINO AS FECHA_TERMINO,
			        TES_FECHAOBTENCION AS FECHA_OBTENCION,
			        TES_ESCUELA AS ESCUELA,
			        TES_CAMPO_CONOCIMIENTO AS CAMPO_CONOCIMIENTO,
			        TES_CEDULAPROFECIONAL AS CEDULA_PROFESIONAL,
			        TES_PNCP AS PNPC,
			        CES_ESCOLARIDAD AS GRADO,
			        CES_CLASIFICACION AS CLASIFICACION,
			        CES_SUBCLASIFICACION AS SUBCLASIFICACION,
			        CES_CLASIFICACION_ROMANO AS CLASIFICACION_ROMANO,
			        CES_SUBCLASIFICACION_ROMANO AS SUBCLASIFICACION_ROMANO
			FROM    EDI.EDITOBTENCIONGRADOESCOLAR TOG,
			        CVU.CVUTESCOLARIDAD TES,
			        CVU.CVUCESCOLARIDAD CES,
			        CVU.CVUTPERSONA TPS
			WHERE   TES.TES_PK_TESCOLARIDAD = TOG.TOG_FK_TESCOLARIDAD
			AND     CES.CES_PK_ESCOLARIDAD = TES.TES_FK_CESCOLARIDAD
			AND     TES.TES_FK_PERSONA = TPS.TPS_PK_PERSONA
			AND     TOG.TOG_FK_ESTADO = 2
			AND     TES.TES_FK_ESTADO = 2
			AND     TPS.TPS_FK_USUARIO = <cfqueryparam value="#pkUsuario#" cfsqltype="cf_sql_numeric">
			ORDER BY CES_PK_ESCOLARIDAD		
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
		*Fecha:	Marzo 2018
		*Autor:	Daniel Memije
	--->
	<cffunction name="getEtapasEvaluacionEscolaridadByObtencionGrado" hint="obtiene las etapas de evaluacion con el pk de la obtencion de un grado academico">
		<cfargument name="pkObtencion" hint="pk de la obtencion de grado academico">				
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TES_FK_OBTENCIONGRADO AS PK_EVALUACION,
			        TES_PK_EVALUACIONESCOLARIDAD AS PK_EVALUACIONETAPA,
			        TES_FECHACAPTURA AS FECHA_CAPTURA,
			        TES_PUNTAJEOBTENIDO AS PUNTAJE_OBTENIDO,       
			        TES_FK_EVALUADOR AS FK_EVALUADOR,
			        TES_FK_EVALUACIONTIPO AS FK_TIPO_EVALUACION,
			        CET_NOMBRE AS NOMBRE_TIPO_EVALUACION,
			        TES_FK_ESTADO AS ESTADO_EVALUACION,
			        CET_ACC_CVE AS ACCIONESCVE,
			        TES_COMENTARIO_EVAL AS COMENT_EVAL,
			        TNC_PK_MOTIVO AS MOTIVO
			FROM    EDI.EDITEVALUACIONESCOLARIDAD TES,
			        EDI.EDICEVALUACIONTIPO CET,
			        EDI.EDICPRODUCTONOCALIFICADO CPN
			WHERE   CET.CET_PK_EVALUACIONTIPO = TES.TES_FK_EVALUACIONTIPO
			AND     CPN.TNC_PK_MOTIVO(+) = TES.TES_FK_SINCALIFICAR
			AND     TES.TES_FK_OBTENCIONGRADO = <cfqueryparam value="#pkObtencion#" cfsqltype="cf_sql_numeric">
			AND     TES.TES_FK_ESTADO > 0
			ORDER BY FK_TIPO_EVALUACION
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="verificaEscolaridadEvaluada">
		<cfargument name="pkEvaluador" 		type="numeric" hint="pk del">
		<cfargument name="pkEvaluado" 		type="numeric" hint="pk del">
		<cfargument name="pkTipoEvaluacion" type="numeric" hint="pk del">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TEE.TES_PUNTAJEOBTENIDO,
			        TEE.TES_FK_EVALUACIONTIPO,
			        TOG.TOG_FK_CESTADO,
			        TOG.TOG_FK_TESCOLARIDAD
			FROM    EDI.EDITEVALUACIONESCOLARIDAD TEE,
							EDI.EDITOBTENCIONGRADOESCOLAR TOG,
							CVU.CVUTESCOLARIDAD           TES,
							CVU.CVUTPERSONA               TPS
			WHERE   TES.TES_PK_TESCOLARIDAD   =  TOG.TOG_FK_TESCOLARIDAD
			AND     TOG.TOG_PK_OBTENCIONGRADO =  TEE.TES_FK_OBTENCIONGRADO
			AND     TES.TES_FK_PERSONA        =  TPS.TPS_PK_PERSONA
			AND     TEE.TES_FK_EVALUADOR      =  <cfqueryparam value="#pkEvaluador#" cfsqltype="cf_sql_numeric">
			AND     TPS.TPS_FK_USUARIO        =  <cfqueryparam value="#pkEvaluado#" cfsqltype="cf_sql_numeric">
			AND     TEE.TES_FK_EVALUACIONTIPO =  <cfqueryparam value="#pkTipoEvaluacion#" cfsqltype="cf_sql_numeric">
			AND     TEE.TES_PUNTAJEOBTENIDO   IS NOT NULL
			AND     TOG.TOG_FK_ESTADO         =  2
			AND     TEE.TES_FK_ESTADO         =  2
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha:	Marzo de 2018
	*Autor:	Daniel Memije
	--->
	<cffunction name="verificaEscolaridadParaEvaluar">
		<cfargument name="pkEvaluador" 		type="numeric" hint="pk del">
		<cfargument name="pkEvaluado" 		type="numeric" hint="pk del">
		<cfargument name="pkTipoEvaluacion" type="numeric" hint="pk del">
		<cfquery name="respuesta" datasource="DS_EDI">
			SELECT  TEE.TES_PUNTAJEOBTENIDO,
			        TEE.TES_FK_EVALUACIONTIPO,
			        TOG.TOG_FK_CESTADO,
			        TOG.TOG_FK_TESCOLARIDAD
			FROM    EDI.EDITEVALUACIONESCOLARIDAD TEE,
							EDI.EDITOBTENCIONGRADOESCOLAR TOG,
							CVU.CVUTESCOLARIDAD           TES,
							CVU.CVUTPERSONA               TPS
			WHERE   TES.TES_PK_TESCOLARIDAD   =  TOG.TOG_FK_TESCOLARIDAD
			AND     TOG.TOG_PK_OBTENCIONGRADO =  TEE.TES_FK_OBTENCIONGRADO
			AND     TES.TES_FK_PERSONA        =  TPS.TPS_PK_PERSONA
			AND     TEE.TES_FK_EVALUADOR      =  <cfqueryparam value="#pkEvaluador#" cfsqltype="cf_sql_numeric">
			AND     TPS.TPS_FK_USUARIO        =  <cfqueryparam value="#pkEvaluado#" cfsqltype="cf_sql_numeric">
			AND     TEE.TES_FK_EVALUACIONTIPO =  <cfqueryparam value="#pkTipoEvaluacion#" cfsqltype="cf_sql_numeric">			
			AND     TOG.TOG_FK_ESTADO         =  2
			AND     TEE.TES_FK_ESTADO         =  2
		</cfquery>
		<cfreturn respuesta>
	</cffunction>
	<!--- 
	*Fecha: Marzo de 2018
	*Autor: Alejandro Rosales
	---->
	<cffunction name="getClasificaciones">
		<cfquery name="respuesta" datasource="DS_UR">
			SELECT DISTINCT CLA_PK_CLASIFICACION CLAVE, CLA_PK_CLASIFICACION || ' - ' || CLA_CLASIFICACION NOMBRE
			FROM CUR_CLASIFICACION ORDER BY NOMBRE
		</cfquery>
		<cfreturn respuesta>
	</cffunction>
	
	<!--- 
	*Fecha: Marzo de 2018
	*Autor: Alejandro Rosales
	---->
	<cffunction name="getUR">
		<cfargument name="clasificacion" default="">
		<cfquery name="respuesta" datasource="DS_UR">
			SELECT DISTINCT TUR_PK_UR PK, TUR_PK_UR || ' - ' || TUR_NOMBRE NOMBRE
				FROM TUR_TURCLASIFICACION, TUR WHERE TUC_FK_UR = TUR_PK_UR  
				<cfif LEN(clasificacion) GT 0>
					AND TUC_FK_CLASIFICACION = '#clasificacion#'
				</cfif>
				ORDER BY NOMBRE
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!--- 
	*Fecha: Marzo de 2018
	*Autor: Alejandro Rosales
	---->
 	<cffunction name="getTablaAspiranteProcesoUR" hint="obtiene la tabla de movimientos de aspiranteproceso">
		<cfargument name="pkProceso"   type="numeric" hint="Pk del proceso">
		<cfargument name="pkEvaluador" type="numeric" hint="Pk del evaluador">
		<cfargument name="pkUr"       type="any" hint="pk de la ur">
		<cfquery name="respuesta" datasource="DS_EDI">						
			SELECT DISTINCT(MOV.TMO_PK_MOVIMIENTO) AS PK_MOVIMIENTO,
			       MOV.TMO_NOMBRE				   AS MOVIMIENTO,
			       EDO.CER_PK_ESTADO               AS PK_ESTADO,
				   EDO.CER_NUMERO_ESTADO           AS NUM_ESTADO,
				   EDO.CER_NOMBRE                  AS ESTADO,
				   EDO.CER_COLOR				   AS COLOR,
			       PERS.TPS_PK_PERSONA             AS PK_PERSONA,
				   PERS.TPS_FK_USUARIO             AS FK_USUARIO,
				   PERS.TPS_RFC                    AS RFC,
				   PERS.TPS_NUMERO_EMPLEADO        AS NUM_EMPLEADO,
			       PERS.TPS_PERSONA_NOMBRE||' '||PERS.TPS_PERSONA_PATERNO||' '||PERS.TPS_PERSONA_MATERNO AS NOMBRE,
			       PERS.TPS_CORREO_IPN             AS CORREO,
			       ROL.TRO_FK_VERTIENTE 		   AS VERTIENTE,
			       TUR.TUR_SIGLA				   	AS UR,
			       TUR.TUR_PK_UR  					AS PK_UR,
			       ASPROC.TAS_PK_ASPIRANTEPROCESO  AS PK_ASPIRANTEPROCESO,
				   ASPROC.TAS_FK_CESTADO		   AS CESESTADO,
				   ASPROC.TAS_FK_CRUTA			   AS CESRUTA,
				   NIVEL.CED_NOMBRE_EDI 		   AS NIVEL_ASIGNADO_CA,
				   ACRO.CAC_ACRONIMO AS ACRONIMO,
				   USR.TUS_FK_GENERO AS GENERO
			  FROM EDI.EDITEVALUACIONETAPA       ETAPA,
			  	   EDI.EDITEVALUACIONPRODUCTOEDI EVALP,
			  	   EDI.EDITASPIRANTEPROCESO      ASPROC,
			  	   EDI.EDITMOVIMIENTO            MOV,
			  	   GRAL.CESCESTADO               EDO,
			  	   CVU.CVUCTPRODUCTOPERSONA      PROP,
			  	   CVU.CVUTPERSONA               PERS,
       			   GRAL.USRTUSUARIO 			 USR,
       			   GRAL.USRTROL 				 ROL,
       			   UR.TURIPN@DBL_URSIGA 		 TUR,
				   EDI.EDITEVALUACIONASPIRANTE 	 TEA,
       			   EDI.EDICEDI NIVEL, 
       			   GRAL.GRALCACRONIMO ACRO
			 WHERE ETAPA.TEE_FK_EVALUACIONPRODUCTOEDI(+) = EVALP.TEP_PK_EVALUACIONPRODUCTOEDI
			   AND EVALP.TEP_FK_CVUCCPRODUCTOPERSONA(+)  = PROP.TPP_PK_TPRODUCTOPERSONA
			   AND PROP.TPP_FK_PERSONA 				  	 = PERS.TPS_PK_PERSONA
			   AND PERS.TPS_PK_PERSONA 				  	 = ASPROC.TAS_FK_PERSONA
			   AND ASPROC.TAS_FK_MOVIMIENTO 		  	 = MOV.TMO_PK_MOVIMIENTO
			   AND EDO.CER_PK_ESTADO     			  	 = ASPROC.TAS_FK_CESTADO
			   AND ASPROC.TAS_FK_CESTADO     		  	 >= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.SOLICITUDENVIADASIP#" cfsqltype="cf_sql_numeric">
			   AND ETAPA.TEE_FK_ESTADO(+)				 = <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			   AND ASPROC.TAS_FK_PROCESO   = <cfqueryparam value="#arguments.pkProceso#" cfsqltype="cf_sql_numeric">
			   AND EVALP.TEP_FK_PROCESO(+) = <cfqueryparam value="#arguments.pkProceso#" cfsqltype="cf_sql_numeric">
			   <cfif not arraycontains(session.cbstorage.grant,'impr.verTodos')>
			   		AND ETAPA.TEE_FK_EVALUADOR 		= <cfqueryparam value="#arguments.pkEvaluador#" cfsqltype="cf_sql_numeric">
			   </cfif>
			   AND ASPROC.TAS_FK_ESTADO 			= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			   AND PERS.TPS_FK_USUARIO 				= USR.TUS_PK_USUARIO
       		   AND USR.TUS_FK_ROL 	   				= ROL.TRO_PK_ROL
       		   AND PERS.TPS_FK_UR 	   				= TUR.TUR_PK_UR
			   AND ASPROC.TAS_PK_ASPIRANTEPROCESO 	= TEA.TEA_FK_ASPIRANTEPROC(+)
			   AND TEA.TEA_FK_TIPOEVALUACION(+) 		= <cfqueryparam value="#application.SIIIP_CTES.TIPOEVALUACION.CA#" cfsqltype="cf_sql_numeric">
			   AND TEA.TEA_FK_ESTADO(+) 				= <cfqueryparam value="#application.SIIIP_CTES.ESTADO.VALIDADO#" cfsqltype="cf_sql_numeric">
			   AND TUR.TUR_PK_UR = '#pkUr#'
			   AND TEA.TEA_FK_NIVEL = NIVEL.CED_PK_EDI(+)
			   AND USR.TUS_FK_ACRONIMO = ACRO.CAC_PK_ACRONIMO(+)
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

</cfcomponent>
