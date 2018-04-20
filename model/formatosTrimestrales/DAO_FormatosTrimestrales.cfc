
 <cfcomponent <!--- accessors="true" singleton --->>
 
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getRespuestas" hint="query con las celdas del formato">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkUsuario">
		<cfquery  name="res" datasource="DS_CVU" >
	       SELECT   TCE.TCE_PK_CELDA     AS PKCELDA,
                    TCE.TCE_VALOR        AS valorcelda,
                    TFL.TFF_PK_FILA      AS PK_FILA,
                    TCE.TCE_FK_COLUMNA   AS PK_COLUMNA,
                    TPP.TPP_PK_PRODUCTOTEMP         AS PRODUCTO_ELIMINAR
	         FROM   CVU.EVTTFORMATO    TFR,
                    CVU.EVTTREPORTE    TRE,
                    CVU.EVTTCELDA      TCE,
                    CVU.EVTTFILA       TFL,
         			CVU.CVUCTPRODUCTOPERSONA TPP
	        WHERE   TFR.TFR_PK_FORMATO = TRE.TRP_FK_FORMATO
                    AND TRE.TRP_PK_REPORTE = TFL.TFF_FK_REPORTE
                    AND TCE.TCE_FK_FILA = TFL.TFF_PK_FILA
                    AND TFR.TFR_PK_FORMATO = <cfqueryparam value="#arguments.pkTFormato#" cfsqltype="cf_sql_numeric">
                    AND TRE.TRP_FK_PERIODO = <cfqueryparam value="#arguments.pkPeriodo#" cfsqltype="cf_sql_numeric">
					AND TFL.TFF_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
					AND TCE.TCE_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
					<cfif  pkUsuario neq ''>
						AND TFL.TFF_FK_USUARIO = <cfqueryparam value="#arguments.pkUsuario#" cfsqltype="cf_sql_numeric">
					</cfif>
					AND TFL.TFF_PK_FILA = TPP.TPP_FK_FILA
					AND TPP.TPP_ESTADO > 0
					AND TFL.TFF_ESTADO > 0
	       ORDER BY PK_FILA
		</cfquery>
		<cfreturn res>
	</cffunction>
		
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getEncabezado" hint="obtiene la informacion del encabezado">
		<cfargument name="pkFormato">
		<cfquery  name="res" datasource="DS_CVU" >      
		
		  SELECT TCL.TCL_PK_COLUMNA     	AS PK_COLUMNA,
	               	TCL.TCL_PK_COLUMNA      AS DATA,
	               	TCL.TCL_NOMBRE          AS NOM_COLUMNA,
	               	TCL.TCL_ORDEN           AS ORDEN,
	               	TDT.CTD_PK_TIPODATO     AS TIPO_DATO,
	               	TDT.CTD_NOMBRE          AS TIPO_DATONOMBRE,
	               	TCL.TCL_NIVEL		    AS NIVEL,
	               	TCL.TCL_FK_COLUMNA		AS PK_PADRE,
	               	TCL.TCL_FK_FORMATO 		AS PK_FORMATO,
	               	TDT.CTD_TIPOHT 			as type,
	               	TDT.CTD_REQUERIDO 		as requerido,
	               	TDT.CTD_READONLY 		as readOnly,
	               	TDT.CTD_RENDER 			as renderer,
					TDT.CTD_VALIDATOR 		as validator,
	                TCL.TCL_FK_TPLANTILLA 	as pk_Plantilla,
	                TCL.TCL_BLOQUEADA		AS BLOQUEADA,      
	               	TDT.CTD_SUMABLE 		AS SUMABLE
   			  FROM  CVU.EVTCFORMATO    CFT,
                    CVU.EVTTFORMATO    TFT,
                    CVU.EVTTCOLUMNA    TCL,
                    CVU.EVTCTIPODATO   TDT
             WHERE  CFT.CFT_PK_FORMATO = TFT.TFR_FK_CFORMATO
                    AND TFT.TFR_PK_FORMATO = TCL.TCL_FK_FORMATO
                    AND TDT.CTD_PK_TIPODATO = TCL.TCL_FK_TIPODATO
                    AND TFT.TFR_PK_FORMATO =  <cfqueryparam value="#arguments.pkFormato#" cfsqltype="cf_sql_numeric">
					AND TCL_FK_ESTADO = 2
   			ORDER BY TCL.TCL_ORDEN 	
	       
		</cfquery>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getCatalogoColumna" hint="Obtiene el catalogo de un acolumna">
		<cfargument name="pkColumna">
		<cfquery  name="res" datasource="DS_CVU" >
			  SELECT 	TRIM(TCC.CCC_ELEMENTO) AS OPCIONES
			  FROM	CVU.EVTTCATALOGOCOLUMNA TCC
			 WHERE	TCC.CCC_FK_ESTADO > 0
			 		AND TCC.CCC_FK_COLUMNA = <cfqueryparam value="#arguments.pkColumna#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getColumnasSumables" hint="Obtiene las columnas sumandos">
		<cfargument name="pkColumna">
		<cfquery  name="res" datasource="DS_CVU" >
		  	SELECT  TRP.TRP_FK_COLUMNA AS SUMANDOS,
		  			TRP.TRP_FK_TIPOOPERANDO AS OPERANDO
			  FROM	CVU.EVTTOPERANDO TRP
			 WHERE	TRP.TRP_FK_COLUMNADESTINO= #pkColumna#
		   ORDER BY TRP.TRP_FK_COLUMNA 
		</cfquery>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getColumna" hint="obtiene la informacion del encabezado">
		<cfargument name="pkColumna">
		<cfquery  name="res" datasource="DS_CVU" >

   		    SELECT  TCL.TCL_PK_COLUMNA      AS PK_COLUMNA,
	               	TCL.TCL_PK_COLUMNA      AS DATA,
	               	TCL.TCL_NOMBRE          AS NOM_COLUMNA,
	               	TCL.TCL_ORDEN           AS ORDEN,
	               	NVL(TCL.TCL_FK_TPLANTILLA,'0') AS PK_PLANTILLA,
	               	(SELECT EVTTPLANTILLA.TPL_NOMBRE FROM EVTTPLANTILLA WHERE EVTTPLANTILLA.TPL_PK_TPLANTILLA = TCL.TCL_FK_TPLANTILLA) AS NOMBRE_PLANTILLA,
	               	TDT.CTD_PK_TIPODATO     AS TIPO_DATO,
	               	TDT.CTD_NOMBRE          AS TIPO_DATONOMBRE,
	               	TCL.TCL_NIVEL		    AS NIVEL,
	               	TCL.TCL_FK_COLUMNA		AS PK_PADRE,
	               	TCL.TCL_FK_FORMATO 		AS PK_FORMATO,
	               	TDT.CTD_TIPOHT 			as type,
					TDT.CTD_REQUERIDO 		as requerido,
					TDT.CTD_READONLY 		as readOnly,
					TDT.CTD_RENDER 			as renderer,
					TDT.CTD_VALIDATOR 		as validator,
	               	TCL.TCL_FK_COLUMNAORIGEN  AS COL_ORIGEN,
  					TCL.TCL_TRIMESTRECOPIABLE AS TRIM_COPIABLE,
  					TCL.TCL_BLOQUEADA   AS BLOQUEADA_EDO, 					
  					TCL.TCL_COPIABLE    AS COPIABLE_EDO,
  					(SELECT EVTTFORMATO.TFR_FK_COLUMNATOTAL FROM EVTTFORMATO WHERE EVTTFORMATO.TFR_PK_FORMATO = TCL.TCL_FK_FORMATO) AS COLUMNATOTAL_EDO,
  					(SELECT EVTTFORMATO.TFR_FK_COLUMNATOTALFINAL FROM EVTTFORMATO WHERE EVTTFORMATO.TFR_PK_FORMATO = TCL.TCL_FK_FORMATO) AS COLUMNATOTALFINAL_EDO,	    
  					(SELECT EVTTPLANTILLA.TPL_NOMBRE FROM EVTTPLANTILLA WHERE EVTTPLANTILLA.TPL_PK_TPLANTILLA = (SELECT EVTTFORMATO.TFR_FK_PLANTILLASECCIO FROM EVTTFORMATO WHERE EVTTFORMATO.TFR_PK_FORMATO = TCL.TCL_FK_FORMATO)) AS PLANTILLASECCION,  					
  					TCL.TCL_DESCRIPCION AS DESCRIPCION,
	               	NVL(TDT.CTD_SUMABLE,0) AS SUMABLE
   			  FROM  CVU.EVTTCOLUMNA    TCL,
                    CVU.EVTCTIPODATO   TDT
             WHERE  TDT.CTD_PK_TIPODATO = TCL.TCL_FK_TIPODATO
                    AND TCL.TCL_PK_COLUMNA =  <cfqueryparam value="#arguments.pkColumna#" cfsqltype="cf_sql_numeric">
            ORDER BY TCL.TCL_ORDEN 
		</cfquery>
		<cfreturn res>
	</cffunction>
		
	
	<!--- funci0nes de guardado --->
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="actualizarDatos" hint="">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkColumna">
		<cfargument name="pkFila">
		<cfargument name="valor">
		<!--- <cfif not isnumeric(pkColumna)>
		<cfdump var="#arguments#" abort="true">
 		</cfif> --->
		<cfquery  name="res" datasource="DS_CVU" >
			UPDATE	CVU.EVTTCELDA TCE
			   SET	TCE.TCE_VALOR = <cfqueryparam value="#arguments.valor#" cfsqltype="cf_sql_varchar">
			 WHERE	TCE.TCE_FK_FILA = <cfqueryparam value="#arguments.pkFila#" cfsqltype="cf_sql_numeric">
			 		AND TCE.TCE_FK_COLUMNA = <cfqueryparam value="#arguments.pkColumna#" cfsqltype="cf_sql_numeric">
			 		AND TCE.TCE_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
		</cfquery> 
		<cfreturn 1>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="insertarDatos" hint="">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkColumna">
		<cfargument name="pkFila">
		<cfargument name="valor">
		<!----es importante verificar que no existan los registros---->
		<cftry>
		<cfquery  name="res" datasource="DS_CVU" >
			INSERT INTO CVU.EVTTCELDA TCE(
					TCE_VALOR,
					TCE_FK_FILA,
					TCE_FK_COLUMNA,
					TCE_ESTADO,
					TCE_FK_FORMATO
				) VALUES (
					<cfqueryparam value="#arguments.valor#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#arguments.pkFila#" cfsqltype="cf_sql_numeric">,
					<cfqueryparam value="#arguments.pkColumna#" cfsqltype="cf_sql_numeric">,
					2,
					<cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
				)
		</cfquery>
		<cfcatch>
			<cfreturn 0>
		</cfcatch>
		</cftry>
		<cfreturn 1>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="insertarFila" hint="">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkReporte">
		<cfargument name="pkUsuario">
		<cfstoredproc procedure="CVU.P_CAPTURA.GUARDAR_FILA" datasource="DS_CVU">
                <cfprocparam value="#pkCFormato#" 	cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkReporte#"    cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkUsuario#"    cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" 	cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
		<cfreturn respuesta>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="eliminarFilas" hint="recorre el arreglo e inserta las filas que contiene">
		<cfargument name="pkCformato">
		<cfargument name="pkPeriodo">
		<cfargument name="arrayEliminadas">
			<cfquery  name="res" datasource="DS_CVU" >
				UPDATE EVTTFILA
				SET TFF_ESTADO = 0
				WHERE	TFF_FK_FORMATO = #pkCformato#
						AND  TFF_PK_FILA IN(#arrayEliminadas#)
						
			</cfquery>
		<cfreturn 1>
	</cffunction>
	
	<!---
    * Fecha : Enero 2017
    * author : Marco Torres
	--->        
   	<cffunction name="insertarColumna" hint="">
		<cfargument name="pkTformato">
		<cfargument name="nombre">
		<cfargument name="nivel">
		<cfargument name="orden">
		<cfargument name="colspan">
		<cfargument name="rowspan">
		<cfargument name="fkPadre">
		<!----es importante verificar que no existan los registros---->
		<cfstoredproc procedure="CVU.P_CONFIGURACION.INSERTARCOLUMNA" datasource="DS_CVU">
                <cfprocparam value="#arguments.pkTformato#" cfsqltype="cf_sql_numeric">
				<cfprocparam value="#arguments.nombre#" cfsqltype="cf_sql_varchar">
				<cfprocparam value="#arguments.nivel#" cfsqltype="cf_sql_numeric">
				<cfprocparam value="#arguments.orden#" cfsqltype="cf_sql_numeric">
				<cfprocparam value="#arguments.colspan#" cfsqltype="cf_sql_numeric">
				<cfprocparam value="#arguments.rowspan#" cfsqltype="cf_sql_numeric">
				<cfprocparam value="#arguments.fkPadre#" cfsqltype="cf_sql_numeric">
                <cfprocparam variable="respuesta" 	cfsqltype="cf_sql_numeric" type="out">
		    </cfstoredproc>
		<cfreturn respuesta>
	</cffunction>
	
	<!---
    * Fecha : Enero 2017
    * author : Marco Torres
	--->        
   	<cffunction name="updateColumnaEstructura" hint="">
		<cfargument name="pkColumna">
		<cfargument name="nombre">
		<cfargument name="nivel">
		<cfargument name="orden">
		<cfargument name="colspan">
		<cfargument name="rowspan">
		<cfargument name="fkPadre">
		<!----es importante verificar que no existan los registros---->
		<cfstoredproc procedure="CVU.P_CONFIGURACION.UPDATECOLUMNAESTRUCTURA" datasource="DS_CVU">
                <cfprocparam value="#arguments.pkColumna#" cfsqltype="cf_sql_numeric">
				<cfprocparam value="#arguments.nombre#" cfsqltype="cf_sql_varchar">
				<cfprocparam value="#arguments.nivel#" cfsqltype="cf_sql_numeric">
				<cfprocparam value="#arguments.orden#" cfsqltype="cf_sql_numeric">
				<cfprocparam value="#arguments.colspan#" cfsqltype="cf_sql_numeric">
				<cfprocparam value="#arguments.rowspan#" cfsqltype="cf_sql_numeric">
				<cfprocparam value="#arguments.fkPadre#" cfsqltype="cf_sql_numeric">
                <cfprocparam variable="respuesta" 	cfsqltype="cf_sql_numeric" type="out">
		    </cfstoredproc>
		<cfreturn respuesta>
	</cffunction>
	
	<!---
    * Fecha : Enero 2017
    * author : Marco Torres
	--->        
   	<cffunction name="updateAllColumnastoCero" hint="envia todas las columnas del formato a estado cero">
		<cfargument name="pkTFormato">
		<cfargument name="arrayEliminadas">
		
		
			<cfquery  name="res" datasource="DS_CVU" >
				UPDATE EVTTCOLUMNA
				SET TCL_FK_ESTADO = 0
				WHERE	TCL_FK_FORMATO = #pkTFormato#
			</cfquery>
		<cfreturn 1>
	</cffunction>
		<!----funciones de seleccion de formatos---->
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getPeriodos" hint="">
		<cfquery  name="res" datasource="DS_CVU" >
		     SELECT TPR.TPE_PK_PERIODO  AS PK,
                    TPR.TPE_NOMBRE      AS NOMBRE
   			  FROM  CVU.EVTTPERIODO    TPR
             WHERE  TPR.TPE_ESTADO > 0
          ORDER BY  TPR.TPE_ANIO DESC, TPR.TPE_TRIMESTRE DESC
		</cfquery>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getFormatos" hint=""> 
   		<cfargument name="pkUsuario">
		<cfargument name="UR" default="">
		<cfquery  name="res" datasource="DS_CVU" >
		    SELECT  CFT.CFT_NOMBRE      AS NOMBRE,
                    TFT.TFR_PK_FORMATO  AS PK,
                    CFT.CFT_CLAVE       AS CLAVE,        
                    TFT.TFR_VERSION     AS VERSION,            
					TFT.TFR_FK_CESTADO	AS CESESTADO,
					TFT.TFR_RUTA		AS CESRUTA
   			  FROM  CVU.EVTCFORMATO    CFT,
                    CVU.EVTTFORMATO    TFT
					<cfif pkusuario neq ''>
                    ,CVU.EVTRUSUARIOFORMATO UFT
					</cfif>
             WHERE  CFT.CFT_PK_FORMATO = TFT.TFR_FK_CFORMATO
                    <cfif pkusuario neq ''>
						AND TFT.TFR_PK_FORMATO = UFT.TRU_FK_FORMATO
	                    AND UFT.TRU_FK_USUARIO = <cfqueryparam value="#arguments.pkUsuario#" cfsqltype="cf_sql_numeric">
	                    AND UFT.TRU_ESTADO = 1
					</cfif>
					
					<cfif UR neq ''>
                    	AND TFT.TFR_FK_UR = <cfqueryparam value="#arguments.UR#" cfsqltype="CF_sql_char">
                    </cfif>
		  ORDER BY	TFT.TFR_PK_FORMATO  DESC 

		</cfquery>
		<cfreturn res>
	</cffunction>
	
	
	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getFormatosPeriodo" hint="">
		<cfargument name="pkFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="UR" default="">
		<cfargument name="pkUsuario">
		<cfquery  name="res" datasource="DS_CVU" >
			SELECT  CFT.CFT_NOMBRE      AS NOMBRE,
                    TFT.TFR_PK_FORMATO  AS PK,
                    CFT.CFT_CLAVE       AS CLAVE,
					TFT.TFR_VERSION     AS VERSION,
                    TPR.TPE_PK_PERIODO  AS PKPERIODO,
                    TPR.TPE_NOMBRE      AS PERIODO,
					TRP_FK_CESTADO  	AS CESESTADO,
  					TRP_FK_RUTA			AS CESRUTA,
  					TRP.TRP_PK_REPORTE  AS PKREPORTE
   			  FROM  CVU.EVTCFORMATO    CFT,
                    CVU.EVTTFORMATO    TFT,
                    CVU.EVTTREPORTE    TRP,
                    CVU.EVTTPERIODO    TPR
             WHERE  CFT.CFT_PK_FORMATO = TFT.TFR_FK_CFORMATO
                    AND TFT.TFR_PK_FORMATO = TRP.TRP_FK_FORMATO
                    AND TPR.TPE_PK_PERIODO = TRP.TRP_FK_PERIODO
                    <cfif pkPeriodo neq ''>
	                    AND TPR.TPE_PK_PERIODO IN (#pkPeriodo#)
                    </cfif>
                    <cfif pkFormato neq 0>
                    	AND TFT.TFR_PK_FORMATO = <cfqueryparam value="#arguments.pkFormato#" cfsqltype="">
                    </cfif>
                    AND TFT.TFR_FK_CESTADO >= #application.SIIIP_CTES.FORMATO.VALIDADO#
            GROUP BY
            		CFT.CFT_NOMBRE,
                    TFT.TFR_PK_FORMATO,
                    CFT.CFT_CLAVE,
					TFT.TFR_VERSION,
                    TPR.TPE_PK_PERIODO,
                    TPR.TPE_NOMBRE,
					TRP_FK_CESTADO,
  					TRP_FK_RUTA,
  					TRP.TRP_PK_REPORTE

		</cfquery>
		<cfreturn res>
	</cffunction>


	<!---
	* Fecha: Enero 2017
	* Autor: Daniel Memije
	--->
	<cffunction name="insertarFormato" access="public" hint="Inserta el formato y obtiene el pk generado">
		<cfargument name="clave" 	   hint="">
		<cfargument name="nombre"    hint="">		
		<cfargument name="vigencia"    hint="">		
		<cfargument name="uresponsable"    hint="">		
		<cfargument name="instrucciones"    hint="">
		<cfargument name="pkEstadoInicio"    hint="">
		<cfargument name="pkRuta"    hint="">
		<cfargument name="pkUsuario"    hint="">
		<cfargument name="pkRol"	hint="">		
		<cfstoredproc procedure="CVU.P_CONFIGURACION.INSERTARFORMATO" datasource="DS_CVU">	    	
	    	<cfprocparam value="#clave#" 	 		cfsqltype="cf_sql_string"	type="in">
            <cfprocparam value="#nombre#"    		cfsqltype="cf_sql_string" 	type="in">            
            <cfprocparam value="#pkEstadoInicio#"	cfsqltype="cf_sql_numeric" 	type="in">            
            <cfprocparam value="#pkRuta#"			cfsqltype="cf_sql_numeric" 	type="in">
            <cfprocparam value="1.0"				cfsqltype="cf_sql_string" 	type="in">
            <cfprocparam value="#vigencia#"			cfsqltype="cf_sql_string" 	type="in">
            <cfprocparam value="#uresponsable#"		cfsqltype="cf_sql_string" 	type="in">                  
            <cfprocparam value="#instrucciones#"	cfsqltype="cf_sql_string" 	type="in">
            <cfprocparam value="#pkUsuario#"	cfsqltype="cf_sql_string" 	type="in">
            <cfprocparam value="#pkRol#"	cfsqltype="cf_sql_string" 	type="in">            	
            <cfprocparam variable="resultado" 		cfsqltype="cf_sql_numeric" 	type="out">
	    </cfstoredproc>
		<cfreturn resultado>
	</cffunction>

	<!---
	* Fecha: Enero 2017
	* Autor: Daniel Memije
	--->
	<cffunction name="actualizarFormato" access="public" hint="Actualiza el reporte">
		<cfargument name="pkFormato" 	   hint="">
		<cfargument name="claveFormato"    hint="">		
		<cfargument name="nombreFormato"    hint="">		
		<cfargument name="vigenciaFormato"    hint="">		
		<cfargument name="areaFormato"    hint="">
		<cfargument name="instrucciones" hint="">	
		<cfstoredproc procedure="CVU.P_CONFIGURACION.ACTUALIZARFORMATO" datasource="DS_CVU">	    	
	    	<cfprocparam value="#pkFormato#" 		cfsqltype="cf_sql_numeric"	type="in">
	    	<cfprocparam value="#claveFormato#"		cfsqltype="cf_sql_string"	type="in">
            <cfprocparam value="#nombreFormato#"	cfsqltype="cf_sql_string" 	type="in">                        
            <cfprocparam value="#vigenciaFormato#"	cfsqltype="cf_sql_string" 	type="in">
            <cfprocparam value="#areaFormato#"		cfsqltype="cf_sql_string" 	type="in">
            <cfprocparam value="#instrucciones#"	cfsqltype="cf_sql_string" 	type="in">
            <cfprocparam variable="respuesta" 		cfsqltype="cf_sql_numeric" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>

	<cffunction name="actualizarTipoDato" access="public" hint="Actualiza el tipo de dato de una columa">
		<cfargument name="pkColumna" 	   hint="">
		<cfargument name="pkTipoDato" 	   hint="">
		<cfstoredproc procedure="CVU.P_CONFIGURACION.ACTUALIZARTIPODATOCOLUMNA" datasource="DS_CVU">	    	
            <cfprocparam value="#pkColumna#"		cfsqltype="cf_sql_numeric" 	type="in">
	    	<cfprocparam value="#pkTipoDato#" 		cfsqltype="cf_sql_numeric"	type="in">
            <cfprocparam variable="respuesta" 		cfsqltype="cf_sql_numeric" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>

	<cffunction name="guardarPlantillaColumna" access="public" hint="Relaciona una columna con una plantilla">
		<cfargument name="pkColumna" 	   hint="">
		<cfargument name="pkPlantilla" 	   hint="">
		<cfstoredproc procedure="CVU.P_CONFIGURACION.GUARDARPLANTILLACOLUMNA" datasource="DS_CVU">	    	
            <cfprocparam value="#pkColumna#"		cfsqltype="cf_sql_numeric" 	type="in">
	    	<cfprocparam value="#pkPlantilla#" 		cfsqltype="cf_sql_numeric"	type="in">
            <cfprocparam variable="respuesta" 		cfsqltype="cf_sql_numeric" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>
	
	<cffunction name="bloquearparaCaptura" access="public" hint="Bloquea una columna para captura">
		<cfargument name="pkColumna" 	   hint="">
		<cfargument name="bloqueada" 	   hint="">
		<cfstoredproc procedure="CVU.P_CONFIGURACION.BLOQUEARPARACAPTURA" datasource="DS_CVU">	    	
            <cfprocparam value="#pkColumna#"		cfsqltype="cf_sql_numeric" 	type="in">
	    	<cfprocparam value="#bloqueada#" 		cfsqltype="cf_sql_numeric"	type="in">
            <cfprocparam variable="respuesta" 		cfsqltype="cf_sql_numeric" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>

	<cffunction name="columnaReferencia" access="public" hint="Bloquea una columna para captura">
		<cfargument name="pkColumna" 	   hint="">
		<cfargument name="referencia" 	   hint="">
		<cfstoredproc procedure="CVU.P_CONFIGURACION.COLUMNAREFERENCIA" datasource="DS_CVU">	    	
            <cfprocparam value="#pkColumna#"		cfsqltype="cf_sql_numeric" 	type="in">
	    	<cfprocparam value="#referencia#" 		cfsqltype="cf_sql_numeric"	type="in">
            <cfprocparam variable="respuesta" 		cfsqltype="cf_sql_numeric" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>

	<cffunction name="setCopiableTrimestre" access="public" hint="Copiar esta columna para cada trimestre">
		<cfargument name="pkColumna" 	   hint="">
		<cfargument name="copiable" 	   hint="">
		<cfstoredproc procedure="CVU.P_CONFIGURACION.COPIABLETRIMESTRE" datasource="DS_CVU">	    	
            <cfprocparam value="#pkColumna#"		cfsqltype="cf_sql_numeric" 	type="in">
	    	<cfprocparam value="#copiable#" 		cfsqltype="cf_sql_numeric"	type="in">
            <cfprocparam variable="respuesta" 		cfsqltype="cf_sql_numeric" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>
 	<!---
    * Fecha : febrero 2017
    * author : Marco Torres
	--->        
   	<cffunction name="getinfoFormato" hint="obtiene la informacion general del formato ">
		<cfargument name="pkTFormato">
		<cfquery  name="res" datasource="DS_CVU" >
			/*
			SELECT  CFT.CFT_NOMBRE      		AS NOMBRE,
                    TFT.TFR_PK_FORMATO  		AS PKTFORMATO,
                    CFT.CFT_PK_FORMATO  		AS PKCFORMATO,
					CFT.CFT_CLAVE       		AS CLAVE,
					TFT.TFR_VIGENCIA            AS VIGENCIA,
					TFT.TFR_FK_UR               AS UR,
					URS.TUR_SIGLA              as URnombre,
					URS.CLASE                   AS CLASIFICACION,
					TFT.TFR_INSTRUCCIONES       AS instrucciones,
					NVL(TFT.TFR_FK_TASOCIACION,0)      AS pkAsociacion,
					NVL(TFT.TFR_FK_COLUMNACATALOGOORIGEN,0) AS pkCatalogoOrigen,
	                NVL(TFT.TFR_FK_COLUMNACATALOGODESTINO,0) AS pkCatalogoDestino
	          FROM  CVU.EVTCFORMATO    CFT,
                    CVU.EVTTFORMATO    TFT,
                    UR.TURIPN URS 
             WHERE  CFT.CFT_PK_FORMATO = TFT.TFR_FK_CFORMATO
                    AND TFT.TFR_FK_UR = URS.TUR_PK_UR(+) 
                    AND TFT.TFR_PK_FORMATO = #pkTFormato#*/
					
					
					
			SELECT  CFT.CFT_NOMBRE      		AS NOMBRE,
                    TFT.TFR_PK_FORMATO  		AS PKTFORMATO,
                    CFT.CFT_PK_FORMATO  		AS PKCFORMATO,
					CFT.CFT_CLAVE       		AS CLAVE,
					TFT.TFR_VIGENCIA            AS VIGENCIA,
					TFT.TFR_FK_UR               AS UR,
					'SIP'              as URnombre,
					'ADMIN'                   AS CLASIFICACION,
					TFT.TFR_INSTRUCCIONES       AS instrucciones,
					NVL(TFT.TFR_FK_TASOCIACION,0)      AS pkAsociacion,
					NVL(TFT.TFR_FK_COLUMNACATALOGOORIGEN,0) AS pkCatalogoOrigen,
	                NVL(TFT.TFR_FK_COLUMNACATALOGODESTINO,0) AS pkCatalogoDestino
	          FROM  CVU.EVTCFORMATO    CFT,
                    CVU.EVTTFORMATO    TFT
             WHERE  CFT.CFT_PK_FORMATO = TFT.TFR_FK_CFORMATO
                    AND TFT.TFR_PK_FORMATO = #pkTFormato#
					
       	</cfquery>
		<cfreturn res>
	</cffunction>

	<cffunction name="setCalcularTotales" access="public" hint="Calcular Totales para cada valor de esta columna">
		<cfargument name="pkFormato" 	   hint="">
		<cfargument name="pkColumna" 	   hint="">
		<cfstoredproc procedure="CVU.P_CONFIGURACION.CALCULARTOTALES" datasource="DS_CVU">
		    <cfprocparam value="#pkFormato#"		cfsqltype="cf_sql_numeric" 	type="in">
	    	<cfprocparam value="#pkColumna#" 		cfsqltype="cf_sql_numeric"	type="in">
            <cfprocparam variable="respuesta" 		cfsqltype="cf_sql_numeric" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>

	<cffunction name="setCalcularTotalFinal" access="public" hint="Es la columna de Total Final">
		<cfargument name="pkFormato" 	   hint="">
		<cfargument name="pkColumna" 	   hint="">
		<cfstoredproc procedure="CVU.P_CONFIGURACION.CALCULARTOTALFINAL" datasource="DS_CVU">	    	
            <cfprocparam value="#pkFormato#"		cfsqltype="cf_sql_numeric" 	type="in">
	    	<cfprocparam value="#pkColumna#" 		cfsqltype="cf_sql_numeric"	type="in">
            <cfprocparam variable="respuesta" 		cfsqltype="cf_sql_numeric" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>

	<cffunction name="actualizarNombreColumna" access="public" hint="Es la columna de Total Final">
		<cfargument name="pkColumna" 	   hint="">
		<cfargument name="nombre" 	   hint="">
		<cfstoredproc procedure="CVU.P_CONFIGURACION.ACTUALIZARNOMBRECOLUMNA" datasource="DS_CVU">	    	
            <cfprocparam value="#pkColumna#"		cfsqltype="cf_sql_numeric" 	type="in">
	    	<cfprocparam value="#nombre#" 			cfsqltype="cf_sql_string"	type="in">
            <cfprocparam variable="respuesta" 		cfsqltype="cf_sql_numeric" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>

	<cffunction name="registrarSumaSecciones" access="public" hint="Mostrar la suma por las secciones de esta columna">
		<cfargument name="pkFormato" 	   	hint="">
		<cfargument name="pkPlantilla" 	   	hint="">
		<cfargument name="pkColumna" 	   	hint="">
		<cfargument name="pkAsociacion" 	hint="">
		<cfstoredproc procedure="CVU.P_CONFIGURACION.REGISTRARSUMASECCIONES" datasource="DS_CVU">	    	
            <cfprocparam value="#pkFormato#"		cfsqltype="CF_SQL_NUMERIC" 	type="in">
	    	<cfprocparam value="#pkPlantilla#" 		cfsqltype="CF_SQL_NUMERIC"	type="in">
	    	<cfprocparam value="#pkColumna#"		cfsqltype="CF_SQL_NUMERIC" 	type="in">
	    	<cfprocparam value="#pkAsociacion#" 	cfsqltype="CF_SQL_NUMERIC"	type="in">
            <cfprocparam variable="respuesta" 		cfsqltype="CF_SQL_NUMERIC" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>
		
	<!---
	* Fecha: Mayo 2017
	* Autor: Ana Belem Juarez
	--->		
	<cffunction name="actualizarOperando" access="public" hint="Registra el operando de una columa">
		<cfargument name="pkColumna" 	   	hint="">
		<cfargument name="pkDestino" 	   	hint="">
		<cfargument name="operacion" 	   	hint="">		
		<cfstoredproc procedure="CVU.P_CONFIGURACION.ACTUALIZAROPERANDO" datasource="DS_CVU">	    	
            <cfprocparam value="#pkColumna#"		cfsqltype="CF_SQL_NUMERIC" 	type="in">
	    	<cfprocparam value="#pkDestino#" 		cfsqltype="CF_SQL_NUMERIC"	type="in">
	    	<cfprocparam value="#operacion#"		cfsqltype="CF_SQL_NUMERIC" 	type="in">	    	
            <cfprocparam variable="respuesta" 		cfsqltype="CF_SQL_NUMERIC" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>	
		
	<cffunction name="registrarOperando" access="public" hint="Registra el operando de una columa">
		<cfargument name="pkColumna" 	   	hint="">
		<cfargument name="pkDestino" 	   	hint="">
		<cfargument name="operacion" 	   	hint="">		
		<cfstoredproc procedure="CVU.P_CONFIGURACION.REGISTRAROPERANDO" datasource="DS_CVU">	    	
            <cfprocparam value="#pkColumna#"		cfsqltype="CF_SQL_NUMERIC" 	type="in">
	    	<cfprocparam value="#pkDestino#" 		cfsqltype="CF_SQL_NUMERIC"	type="in">
	    	<cfprocparam value="#operacion#"		cfsqltype="CF_SQL_NUMERIC" 	type="in">	    	
            <cfprocparam variable="respuesta" 		cfsqltype="CF_SQL_NUMERIC" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>
	
	<cffunction name="eliminarOperando" access="public" hint="Elimina el operando de una columa">
		<cfargument name="pkColumna" 	   	hint="">
		<cfargument name="pkDestino" 	   	hint="">		
		<cfstoredproc procedure="CVU.P_CONFIGURACION.ELIMINAROPERANDO" datasource="DS_CVU">	    	
            <cfprocparam value="#pkColumna#"		cfsqltype="CF_SQL_NUMERIC" 	type="in">
	    	<cfprocparam value="#pkDestino#" 		cfsqltype="CF_SQL_NUMERIC"	type="in">	    	
            <cfprocparam variable="respuesta" 		cfsqltype="CF_SQL_NUMERIC" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>	

	<cffunction name="actualizarDescripcionColumna" access="public" hint="Actualiza el texto de ayuda de la columna">
		<cfargument name="pkColumna" 	   	hint="">
		<cfargument name="descripcion" 	   	hint="">		
		<cfstoredproc procedure="CVU.P_CONFIGURACION.ACTUALIZARDESCRIPCIONCOLUMNA" datasource="DS_CVU">	    	
            <cfprocparam value="#pkColumna#"		cfsqltype="CF_SQL_NUMERIC" 	type="in">
	    	<cfprocparam value="#descripcion#" 		cfsqltype="CF_SQL_STRING"	type="in">	    	
            <cfprocparam variable="respuesta" 		cfsqltype="CF_SQL_NUMERIC" type="out">          
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>

	<cffunction name="getAsociacionPlantillas" hint="Obtiene las plantillas asociadas">
		<cfargument name="pkPlantilla" hint ="">
		<cfquery name="qAsociacion" datasource="DS_CVU">
			SELECT CVE,TAS_NOMBRE NOMBRE
			FROM EVTTASOCIACION TA
			INNER JOIN (SELECT TAP_FK_ASOCIACION CVE
				FROM(SELECT  TAP.TAP_FK_ASOCIACION
					FROM    EVTTASOCIACIONPLANTILLA TAP                        
					WHERE   TAP.TAP_FK_PADRE = #pkPlantilla#
					UNION ALL
					SELECT  TAP.TAP_FK_ASOCIACION
					FROM    EVTTASOCIACIONPLANTILLA TAP                        
					WHERE   TAP.TAP_FK_PLANTILLA = #pkPlantilla#
					)
				GROUP BY TAP_FK_ASOCIACION ) Q
			ON Q.CVE = TA.TAS_PK_ASOCIACION 
		</cfquery>
		<cfreturn qAsociacion>
	</cffunction>

	<cffunction name="getPlantillasAsociadas" hint="Obtiene las plantillas asociadas">
		<cfargument name="pkAsociacion" hint ="">
		<cfquery name="qPlantillas" datasource="DS_CVU">
			SELECT  TAP.TAP_FK_PADRE AS PKPLANTILLA,
			TPL.TPL_NOMBRE   AS NOMBRE
			FROM    EVTTASOCIACIONPLANTILLA TAP,
			EVTTPLANTILLA TPL  
			WHERE TAP.TAP_FK_ASOCIACION = #pkAsociacion#
			AND TPL.TPL_PK_TPLANTILLA = TAP_FK_PADRE			
		</cfquery>
		<cfreturn qPlantillas>
	</cffunction>

		

	<cffunction name="getClasif" hint="Obtiene la clasificacion para el registro de reportes">
		<cfquery name="qClasif" datasource="DS_UR">
			SELECT DISTINCT CLASIF.CLA_PK_CLASIFICACION CVE, CLASIF.CLA_CLASIFICACION NOMBRE
			FROM UR.CUR_CLASIFICACION CLASIF
			ORDER BY NOMBRE
		</cfquery>		
		<cfreturn qClasif>
	</cffunction>

	<cffunction name="getTiposDato" hint="Obtiene los tipos de dato para las columnas">
		<cfquery name="qTipos" datasource="DS_CVU">
			SELECT DISTINCT CTD_PK_TIPODATO CVE, CTD_NOMBRE NOMBRE
			FROM EVTCTIPODATO TIPO
			ORDER BY CVE
		</cfquery>		
		<cfreturn qTipos>
	</cffunction>

	<cffunction name="getPlantillas" hint="Obtiene las plantillas">
		<cfquery name="qPlantillas" datasource="DS_CVU">
			SELECT DISTINCT  PLANTILLA.TPL_PK_TPLANTILLA CVE, PLANTILLA.TPL_NOMBRE NOMBRE
			FROM EVTTPLANTILLA PLANTILLA
			WHERE PLANTILLA.TPL_FK_CESTADO > 0
			ORDER BY NOMBRE
		</cfquery>
		<cfreturn qPlantillas>
	</cffunction>

	<cffunction name="getElementosPlantilla" hint="Obtiene los elementos de una plantilla">
		<cfargument name="pkPlantilla" hint ="">
		<cfquery name="qElementos" datasource="DS_CVU">
			SELECT ELEMENTO.TPE_PK_PLANTILLAELEMENTO CVE, ELEMENTO.TPE_NOMBRE NOMBRE
			FROM EVTTPLANTILLAELEMENTO ELEMENTO
			WHERE ELEMENTO.TPE_FK_PLANTILLA = '#pkPlantilla#'
					AND ELEMENTO.TPE_FK_ESTADO > 0
			ORDER BY NOMBRE
		</cfquery>
		<cfreturn qElementos>
	</cffunction>


	<cffunction name="getUR" hint="Obtiene las UR dada la clasificacion">
		<cfargument name="pkClasif" hint ="">
		<cfquery name="qUR" datasource="DS_UR">
			SELECT URS.TUR_PK_UR CVE, URS.TUR_NOMBRE NOMBRE
			FROM UR.TURIPN URS
			WHERE URS.CLASE = '#pkClasif#'
			ORDER BY NOMBRE		
		</cfquery>		
		<cfreturn qUR>
	</cffunction>

	<cffunction name="eliminarElementosCatalogo" hint="Elimina los elementos del catalogo de una columna">
		<cfargument name="pkColumna" hint ="">		
		<cfstoredproc procedure="CVU.P_CONFIGURACION.ELIMINARELEMENTOSCATALOGO" datasource="DS_CVU">	    	
	    	<cfprocparam value="#pkColumna#" 	 		cfsqltype="cf_sql_numeric"	type="in">           
	    </cfstoredproc>		
	</cffunction>

	<cffunction name="insertarElementosCatalogo" hint="Inserta los elementos a el catalogo de la columna">
		<cfargument name="pkColumna" hint ="">
		<cfargument name="elemento" hint ="">		
		<cfstoredproc procedure="CVU.P_CONFIGURACION.INSERTARELEMENTOSCATALOGO" datasource="DS_CVU">	    	
	    	<cfprocparam value="#pkColumna#" 	 		cfsqltype="cf_sql_numeric"	type="in">           
	    	<cfprocparam value="#elemento#" 	 		cfsqltype="cf_sql_string"	type="in">
	    </cfstoredproc>
	</cffunction>

	<cffunction name="copiarFormato" hint="Copia los formatos">
		<cfargument name="pkFormato" hint ="">
		<cfargument name="clave" hint ="">
		<cfargument name="nombre" hint ="">
		<cfargument name="pkUsuario"    hint="">
		<cfargument name="pkRol"    hint="">
		<cfstoredproc procedure="CVU.P_CONFIGURACION.COPIARFORMATO" datasource="DS_CVU">	    	
	    	<cfprocparam value="#pkFormato#" 	 		cfsqltype="cf_sql_numeric"	type="in">           
	    	<cfprocparam value="#clave#" 	 		cfsqltype="cf_sql_string"	type="in">
	    	<cfprocparam value="#nombre#"	 		cfsqltype="cf_sql_string"	type="in">
	    	<cfprocparam value="#pkUsuario#"	cfsqltype="cf_sql_string" 	type="in">
            <cfprocparam value="#pkRol#"	cfsqltype="cf_sql_string" 	type="in">            	
	    	<cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	    </cfstoredproc>
	    <cfreturn respuesta>
	</cffunction>

	<cffunction name="getInfoCopiar" hint="Obtiene la clave y el nombre del formato a copiar">
		<cfargument name="pkTFormato">		
		<cfquery  name="res" datasource="DS_CVU" >
			SELECT TCF.CFT_CLAVE CVE, TCF.CFT_NOMBRE NOMBRE
			FROM EVTCFORMATO TCF
			WHERE TCF.CFT_PK_FORMATO = 
    			(SELECT TTF.TFR_FK_CFORMATO
    			FROM EVTTFORMATO TTF
    			WHERE TTF.TFR_PK_FORMATO = #pkTformato#)
       </cfquery>		
		<cfreturn res>
	</cffunction>

	<cffunction name="formatoVersion" hint="">
		<cfargument name="pkTFormato">
		<cfargument name="pkUsuario"    hint="">
		<cfargument name="pkRol"    hint="">
		<cfstoredproc procedure="CVU.P_CONFIGURACION.FORMATOVERSION" datasource="DS_CVU">
			<cfprocparam value="#pkTFormato#" cfsqltype="CF_SQL_NUMERIC" type="in">
			<cfprocparam value="#pkUsuario#"	cfsqltype="cf_sql_string" 	type="in">
            <cfprocparam value="#pkRol#"	cfsqltype="cf_sql_string" 	type="in">
			<cfprocparam variable="respuesta" cfsqltype="CF_SQL_NUMERIC" type="out">
		</cfstoredproc>		
		<cfreturn respuesta>		
	</cffunction>
	
 	<!---
    * Fecha : febrero 2017
    * author : Marco Torres
	--->        
   	<cffunction name="getinfoReporte" hint="Obtiene la informacion de capturada para un reporte">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfquery  name="res" datasource="DS_CVU" >
			SELECT   TRP.TRP_PK_REPORTE	AS PKREPORTE,
					CFT.CFT_NOMBRE      		AS NOMBRE,
                    TFT.TFR_PK_FORMATO  		AS PKTFORMATO,
                    CFT.CFT_PK_FORMATO  		AS PKCFORMATO,
                    CFT.CFT_CLAVE       		AS CLAVE,
                    TPR.TPE_PK_PERIODO  		AS PKPERIODO,
                    TPR.TPE_NOMBRE      		AS PERIODO,
					TFT.TFR_FK_COLUMNATOTAL		AS agruparCol,
					TFT.TFR_FK_COLUMNASECCION	AS pkColumnaSeccion,
					TFT.TFR_FK_PLANTILLASECCIO	AS pkPlantillaSeccion,	                
	                NVL(TFT.TFR_FK_TASOCIACION,0) 		AS pkAsociacion,
	                TFT.TFR_FIJARFILAS			AS FILAFIJA,
	                NVL(TFT.TFR_FK_COLUMNACATALOGOORIGEN,0) AS pkCatalogoOrigen,
	                NVL(TFT.TFR_FK_COLUMNACATALOGODESTINO,0) AS pkCatalogoDestino,
					TFT.TFR_VERTOTALES			AS sumaFinal
			  FROM  CVU.EVTCFORMATO    CFT,
                    CVU.EVTTFORMATO    TFT,
                    CVU.EVTTPERIODO    TPR,
                    CVU.EVTTREPORTE    TRP
             WHERE  CFT.CFT_PK_FORMATO = TFT.TFR_FK_CFORMATO
                    AND TFT.TFR_PK_FORMATO = TRP.TRP_FK_FORMATO
                    AND TPR.TPE_PK_PERIODO = TRP.TRP_FK_PERIODO
                   	AND TFT.TFR_PK_FORMATO = #pkTFormato#
        </cfquery>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha : Febrero 2017
    * author : Marco Torres
	--->        
   	<cffunction name="getEstructuraSecciones" hint="crea un aray con las secciones asociadas">
		<cfargument name="pkPlatillaPadre">
		<cfargument name="pkPlatillaHijo">
		<cfargument name="pkAsociacion">
		<cfquery  name="res" datasource="DS_CVU" >
			    SELECT  PADRE.TPE_NOMBRE     AS   ELEMPADRE,
			            HIJO.TPE_NOMBRE     AS   ELEMHIJO
			      FROM  CVU.EVTTPLANTILLAELEMENTO HIJO,
			            CVU.EVTTPLANTILLAELEMENTO PADRE,
			            CVU.EVTTASOCIACIONELEMENTO ASO
			     WHERE  ASO.TAE_FK_PADRE = PADRE.TPE_PK_PLANTILLAELEMENTO
			            AND ASO.TAE_FK_PLANTILLAELEMENTO = HIJO.TPE_PK_PLANTILLAELEMENTO
			            AND ASO.TAE_FK_ASOCIACION = #pkAsociacion#
       </cfquery>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha creación: Enero de 2017
    * @author: SGS
    --->
	<cffunction name="cambiaColumna" hint="Marca o desmarca una celda de la tabla de Información de semestres previos">
        <cfargument name="pkColumna" type="numeric" required="yes" hint="pk de la columna">
        <cfargument name="pkColOrigen" type="numeric" required="yes" hint="pk de la columna origen">
        <cfargument name="trimCopiable" type="numeric" required="yes" hint="El trimestre anterior del que sera copiado">
	        <cfstoredproc procedure="CVU.P_CONFIGURACION.CAMBIAR_COL_COPIABLE" datasource="DS_CVU">
	            <cfprocparam value="#pkColumna#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkColOrigen#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#trimCopiable#" cfsqltype="cf_sql_string" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

	<!---
    * Fecha creación: Febrero de 2017
    * @author: SGS
    --->
    <cffunction name="cargaConfigGral" hint="Obtiene las configuraciones generales de un formato">
		<cfargument name="pkFormato" type="numeric" required="yes" hint="pk del formato">
		<cfquery  name="respuesta" datasource="DS_CVU" >
			SELECT  TFT.TFR_PK_FORMATO  AS PKFORMATO,
					TFT.TFR_VERTOTALES  AS VERTOTALES,
                    TFT.TFR_FIJARFILAS  AS FIJARFILAS,
                    TFT.TFR_ACUMULADO   AS ACUMULADO
			  FROM  CVU.EVTTFORMATO    TFT
             WHERE  TFT.TFR_PK_FORMATO = #pkFormato#
       	</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
    * Fecha creación: Febrero de 2017
    * @author: SGS
    --->
	<cffunction name="cambiaConfigGral" hint="Cambia las configuraciones generales">
        <cfargument name="pkFormato" type="numeric" required="yes" hint="pk del formato">
        <cfargument name="insercionFilas" type="numeric" required="yes" hint="Valor de la opcion insercion de filas">
        <cfargument name="totalFinal" type="numeric" required="yes" hint="Valor de la opcion calcular totales">
        <cfargument name="acumulado"  type="numeric" required="yes" hint="genera totales">
	        <cfstoredproc procedure="CVU.P_CONFIGURACION.CAMBIAR_CONFIG_GRAL" datasource="DS_CVU">
	            <cfprocparam value="#pkFormato#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#insercionFilas#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#totalFinal#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#acumulado#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creación: Febrero de 2017
    * @author: SGS
    --->
    <cffunction name="emailSiguienteRol" hint="Obtiene el emial del usuario que debe validar">
        <cfargument name="dependencia" type="string" required="yes" hint="Dependencia del usuario que envia el email">
        <cfargument name="pkRolSiguiente" type="numeric" required="yes" hint="Pk del rol siguiente">
		<cfquery  name="respuesta" datasource="DS_CVU" >
            SELECT 	UST.TUS_USUARIO_USERNAME	AS USERNAME,
            		UST.TUS_FK_ROL				AS ROL,
                	UST.TUS_FK_UR				AS DEPENDENCIA,
                	UST.TUS_USUARIO_EMAIL		AS EMAIL
              FROM 	CVU.USRTUSUARIO UST
             WHERE 	UST.TUS_FK_UR = '#dependencia#'
                	AND UST.TUS_FK_ROL = #pkRolSiguiente#
                	AND UST.TUS_FK_ESTADO = 2
        </cfquery>
        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creación: Febrero de 2017
    * @author: SGS
    --->
    <cffunction name="emailAnteriorRol" hint="Obtiene el emial del usuario que fue rechazada su validacion">
        <cfargument name="pkReporte" type="numeric" required="yes" hint="Pk del registro modificado">
		<cfquery  name="respuesta" datasource="DS_CVU" >
            SELECT	HIS.BHI_PK_HISTORIAL 			AS PK_HISTORIAL,
	        		HIS.BHI_USUARIO_MODIFICACION	AS MODIFICACION,
	        		UST.TUS_USUARIO_USERNAME		AS USERNAME,
	       			UST.TUS_USUARIO_EMAIL			AS EMAIL
			  FROM 	CVU.CESBHISTORIAL HIS,
        			CVU.USRTUSUARIO   UST
			 WHERE	HIS.BHI_REGISTRO_MODIFICACION = #pkReporte#
        			AND UST.TUS_PK_USUARIO = HIS.BHI_USUARIO_MODIFICACION
        			AND HIS.BHI_FK_ESTADO = 2
        			AND ROWNUM <=1
			ORDER BY PK_HISTORIAL DESC
        </cfquery>
        <cfreturn respuesta>
    </cffunction>

	<!---
    * Fecha : Febrero 2017
    * author : Alejandro Tovar
	--->        
   	<cffunction name="getReporte" hint="">
		<cfargument name="pkReporte">
		<cfargument name="UR" default="">
		<cfquery  name="res" datasource="DS_CVU" >
			SELECT  CFT.CFT_NOMBRE      AS NOMBRE,
                    TFT.TFR_PK_FORMATO  AS PK,
                    CFT.CFT_CLAVE       AS CLAVE,
                    TPR.TPE_PK_PERIODO  AS PKPERIODO,
                    TPR.TPE_NOMBRE      AS PERIODO,
					TRP_FK_CESTADO  	AS CESESTADO,
  					TRP_FK_RUTA			AS CESRUTA,
  					TRP.TRP_PK_REPORTE  AS PKREPORTE
   			  FROM  CVU.EVTCFORMATO    CFT,
                    CVU.EVTTFORMATO    TFT,
                    CVU.EVTTREPORTE    TRP,
                    CVU.EVTTPERIODO    TPR
             WHERE  CFT.CFT_PK_FORMATO = TFT.TFR_FK_CFORMATO
                    AND TFT.TFR_PK_FORMATO = TRP.TRP_FK_FORMATO
                    AND TPR.TPE_PK_PERIODO = TRP.TRP_FK_PERIODO
			        AND TRP.TRP_PK_REPORTE = #pkReporte#
			        <cfif UR neq ''>
                    	AND TFT.TFR_FK_UR = '#UR#'
                    </cfif>
            GROUP BY
            		CFT.CFT_NOMBRE,
                    TFT.TFR_PK_FORMATO,
                    CFT.CFT_CLAVE,
                    TPR.TPE_PK_PERIODO,
                    TPR.TPE_NOMBRE,
					TRP_FK_CESTADO,
  					TRP_FK_RUTA,
  					TRP.TRP_PK_REPORTE

		</cfquery>
		<cfreturn res>
	</cffunction>


	<cffunction name="obtenerFormatos" hint="Obtiene los formatos de un periodo">
    	<cfargument name="anio">
        <cfquery name="resultado" datasource="DS_CVU">
            SELECT  DISTINCT FORM.TFR_PK_FORMATO PKFORMATO,
			        CATG.CFT_NOMBRE		NOMBREFORMATO
			FROM    CVU.EVTTFORMATO FORM, 
			        CVU.EVTCFORMATO CATG,
			        CVU.EVTTREPORTE REP,
			        CVU.EVTTPERIODO PER
			WHERE FORM.TFR_ACUMULADO = 1
			      AND FORM.TFR_FK_CFORMATO = CATG.CFT_PK_FORMATO
			      --AND FORM.TFR_FK_CESTADO = #application.SIIIP_CTES.FORMATO.VALIDADO#
			      AND FORM.TFR_PK_FORMATO = REP.TRP_FK_FORMATO
			      AND REP.TRP_FK_PERIODO = PER.TPE_PK_PERIODO
			      AND PER.TPE_ANIO = #anio# --ANIO
        </cfquery>
        <cfreturn resultado>        
    </cffunction>


    <cffunction name="getPeriodosByReporte" hint="Obtiene los formatos de un periodo">
    	<cfargument name="pkTFormato">
    	<cfargument name="anio">
        <cfquery name="resultado" datasource="DS_CVU">
            SELECT  PER.TPE_PK_PERIODO PERIODO
			FROM    CVU.EVTTREPORTE REP,
			        CVU.EVTTPERIODO PER
			WHERE REP.TRP_FK_PERIODO = PER.TPE_PK_PERIODO
                  AND REP.TRP_FK_FORMATO = #pkTFormato#
                  AND REP.TRP_FK_PERIODO = PER.TPE_PK_PERIODO
                  AND PER.TPE_ANIO = #anio#
        </cfquery>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
    <cffunction name="getCatalogoAsociacionesDependencias" hint="Obtiene las asociaciones padre-hijo de una asociacion">
    	<cfargument name="pkAsociacion">
        <cfquery name="resultado" datasource="DS_CVU">
            SELECT  TAE.TAE_FK_PADRE    PADRE,
			        TAE.TAE_FK_PLANTILLAELEMENTO HIJO,
			        TRIM(TPEPADRE.TPE_NOMBRE) PADRENOMBRE,
			        TRIM(TPEHIJO.TPE_NOMBRE) HIJONOMBRE    
			FROM    EVTTASOCIACIONELEMENTO  TAE,
			        EVTTPLANTILLAELEMENTO   TPEPADRE,
			        EVTTPLANTILLAELEMENTO   TPEHIJO
			WHERE   TPEPADRE.TPE_PK_PLANTILLAELEMENTO = TAE.TAE_FK_PADRE
			AND     TPEHIJO.TPE_PK_PLANTILLAELEMENTO = TAE.TAE_FK_PLANTILLAELEMENTO
			AND     TAE.TAE_FK_ASOCIACION = #pkAsociacion#
        </cfquery>
        <cfreturn resultado>        
    </cffunction>
    
    <!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
    <cffunction name="getAsociacionesCatalogos" hint="Obtiene las asociaciones padre-hijo de una asociacion">
    	<cfargument name="pkPadre">
		<cfargument name="pkHijo">
        <cfquery name="resultado" datasource="DS_CVU">
            SELECT
			TAS_PK_ASOCIACION CVE,
			TAS_NOMBRE NOMBRE
			FROM
			EVTTASOCIACION INNER JOIN (
			    SELECT *
			    FROM EVTTASOCIACIONPLANTILLA ETP
			    WHERE ETP.TAP_FK_PADRE = (SELECT TCL_FK_TPLANTILLA FROM EVTTCOLUMNA WHERE TCL_PK_COLUMNA = #pkPadre#)
			    AND ETP.TAP_FK_PLANTILLA = (SELECT TCL_FK_TPLANTILLA FROM EVTTCOLUMNA WHERE TCL_PK_COLUMNA = #pkHijo#)) Q1
			ON EVTTASOCIACION.TAS_PK_ASOCIACION = Q1.TAP_FK_ASOCIACION
			AND EVTTASOCIACION.TAS_ESTADO > 0
        </cfquery>
        <cfreturn resultado>        
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
	<cffunction name="seleccionarAsociacionCatalogos" hint="Selecciona una asociacion de catalogos">
        <cfargument name="pkFormato" 	type="numeric" required="yes" hint="PK DEL FORMATO">
        <cfargument name="pkAsociacion" type="numeric" required="yes" hint="PK DE LA ASOCIACION SELECCIONADA">        
	        <cfstoredproc procedure="CVU.P_CONFIGURACION.SELECCIONARASOCIACIONCATALOGOS" datasource="DS_CVU">
	            <cfprocparam value="#pkFormato#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkAsociacion#" cfsqltype="cf_sql_numeric" type="in">	            
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>
    
    <!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
	<cffunction name="quitarAsociacionCatalogos" hint="Deselecciona una asociacion de catalogos">
        <cfargument name="pkFormato" 	type="numeric" required="yes" hint="PK DEL FORMATO">        
	        <cfstoredproc procedure="CVU.P_CONFIGURACION.QUITARASOCIACIONCATALOGOS" datasource="DS_CVU">
	            <cfprocparam value="#pkFormato#" cfsqltype="cf_sql_numeric" type="in">	            
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
	<cffunction name="seleccionarColumnaOrigen" hint="Selecciona una columna como origen del catalogo">
        <cfargument name="pkFormato" 	type="numeric" required="yes" hint="PK DEL FORMATO">        
        <cfargument name="pkOrigen" 	type="numeric" required="yes" hint="PK DEL CATALOGO ORIGEN">        
        <cfargument name="pkDestino" 	type="numeric" required="yes" hint="PK DEL CATALOGO DESTINO">                
	        <cfstoredproc procedure="CVU.P_CONFIGURACION.SELECCIONARCOLUMNAORIGEN" datasource="DS_CVU">
	            <cfprocparam value="#pkFormato#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkOrigen#" cfsqltype="cf_sql_numeric" type="in">	            
	            <cfprocparam value="#pkDestino#" cfsqltype="cf_sql_numeric" type="in">	            
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>
    
    <!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
	<cffunction name="quitarColumnaOrigen" hint="Deselecciona una columna como origen del catalogo">
        <cfargument name="pkFormato" 	type="numeric" required="yes" hint="PK DEL FORMATO">        
	        <cfstoredproc procedure="CVU.P_CONFIGURACION.QUITARCOLUMNAORIGEN" datasource="DS_CVU">
	            <cfprocparam value="#pkFormato#" cfsqltype="cf_sql_numeric" type="in">	            
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>
    
    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="getReportes" access="public" hint="Muestra los formatos disponibles a relacionar">
    	<cfargument name="arrayFormatos">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT FORM.TFR_PK_FORMATO  PKFORMATO,
			       CATF.CFT_NOMBRE    	NOMBREFORMATO
			FROM   CVU.EVTTFORMATO FORM,
			       CVU.EVTCFORMATO CATF
			WHERE  FORM.TFR_FK_CFORMATO = CATF.CFT_PK_FORMATO
			       AND CATF.CFT_FK_ESTADO > 0
			       <cfif arrayFormatos NEQ ''>
			          AND FORM.TFR_PK_FORMATO NOT IN (#arrayFormatos#)
			       </cfif>
			       AND FORM.TFR_FK_CESTADO = #application.SIIIP_CTES.FORMATO.VALIDADO#
			ORDER BY PKFORMATO DESC
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>

    <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="getFormatosRelacionados" access="public" hint="Muestra los formatos que estan asociados">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT DISTINCT COLUMNA.TCL_FK_FORMATO AS FMT
			FROM   CVU.EVTTASOCIACIONCOLUMNA COLASOC,
			       CVU.EVTTCOLUMNA COLUMNA
			WHERE  COLASOC.TAC_FK_ORIGEN = COLUMNA.TCL_PK_COLUMNA
			       AND COLASOC.TAC_FK_ACCION = #application.SIIIP_CTES.ACCION.ASOCIACION_FORMATOS#
			      
			UNION

			SELECT DISTINCT COLASOC.TAC_FK_FORMATO AS FMT
			FROM   CVU.EVTTASOCIACIONCOLUMNA COLASOC
			WHERE  COLASOC.TAC_FK_ACCION = #application.SIIIP_CTES.ACCION.ASOCIACION_FORMATOS#
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>

    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="getAsociacionFormatos" access="public" hint="Obtiene las relaciones de formatos">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT  DISTINCT NOMASOC.TNA_PK_NOMBRE AS PKNOMBRE,
			        NOMASOC.TNA_NOMBRE    AS NOMBRE,
			        REPASOC.TAR_FK_ORIGEN AS PKREPORTEORIGEN
			FROM    CVU.EVTTASOCIACIONFORMATONOMBRE NOMASOC,
                    CVU.EVTTASOCIACIONFORMATO 		 REPASOC
            WHERE   NOMASOC.TNA_PK_NOMBRE = REPASOC.TAR_FK_NOMBRE
			ORDER BY NOMBRE
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>
    
    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="getFormatosAsociados" access="public" hint="Obtiene los reportes que estan asociados a un registro de asociacion">
    	<cfargument name="pkAsociacion">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT  REPASOC.TAR_FK_ORIGEN 	AS PKORIGEN,	
			        REPASOC.TAR_FK_ASOCIADO AS PKREPORTE,
			        REPASOC.TAR_FK_NOMBRE 	AS PKNOMBRE
			FROM    CVU.EVTTASOCIACIONFORMATONOMBRE NOMASOC,
                    CVU.EVTTASOCIACIONFORMATO 		 REPASOC
            WHERE   NOMASOC.TNA_PK_NOMBRE = REPASOC.TAR_FK_NOMBRE
            		AND REPASOC.TAR_FK_NOMBRE = #pkAsociacion#
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>


    <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="getFormatosAsociacionContenedor" access="public" hint="Obtiene los reportes que estan asociados, excepto el formato contenedor">
    	<cfargument name="pkAsociacion">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT  REPASOC.TAR_FK_ORIGEN 	AS PKORIGEN,	
			        REPASOC.TAR_FK_ASOCIADO AS PKREPORTE,
			        REPASOC.TAR_FK_NOMBRE 	AS PKNOMBRE
			FROM    CVU.EVTTASOCIACIONFORMATONOMBRE NOMASOC,
                    CVU.EVTTASOCIACIONFORMATO 		 REPASOC
            WHERE   NOMASOC.TNA_PK_NOMBRE = REPASOC.TAR_FK_NOMBRE
            		AND REPASOC.TAR_FK_ORIGEN <> REPASOC.TAR_FK_ASOCIADO
            		AND REPASOC.TAR_FK_NOMBRE = #pkAsociacion#
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="getColumnasAsociadas" access="public" hint="Obtiene las columnas asociadas a la columna origen">
    	<cfargument name="pkColumnaOrigen">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT 	COLASOC.TAC_FK_COLUMNA AS PKCOLASOCIADA
			FROM 	CVU.EVTTASOCIACIONCOLUMNA COLASOC
			WHERE 	COLASOC.TAC_FK_ORIGEN = #pkColumnaOrigen#
					AND COLASOC.TAC_FK_ACCION = #application.SIIIP_CTES.ACCION.ASOCIACION_FORMATOS#
					AND COLASOC.TAC_FK_ESTADO <> 0
		</cfquery>
		<cfreturn respuesta>
    </cffunction>    

    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
	<cffunction name="setNombreAsociacion" hint="GUARDA EL NOMBRE DE ASOCIACION DE REPORTES">
        <cfargument name="nombres" type="string" required="yes" hint="nombre de la asociacion">
	        <cfstoredproc procedure="CVU.P_REPORTES.GUARDA_NOMBRE_ASOCIACION" datasource="DS_CVU">
	            <cfprocparam value="#nombres#" cfsqltype="cf_sql_string" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>
    
    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="setAsociaciones" hint="Establece la relacion entre formatos seleccionados">
        <cfargument name="pkNombre"   type="numeric" required="yes" hint="pk del nombre de la asociacion de formatos">
        <cfargument name="pkOrigen"   type="numeric" required="yes" hint="pk de formato origen">
        <cfargument name="pkAsociado" type="numeric" required="yes" hint="pk de formato asociado">
	        <cfstoredproc procedure="CVU.P_REPORTES.GUARDA_ASOCIACION_REPORTES" datasource="DS_CVU">
	            <cfprocparam value="#pkNombre#"   cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkOrigen#"   cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkAsociado#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="setRelacionColumnas" hint="Inserta o actualiza la relacion de columnas">
        <cfargument name="pkOrigen"   type="numeric" required="yes">
		<cfargument name="pkAsociado" type="numeric" required="yes">
		<cfargument name="pkFormato"  type="numeric" required="yes">
		<cfargument name="accion"     type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_REPORTES.GUARDA_RELACION_COLUMNAS" datasource="DS_CVU">
	            <cfprocparam value="#pkOrigen#"   cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkAsociado#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkFormato#"  cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#accion#"     cfsqltype="cf_sql_numeric" type="in">	
				<cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="existeRelacionColumnas" access="public" hint="">
    	<cfargument name="pkOrigen"   type="numeric" required="yes">
		<cfargument name="pkAsociado" type="numeric" required="yes">
		<cfargument name="pkFormato"  type="numeric" required="yes">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT REL.TAC_PK_ASOCIACIONCOLUMNA AS PKRELACION
			FROM   CVU.EVTTASOCIACIONCOLUMNA REL
			WHERE  REL.TAC_FK_ORIGEN = #pkOrigen#
        		   AND REL.TAC_FK_FORMATO = #pkFormato#
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>

    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  

    <cffunction name="getElementosByPlantilla" access="public" hint="Obtiene los elementos relacionados a una plantilla">
		<cfargument name="pkPlantilla" type="numeric" required="yes">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT ELEM.TPE_NOMBRE AS ELEMENTO
			FROM   CVU.EVTTPLANTILLAELEMENTO ELEM
			WHERE  ELEM.TPE_FK_PLANTILLA = #pkPlantilla#
				   AND ELEM.TPE_FK_ESTADO > 0	
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>

    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="guardaClasificacionFormato" hint="Guarda la clasificacion del formato en la asociacion">
        <cfargument name="pkFormato" type="numeric" required="yes">
        <cfargument name="pkPlantilla" type="string" required="yes">
		<cfargument name="clasificacion" type="string" required="yes">
		<cfargument name="pkNombreAsociacion" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_REPORTES.GUARDA_CLASIFICACION" datasource="DS_CVU">
	            <cfprocparam value="#pkFormato#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkPlantilla#" cfsqltype="cf_sql_numeric" type="in">	
	            <cfprocparam value="#clasificacion#" cfsqltype="cf_sql_string" type="in">
	            <cfprocparam value="#pkNombreAsociacion#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>
    
    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="getPlantillaSelected" access="public" hint="Obtiene la plantilla asociada a un formato">
		<cfargument name="pkAsociacion" type="numeric" required="yes">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT DISTINCT PLNT.TAR_FK_PLANTILLA AS PLANTILLA
			FROM   CVU.EVTTASOCIACIONFORMATO PLNT
			WHERE  PLNT.TAR_FK_NOMBRE = #pkAsociacion#
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>

    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="getValorElementos" access="public" hint="Obtiene los valores de los elementos de una plantilla">
		<cfargument name="pkAsociacion" type="numeric" required="yes">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT PLNT.TAR_CLASIFICACION AS VALORELEMENTO,
				   PLNT.TAR_FK_ASOCIADO	  AS PKFORMATO
			FROM   CVU.EVTTASOCIACIONFORMATO PLNT
			WHERE  PLNT.TAR_FK_NOMBRE = #pkAsociacion#
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>




    <!---
    * Fecha creación: Marzo de 2017
    * @author: SGS
    --->
    <cffunction name="getFilaData" hint="obtiene la informacion de la fila del reporte seleccionado">
        <cfargument name="pkFila" type="numeric" required="yes" hint="pk de la fila">
		<cfquery  name="respuesta" datasource="DS_CVU" >
            SELECT  TCE.TCE_FK_COLUMNA AS COLUMNA,
            		TCE.TCE_VALOR AS VALOR
  			  FROM  CVU.EVTTCELDA TCE
 			 WHERE  TCE.TCE_FK_FILA = #pkFila#
 			ORDER BY COLUMNA
        </cfquery>
        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: SGS
    --->
	<cffunction name="saveDatosFormulario" hint="guardar la informacion de la fila del reporte seleccionado">
        <cfargument name="pkFila" type="numeric" required="yes" hint="pk de la fila">
        <cfargument name="pkColumna" type="numeric" required="yes" hint="pk de la columna">
        <cfargument name="valor" type="string" required="yes" hint="datos de la celda">
	        <cfstoredproc procedure="CVU.P_CAPTURA.GUARDAR_FILA_FORMULARIO" datasource="DS_CVU">
	            <cfprocparam value="#pkFila#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkColumna#" cfsqltype="cf_sql_numeric" type="in">
				<cfprocparam value="#valor#" cfsqltype="cf_sql_string" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: SGS
    --->
    <cffunction name="pkFormatoReporte" hint="obtiene el pk del formato del reporte">
        <cfargument name="formato" type="numeric" required="yes" hint="pk del formato">
		<cfquery  name="respuesta" datasource="DS_CVU" >
            SELECT  TFR.TFR_FK_CFORMATO AS PK_FORMATO
  			  FROM  CVU.EVTTFORMATO TFR
 			 WHERE  TFR.TFR_PK_FORMATO = #formato#
        </cfquery>
        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: SGS
    --->
    <cffunction name="crearFilaNueva" hint="crea una fila para el reporte que se esta llenando">
        <cfargument name="formato" type="numeric" required="yes" hint="pk del formato">
        <cfargument name="reporte" type="numeric" required="yes" hint="pk del reporte">
        <cfargument name="fkUsuario" type="numeric" required="yes" hint="pk del usuario">
		<cfstoredproc procedure="CVU.P_CAPTURA.GUARDAR_FILA" datasource="DS_CVU">
	            <cfprocparam value="#formato#" cfsqltype="cf_sql_numeric" type="in">
				<cfprocparam value="#reporte#" cfsqltype="cf_sql_numeric" type="in">
				<cfprocparam value="#fkUsuario#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: SGS
    --->
    <cffunction name="crearCelda" hint="crea las celdas de la fila nueva">
        <cfargument name="filaNueva" type="numeric" required="yes" hint="pk de la fila creada">
        <cfargument name="pkColumna" type="numeric" required="yes" hint="pk de la columna">
        <cfargument name="formato" type="numeric" required="yes" hint="pk del formato">
		<cfstoredproc procedure="CVU.P_CAPTURA.CREAR_CELDA" datasource="DS_CVU">
	            <cfprocparam value="#filaNueva#" cfsqltype="cf_sql_numeric" type="in"> 
				<cfprocparam value="#pkColumna#" cfsqltype="cf_sql_numeric" type="in">
				<cfprocparam value="#formato#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: SGS
    --->
    <cffunction name="eliminarFilaFormulario" hint="elimina una fila para el reporte que se esta llenando">
        <cfargument name="pkFila" type="numeric" required="yes" hint="pk de la fila">
			<cfstoredproc procedure="CVU.P_CAPTURA.ELIMINAR_FILA_FORMULARIO" datasource="DS_CVU">
				<cfprocparam value="#pkFila#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

    <!-- definicion del cubo -->

    <!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getFormatosValidados" hint="">
   		<cfargument name="pkUsuario">
		<cfquery  name="resultado" datasource="DS_CVU" >
		    
		    SELECT  CFT.CFT_NOMBRE      AS NOMBRE,
                    TFT.TFR_PK_FORMATO  AS PK,
                    CFT.CFT_CLAVE       AS CLAVE,        
                    TFT.TFR_VERSION     AS VERSION,            
					TFT.TFR_FK_CESTADO	AS CESESTADO,
					TFT.TFR_RUTA		AS CESRUTA
   			  FROM  CVU.EVTCFORMATO    CFT,
                    CVU.EVTTFORMATO    TFT
                    <cfif pkusuario neq ''>
                    	,CVU.EVTRUSUARIOFORMATO UFT
					</cfif>
             WHERE  CFT.CFT_PK_FORMATO = TFT.TFR_FK_CFORMATO
             		AND TFT.TFR_FK_CESTADO = #application.SIIIP_CTES.FORMATO.VALIDADO# --ESTADO VALIDADO DE LA RUTA 1
             		<cfif pkusuario neq ''>
                    	AND TFT.TFR_PK_FORMATO = UFT.TRU_FK_FORMATO
                    	AND UFT.TRU_FK_USUARIO = #pkUsuario#
					</cfif>
		  
			UNION

			SELECT  CFT.CFT_NOMBRE      AS NOMBRE,
			        TFT.TFR_PK_FORMATO  AS PK,
			        CFT.CFT_CLAVE       AS CLAVE,        
			        TFT.TFR_VERSION     AS VERSION,            
			        TFT.TFR_FK_CESTADO	AS CESESTADO,
			        TFT.TFR_RUTA		AS CESRUTA
			FROM    CVU.EVTTASOCIACIONFORMATO FMTASOC,
			        CVU.EVTCFORMATO CFT,
			        CVU.EVTTFORMATO TFT
			        <cfif pkusuario neq ''>
                    	,CVU.EVTRUSUARIOFORMATO UFT
					</cfif>
			WHERE   FMTASOC.TAR_FK_ASOCIADO = TFT.TFR_PK_FORMATO
			        AND TFT.TFR_FK_CFORMATO = CFT.CFT_PK_FORMATO
			        <cfif pkusuario neq ''>
                    	AND TFT.TFR_PK_FORMATO = UFT.TRU_FK_FORMATO
                    	AND UFT.TRU_FK_USUARIO = #pkUsuario#
					</cfif>
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="getInfoCubo" hint="Obtiene el nombre y prefijo del cubo">
   		<cfargument name="pkCubo" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU" >
		    SELECT  CUBO.CCB_NOMBRE AS NOMBRECUBO,
                    CUBO.CCB_PREFIJO AS PREFIJO,
                    CUBO.CCB_CREADO AS CREADO
   			  FROM  CVU.BITCCUBO CUBO
             WHERE  CUBO.CCB_PK_CUBO = #pkCubo#
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->         
   	<cffunction name="getHechos" hint="Obtiene los hechos">
   		<cfargument name="pkCubo" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU" >
		    SELECT  HEC.CHC_PK_HECHO AS PKHECHO,
                    HEC.CHC_NOMBRE   AS NOMBREHECHO
   			  FROM  CVU.BITCHECHO HEC
             WHERE  HEC.CHC_ESTADO > 0
             		AND HEC.CHC_FK_CUBO = #pkCubo#
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->         
   	<cffunction name="getDimensiones" hint="Obtiene las dimensiones">
		<cfquery  name="resultado" datasource="DS_CVU" >
		    SELECT  DIM.CDM_PK_DIMENSION AS PKDIMENSION,
                    DIM.CDM_NOMBRE       AS NOMBREDIMENSION
   			  FROM  CVU.BITTDIMENSION DIM
             WHERE  DIM.CDM_ESTADO > 0
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->         
   	<cffunction name="getDimensionesAsociadas" hint="Obtiene las dimensiones">
   		<cfargument name="pkCubo" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU" >
		    SELECT  DIM.CDM_PK_DIMENSION AS PKDIMENSION,
                    DIM.CDM_NOMBRE       AS NOMBREDIMENSION
   			  FROM  CVU.BITTDIMENSION DIM,
                    CVU.BITTCUBODIMENSION CUBDIM
             WHERE  CUBDIM.TCD_FK_DIMENSION = DIM.CDM_PK_DIMENSION
             	AND CUBDIM.TCD_FK_CUBO = #pkCubo#
			    AND CUBDIM.TCD_FK_ESTADO > 0
			    AND DIM.CDM_ESTADO > 0
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="getClasificacion" hint="Obtiene las clasificaciones">
		<cfquery  name="resultado" datasource="DS_CVU" >
			SELECT  CLA.CCC_PK_CATCLASIFICACION AS PKCLASIF,
                    CLA.CCC_NOMBRE              AS NOMBRECLASIF
   			  FROM  CVU.CLACCLASIFICACION CLA
             WHERE  CLA.CCC_ESTADO > 0
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
	<cffunction name="getPkCubo" hint="Obtiene los cubos relacionados a un formato">
		<cfargument name="pkFormato" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT CUBFMT.RCF_FK_CUBO AS PKCUBO,
			       CUBO.CCB_NOMBRE    AS NOMBRECUBO,
			       CUBO.CCB_PREFIJO   AS PREFCUBO
			FROM   CVU.BITRCUBOFORMATO CUBFMT,
			       CVU.BITCCUBO CUBO
			WHERE  CUBFMT.RCF_FK_CUBO = CUBO.CCB_PK_CUBO
			       AND CUBFMT.RCF_FK_FORMATO = #pkFormato#
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="guardaHecho" hint="Guarda hechos">
        <cfargument name="nombreHecho" type="string" required="yes">
        <cfargument name="tipoHecho"   type="string" required="yes">
        <cfargument name="pkCubo"      type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.GUARDA_HECHOS" datasource="DS_CVU">
	            <cfprocparam value="#nombreHecho#" cfsqltype="cf_sql_string" type="in">
	            <cfprocparam value="#tipoHecho#"   cfsqltype="cf_sql_string" type="in">
	            <cfprocparam value="#pkCubo#"      cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="guardaDimension" hint="Guarda dimensiones">
        <cfargument name="nombreDimen"  type="string" required="yes">
        <cfargument name="prefijoDimen" type="string" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.GUARDA_DIMENSIONES" datasource="DS_CVU">
	            <cfprocparam value="#nombreDimen#"  cfsqltype="cf_sql_string" type="in">
	            <cfprocparam value="#prefijoDimen#" cfsqltype="cf_sql_string" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="guardaColDim" hint="Guarda dimensiones">
        <cfargument name="nombreCol" type="string" required="yes">
        <cfargument name="tipoCol"   type="string" required="yes">
        <cfargument name="descrCol"  type="string" required="yes">
        <cfargument name="pkDimens"  type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.GUARDA_COLUMNA_DIMENSION" datasource="DS_CVU">
	            <cfprocparam value="#nombreCol#" cfsqltype="cf_sql_string" type="in">
	            <cfprocparam value="#tipoCol#"   cfsqltype="cf_sql_string" type="in">
	            <cfprocparam value="#descrCol#"  cfsqltype="cf_sql_string" type="in">
	            <cfprocparam value="#pkDimens#"  cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="guardaCubo" hint="Registra cubo">
        <cfargument name="nombreCubo"  type="string" required="yes">
        <cfargument name="prefijoCubo" type="string" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.GUARDA_CUBO" datasource="DS_CVU">
	            <cfprocparam value="#nombreCubo#"  cfsqltype="cf_sql_string" type="in">
	            <cfprocparam value="#prefijoCubo#" cfsqltype="cf_sql_string" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="existeClasificacion" hint="Verifica si existe clasificacion">
        <cfargument name="pkFormato"  type="string" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.EXISTE_CLASIFICACION" datasource="DS_CVU">
	            <cfprocparam value="#pkFormato#"  cfsqltype="cf_sql_string" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="getcolumasDimension" hint="Obtiene las clasificaciones">
   		<cfargument name="pkDimension"  type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT  COLDIM.TCL_PK_COLUMNA AS PKCOL,
                    COLDIM.TCL_NOMBRE     AS NOMCOL
   			  FROM  CVU.BITTCOLUMNA COLDIM
             WHERE  COLDIM.TCL_FK_DIMENSION = #pkDimension#
			   AND COLDIM.TCL_ESTADO > 0
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="asociaColumnaHecho" hint="Asociacion entre columna y hecho">
        <cfargument name="pkColumna" type="numeric" required="yes">
        <cfargument name="pkHecho"   type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.ASOCIA_COLUMN_HECHO" datasource="DS_CVU">
	            <cfprocparam value="#pkColumna#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkHecho#"   cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>



	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="asociaCuboDimension" hint="Asociacion entre cubo y dimension">
        <cfargument name="pkCubo"      type="numeric" required="yes">
        <cfargument name="pkDimension" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.ASOCIA_CUBO_DIM" datasource="DS_CVU">
	            <cfprocparam value="#pkCubo#"      cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkDimension#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="asociaDimensionColumnas" hint="Asociacion entre columnas y clasificacion">
        <cfargument name="pkColFmt"  type="numeric" required="yes">
        <cfargument name="pkColumna" type="numeric" required="yes">
        <cfargument name="pkClasif"  type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.ASOCIA_COLDIM_COLFMT" datasource="DS_CVU">
	            <cfprocparam value="#pkColFmt#"  cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkColumna#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkClasif#"  cfsqltype="cf_sql_numeric" type="in">	
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="asociaFormatoCubo" hint="Asociacion entre un formato y un cubo">
        <cfargument name="pkFormato" type="numeric" required="yes">
        <cfargument name="pkCubo"    type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.ASOCIA_FMT_CUBO" datasource="DS_CVU">
	            <cfprocparam value="#pkFormato#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkCubo#"    cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="getConfigDimenColumna" hint="Obtiene la ascociacion de una columna">
   		<cfargument name="pkColumna" type="numeric" required="yes">
   		<cfargument name="pkCubo"    type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT  DIM.CDM_PK_DIMENSION  AS PKDIM,
                    COLDIM.TCL_PK_COLUMNA AS PKCOL,
                    CLASIF.CCC_PK_CATCLASIFICACION AS PKCLASIF,
                    RELCOLMS.RDC_PK_CLASIFICACION AS PKDIMCOLS
   			  FROM  CVU.BITTDIMENSION DIM,
   			  		CVU.BITTCOLUMNA   COLDIM,
   			  		CVU.CLACCLASIFICACION CLASIF,
   			  		CVU.BITTCUBODIMENSION CUBODIM,
   			        CVU.CLARDIMENSIONCOLUMNA RELCOLMS,
                    CVU.BITCCUBO CUBO
             WHERE  RELCOLMS.RDC_FK_COLUMNAD = COLDIM.TCL_PK_COLUMNA
                    AND COLDIM.TCL_FK_DIMENSION = DIM.CDM_PK_DIMENSION
                    AND RELCOLMS.RDC_FK_CATCLASIFICACION = CLASIF.CCC_PK_CATCLASIFICACION
                    AND RELCOLMS.RDC_FK_COLUMNA = #pkColumna#
                    AND CUBODIM.TCD_FK_DIMENSION = DIM.CDM_PK_DIMENSION
                    AND CUBODIM.TCD_FK_CUBO = CUBO.CCB_PK_CUBO
                    AND CUBO.CCB_PK_CUBO = #pkCubo#
					AND RELCOLMS.RDC_FK_ESTADO > 0
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="getConfigHechoColumna" hint="Obtiene la ascociacion de una columna">
   		<cfargument name="pkColumna"  type="numeric" required="yes">
   		<cfargument name="pkCubo"     type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT  HECHO.CHC_PK_HECHO AS PKHECHO,
                    HECOL.RHC_PK_HECHOCOLUMNA AS PKCOLHEC
   			  FROM  CVU.CLARHECHOCOLUMNA HECOL,
                    CVU.BITCHECHO HECHO,
                    CVU.BITCCUBO CUBO
             WHERE  HECOL.RHC_FK_COLUMNA = #pkColumna#
                    AND HECOL.RHC_FK_HECHO = HECHO.CHC_PK_HECHO
                    AND HECHO.CHC_FK_CUBO = CUBO.CCB_PK_CUBO
                    AND CUBO.CCB_PK_CUBO = #pkCubo#
					AND HECOL.RHC_FK_ESTADO > 0
		</cfquery>
		<cfreturn resultado>
	</cffunction>

	<!---
    * Fecha : Marzo 2017
    * author : Ana Belem Juarez Mendez
	--->
   	<cffunction name="existeColumnaHecho" hint="Verifica si existe la relacion columna hecho">
   		<cfargument name="pkColumna" type="numeric" required="yes">
	    <cfargument name="pkHecho" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT RHC.RHC_FK_COLUMNA AS COLUMNA
			FROM   CVU.CLARHECHOCOLUMNA RHC
			WHERE  RHC.RHC_FK_COLUMNA = #pkColumna#
			  AND  RHC.RHC_FK_HECHO = #pkHecho#
			  AND RHC.RHC_FK_ESTADO > 0
			GROUP BY RHC.RHC_FK_COLUMNA
		</cfquery>
		<cfreturn resultado>
	</cffunction>

	<!---
    * Fecha : Marzo 2017
    * author : Ana Belem Juarez Mendez
	--->
   	<cffunction name="existeColumnaDimension" hint="Verifica si existe la relacion columna dimension">
   		<cfargument name="pkColumna" type="numeric" required="yes">
	    <cfargument name="pkColDim" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT RDC.RDC_FK_COLUMNA AS COLUMNA
			FROM   CVU.CLARDIMENSIONCOLUMNA RDC
			WHERE  RDC.RDC_FK_COLUMNA = #pkColumna#
			  AND  RDC.RDC_FK_COLUMNAD = #pkColDim#
			  AND RDC.RDC_FK_ESTADO > 0
		</cfquery>
		<cfreturn resultado>
	</cffunction>

	<!---
    * Fecha : Marzo 2017
    * author : Ana Belem Juarez Mendez
	--->
   	<cffunction name="existeFormatoCubo" hint="Verifica si existe la relacion formato cubo">
   		<cfargument name="pkFormato" type="numeric" required="yes">
	    <cfargument name="pkCubo" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT RCF.RCF_FK_FORMATO AS FORM
			FROM   CVU.BITRCUBOFORMATO RCF
			WHERE  RCF.RCF_FK_FORMATO = #pkFormato#
			  AND  RCF.RCF_FK_CUBO = #pkCubo#
			  AND  RCF.RCF_ESTADO > 0
		</cfquery>
		<cfreturn resultado>
	</cffunction>

	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="existeAsociacionColumnaHecho" hint="Verifica si existe una asociacion entre una columna y un hecho">
   		<cfargument name="pkColumna" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT HECCOL.RHC_PK_HECHOCOLUMNA AS PKHECOL,
				   HECCOL.RHC_FK_HECHO AS PKHECHO
			FROM   CVU.CLARHECHOCOLUMNA HECCOL
			WHERE  HECCOL.RHC_FK_COLUMNA = #pkColumna#
			  AND HECCOL.RHC_FK_ESTADO > 0
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="existeAsociacionColumnaDimension" hint="Verifica si existe una asociacion entre una columna y una dimension">
   		<cfargument name="pkColumna"   type="numeric" required="yes">
   		<cfargument name="pkCubo"      type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
		SELECT  DISTINCT DIMEN.CDM_PK_DIMENSION AS PKDIMEN,
				DIMCOL.RDC_FK_CATCLASIFICACION AS PKCLASIF,
        		DIMCOL.RDC_FK_COLUMNAD AS PKCOLDIM
		  FROM  CVU.BITTCUBODIMENSION CUBDIM,
		        CVU.BITTDIMENSION DIMEN,
		        CVU.CLARDIMENSIONCOLUMNA DIMCOL,
		        CVU.BITTCOLUMNA COLNA
		 WHERE  CUBDIM.TCD_FK_CUBO = #pkCubo#
		        AND DIMEN.CDM_PK_DIMENSION = COLNA.TCL_FK_DIMENSION
		        AND COLNA.TCL_PK_COLUMNA = DIMCOL.RDC_FK_COLUMNAD
		        AND DIMCOL.RDC_FK_COLUMNA = #pkColumna#
		        AND DIMCOL.RDC_FK_ESTADO > 0
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="actualizaRelHecho" hint="Actualiza relacion entre una columna y un hecho">
        <cfargument name="pkHecho" type="numeric" required="yes">
        <cfargument name="pkHecoColumna" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.ACTUALIZA_REL_HECHO" datasource="DS_CVU">
	            <cfprocparam value="#pkHecho#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkHecoColumna#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="actualizaRelDimension" hint="Actualiza el registro de una columna asociada a una dimension">
        <cfargument name="pkCubo"      type="numeric" required="yes">
        <cfargument name="pkColDim"    type="numeric" required="yes">
        <cfargument name="pkClasif"    type="numeric" required="yes">
        <cfargument name="pkRelCols"   type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.ACTUALIZA_REL_DIMEN" datasource="DS_CVU">
	        	<cfprocparam value="#pkCubo#"      cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkColDim#"    cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkClasif#"    cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkRelCols#"   cfsqltype="cf_sql_numeric" type="in">	
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="consultaRelCuboDimen" hint="Consulta la relacion entre un cubo y una dimension">
        <cfargument name="pkCubo"      type="numeric" required="yes">
        <cfargument name="pkDimension" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.CONSULTA_REL_CUBO_DIMEN" datasource="DS_CVU">
	        	<cfprocparam value="#pkCubo#"      cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkDimension#" cfsqltype="cf_sql_numeric" type="in">	
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="validaCubo" hint="Establece como creado el registro del cubo.">
        <cfargument name="pkCubo" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.VALIDA_CUBO" datasource="DS_CVU">
	        	<cfprocparam value="#pkCubo#" cfsqltype="cf_sql_numeric" type="in">	
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="asociaDimensionCubo" hint="Asocia una dimension con el cubo">
        <cfargument name="pkDimension" type="numeric" required="yes">
        <cfargument name="pkCubo" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.ASOCIA_DIMENSION_CUBO" datasource="DS_CVU">
	            <cfprocparam value="#pkDimension#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkCubo#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="getNombreFormato" hint="Obtiene el nombre de un formato">
   		<cfargument name="pkformato" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT CAT.CFT_NOMBRE AS NOMBREFMT
			FROM   CVU.EVTTFORMATO FMT,
			       CVU.EVTCFORMATO CAT
			WHERE  FMT.TFR_FK_CFORMATO = CAT.CFT_PK_FORMATO
			       AND FMT.TFR_PK_FORMATO = #pkformato#
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
	<cffunction name="getCubos" hint="Obtiene los cubos existentes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT CUBO.CCB_PK_CUBO PKCUBO,
			       CUBO.CCB_NOMBRE NOMBRECUBO,
			       CUBO.CCB_PREFIJO PREFCUBO
			FROM   CVU.BITCCUBO CUBO
			WHERE  CUBO.CCB_ESTADO > 0
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
	<cffunction name="getClasificaciones" hint="Obtiene las clasificaciones">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT CUBO.CCB_PK_CUBO   AS PKCUBO,
			       CUBO.CCB_NOMBRE    AS NOMBRECUBO,
			       CUBO.CCB_PREFIJO   AS PREFIJOCUBO,
			       FMT.TFR_PK_FORMATO AS PKFORMATO,
			       CATFMT.CFT_NOMBRE  AS NOMBREFORMATO,
			       CATFMT.CFT_CLAVE   AS CLAVEFORMATO
			FROM   CVU.BITRCUBOFORMATO CUBFMT,
			       CVU.EVTCFORMATO CATFMT,
			       CVU.EVTTFORMATO FMT,
			       CVU.BITCCUBO    CUBO
			WHERE  CUBFMT.RCF_FK_CUBO = CUBO.CCB_PK_CUBO
			       AND CUBFMT.RCF_FK_FORMATO = FMT.TFR_PK_FORMATO
			       AND FMT.TFR_FK_CFORMATO = CATFMT.CFT_PK_FORMATO
			ORDER BY NOMBRECUBO
		</cfquery>
		<cfreturn resultado>
	</cffunction>

  <!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez Mendez
	--->
   	<cffunction name="existeAsociacionColumna" hint="Verifica si la columna esta asociada">
   		<cfargument name="pkColumna" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT RDC.RDC_PK_CLASIFICACION PKCLASIF
			FROM   CVU.CLARDIMENSIONCOLUMNA RDC,
	   			   CVU.BITTCOLUMNA TCL
		    WHERE  RDC.RDC_FK_COLUMNAD = TCL.TCL_PK_COLUMNA 
  			  AND TCL.TCL_PK_COLUMNA = #pkColumna#
			  AND RDC.RDC_FK_ESTADO > 0
		</cfquery>
		<cfreturn resultado>
	</cffunction>

  <!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez Mendez
	--->
   	<cffunction name="existeAsociacionDimension" hint="Verifica si la dimensión esta asociada">
		<cfargument name="pkCubo" type="numeric" required="yes">
   		<cfargument name="pkDimension" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT RDC.RDC_PK_CLASIFICACION PKCLASIF
			FROM   CVU.CLARDIMENSIONCOLUMNA RDC,
			       CVU.BITTCOLUMNA TCL,
			       CVU.BITRCUBOFORMATO RCF,
			       CVU.EVTTCOLUMNA TCA
			WHERE (RDC.RDC_FK_COLUMNA = TCA.TCL_PK_COLUMNA AND RDC.RDC_FK_COLUMNAD = TCL.TCL_PK_COLUMNA )
			  AND TCA.TCL_FK_FORMATO = RCF.RCF_FK_FORMATO
			  AND RCF.RCF_FK_CUBO = #pkCubo#  
			  AND TCL.TCL_FK_DIMENSION = #pkDimension#
			  AND RDC.RDC_FK_ESTADO > 0
		</cfquery>
		<cfreturn resultado>
	</cffunction>

  <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="existeAsociacionHecho" hint="Verifica si el hecho esta asociado">
   		<cfargument name="pkHecho" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT HECOL.RHC_PK_HECHOCOLUMNA PKHECOL
			FROM   CVU.CLARHECHOCOLUMNA HECOL
			WHERE  HECOL.RHC_FK_HECHO = #pkHecho#
		</cfquery>
		<cfreturn resultado>
	</cffunction>

	<!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez Mendez
	--->
    <cffunction name="eliminarColumna" hint="Elimina una columna de una dimensión">
   	   <cfargument name="pkColumna" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.ELIMINA_COLUMNA" datasource="DS_CVU">
	            <cfprocparam value="#pkColumna#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

	<!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez Mendez
	--->
    <cffunction name="desasociarHecho" hint="Desasocia una columna y un hecho">
        <cfargument name="pkHecoColumna" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.DESASOCIAR_HECHO" datasource="DS_CVU">	
	            <cfprocparam value="#pkHecoColumna#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

  <!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez Mendez
	--->
    <cffunction name="desasociarDimension" hint="Actualiza el registro de una columna asociada a una dimension">
        <cfargument name="pkRelCols"   type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.DESASOCIAR_DIMEN" datasource="DS_CVU">
	            <cfprocparam value="#pkRelCols#"   cfsqltype="cf_sql_numeric" type="in">	
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


	<!---
    * Fecha : Mayo 2017
    * author : Ana Belem Juarez Mendez
	--->
    <cffunction name="desasociarCuboDimension" hint="Desasocia una dimensión con un cubo">
       <cfargument name="pkCubo" type="numeric" required="yes">
   	   <cfargument name="pkDimension" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.DESASOCIA_CUBO_DIM" datasource="DS_CVU">
	            <cfprocparam value="#pkCubo#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkDimension#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="cambiaEstadoHecho" hint="Cambia a 0 el estado del hecho">
        <cfargument name="pkHecho" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CLASIFICACION_ENCABEZADO.CAMBIA_EDO_HECHO" datasource="DS_CVU">
	            <cfprocparam value="#pkHecho#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha : Abril 2017
    * author : Ana Belem Juárez M				
		Recibe 1 si el pre analisis fue exitoso y 0 si no lo fue.
	--->

 <!---
    * Fecha : Abril 2017
    * author : Ana Belem Juárez M				
		
	--->
 <cffunction name="getAnalisisAutomatico" hint="Obtiene el pre analisis del formato.">
    	<cfargument name="pkCubo"    type="numeric" required="yes">
        <cfargument name="pkFormato" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_ANALISIS_AUTOMATICO.P_ANALISIS" datasource="DS_CVU">
	            <cfprocparam value="#pkCubo#"    cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkFormato#" cfsqltype="cf_sql_numeric" type="in">	        
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_string" type="out">		
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


  
<!---
    * Fecha : Abril 2017
    * author : Ana Belem Juárez M				
		Recibe 1 si el analisis fue exitoso y 0 si no lo fue.
	--->
    <cffunction name="updateAnalisisAutomatico" hint="Obtiene el pre analisis del formato.">
    	<cfargument name="pkCubo"    type="numeric" required="yes">
        <cfargument name="pkColumna" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_ANALISIS_AUTOMATICO.P_UPDATE" datasource="DS_CVU">
	            <cfprocparam value="#pkCubo#"    cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkColumna#" cfsqltype="cf_sql_numeric" type="in">	        
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_string" type="out">		
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="getPreview" hint="Obtiene la vista previa de los datos del cubo.">
    	<cfargument name="pkCubo"    type="numeric" required="yes">
        <cfargument name="pkFormato" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_EXTRACCION_FORMATOS.CREAR_QUERY" datasource="DS_CVU">
	            <cfprocparam value="#pkCubo#"    cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkFormato#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="1" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_string" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
   	<cffunction name="consultaPreview" hint="Verifica si el hecho esta asociado">
   		<cfargument name="consulta" type="string" required="yes">
   		<cfscript>
   			var registros = structNew();
   			var resultado = ejecutaConsulta(consulta);
   			registros.resultado = resultado;
   			registros.columnas  = ListToArray(resultado.columnList);
		</cfscript>
		<cfreturn registros>
	</cffunction>


	<!---
  	* Fecha : 16 de febrero de 2017
  	* Autor : Alejandro Rosales
  	--->
  	<cffunction name="ejecutaConsulta" access="remote" hint="retorno de una query">
	  	<cfargument name="consulta" type="string" required="yes">  
	   	<cfscript>
	      	excQuery = new query();
	      	excQuery.setDatasource("DS_CVU");
	      	excQuery.setName("datos");
	      	var resultado = excQuery.execute(sql=consulta).getResult();
	      	return resultado;
	   	</cfscript> 
   </cffunction>


   <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="creaVistaBD" hint="Obtiene la vista previa de los datos del cubo.">
    	<cfargument name="pkCubo"    type="numeric" required="yes">
       
	        <cfstoredproc procedure="CVU.P_EXTRACCION_FORMATOS.CREAR_VISTA_GENERAL" datasource="DS_CVU">
	            <cfprocparam value="#pkCubo#"    cfsqltype="cf_sql_numeric" type="in">	           
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_string" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha creación: Marzo de 2017
    * @author: SGS
    ---> 
    <cffunction name="cargarNota" hint="obtiene la nota del reporte seleccionado">
		<cfargument name="formato" type="numeric" required="yes" hint="pk del formato">
        <cfargument name="periodo" type="numeric" required="yes" hint="periodo del formato">
        <cfargument name="reporte" type="numeric" required="yes" hint="pk del reporte">
		<cfquery  name="respuesta" datasource="DS_CVU" >
            SELECT  TRP.TRP_NOTA AS NOTA
  			  FROM  CVU.EVTTREPORTE TRP
 			 WHERE  TRP.TRP_PK_REPORTE = #reporte#
 			 		AND TRP.TRP_FK_PERIODO = #periodo#
 			 		AND TRP.TRP_FK_FORMATO = #formato#
        </cfquery>
        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: SGS
    ---> 
	<cffunction name="guardarNota" hint="edita la nota del reporte seleccionado">
		<cfargument name="formato" type="numeric" required="yes" hint="pk del formato">
        <cfargument name="periodo" type="numeric" required="yes" hint="periodo del formato">
        <cfargument name="reporte" type="numeric" required="yes" hint="pk del reporte">
        <cfargument name="nota" type="string" required="yes" hint="nota del reporte">
			<cfstoredproc procedure="CVU.P_CAPTURA.GUARDAR_NOTA_REPORTE" datasource="DS_CVU">
	            <cfprocparam value="#formato#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#periodo#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#reporte#" cfsqltype="cf_sql_numeric" type="in">
				<cfprocparam value="#nota#" cfsqltype="cf_sql_string" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>




    <!-- REPLICA DE CLASIFICACION -->

    <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
	<cffunction name="getFmtsAsocByCont" hint="Obtiene los formatos asociados con respecto al formato contenedor">
		<cfargument name="pkFormato" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT DISTINCT FMTASOC.TAR_FK_ASOCIADO
            FROM   CVU.EVTTASOCIACIONFORMATO FMTASOC
            WHERE  FMTASOC.TAR_FK_ORIGEN <> FMTASOC.TAR_FK_ASOCIADO
            	   AND FMTASOC.TAR_FK_ORIGEN = #pkFormato#
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
	<cffunction name="getColsFmtCont" hint="Obtiene los formatos asociados con respecto al formato contenedor">
		<cfargument name="pkFormato" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT COLUMNA.TCL_PK_COLUMNA AS COLSFMT
            FROM   CVU.EVTTCOLUMNA COLUMNA
            WHERE  COLUMNA.TCL_FK_FORMATO = #pkFormato#
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!-- MODIFICACION ASOCIACION DE FORMATOS -->

	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
	<cffunction name="existenAsociaciones" hint="Verifica si hay columnas asociadas del formato contenedor">
		<cfargument name="pkFormato" type="numeric" required="yes">
		<cfquery  name="resultado" datasource="DS_CVU">
			SELECT COUNT(COLASOC.TAC_PK_ASOCIACIONCOLUMNA) AS ASOCIADAS
			FROM   CVU.EVTTASOCIACIONCOLUMNA COLASOC,
			       CVU.EVTTCOLUMNA COL
			WHERE  COL.TCL_PK_COLUMNA = COLASOC.TAC_FK_ORIGEN
			       AND COLASOC.TAC_FK_FORMATO > 0
			       AND COL.TCL_FK_FORMATO = #pkFormato#
		</cfquery>
		<cfreturn resultado>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->  
    <cffunction name="getColumnasByFormato" access="public" hint="Obtiene las columnas correspondientes a un formato">
    	<cfargument name="pkFormato">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT COLUMNA.TCL_PK_COLUMNA AS PKCOLUMNA
			FROM   CVU.EVTTCOLUMNA  COLUMNA
			WHERE  COLUMNA.TCL_FK_FORMATO = #pkFormato#
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>  


    <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="cambiaEdoAsocColumns" access="remote" hint="Cambia a 0 el estado de la asociacion de las columnas">
		<cfargument name="pkColOrigen"   type="numeric" required="yes" hint="pk de la columna origen">
        <cfargument name="pkColAsociada" type="numeric" required="yes" hint="pk de la columna asociada">
        <cfargument name="pkFormato"     type="numeric" required="yes" hint="pk del formato">
	        <cfstoredproc procedure="CVU.P_REPORTES.CAMBIA_ESTADO_ASOCIACION" datasource="DS_CVU">
	            <cfprocparam value="#pkColOrigen#"   cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkColAsociada#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkFormato#"     cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="cargaMetadatos" hint="Hace la carga de metadatos.">
    	<cfargument name="pkCubo" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_METADATOS.CARGAR_CUBO" datasource="DS_CVU">
	            <cfprocparam value="#pkCubo#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="resetClasifiacion" hint="Resetea clasificaciones de los formatos">
    	<cfargument name="pkNombreAsociacion" type="numeric" required="yes">
    	<cfargument name="pkPlantilla" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_REPORTES.RESET_CLASIFICACIONES" datasource="DS_CVU">
	            <cfprocparam value="#pkNombreAsociacion#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam value="#pkPlantilla#" cfsqltype="cf_sql_numeric" type="in">	
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_string" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Septiembre 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="getTfidf" hint="calcula el tf-idf de mision vision y objetivo">
    	<cfargument name="formato" type="numeric" required="yes">
	        <cfstoredproc procedure="CVU.P_CONTADOR_PALABRAS.CONTAR_PALABRAS_FORMATO" datasource="DS_CVU">
	            <cfprocparam value="#formato#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha  : Octubre 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="registrarArchivo" hint="Guarda un registro del archivo que se subió al FTP">
        <cfargument name="pkCFormato" hint="Pk del catalogo del archivo">
        <cfargument name="pkColumna"  hint="Pk de la columna">
        <cfargument name="pkFila"     hint="Pk de la fila">
        <cfargument name="filename"   hint="nombre del archivo">
        <cfscript>
            spArchivo = new storedproc();
            spArchivo.setDatasource("DS_CVU");
            spArchivo.setProcedure("P_CAPTURA.GUARDA_NOMBRE_ARCHIVO");
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkCFormato);
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkColumna);
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkFila);
            spArchivo.addParam(cfsqltype="cf_sql_varchar", type="in", value=filename);
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="out", variable="resultado");
            result = spArchivo.execute();
            var success = result.getprocOutVariables().resultado;
            return success;
        </cfscript>
    </cffunction>


    <!---
	* Fecha : Octubre del 2017
	* Autor : Alejandro Tovar
	--->
	<cffunction name="consultarNombreArchivo" hint="Obtiene el nombre de un archivo">
		<cfargument name="pkCFormato" hint="Pk del catalogo del archivo">
        <cfargument name="pkColumna"  hint="Pk de la columna">
        <cfargument name="pkFila"     hint="Pk de la fila">
		<cfquery name="qFileName" datasource="DS_CVU">
			SELECT 	ARCH.TCE_VALOR AS NOMBRE
			  FROM 	EVTTCELDA ARCH
			 WHERE  ARCH.TCE_FK_FORMATO = #pkCFormato#
               AND 	ARCH.TCE_FK_COLUMNA = #pkColumna#
               AND 	ARCH.TCE_FK_FILA    = #pkFila#
		</cfquery>
		<cfreturn qFileName>
	</cffunction>

	<!---
    	* Fecha: Octubre del 2017
	* Autor : Alejandro Tovar
	---> 
	<cffunction name="getNodosHoja" hint="">
		<cfargument name="pkProducto">
		<cfquery  name="res" datasource="DS_CVU" >
			SELECT 	CPD_PK_CPRODUCTO 	AS PRODUCTO, 
					CPD_FK_REPORTE 		AS REPORTE, 
					RPT.TRP_FK_FORMATO 	AS FORMATO, 
					RPT.TRP_FK_PERIODO	AS PERIODO,
					PRODUCTOS.RUTAPRODUCTOS
			FROM(SELECT CPD_FK_REPORTE, 
			    		SYS_CONNECT_BY_PATH(CPD_CPRODUCTO, '$$') AS RUTAPRODUCTOS, 
			    		CPD_PK_CPRODUCTO 
			      FROM  CVUCCPRODUCTO
			    start WITH CPD_PK_CPRODUCTO 	 = #pkProducto#
			    CONNECT BY NOCYCLE  CPD_FK_PADRE = prior CPD_PK_CPRODUCTO  
			    ORDER BY level,CPD_PK_CPRODUCTO) PRODUCTOS,
				CVU.EVTTREPORTE RPT
			WHERE PRODUCTOS.CPD_FK_REPORTE IS NOT NULL
              AND PRODUCTOS.CPD_FK_REPORTE = RPT.TRP_PK_REPORTE
		</cfquery>
		<cfreturn res>
	</cffunction>


	<cffunction name="getNodosHojaEDI" hint="">
		<cfargument name="pkProducto">
		<cfquery  name="res" datasource="DS_CVU" >
			SELECT 	DISTINCT CPD_PK_CPRODUCTO 	AS PRODUCTO, 
			        CPD_FK_REPORTE 		AS REPORTE, 
			        RPT.TRP_FK_FORMATO 	AS FORMATO, 
			        RPT.TRP_FK_PERIODO	AS PERIODO,
			        PRODUCTOS.RUTAPRODUCTOS
			FROM(SELECT CPD_FK_REPORTE, 
			            SYS_CONNECT_BY_PATH(CPD_CPRODUCTO, '$$') AS RUTAPRODUCTOS, 
			            CPD_PK_CPRODUCTO 
				  FROM  CVUCCPRODUCTO
				  WHERE CPD_PK_CPRODUCTO <> 126
			    start WITH CPD_PK_CPRODUCTO 	 = <cfqueryparam value="#pkProducto#" cfsqltype="cf_sql_numeric">
			    CONNECT BY NOCYCLE  CPD_FK_PADRE = prior CPD_PK_CPRODUCTO  
			    ORDER BY level,CPD_PK_CPRODUCTO) PRODUCTOS,
			    CVU.EVTTREPORTE RPT,
			    CVU.CVUCTPRODUCTOPERSONA TPP,
			    EDI.EDITEVALUACIONPRODUCTOEDI TPE
			WHERE PRODUCTOS.CPD_FK_REPORTE IS NOT NULL
			AND PRODUCTOS.CPD_PK_CPRODUCTO = TPP.TPP_FK_CPRODUCTO
			AND TPP.TPP_PK_TPRODUCTOPERSONA = TPE.TEP_FK_CVUCCPRODUCTOPERSONA
			AND PRODUCTOS.CPD_FK_REPORTE = RPT.TRP_PK_REPORTE
			AND TPE.TEP_FK_ESTADO > 0
		</cfquery>
		<cfreturn res>
	</cffunction>

	
	<cffunction name="getNodosHojaCVU" hint="">
		<cfargument name="pkProducto">		
		<cfquery  name="res" datasource="DS_CVU" >
			SELECT 	DISTINCT CPD_PK_CPRODUCTO 	AS PRODUCTO, 
			        CPD_FK_REPORTE 		AS REPORTE, 
			        RPT.TRP_FK_FORMATO 	AS FORMATO, 
			        RPT.TRP_FK_PERIODO	AS PERIODO,
			        PRODUCTOS.RUTAPRODUCTOS
			FROM(SELECT CPD_FK_REPORTE, 
			            SYS_CONNECT_BY_PATH(CPD_CPRODUCTO, '$$') AS RUTAPRODUCTOS, 
			            CPD_PK_CPRODUCTO 
				  FROM  CVUCCPRODUCTO				  
			    start WITH CPD_PK_CPRODUCTO 	 = <cfqueryparam value="#pkProducto#" cfsqltype="cf_sql_numeric">
			    CONNECT BY NOCYCLE  CPD_FK_PADRE = prior CPD_PK_CPRODUCTO  
			    ORDER BY level,CPD_PK_CPRODUCTO) PRODUCTOS,
			    CVU.EVTTREPORTE RPT,
			    CVU.CVUCTPRODUCTOPERSONA TPP,
			    EDI.EDITEVALUACIONPRODUCTOEDI TPE
			WHERE PRODUCTOS.CPD_FK_REPORTE IS NOT NULL
			AND PRODUCTOS.CPD_PK_CPRODUCTO = TPP.TPP_FK_CPRODUCTO
			AND TPP.TPP_PK_TPRODUCTOPERSONA = TPE.TEP_FK_CVUCCPRODUCTOPERSONA
			AND PRODUCTOS.CPD_FK_REPORTE = RPT.TRP_PK_REPORTE
			AND TPE.TEP_FK_ESTADO > 0
		</cfquery>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha:	Noviembre de 2107
    * Autor:	Roberto Cadena
	---> 
	<cffunction name="getNodosAllHoja" hint="">
		<cfargument name="pkProducto" type="array">
		<cfquery  name="res" datasource="DS_CVU" >
			SELECT 	CPD_PK_CPRODUCTO 	AS PRODUCTO, 
					CPD_FK_REPORTE 		AS REPORTE, 
					RPT.TRP_FK_FORMATO 	AS FORMATO, 
					RPT.TRP_FK_PERIODO	AS PERIODO,
					PRODUCTOS.RUTAPRODUCTOS
			FROM(
				<cfloop index="i" from="1" to="#arrayLen(pkProducto)#">
					<cfif i NEQ 1>
						UNION
					</cfif>
					SELECT CPD_FK_REPORTE, 
				    		SYS_CONNECT_BY_PATH(CPD_CPRODUCTO, '$$') AS RUTAPRODUCTOS, 
				    		CPD_PK_CPRODUCTO 
				      FROM  CVUCCPRODUCTO
				    start WITH CPD_PK_CPRODUCTO 	 = #pkProducto[i]#
				    CONNECT BY NOCYCLE  CPD_FK_PADRE = prior CPD_PK_CPRODUCTO
				</cfloop>
			    ) PRODUCTOS,
				CVU.EVTTREPORTE RPT
		WHERE PRODUCTOS.CPD_FK_REPORTE IS NOT NULL
             AND PRODUCTOS.CPD_FK_REPORTE = RPT.TRP_PK_REPORTE
			 AND 	CPD_PK_CPRODUCTO <> 126
		</cfquery>
		<cfreturn res>
	</cffunction>
	
	<!---
    * Fecha:	Noviembre de 2107
    * Autor:	
	---> 
	<cffunction name="getNodosAllHojabyPKUsuario" hint="">
		<cfargument name="pkProducto" type="array">
		<cfargument name="pkusuario" type="numeric">
		<cfquery  name="res" datasource="DS_CVU" >
			SELECT 	/*+ ORDERED */CPD_PK_CPRODUCTO 	AS PRODUCTO, 
					CPD_FK_REPORTE 		AS REPORTE, 
					RPT.TRP_FK_FORMATO 	AS FORMATO, 
					RPT.TRP_FK_PERIODO	AS PERIODO,
					PRODUCTOS.RUTAPRODUCTOS
			FROM(
				<cfloop index="i" from="1" to="#arrayLen(pkProducto)#">
					<cfif i NEQ 1>
						UNION
					</cfif>
					SELECT CPD_FK_REPORTE, 
				    		SYS_CONNECT_BY_PATH(CPD_CPRODUCTO, '$$') AS RUTAPRODUCTOS, 
				    		CPD_PK_CPRODUCTO 
				      FROM  CVUCCPRODUCTO
				    start WITH CPD_PK_CPRODUCTO 	 = #pkProducto[i]#
				    CONNECT BY NOCYCLE  CPD_FK_PADRE = prior CPD_PK_CPRODUCTO
				</cfloop>
			    ) PRODUCTOS,
				CVU.EVTTREPORTE RPT,
				CVU.EVTTFILA TFL,
		         CVU.CVUCTPRODUCTOPERSONA TPP,
		         EDI.EDITEVALUACIONPRODUCTOEDI TPE
		WHERE RPT.TRP_PK_REPORTE = TFL.TFF_FK_REPORTE
         	AND TFL.TFF_FK_USUARIO = <cfqueryparam value="#arguments.pkusuario#" cfsqltype="cf_sql_numeric">
			AND PRODUCTOS.CPD_FK_REPORTE IS NOT NULL
             AND PRODUCTOS.CPD_FK_REPORTE = RPT.TRP_PK_REPORTE
	         AND TFL.TFF_PK_FILA = TPP.TPP_FK_FILA
	         AND TPP.TPP_PK_TPRODUCTOPERSONA = TPE.TEP_FK_CVUCCPRODUCTOPERSONA
	         
	         AND TPE.TEP_FK_PROCESO IN (/*OBTIENE LOS PKS DE LOS PROCESOS QUE PUEDEN TENER PRODUCTOS QUE PARTICIPAN EN EL PROCESO ACTUAL*/
								               SELECT 	TCC.TPR_PK_PROCESO
									         	 FROM  	EDI.EDITPROCESO  TCC,
									            		EDI.EDITPROCESO  TCC2
									         	WHERE 	TCC2.TPR_FK_ESTADO = 2  /*TODO:OBTENER EL PK DEL PROCESO */
									                AND TCC.TPR_ANIO_EVAL_FIN <= TCC2.TPR_ANIO_EVAL_FIN AND TCC.TPR_ANIO_EVAL_FIN >= TCC2.TPR_ANIO_EVAL_INICIO
	                                )
			 AND 	CPD_PK_CPRODUCTO <> 126
	         AND TFL.TFF_ESTADO = 2
			 GROUP BY CPD_PK_CPRODUCTO, 
					CPD_FK_REPORTE, 
					RPT.TRP_FK_FORMATO, 
					RPT.TRP_FK_PERIODO,
					PRODUCTOS.RUTAPRODUCTOS
		</cfquery>
		<cfreturn res>
		
	</cffunction>
	

	<cffunction name="getAllNodosPadres" hint="">
		<cfquery  name="res" datasource="DS_CVU" >
			SELECT   CPD_PK_CPRODUCTO AS PKPRODUCTO
			 FROM	CVUCCPRODUCTO
			WHERE	CPD_FK_PADRE IS NULL
			 AND	CPD_ESTADO = 2
		</cfquery>
		<cfreturn res>
	</cffunction>

	<!---
    * Fecha : Diciembre 2016
    * author : Marco Torres
	--->        
   	<cffunction name="getRespuestasbyProducto" hint="query con las celdas del formato">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkUsuario">
		<cfargument name="pkProducto">
		<cfquery  name="res" datasource="DS_CVU" >
	       SELECT   TCE.TCE_PK_CELDA     AS PKCELDA,
                    TCE.TCE_VALOR        AS valorcelda,
                    TFL.TFF_PK_FILA      AS PK_FILA,
                    TCE.TCE_FK_COLUMNA   AS PK_COLUMNA,
			        CPD.CPD_NUMEROPRODUCTO AS NUM,
                    TPP_EVALUADO          AS TPP_EVALUADO,
                    TPP.TPP_PK_PRODUCTOTEMP  AS PRODUCTO_ELIMINAR
	         FROM   CVU.EVTTFORMATO    TFR,
                    CVU.EVTTREPORTE    TRE,
                    CVU.EVTTCELDA      TCE,
                    CVU.EVTTFILA       TFL,
			        CVU.CVUCCPRODUCTO 			CPD,
         			CVU.CVUCTPRODUCTOPERSONA TPP
	        WHERE   TFR.TFR_PK_FORMATO = TRE.TRP_FK_FORMATO
                    AND TRE.TRP_PK_REPORTE = TFL.TFF_FK_REPORTE
                    AND TCE.TCE_FK_FILA = TFL.TFF_PK_FILA
					AND TFL.TFF_ESTADO > 0
					AND TPP.TPP_ESTADO > 0
			        AND TPP.TPP_FK_CPRODUCTO = CPD.CPD_PK_CPRODUCTO
                    AND TFR.TFR_PK_FORMATO = <cfqueryparam value="#arguments.pkTFormato#" cfsqltype="cf_sql_numeric">
                    AND TRE.TRP_FK_PERIODO = <cfqueryparam value="#arguments.pkPeriodo#" cfsqltype="cf_sql_numeric">
					AND TFL.TFF_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
					AND TCE.TCE_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
					<cfif  pkUsuario neq ''>
						AND TFL.TFF_FK_USUARIO = <cfqueryparam value="#arguments.pkUsuario#" cfsqltype="cf_sql_numeric">
					</cfif>
					AND TFL.TFF_PK_FILA = TPP.TPP_FK_FILA
					AND TPP.TPP_FK_CPRODUCTO = <cfqueryparam value="#arguments.pkProducto#" cfsqltype="cf_sql_numeric">
			ORDER BY NUM,PK_FILA desc
		</cfquery>
		<cfreturn res>
	</cffunction>

	<!---
    * Fecha:	Noviembre de 2107
    * Autor:	Roberto Cadena
	--->        
   	<cffunction name="getRespuestasbyProductoNoEvaluado" hint="query con las celdas del formato">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkUsuario">
		<cfargument name="pkProducto">
		<cfquery  name="res" datasource="DS_CVU" >
			SELECT  TCE.TCE_PK_CELDA    	AS PKCELDA,
			        TCE.TCE_VALOR       	AS valorcelda,
			        TFL.TFF_PK_FILA     	AS PK_FILA,
			        TCE.TCE_FK_COLUMNA  	AS PK_COLUMNA,
			        0                   	AS SELECCIONADO,
			        CPD.CPD_PK_CPRODUCTO	AS PKCPRODUCTO,
			        CPD.CPD_NUMEROPRODUCTO 	AS NUM,
                    TPP.TPP_PK_PRODUCTOTEMP AS PRODUCTO_ELIMINAR
			 FROM   CVU.EVTTFORMATO    			    TFR,
			        CVU.EVTTREPORTE    			    TRE,
			        CVU.EVTTCELDA      			    TCE,
			        CVU.EVTTFILA       			    TFL,
			        CVU.CVUCTPRODUCTOPERSONA 	    TPP,
			        CVU.CVUCCPRODUCTO 			    CPD
			WHERE   TFR.TFR_PK_FORMATO = TRE.TRP_FK_FORMATO
			        AND TRE.TRP_PK_REPORTE = TFL.TFF_FK_REPORTE
			        AND TCE.TCE_FK_FILA = TFL.TFF_PK_FILA
                    AND TPP.TPP_FK_CPRODUCTO = CPD.CPD_PK_CPRODUCTO
			        AND TPP.TPP_PK_TPRODUCTOPERSONA NOT IN (
			            SELECT TEP_FK_CVUCCPRODUCTOPERSONA
			             FROM EDI.EDITEVALUACIONPRODUCTOEDI
			            WHERE TEP_FK_ESTADO = 2)
			        AND TFR.TFR_PK_FORMATO = <cfqueryparam value="#arguments.pkTFormato#" cfsqltype="cf_sql_numeric">
			        AND TRE.TRP_FK_PERIODO = <cfqueryparam value="#arguments.pkPeriodo#" cfsqltype="cf_sql_numeric">
			        AND TFL.TFF_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
			        AND TCE.TCE_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
			        <cfif  pkUsuario neq ''>
			            AND TFL.TFF_FK_USUARIO = <cfqueryparam value="#arguments.pkUsuario#" cfsqltype="cf_sql_numeric">
			        </cfif>
			        AND TFL.TFF_PK_FILA = TPP.TPP_FK_FILA
			        AND TPP.TPP_FK_CPRODUCTO = <cfqueryparam value="#arguments.pkProducto#" cfsqltype="cf_sql_numeric">
			        AND TPP.TPP_EVALUADO = 0
                    AND TPP.TPP_ESTADO > 0
					AND TFL.TFF_ESTADO > 0

			UNION

			SELECT  TCE.TCE_PK_CELDA     	AS PKCELDA,
			        TCE.TCE_VALOR        	AS valorcelda,
			        TFL.TFF_PK_FILA      	AS PK_FILA,
			        TCE.TCE_FK_COLUMNA   	AS PK_COLUMNA,
			        1                    	AS SELECCIONADO,
			        CPD.CPD_PK_CPRODUCTO	AS PKCPRODUCTO,
			        CPD.CPD_NUMEROPRODUCTO 	AS NUM,
                    TPP.TPP_PK_PRODUCTOTEMP AS PRODUCTO_ELIMINAR
			 FROM   CVU.EVTTFORMATO    				TFR,
			        CVU.EVTTREPORTE    				TRE,
			        CVU.EVTTCELDA      				TCE,
			        CVU.EVTTFILA       				TFL,
			        CVU.CVUCTPRODUCTOPERSONA		TPP,
			        CVU.CVUCCPRODUCTO 				CPD,
			        EDI.EDITEVALUACIONPRODUCTOEDI 	TEP
			WHERE   TFR.TFR_PK_FORMATO = TRE.TRP_FK_FORMATO
			        AND TRE.TRP_PK_REPORTE = TFL.TFF_FK_REPORTE
			        AND TCE.TCE_FK_FILA = TFL.TFF_PK_FILA
			        AND TPP.TPP_PK_TPRODUCTOPERSONA = TEP.TEP_FK_CVUCCPRODUCTOPERSONA
                    AND TPP.TPP_FK_CPRODUCTO = CPD.CPD_PK_CPRODUCTO
			        AND TFR.TFR_PK_FORMATO = <cfqueryparam value="#arguments.pkTFormato#" cfsqltype="cf_sql_numeric">
			        AND TRE.TRP_FK_PERIODO = <cfqueryparam value="#arguments.pkPeriodo#" cfsqltype="cf_sql_numeric">
			        AND TFL.TFF_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
			        AND TCE.TCE_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
			        <cfif  pkUsuario neq ''>
			            AND TFL.TFF_FK_USUARIO = <cfqueryparam value="#arguments.pkUsuario#" cfsqltype="cf_sql_numeric">
			        </cfif>
			        AND TFL.TFF_PK_FILA = TPP.TPP_FK_FILA
			        AND TPP.TPP_FK_CPRODUCTO = <cfqueryparam value="#arguments.pkProducto#" cfsqltype="cf_sql_numeric">
			        AND TEP.TEP_FK_ESTADO = 2
					AND TPP.TPP_ESTADO > 0
					AND TFL.TFF_ESTADO > 0
			ORDER BY NUM,PK_FILA
		</cfquery>
		<cfreturn res>
	</cffunction>

    <!---
    * Fecha:    Diciembre de 2018
    * Autor:    JLGC copia de getRespuestasbyProductoNoEvaluado 
    --->        
    <cffunction name="getRespuestasbyProductosSeleccionados" hint="query con las celdas del formato">
        <cfargument name="pkCFormato">
        <cfargument name="pkTFormato">
        <cfargument name="pkPeriodo">
        <cfargument name="pkUsuario">
        <cfargument name="pkProducto">
        <cfquery  name="res" datasource="DS_CVU" >
            SELECT  TCE.TCE_PK_CELDA        AS PKCELDA,
                    TCE.TCE_VALOR           AS valorcelda,
                    TFL.TFF_PK_FILA         AS PK_FILA,
                    TCE.TCE_FK_COLUMNA      AS PK_COLUMNA,
                    CPD.CPD_PK_CPRODUCTO    AS PKCPRODUCTO,
                    CPD.CPD_NUMEROPRODUCTO  AS NUM,
                    TPP.TPP_PK_PRODUCTOTEMP AS PRODUCTO_ELIMINAR,
                    TEP.TEP_PK_EVALUACIONPRODUCTOEDI AS EVALUACIONPRODUCTOEDI,
                    TEP.TEP_FK_PROCESO AS PROCESO,
                    NVL((SELECT TEE.TEE_FK_ESTADO 
                           FROM EDI.EDITEVALUACIONETAPA TEE
                          WHERE TEE_FK_EVALUACIONPRODUCTOEDI = TEP.TEP_PK_EVALUACIONPRODUCTOEDI
                            AND TEE.TEE_FK_EVALUACIONTIPO    = 4
							AND TEE.TEE_FK_ESTADO            > 0), 0) AS SELECCIONADOINC,
					TCL.TCL_FK_TIPOFECHA 		AS PK_TIPOFECHA,
					TCL.TCL_ISNOMBRE			AS ISNOMBRE,
					TPE.TPE_PK_TPRODUCTOEDI		AS PKTPRODUCTOEDI,					
					TPE.TPE_CLASIFICACION       AS CLASIFICACION,
					TPE.TPE_CLASIFICACION_ROMANO AS CLASIFICACION_ROMANO,
					TPE.TPE_SUBCLASIFICACION    AS SUBCLASIFICACION,
					TPE.TPE_SUBCLASIFICACION_ROMANO AS SUBCLASIFICACION_ROMANO,
					TPE.TPE_PUNTUACION          AS MAX_PUNTUACION,
					TPE.TPE_MAXIMOPRODUCTOS     AS MAX_PRODUCTOS					
             FROM   CVU.EVTTFORMATO                 TFR,
                    CVU.EVTTREPORTE                 TRE,
                    CVU.EVTTCELDA                   TCE,
                    CVU.EVTTFILA                    TFL,
                    CVU.CVUCTPRODUCTOPERSONA        TPP,
					CVU.CVUCCPRODUCTO               CPD,
					CVU.EVTTCOLUMNA 				TCL,
					EDI.EDITEVALUACIONPRODUCTOEDI   TEP,
					EDI.EDITPRODUCTOEDI             TPE
			WHERE   TFR.TFR_PK_FORMATO = TRE.TRP_FK_FORMATO
					AND	TPE.TPE_PK_TPRODUCTOEDI = TEP.TEP_FK_TPRODUCTOEDI
					AND TCL.TCL_PK_COLUMNA = TCE.TCE_FK_COLUMNA
                    AND TRE.TRP_PK_REPORTE = TFL.TFF_FK_REPORTE
                    AND TCE.TCE_FK_FILA = TFL.TFF_PK_FILA
                    AND TPP.TPP_PK_TPRODUCTOPERSONA = TEP.TEP_FK_CVUCCPRODUCTOPERSONA
                    AND TPP.TPP_FK_CPRODUCTO = CPD.CPD_PK_CPRODUCTO
                    AND TFR.TFR_PK_FORMATO = <cfqueryparam value="#arguments.pkTFormato#" cfsqltype="cf_sql_numeric">
                    AND TRE.TRP_FK_PERIODO = <cfqueryparam value="#arguments.pkPeriodo#" cfsqltype="cf_sql_numeric">
                    AND TFL.TFF_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
                    AND TCE.TCE_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
                    <cfif  pkUsuario neq ''>
                        AND TFL.TFF_FK_USUARIO = <cfqueryparam value="#arguments.pkUsuario#" cfsqltype="cf_sql_numeric">
                    </cfif>
                    AND TFL.TFF_PK_FILA = TPP.TPP_FK_FILA
                    AND TPP.TPP_FK_CPRODUCTO = <cfqueryparam value="#arguments.pkProducto#" cfsqltype="cf_sql_numeric">
                    AND TEP.TEP_FK_ESTADO = 2
                    AND TPP.TPP_ESTADO > 0
                    AND TFL.TFF_ESTADO > 0
            ORDER BY NUM,PK_FILA
        </cfquery>
		
        <cfreturn res>
    </cffunction>

    <cffunction name="getEstadoEtapaEval" hint="query con las celdas del formato">
        <cfargument name="fkProdEdi">
        <cfquery  name="res" datasource="DS_CVU" >
           
            SELECT TEE.TEE_FK_ESTADO 
              FROM EDI.EDITEVALUACIONETAPA TEE
             WHERE TEE_FK_EVALUACIONPRODUCTOEDI = <cfqueryparam value="#arguments.fkProdEdi#" cfsqltype="cf_sql_numeric">
               AND TEE.TEE_FK_EVALUACIONTIPO    = 4
               AND TEE.TEE_FK_ESTADO            > 0
            
        </cfquery>
        <cfreturn res>
    </cffunction>
	
	<cffunction name="getDatosProductos" hint="obtiene la clasificacion y subclasificacion de los productos">
		<cfargument name="pkProducto">
		<cfquery name="resultado" datasource="DS_EDI">
			SELECT  TPE_CLASIFICACION       AS CLASIFICACION,
					TPE_SUBCLASIFICACION    AS SUBCLASIFICACION,
					TPE_PUNTUACION          AS MAX_PUNTUACION,
					TPE_MAXIMOPRODUCTOS     AS MAX_PRODUCTOS,
			        CPD.CPD_CPRODUCTO       AS PRODUCTO
			 FROM   EDI.EDICPRODUCTOEDI     CPE,
			        EDI.EDITPRODUCTOEDI     TPE,
			        CVU.CVUCCPRODUCTO       CPD
			WHERE   CPE.CPE_PK_CPRODUCTOEDI = TPE.TPE_FK_CPRODUCTOEDI
			 AND    CPD.CPD_PK_CPRODUCTO 	= CPE.CPE_FK_CVUCPRODUCTO
			 AND    CPE_FK_CVUCPRODUCTO 	= <cfqueryparam value="#arguments.pkProducto#" cfsqltype="cf_sql_numeric">
		</cfquery>
		<cfreturn resultado>
	</cffunction> 

	<!---
    * Fecha : Noviembre 2017
    * author : Daniel Memije
	--->        
   	<cffunction name="getRespuestasbyProductoEDI" hint="query con las celdas del formato">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkUsuario">
		<cfargument name="pkProducto">
		<cfargument name="pkEvaluador">
		<cfquery  name="res" datasource="DS_CVU" >
			SELECT  TCE.TCE_PK_CELDA     	AS PKCELDA,
					TFL.TFF_FK_USUARIO,
			        TCE.TCE_VALOR        	AS valorcelda,
			        TFL.TFF_PK_FILA      	AS PK_FILA,
			        TCE.TCE_FK_COLUMNA   	AS PK_COLUMNA,
			        1                    	AS SELECCIONADO,
			        CPD.CPD_PK_CPRODUCTO	AS PKCPRODUCTO,
			        CPD.CPD_NUMEROPRODUCTO 	AS NUM,
					TPP.TPP_PK_PRODUCTOTEMP         AS PRODUCTO_ELIMINAR,
					TPE.TPE_PK_TPRODUCTOEDI		AS PKTPRODUCTOEDI,
					TPE.TPE_CLASIFICACION       AS CLASIFICACION,
					TPE.TPE_CLASIFICACION_ROMANO AS CLASIFICACION_ROMANO,
					TPE.TPE_SUBCLASIFICACION    AS SUBCLASIFICACION,
					TPE.TPE_SUBCLASIFICACION_ROMANO AS SUBCLASIFICACION_ROMANO,
					TEP.TEP_PK_EVALUACIONPRODUCTOEDI AS EVALUACIONPRODUCTOEDI,
					TEP.TEP_FK_CESTADO AS CESTADO_EVALUACION,
					TEP.TEP_FK_PROCESO AS PROCESO,
					TCL.TCL_FK_TIPOFECHA 		AS PK_TIPOFECHA,
					TCL.TCL_ISNOMBRE			AS ISNOMBRE,
					TEP.TEP_PK_EVALUACIONPRODUCTOEDI AS PK_EVALUACION, 
                    TEE.TEE_PK_EVALUACIONETAPA 	AS PK_EVALUACIONETAPA, 
                    TEE.TEE_FECHACAPTURA 		AS FECHA_CAPTURA, 
                    TEE.TEE_PUNTAJE_OBTENIDO 	AS PUNTAJE_OBTENIDO, 
                    TEE.TEE_FK_RECLASIFICACION 	AS FK_RECLASIFICACION, 
                    TEE.TEE_FK_EVALUADOR 		AS FK_EVALUADOR, 
                    TEE.TEE_FK_EVALUACIONTIPO 	AS FK_TIPO_EVALUACION, 
                    TEE.TEE_FK_ESTADO 			AS ESTADO_EVALUACION, 
                    TEE.TEE_COMENTARIO_EVAL 		AS COMENT_EVAL, 
                    TPE.TPE_FK_PUNTUACIONTIPO 	AS TIPO_PUNTUACION, 
                    TPE.TPE_PUNTUACION 			AS PUNTUACION_MAXIMA, 
                    TEP.TEP_FK_CESTADO 			AS CESESTADO, 
                    TEP.TEP_FK_CRUTA 			AS CESRUTA, 
                    TET.CET_ACC_CVE 				AS CVETIPO, 
                    TEE.TEE_FK_SINCALIFICAR 		AS SINCALIFICAR,
                    TET.CET_NOMBRE 					AS NOMBRE_TIPO_EVALUACION, 
       				TET.CET_PK_EVALUACIONTIPO 		AS PK_TIPO_EVALUACION, 
       				RECLA.TPE_CLASIFICACION 			AS REC_CLASIFICACION, 
       				RECLA.TPE_CLASIFICACION_ROMANO 		AS REC_CLASIFICACION_ROMANO, 
       				RECLA.TPE_SUBCLASIFICACION 			AS REC_SUBCLASIFICACION, 
       				RECLA.TPE_SUBCLASIFICACION_ROMANO 	AS REC_SUBCLASIFICACION_ROMANO, 
       				RECLA.TPE_PUNTUACION 				AS REC_PUNTAJE,
         			RECLA.TPE_PUNTUACION 				AS REC_PUNTMAX,
         			RECLA.TPE_FK_PUNTUACIONTIPO 		AS REC_TIPOPUNTUACION,
					S.TNC_MOTIVO 					AS MOTIVO
       				
			 FROM   CVU.EVTTFORMATO    				TFR,
			        CVU.EVTTREPORTE    				TRE,
			        CVU.EVTTCELDA      				TCE,
			        CVU.EVTTFILA       				TFL,
			        CVU.CVUCTPRODUCTOPERSONA		TPP,
			        CVU.CVUCCPRODUCTO 				CPD,
					EDI.EDITEVALUACIONPRODUCTOEDI   TEP,
					EDI.EDITPRODUCTOEDI             TPE,
					CVU.EVTTCOLUMNA 				TCL,
					EDI.EDITPRODUCTOEDI					RECLA,
					EDI.EDITEVALUACIONETAPA             TEE,
					EDI.EDICEVALUACIONTIPO TET,
					EDI.EDICPRODUCTONOCALIFICADO S		
			WHERE   TFR.TFR_PK_FORMATO = TRE.TRP_FK_FORMATO
					AND TCL.TCL_PK_COLUMNA = TCE.TCE_FK_COLUMNA
					AND	TPE.TPE_PK_TPRODUCTOEDI = TEP.TEP_FK_TPRODUCTOEDI
			        AND TRE.TRP_PK_REPORTE = TFL.TFF_FK_REPORTE
			        AND TCE.TCE_FK_FILA = TFL.TFF_PK_FILA
			        AND TPP.TPP_PK_TPRODUCTOPERSONA = TEP.TEP_FK_CVUCCPRODUCTOPERSONA
			        AND TPP.TPP_FK_CPRODUCTO = CPD.CPD_PK_CPRODUCTO
			        AND TEE.TEE_FK_EVALUACIONPRODUCTOEDI(+) = TEP.TEP_PK_EVALUACIONPRODUCTOEDI
			        AND TEE.TEE_FK_RECLASIFICACION = RECLA.TPE_PK_TPRODUCTOEDI(+)
			        AND TEE.TEE_FK_EVALUACIONTIPO = TET.CET_PK_EVALUACIONTIPO(+)
			        AND TEE.TEE_FK_SINCALIFICAR = S.TNC_PK_MOTIVO(+)
			        AND TFR.TFR_PK_FORMATO = <cfqueryparam value="#arguments.pkTFormato#" cfsqltype="cf_sql_numeric">
			        AND TRE.TRP_FK_PERIODO = <cfqueryparam value="#arguments.pkPeriodo#" cfsqltype="cf_sql_numeric">
			        AND TFL.TFF_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
			        AND TCE.TCE_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
			        <cfif  pkUsuario neq ''>
			            AND TFL.TFF_FK_USUARIO = <cfqueryparam value="#arguments.pkUsuario#" cfsqltype="cf_sql_numeric">
			        </cfif>
			        AND TFL.TFF_PK_FILA = TPP.TPP_FK_FILA
			        AND TPP.TPP_FK_CPRODUCTO = <cfqueryparam value="#arguments.pkProducto#" cfsqltype="cf_sql_numeric">

					AND TEP.TEP_FK_ESTADO = 2
					AND TPP.TPP_ESTADO > 0
					AND TFL.TFF_ESTADO > 0
					AND TEE.TEE_FK_ESTADO(+) > 0
			ORDER BY TEP_FK_PROCESO,PK_FILA,PK_COLUMNA,FK_TIPO_EVALUACION
			</cfquery>
		<cfreturn res>
	</cffunction>	

	<!---
    * Fecha : Noviembre 2017
    * author : Daniel Memije
	--->        	
	<cffunction name="getRespuestasbyProductoCVU" hint="query con las celdas del formato">
		<cfargument name="pkCFormato">
		<cfargument name="pkTFormato">
		<cfargument name="pkPeriodo">
		<cfargument name="pkUsuario">
		<cfargument name="pkProducto">
		<cfquery  name="res" datasource="DS_CVU" >
			SELECT  TCE.TCE_PK_CELDA     	AS PKCELDA,
					TCE.TCE_VALOR        	AS valorcelda,
					TFL.TFF_PK_FILA      	AS PK_FILA,
					TCE.TCE_FK_COLUMNA   	AS PK_COLUMNA,
					1                    	AS SELECCIONADO,
					CPD.CPD_PK_CPRODUCTO	AS PKCPRODUCTO,
					CPD.CPD_NUMEROPRODUCTO 	AS NUM,
					TPP.TPP_PK_PRODUCTOTEMP         AS PRODUCTO_ELIMINAR					
			FROM    CVU.EVTTFORMATO    				TFR,
					CVU.EVTTREPORTE    				TRE,
					CVU.EVTTCELDA      				TCE,
					CVU.EVTTFILA       				TFL,
					CVU.CVUCTPRODUCTOPERSONA		TPP,
					CVU.CVUCCPRODUCTO 				CPD					
			WHERE   TFR.TFR_PK_FORMATO = TRE.TRP_FK_FORMATO
					AND TRE.TRP_PK_REPORTE = TFL.TFF_FK_REPORTE
					AND TCE.TCE_FK_FILA = TFL.TFF_PK_FILA					
					AND TPP.TPP_FK_CPRODUCTO = CPD.CPD_PK_CPRODUCTO
					AND TFR.TFR_PK_FORMATO = <cfqueryparam value="#arguments.pkTFormato#" cfsqltype="cf_sql_numeric">
					AND TRE.TRP_FK_PERIODO = <cfqueryparam value="#arguments.pkPeriodo#" cfsqltype="cf_sql_numeric">
					AND TFL.TFF_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
					AND TCE.TCE_FK_FORMATO = <cfqueryparam value="#arguments.pkCFormato#" cfsqltype="cf_sql_numeric">
					<cfif  pkUsuario neq ''>
						AND TFL.TFF_FK_USUARIO = <cfqueryparam value="#arguments.pkUsuario#" cfsqltype="cf_sql_numeric">
					</cfif>
					AND TFL.TFF_PK_FILA = TPP.TPP_FK_FILA
					AND TPP.TPP_FK_CPRODUCTO = <cfqueryparam value="#arguments.pkProducto#" cfsqltype="cf_sql_numeric">					
					AND TPP.TPP_ESTADO > 0
					AND TFL.TFF_ESTADO > 0
			ORDER BY PK_FILA,PK_COLUMNA
		</cfquery>
		<cfreturn res>
	</cffunction>


	<!---
    * Fecha  : Octubre 2017
    * author : Alejandro Tovar
	--->
    <cffunction name="relacionaProdPersona" hint="Guarda un registro del archivo que se subió al FTP">
        <cfargument name="pkReporte" type="numeric" required="yes" hint="pk del reporte">
        <cfargument name="pkFila" 	 type="numeric" required="yes" hint="pk de la fila">
        <cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
        <cfscript>
            spArchivo = new storedproc();
            spArchivo.setDatasource("DS_CVU");
            spArchivo.setProcedure("P_CAPTURA.RELACIONA_PRODUCTO_PERSONA");
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkReporte);
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkFila);
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkPersona);
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="out", variable="resultado");
            result = spArchivo.execute();
            var success = result.getprocOutVariables().resultado;
            return success;
        </cfscript>
    </cffunction>

    <!---
    * Fecha : Noviembre 2017
    * author : Daniel Memije
		--->        
   	<cffunction name="getEtapasEvaluacionByFila" hint="Obtiene las etapas de evaluacion con la fila">
		<cfargument name="pkFila">		
		<cfquery  name="res" datasource="DS_EDI">
			SELECT  Q.*,
					CET.CET_NOMBRE 				AS NOMBRE_TIPO_EVALUACION,
					CET.CET_PK_EVALUACIONTIPO 	AS PK_TIPO_EVALUACION,
					R.TPE_CLASIFICACION 		AS REC_CLASIFICACION,
					R.TPE_CLASIFICACION_ROMANO	AS REC_CLASIFICACION_ROMANO,					
					R.TPE_SUBCLASIFICACION 		AS REC_SUBCLASIFICACION,
					R.TPE_SUBCLASIFICACION_ROMANO AS REC_SUBCLASIFICACION_ROMANO,					
					R.TPE_PUNTUACION 			AS REC_PUNTAJE
			FROM    EDI.EDICEVALUACIONTIPO CET
			FULL OUTER JOIN
					(
					SELECT  TEP.TEP_PK_EVALUACIONPRODUCTOEDI AS PK_EVALUACION,
							TEE.TEE_PK_EVALUACIONETAPA 		 AS PK_EVALUACIONETAPA,
							TEE.TEE_FECHACAPTURA 			 AS FECHA_CAPTURA,
							TEE.TEE_PUNTAJE_OBTENIDO 		 AS PUNTAJE_OBTENIDO,
							TEE.TEE_FK_RECLASIFICACION 		 AS FK_RECLASIFICACION,
							TEE.TEE_FK_EVALUADOR 			 AS FK_EVALUADOR,
							TEE.TEE_FK_EVALUACIONTIPO 		 AS FK_TIPO_EVALUACION,
							TEE.TEE_FK_ESTADO 				 AS ESTADO_EVALUACION,
							TPE.TPE_FK_PUNTUACIONTIPO 		 AS TIPO_PUNTUACION,
							TPE.TPE_PUNTUACION 				 AS PUNTUACION_MAXIMA,
							TEP.TEP_FK_CESTADO 				 AS CESESTADO,
							TEP.TEP_FK_CRUTA   				 AS CESRUTA,
							TET.CET_ACC_CVE 				 AS CVETIPO,
              TEE.TEE_COMENTARIO_EVAL 		 AS COMENT_EVAL
					FROM    EDI.EDITEVALUACIONETAPA 		TEE,
							EDI.EDITEVALUACIONPRODUCTOEDI	TEP,
							CVU.CVUCTPRODUCTOPERSONA 		TPP,
							EDI.EDITPRODUCTOEDI 			TPE,
							EDI.EDICEVALUACIONTIPO 			TET
					WHERE   TEP.TEP_PK_EVALUACIONPRODUCTOEDI = TEE.TEE_FK_EVALUACIONPRODUCTOEDI
					AND     TPP.TPP_PK_TPRODUCTOPERSONA 	 = TEP.TEP_FK_CVUCCPRODUCTOPERSONA
					AND     TEP.TEP_FK_TPRODUCTOEDI 		 = TPE.TPE_PK_TPRODUCTOEDI
					AND     TEE.TEE_FK_ESTADO > 0
					AND     TEP.TEP_FK_ESTADO > 0
					AND     TPP.TPP_FK_FILA 			= <cfqueryparam value="#arguments.pkFila#" cfsqltype="cf_sql_numeric">					
					AND     TEE.TEE_FK_EVALUACIONTIPO	= TET.CET_PK_EVALUACIONTIPO) Q
			ON      Q.FK_TIPO_EVALUACION = CET.CET_PK_EVALUACIONTIPO
			FULL OUTER JOIN
			EDI.EDITPRODUCTOEDI R
			ON Q.FK_RECLASIFICACION = R.TPE_PK_TPRODUCTOEDI
			WHERE   CET.CET_FK_ESTADO > 0	
			ORDER BY CET.CET_PK_EVALUACIONTIPO
		</cfquery>
		<cfreturn res>
	</cffunction>


	<!---
    * Fecha : Enero 2018
    * author: Alejandro Tovar
	--->
   	<cffunction name="getEtapasEvaluacionByFilaAndPkUsuario" hint="Obtiene las etapas de evaluacion con la fila por usuario">
		<cfargument name="pkFila">
		<cfargument name="pkUsuario">
		<cfquery  name="res" datasource="DS_EDI">
			SELECT 	Q.*, 
       				CET.CET_NOMBRE 					AS NOMBRE_TIPO_EVALUACION, 
       				CET.CET_PK_EVALUACIONTIPO 		AS PK_TIPO_EVALUACION, 
       				R.TPE_CLASIFICACION 			AS REC_CLASIFICACION, 
       				R.TPE_CLASIFICACION_ROMANO 		AS REC_CLASIFICACION_ROMANO, 
       				R.TPE_SUBCLASIFICACION 			AS REC_SUBCLASIFICACION, 
       				R.TPE_SUBCLASIFICACION_ROMANO 	AS REC_SUBCLASIFICACION_ROMANO, 
       				R.TPE_PUNTUACION 				AS REC_PUNTAJE, 
       				S.TNC_MOTIVO 					AS MOTIVO,
         			R.TPE_PUNTUACION 				AS REC_PUNTMAX,
         			R.TPE_FK_PUNTUACIONTIPO 		AS REC_TIPOPUNTUACION
  			FROM EDI.EDICEVALUACIONTIPO CET 
       			FULL OUTER JOIN (SELECT TEP.TEP_PK_EVALUACIONPRODUCTOEDI AS PK_EVALUACION, 
                               TEE.TEE_PK_EVALUACIONETAPA 	AS PK_EVALUACIONETAPA, 
                               TEE.TEE_FECHACAPTURA 		AS FECHA_CAPTURA, 
                               TEE.TEE_PUNTAJE_OBTENIDO 	AS PUNTAJE_OBTENIDO, 
                               TEE.TEE_FK_RECLASIFICACION 	AS FK_RECLASIFICACION, 
                               TEE.TEE_FK_EVALUADOR 		AS FK_EVALUADOR, 
                               TEE.TEE_FK_EVALUACIONTIPO 	AS FK_TIPO_EVALUACION, 
                               TEE.TEE_FK_ESTADO 			AS ESTADO_EVALUACION, 
                               TEE.TEE_COMENTARIO_EVAL 		AS COMENT_EVAL, 
                               TPE.TPE_FK_PUNTUACIONTIPO 	AS TIPO_PUNTUACION, 
                               TPE.TPE_PUNTUACION 			AS PUNTUACION_MAXIMA, 
                               TEP.TEP_FK_CESTADO 			AS CESESTADO, 
                               TEP.TEP_FK_CRUTA 			AS CESRUTA, 
                               TET.CET_ACC_CVE 				AS CVETIPO, 
                               TEE.TEE_FK_SINCALIFICAR 		AS SINCALIFICAR 
                          FROM EDI.EDITEVALUACIONETAPA TEE 
                               INNER JOIN EDI.EDITEVALUACIONPRODUCTOEDI TEP 
                                  ON TEP.TEP_PK_EVALUACIONPRODUCTOEDI = TEE.TEE_FK_EVALUACIONPRODUCTOEDI 
                               INNER JOIN CVU.CVUCTPRODUCTOPERSONA TPP 
                                  ON TPP.TPP_PK_TPRODUCTOPERSONA = TEP.TEP_FK_CVUCCPRODUCTOPERSONA 
                               INNER JOIN EDI.EDITPRODUCTOEDI TPE
                                  ON TEP.TEP_FK_TPRODUCTOEDI = TPE.TPE_PK_TPRODUCTOEDI
                               INNER JOIN EDI.EDICEVALUACIONTIPO TET
                                  ON TEE.TEE_FK_EVALUACIONTIPO = TET.CET_PK_EVALUACIONTIPO
                         WHERE TEE.TEE_FK_ESTADO 	> 0
                           AND TEP.TEP_FK_ESTADO 	> 0
                           AND TPP.TPP_FK_FILA 		= <cfqueryparam value="#arguments.pkFila#" cfsqltype="cf_sql_numeric"> 
                           AND TEE.TEE_FK_EVALUADOR = <cfqueryparam value="#arguments.pkUsuario#" cfsqltype="cf_sql_numeric">) Q 
			         ON Q.FK_TIPO_EVALUACION = CET.CET_PK_EVALUACIONTIPO
			       FULL OUTER JOIN EDI.EDITPRODUCTOEDI R
			         ON Q.FK_RECLASIFICACION = R.TPE_PK_TPRODUCTOEDI
			       FULL OUTER JOIN EDI.EDICPRODUCTONOCALIFICADO S
			         ON Q.SINCALIFICAR = S.TNC_PK_MOTIVO
			 WHERE CET.CET_FK_ESTADO > 0
			 ORDER BY CET.CET_PK_EVALUACIONTIPO
		</cfquery>
		
		<cfreturn res>
	</cffunction>

	    <!---
    * Fecha creación: DIC de 2017
    * @author: ABJM
    --->
    <cffunction name="actualizarEstadoFila" hint="actualiza el estado de una fila">
        <cfargument name="pkFila" type="numeric" required="yes" hint="pk de la fila">
        <cfargument name="estado" type="numeric" required="yes" hint="estado de la fila">
		<cfstoredproc procedure="CVU.P_CAPTURA.ACTUALIZAR_ESTADO_FILA" datasource="DS_CVU">
	            <cfprocparam value="#pkFila#" cfsqltype="cf_sql_numeric" type="in">
				<cfprocparam value="#estado#" cfsqltype="cf_sql_numeric" type="in">
	            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
	        </cfstoredproc>
	        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Diciembre 2017
    * author : SGS
		--->        
   	<cffunction name="obtenerDatosPrecargados" hint="Obtiene los valores de la celdas que seran precargadas">
		<cfargument name="celda" 	type="numeric" required="yes" hint="pk de la celda">
   		<cfargument name="issn" 	type="string"  required="yes" hint="Clave issn de la revista">
   		<cfargument name="issnAnio" type="numeric" required="yes" hint="Anio de la revista">
   		<cfset nombreRevista = [113, 128, 365, 386, 409, 432, 731]>
   		<cfset anioRevista = [108, 123, 356, 377, 400, 423, 722]>
   		<cfset paisRevista = [111, 126, 366, 387, 410, 433, 732]>
   		<cfset issnRevista = [112, 127, 370, 391, 414, 437, 736]>
		<cfquery  name="respuesta" datasource="DS_CVU">
			<cfif ArrayContains(issnRevista, celda)> <!--- ISSN Nombre de la revista --->
				SELECT '#issn#' AS DATA
				FROM DUAL
			</cfif>
			<cfif ArrayContains(anioRevista, celda)> <!--- ISSN Anio de la revista --->
				SELECT '#issnAnio#' AS DATA
				FROM DUAL
			</cfif>
			<cfif ArrayContains(paisRevista, celda)> <!--- ISSN Pais de la revista --->
				SELECT CRE.CRE_DESC_PAIS AS DATA
				FROM CVU.CVUCREVISTA CRE
				WHERE CRE.CRE_ISSN = <cfqueryparam value="#arguments.issn#" cfsqltype="cf_sql_string">
			</cfif>
			<cfif ArrayContains(nombreRevista, celda)> <!--- ISSN Pais de la revista --->
				SELECT CRE.CRE_REVISTA AS DATA
				FROM CVU.CVUCREVISTA CRE
				WHERE CRE.CRE_ISSN = <cfqueryparam value="#arguments.issn#" cfsqltype="cf_sql_string">
			</cfif>
		</cfquery>
		<cfreturn respuesta>
	</cffunction>

	<!---
	* Fecha:	Enero de 2018
	* Autor:	Roberto Cadena
	---> 
	<cffunction name="eliminarProducto" hint="elimina el registro de productopersona y de fila">
		<cfargument name="pkFila" type="numeric" required="yes" hint="Pk de la fila">
			<cfstoredproc procedure="CVU.P_CAPTURA.ELIMINARPRODUCTO" datasource="DS_CVU">
				<cfprocparam value="#pkFila#"		cfsqltype="cf_sql_numeric" type="in">
				<cfprocparam variable="respuesta"	cfsqltype="cf_sql_numeric" type="out">
			</cfstoredproc>
			<cfreturn respuesta>
	</cffunction>

	<!---
	* Fecha:	Febrero de 2018
	* Autor:	Alejandro Tovar
	---> 
	<cffunction name="cambiaEstadoEvalProdEdi" hint="cambia el estado del registro en EDITEVALUACIONPRODUCTOEDI">
		<cfargument name="pkEvalProdEdi" type="numeric" required="yes" hint="Pk de EDITEVALUACIONPRODUCTOEDI">
		<cfstoredproc procedure="EDI.P_EVALUACIONEDI.CAMBIA_EDO_EVALPROEDI" datasource="DS_EDI">
			<cfprocparam value="#pkEvalProdEdi#" cfsqltype="cf_sql_numeric" type="in">
			<cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
		</cfstoredproc>
		<cfreturn respuesta>
	</cffunction>

	<!---
	* Fecha:	Febrero de 2018
	* Autor:	Daniel Memije
	---> 
	<cffunction name="getClasificacionesCVU" hint="Obtiene las clasificaciones de cvu">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT  CCP.CCP_PK_CLASIFICACIONPRODUCTO AS PK_CLASIF,
			        CCP.CCP_CLASIFICACIONPRODUCTO AS CLASIF,
			        CCP.CCP_ESTADO AS ESTADO,
			        TPE.TPE_CLASIFICACION AS CLASIF_NUM,
			        TPE.TPE_SUBCLASIFICACION AS SUBCLASIF_NUM,
			        TPE.TPE_CLASIFICACION_ROMANO AS CLASIF_NUM_ROMANO,        
			        TPE.TPE_SUBCLASIFICACION_ROMANO AS SUBCLASIF_NUM_ROMANO
			FROM    CVU.CVUCCLASIFICACIONPRODUCTO CCP,
			        EDI.EDITPRODUCTOEDI TPE
			WHERE   TPE.TPE_CLASIFICACION (+) = CCP.CCP_PK_CLASIFICACIONPRODUCTO
			AND     TPE.TPE_SUBCLASIFICACION(+) <> '01(3.05)'
			AND     TPE.TPE_SUBCLASIFICACION(+) <> '01-05'
			AND     CCP.CCP_ESTADO > 0
			ORDER BY CCP.CCP_PK_CLASIFICACIONPRODUCTO, TPE.TPE_CLASIFICACION, TPE.TPE_SUBCLASIFICACION
		</cfquery>
		<cfreturn respuesta>		
	</cffunction>
	<!---
	* Fecha:	Marzo de 2018
	* Autor:	Alejandro Rosales
	---->
	<cffunction name="eliminarComprobante" hint="Elimina un archivo">
		<cfargument name="pkformato" type="any" hint="pk del formato asociado">
		<cfargument name="pkcol" type="any" hint="pk de la columna asociada">
		<cfargument name="pkfila" type="any" hint="pk de la fila asociada">
		<cfscript>
			spArchivo = new storedproc();
            spArchivo.setDatasource("DS_CVU");
            spArchivo.setProcedure("P_CAPTURA.ELIMINA_ARCHIVO");
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkformato);
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkcol);
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="in", value=pkfila);
            spArchivo.addParam(cfsqltype="cf_sql_numeric", type="out", variable="resultado");
            result = spArchivo.execute();
            var success = result.getprocOutVariables().resultado;
            return success;
        </cfscript>
	</cffunction>

</cfcomponent>