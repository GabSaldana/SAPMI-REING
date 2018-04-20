
<cfcomponent <!--- accessors="true" singleton --->>

	
	<cffunction name="getAllPlantillas" access="public" hint="Query obtiene los nombres de las plantillas disponibles">
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT TPL_PK_TPLANTILLA 		AS PK_PLANTILLA,
			(SELECT COUNT (VARL.TPE_FK_PLANTILLA)
				FROM CVU.EVTTPLANTILLAELEMENTO VARL
				WHERE TPL_PK_TPLANTILLA = VARL.TPE_FK_PLANTILLA
				AND VARL.TPE_FK_ESTADO > 0)	AS NUMERO_COLUMNA,
			TPL_NOMBRE 						AS NOMBRE_PLANTILLA 
			FROM CVU.EVTTPLANTILLA
			WHERE TPL_FK_CESTADO > 0 
			ORDER BY TPL_NOMBRE
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>
	
	<cffunction name="setNombrePlantilla" access="public" hint="guarda el nombre de la plantilla y obtiene el pk generado.">
		<cfargument name="nombrePlantilla" type="string" required="yes" hint="" />
		<cfquery name="inserta" datasource="DS_CVU" result="resultado">
			INSERT INTO CVU.EVTTPLANTILLA EVT (
				EVT.TPL_FK_CESTADO,
				EVT.TPL_FK_RUTA,
                EVT.TPL_NOMBRE)
            VALUES (1,1,<cfqueryparam value="#arguments.nombrePlantilla#" cfsqltype="cf_sql_varchar">)
        </cfquery>
        
        <!--- Obtiene el pk del nombre de la plantilla guarda--->
         <cfquery name="consulta" datasource="DS_CVU">
            SELECT TPL_PK_TPLANTILLA AS PK_FK_UR
            FROM   CVU.EVTTPLANTILLA
            WHERE  ROWID =  <cfqueryparam value="#resultado.ROWID#" cfsqltype="cf_sql_varchar">
        </cfquery>
		<cfreturn consulta.PK_FK_UR[1]>
	</cffunction>SII

	<cffunction name="updateValorPlantilla"access="remote"hint="">
		<cfargument name="pkElemento" type="numeric" required="yes" hint="" />
		<cfargument name="valorElemento" type="string" required="yes" hint="" />
			<cfquery name="inserta" datasource="DS_CVU" >
        		UPDATE  EVTTPLANTILLAELEMENTO
				   SET 	TPE_FK_ESTADO = 1,
				  		TPE_NOMBRE = <cfqueryparam value="#arguments.valorElemento#" cfsqltype="cf_sql_varchar">
				WHERE 	TPE_PK_PLANTILLAELEMENTO = <cfqueryparam value="#arguments.pkElemento#" cfsqltype="cf_sql_varchar">		  
			</cfquery>
		<cfreturn 1 >
	</cffunction>
		
	<cffunction name="setValorePlantilla"access="remote"hint="">
		<cfargument name="pk_nombre_plantilla" type="numeric" required="yes" hint="" />
		<cfargument name="valor_plantilla" type="string" required="yes" hint="" />
			<cfquery name="inserta" datasource="DS_CVU" >       
				INSERT INTO EVTTPLANTILLAELEMENTO(TPE_FK_ESTADO, TPE_NOMBRE, TPE_FK_PLANTILLA)
				VALUES(1, <cfqueryparam value="#arguments.valor_plantilla#" cfsqltype="cf_sql_varchar">, #pk_nombre_plantilla#)
			</cfquery>

		<cfreturn 1 >
	</cffunction>
		
	<cffunction name="getPlantilla" access="public" hint="Query obtiene los valores por el pk del nombre de la plantilla seleccionada por el usuario">
		<cfargument name="pk_plantilla" type="numeric" required="yes" hint="" />
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT  TPE_NOMBRE			AS VALORES_PLANTILLA,
				TPE_PK_PLANTILLAELEMENTO	AS PK_PLANTILLA
			  FROM 	CVU.EVTTPLANTILLAELEMENTO
			 WHERE 	TPE_FK_PLANTILLA = #arguments.pk_plantilla#
			   AND 	TPE_FK_ESTADO > 0
			 ORDER BY TPE_PK_PLANTILLAELEMENTO ASC
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>

	<cffunction name="nombrePlantilla" access="public" hint="Query obtiene los valores por el pk del nombre de la plantilla seleccionada por el usuario">
		<cfargument name="pk_plantilla" type="numeric" required="yes" hint="" />
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT  TPL.TPL_NOMBRE          AS NOMBRE,
			        TPL.TPL_PK_TPLANTILLA   AS PKPLANTILLA
			FROM    CVU.EVTTPLANTILLA TPL
			WHERE   TPL.TPL_PK_TPLANTILLA =  #arguments.pk_plantilla#
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>

	<!---
	* Fecha:	Agosto 2016	
	* @author: 	Marco Torres.
	--->  
	<cffunction name="getFormatosRelacionados" access="public" hint="Obtiene los Formatos Relacionados a la Plantilla">
	<cfargument name="pk_plantilla" type="numeric" required="yes" hint="" />
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT 
				TP.TPL_PK_TPLANTILLA 					AS PK_COLUMNA,
			    CF.CFT_NOMBRE ||' '|| TF.TFR_VERSION 	AS NOMBRE_FORMATO,
			    CF.CFT_CLAVE 							AS CLAVE_FORMATO,
			    TC.TCL_PK_COLUMNA 						AS pk_catalogoPlantilla,
			    TC.TCL_NOMBRE 							AS NOMBRE_COLUMNA,
			    TC.TCL_FECHAPLANTILLA 					AS FECHA_MODIFICACION
			FROM
				CVU.EVTTPLANTILLA TP,
				CVU.EVTTCOLUMNA TC,
				CVU.EVTTFORMATO TF,
				CVU.EVTCFORMATO CF
			WHERE TC.TCL_FK_TPLANTILLA = TP.TPL_PK_TPLANTILLA
			AND TC.TCL_FK_FORMATO = TF.TFR_PK_FORMATO
			AND TF.TFR_FK_CFORMATO = CF.CFT_PK_FORMATO
			AND TP.TPL_PK_TPLANTILLA = #pk_plantilla#
		</cfquery>
		<cfreturn respuesta>
	</cffunction>
	
	<!---
	* Fecha:	Agosto 2016	
	* @author: 	Marco Torres.
	--->  
	<cffunction name="actualizarCatalogo" access="public" hint="Obtiene los Formatos Relacionados a la Plantilla">
	<cfargument name="pkColumna" type="numeric" required="yes" hint="" />
		<cfquery name="respuesta" datasource="DS_CVU">
			UPDATE CVU.EVTTCATALOGOCOLUMNA	CCC
			SET CCC.CCC_FK_ESTADO = 0
			WHERE CCC.CCC_FK_COLUMNA = #pkColumna#
		</cfquery>
		<cfquery name="respuesta" datasource="DS_CVU">
			UPDATE CVU.EVTTCOLUMNA CLU
			SET CLU.TCL_FECHAPLANTILLA  = SYSDATE
			WHERE CLU.TCL_PK_COLUMNA = #pkColumna#
		</cfquery>
		<cfquery name="respuesta" datasource="DS_CVU">
			INSERT INTO CVU.evttcatalogocolumna TCC (
			    TCC.CCC_FK_PLANTILLAELEMENTO,
			    TCC.CCC_ELEMENTO,
			    TCC.CCC_FK_ESTADO,
			    TCC.CCC_FK_COLUMNA)
			
			SELECT TPE_PK_PLANTILLAELEMENTO,
			    TPE_NOMBRE,
			    1 AS EDO,
			    TCL.TCL_PK_COLUMNA AS COLUMNA
			FROM  CVU.EVTTPLANTILLAELEMENTO TPL,
                CVU.EVTTCOLUMNA   TCL
			WHERE TPL.TPE_FK_PLANTILLA = TCL.TCL_FK_TPLANTILLA   
                AND  TCL.TCL_PK_COLUMNA = #pkColumna# 
                AND TPL.TPE_FK_ESTADO > 0
		</cfquery>
		
		<cfreturn 1>
	</cffunction>
	
	<cffunction name="updateValoresPlantilla" access="public" hint="query que actualiza los valores de la plantilla a 0 ">
		<cfargument name="pk_plantilla" type="numeric" required="yes" >
		<cfquery name="qActualiza" datasource="DS_CVU">
			UPDATE CVU.EVTTPLANTILLAELEMENTO CLU
				SET CLU.TPE_FK_ESTADO  = 0
			  WHERE CLU.TPE_FK_PLANTILLA = #arguments.pk_plantilla#
		</cfquery>
        <cfreturn 1>
    </cffunction>
	
	<cffunction name="borraPlantilla" access="public" hint="query que actualiza a 0 el nombre de la plantilla">
		<cfargument name="pk_plantilla" type="numeric" required="yes" >
			<cfquery name="qActualiza" datasource="DS_CVU">
				UPDATE	CVU.EVTTPLANTILLA CLU
				   SET	CLU.TPL_FK_CESTADO  = 0
			  	 WHERE	CLU.TPL_PK_TPLANTILLA = #arguments.pk_plantilla#
			</cfquery>
        <cfreturn 1>
    </cffunction>
	
	<cffunction name="selectPlantilla" access="public" hint="selecciona campos de una plantilla">
		<cfargument name="pk_plantilla" type="numeric" required="yes" >
		<cfquery name="select" datasource="DS_CVU">
			SELECT  TPL.TPL_FK_CESTADO  AS ESTADO,
			        TPL.TPL_FK_RUTA     AS RUTA,
			        TPL.TPL_ISUR		AS ISUR        
			FROM    EVTTPLANTILLA TPL
			WHERE   TPL_PK_TPLANTILLA = #pk_plantilla#			
		</cfquery>
        <cfreturn select>
    </cffunction>
	
	<cffunction name="copiarPlantilla" access="public" hint="copia el contenido de una plantilla en otra">
    	<cfargument name="ESTADO"	type="numeric" required="yes">
    	<cfargument name="RUTA"		type="numeric" required="yes">
    	<cfargument name="NOMBRE" 	type="string" required="yes">
    	<cfargument name="ISUR"  	type="string" required="yes">	
	<cfstoredproc procedure="CVU.P_PLANTILLA.COPIARPLANTILLA" datasource="DS_CVU">
            <cfprocparam value="#ESTADO#" 	cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#RUTA#"    	cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#NOMBRE#" 	cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#ISUR#"		cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam variable="PKSALIDA"cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
		<cfreturn PKSALIDA>
    </cffunction>

	<cffunction name="copiarElemento" access="public" hint="copia los elementos de una plantilla a otro">
		<cfargument name="plantilla" 	type="numeric" required="yes"/>
		<cfargument name="pk_plantilla" type="numeric" required="yes"/>
		<cfquery name="copia" datasource="DS_CVU">
			INSERT INTO EVTTPLANTILLAELEMENTO TPE(
			    TPE.TPE_FK_ESTADO,
			    TPE.TPE_NOMBRE,
			    TPE.TPE_FK_UR,
			    TPE.TPE_FK_PLANTILLA)
			SELECT  TPE1.TPE_FK_ESTADO,
			        TPE1.TPE_NOMBRE,
			        TPE1.TPE_FK_UR,
			        #plantilla# AS TPE_FK_PLANTILLA
			FROM    EVTTPLANTILLAELEMENTO TPE1
			WHERE TPE1.TPE_FK_PLANTILLA = #pk_plantilla#
		</cfquery>
        <cfreturn 1>        
    </cffunction>

	<cffunction name="asociarElemento" access="public" hint="asocia elemento con otro elemento">
		<cfargument name="pkelemento" type="numeric" required="yes" hint="" />
		<cfargument name="pkpadre" type="numeric" required="yes" hint="" />
		<cfargument name="const" type="numeric" required="yes" hint="" />

		<cfquery name="qActualiza" datasource="DS_CVU">
			INSERT INTO CVU.EVTTASOCIACIONELEMENTO(
			    TAE_FK_PLANTILLAELEMENTO,
			    TAE_FK_PADRE,
			    TAE_FK_ASOCIACION)
			VALUES (
			    #pkelemento#,
			    #pkpadre#,
			    #const#)
		</cfquery>
        <cfreturn 1>
    </cffunction>

    <cffunction name="asociarPlantilla" access="public" hint="asocia plantilla con otra plantilla">
		<cfargument name="padre" type="numeric" required="yes" hint="" />
		<cfargument name="hijo" type="numeric" required="yes" hint="" />
		<cfargument name="const" type="numeric" required="yes" hint="" />
		<cfquery name="qActualiza" datasource="DS_CVU">
			INSERT INTO CVU.EVTTASOCIACIONPLANTILLA(
			    TAP_FK_PLANTILLA,
			    TAP_FK_PADRE,
			    TAP_FK_ASOCIACION)
			VALUES (
			    #hijo#,
			    #padre#,
			    #const#)
		</cfquery>
        <cfreturn 1>
    </cffunction>

    <cffunction name="crearAsociacion" access="public" hint="asocia plantilla con otra plantilla">
    	<cfargument name="nombresA">
		<cfstoredproc procedure="CVU.P_PLANTILLA.INSERTASOCIACION" datasource="DS_CVU">
                <cfprocparam value="#nombresA#" 	cfsqltype="cf_sql_varchar" type="in">
                <cfprocparam value="1"    			cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="RESULTADO" 	cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
		<cfreturn RESULTADO>
    </cffunction>

    <cffunction name="consultaAsociacion" access="public" hint="asocia plantilla con otra plantilla">
		<cfargument name="nombresA" type="string" required="yes" hint="" />
		<cfquery name="consultaAsociacion" datasource="DS_CVU">
		SELECT TAS_PK_ASOCIACION
		 FROM CVU.EVTTASOCIACION
		WHERE TAS_NOMBRE = '#nombresA#'
		</cfquery>
        <cfreturn consultaAsociacion>
    </cffunction>

    <cffunction name="getPlantillasAsociadas" access="public" hint="Muestra plantillas asociadas">
    	<cfquery name="asociar" datasource="DS_CVU">                          
			SELECT  TAS_PK_ASOCIACION   AS PKASOCIACION,
			        TAS_NOMBRE          AS NOMBRE,
			        TAS_ESTADO          AS ESTADO
			 FROM CVU.EVTTASOCIACION
			WHERE TAS_ESTADO = 1
        </cfquery>
        <cfreturn asociar>
    </cffunction>

    <cffunction name="cargarPlantillas" access="public" hint="Muestra plantillas asociadas con base a una asociacion">
    <cfargument name="pkAsociacion" type="numeric" required="yes" hint="" />
    	<cfquery name="asociacion" datasource="DS_CVU">                          
            SELECT  TAP.TAP_FK_PADRE        AS PKPLANTILLA,
                    TPL.TPL_NOMBRE          AS NOMBRE
			 FROM   EVTTASOCIACIONPLANTILLA	TAP,
			        EVTTPLANTILLA 			TPL
			WHERE   TAP.TAP_FK_ASOCIACION = #pkAsociacion#
			AND     TPL.TPL_PK_TPLANTILLA = TAP_FK_PADRE
			UNION ALL
			SELECT * 
			 FROM (
			    SELECT  TAP.TAP_FK_PLANTILLA    AS PKPLANTILLA,
                    TPL.TPL_NOMBRE          AS NOMBRE
			     FROM   EVTTASOCIACIONPLANTILLA TAP,
			            EVTTPLANTILLA           TPL  
			    WHERE   TPL.TPL_PK_TPLANTILLA = TAP_FK_PLANTILLA
			    AND     TAP_FK_ASOCIACION = #pkAsociacion#
			    ORDER BY TAP_PK_ASOCIACIOPLANTILLA DESC )
			WHERE ROWNUM = 1
        </cfquery>
        <cfreturn asociacion>
    </cffunction>

    <cffunction name="eliminarElementosAsociados" access="public" hint="elimina los elementos asociados">
        <cfargument name="pkAsociado" type="numeric" required="yes" hint="" />
    	<cfquery name="eliminar" datasource="DS_CVU">                          
			DELETE
			FROM CVU.EVTTASOCIACIONELEMENTO TAE
			WHERE TAE.TAE_FK_ASOCIACION	= #pkAsociado#
        </cfquery>
        <cfreturn 1>
    </cffunction>

    <cffunction name="getPlantillaElementos" access="public" hint="Query obtiene los valores por el pk del nombre de la plantilla seleccionada por el usuario">
		<cfargument name="pk_plantilla" type="numeric" required="yes" hint="" />
		<cfquery name="respuesta" datasource="DS_CVU">
			SELECT  TPE.TPE_NOMBRE 					AS VALORES_PLANTILLA,
					TPE.TPE_PK_PLANTILLAELEMENTO 	AS PK_PLANTILLA,
					0	            AS PADRE
			FROM    CVU.EVTTPLANTILLAELEMENTO      TPE
			WHERE   TPE.TPE_FK_PLANTILLA = #arguments.pk_plantilla#
	        AND TPE.TPE_FK_ESTADO > 0
	        ORDER BY TPE.TPE_NOMBRE
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>
	
	<cffunction name="getElementosAsociados" access="public" hint="Query obtiene lOS ELEMENTOS ASOCIADOS DE UNA ASOCIACION">
		<cfargument name="pkAsociacion" type="numeric" required="yes" hint="" />
		<cfquery name="respuesta" datasource="DS_CVU">
	            SELECT  TAE.TAE_FK_PADRE	            AS PADRE,
	                    TAE.TAE_FK_PLANTILLAELEMENTO    AS HIJO
				FROM    CVU.EVTTASOCIACIONELEMENTO   TAE
				WHERE   TAE.TAE_FK_ASOCIACION = #pkAsociacion#
		</cfquery>
		<cfreturn respuesta>	
    </cffunction>
	

    <cffunction name="eliminarAsociacion" access="public" hint="elimina los elementos asociados">
        <cfargument name="pkAsociado" type="numeric" required="yes" hint="" />
        <cfquery name="eliminar" datasource="DS_CVU">                          
		UPDATE CVU.EVTTASOCIACION TAS
		SET TAS.TAS_ESTADO = 0
		WHERE TAS.TAS_PK_ASOCIACION = #pkAsociado#
        </cfquery>
        <cfreturn 1>

    </cffunction>

    <cffunction name="AsociacionPk" access="public" hint="asocia plantilla con otra plantilla">
		<cfargument name="pk" type="numeric" required="yes" hint="" />
		<cfquery name="AsociacionPk" datasource="DS_CVU">
			SELECT *
			 FROM CVU.EVTTASOCIACION
			WHERE TAS_PK_ASOCIACION = '#pk#'
		</cfquery>
        <cfreturn AsociacionPk>
    </cffunction>

    <cffunction name="actualizarNombre" access="public" hint="actualiza el Nombre de la plantilla">
		<cfargument name="pkAsociado" type="numeric" required="yes" hint="" />
		<cfargument name="nombre" type="string" required="yes" hint="" />
		<cfquery name="actualizarNombre" datasource="DS_CVU">
			UPDATE EVTTASOCIACION TAS
			SET TAS.TAS_NOMBRE = '#nombre#'
			WHERE TAS.TAS_PK_ASOCIACION = #pkAsociado#
		</cfquery>
        <cfreturn 1>
    </cffunction>

</cfcomponent>