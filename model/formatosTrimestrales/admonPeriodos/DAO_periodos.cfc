<!---
============================================================================================
* IPN - CSII
* Sistema: EVALUACION
* Modulo: Administración de periodos
* Fecha: Enero de 2017
* Descripcion:
* Autor: SGS
============================================================================================
--->

<cfcomponent>

    <cffunction name="obtenerPeriodos" hint="Obtiene los periodos para llenar el formulario de busqueda inicial">
		<cfquery  name="resultado" datasource="DS_CVU" >
		     SELECT PER.TPE_PK_PERIODO  AS PK,
                    PER.TPE_NOMBRE      AS NOMBRE
   			  FROM  CVU.EVTTPERIODO    PER
             WHERE  PER.TPE_ESTADO > 0
          ORDER BY  PER.TPE_ANIO, PER.TPE_TRIMESTRE
		</cfquery>
		<cfreturn resultado>
	</cffunction>

	<cffunction name="obtenerAnios" hint="Obtiene los años que ya fueron usados para crear trimestres">
        <cfquery name="resultado" datasource="DS_CVU">
        	SELECT DISTINCT	PER.TPE_ANIO AS ANIO
            		   FROM CVU.EVTTPERIODO PER
            		  WHERE PER.TPE_ESTADO = 2
          		   ORDER BY ANIO ASC
        </cfquery>
        <cfreturn resultado>        
    </cffunction>

    <cffunction name="agregarPeriodo" hint="Agrega un periodo nuevo">
        <cfargument name="anio" type="numeric" required="yes" hint="Año del nuevo periodo">
        <cfargument name="trim1" type="string" required="yes" hint="Primer trimestres del nuevo periodo">
        <cfargument name="trim2" type="string" required="yes" hint="Segundo trimestres del nuevo periodo">
        <cfargument name="trim3" type="string" required="yes" hint="Tercer trimestres del nuevo periodo">
        <cfargument name="trim4" type="string" required="yes" hint="Cuerto trimestres del nuevo periodo">
        <cftry>
            <cfstoredproc procedure="CVU.P_ADMON_PERIODOS.GUARDAR_PERIODO" datasource="DS_CVU">
                <cfprocparam value="#anio#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#trim1#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#trim2#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#trim3#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#trim4#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="obtenerFormatos" hint="Obtiene los formatos de un periodo">
        <cfargument name="periodo" type="numeric" required="yes" hint="pk del periodo">
		<cfargument name="UR" default="">
   		<cfargument name="pkUsuario">
        <cfquery name="resultado" datasource="DS_CVU">
            
            SELECT  TFOR.TFR_PK_FORMATO AS PK,
                    TREP.TRP_FK_PERIODO AS PKPERIODO,
                    CFOR.CFT_NOMBRE     AS NOMBRE,
                    CFOR.CFT_CLAVE      AS CLAVE,
                    TFOR.TFR_VERSION    AS VERSION,
                    EDO.CER_NUMERO_ESTADO AS ESTADO,
                    TREP.TRP_FK_RUTA    AS CESRUTA,
                    EDO.CER_PK_ESTADO AS CESESTADO,
                    TREP.TRP_PK_REPORTE PKREGISTRO              
              FROM  CVU.EVTCFORMATO CFOR,
                    CVU.EVTTFORMATO TFOR,
                    CVU.EVTTREPORTE TREP,
                    GRAL.CESCESTADO EDO
					<cfif pkusuario neq ''>
                    	,CVU.EVTRUSUARIOFORMATO UFT
					</cfif>
             WHERE  CFOR.CFT_PK_FORMATO = TFOR.TFR_FK_CFORMATO
                    AND TFOR.TFR_PK_FORMATO = TREP.TRP_FK_FORMATO(+)
                    AND TREP.TRP_FK_CESTADO = EDO.CER_PK_ESTADO(+)
                    <cfif pkusuario neq ''>
						AND TFOR.TFR_PK_FORMATO = UFT.TRU_FK_FORMATO
	                    AND UFT.TRU_FK_USUARIO = <cfqueryparam value="#arguments.pkUsuario#" cfsqltype="cf_sql_numeric">
	                    AND UFT.TRU_ESTADO = 1
					</cfif>
					
                    <cfif UR neq ''>
                    	AND TFOR.TFR_FK_UR = <cfqueryparam value="#arguments.UR#" cfsqltype="CF_sql_char">
                    </cfif>
                    AND TREP.TRP_FK_PERIODO(+) = <cfqueryparam value="#arguments.periodo#" cfsqltype="cf_sql_numeric">
					AND TFOR.TFR_FK_CESTADO >= 6 /*SOLO DE MANETA TEMPORAL SE PONE EL ESTADO TRES, SE DEBE DE TRABAJAR UNA MEJOR OPCION PARA JALAR ESTE VALOR*/
 
            GROUP BY TFOR.TFR_PK_FORMATO,
                     TREP.TRP_FK_PERIODO,
                     CFOR.CFT_NOMBRE,
                     CFOR.CFT_CLAVE,
                     TFOR.TFR_VERSION,
                     EDO.CER_NUMERO_ESTADO,
                     TREP.TRP_FK_RUTA,
                     EDO.CER_PK_ESTADO,
                     TREP.TRP_PK_REPORTE
            ORDER BY NOMBRE ASC
        </cfquery>
        <cfreturn resultado>        
    </cffunction>


    <cffunction name="formatosNoLiberados" hint="Obtiene los formatos de un periodo">
        <cfargument name="periodo" type="numeric" required="yes" hint="pk del periodo">
		<cfargument name="UR" default="">
   		<cfargument name="pkUsuario">
        <cfquery name="resultado" datasource="DS_CVU">
            
            SELECT  TFOR.TFR_PK_FORMATO AS PK,
                    TREP.TRP_FK_PERIODO AS PKPERIODO,
                    CFOR.CFT_NOMBRE     AS NOMBRE,
                    CFOR.CFT_CLAVE      AS CLAVE,
                    TFOR.TFR_VERSION    AS VERSION,
                    EDO.CER_NUMERO_ESTADO AS ESTADO,
                    TREP.TRP_FK_RUTA    AS CESRUTA,
                    EDO.CER_PK_ESTADO AS CESESTADO              
              FROM  CVU.EVTCFORMATO CFOR,
                    CVU.EVTTFORMATO TFOR,
                    CVU.EVTTREPORTE TREP,
                    GRAL.CESCESTADO EDO
					<cfif pkusuario neq ''>
                    	,CVU.EVTRUSUARIOFORMATO UFT
					</cfif>
             WHERE  CFOR.CFT_PK_FORMATO = TFOR.TFR_FK_CFORMATO
                    AND TFOR.TFR_PK_FORMATO = TREP.TRP_FK_FORMATO(+)
                    AND TREP.TRP_FK_CESTADO = EDO.CER_PK_ESTADO(+)
                    <cfif pkusuario neq ''>
						AND TFOR.TFR_PK_FORMATO = UFT.TRU_FK_FORMATO
	                    AND UFT.TRU_FK_USUARIO = <cfqueryparam value="#arguments.pkUsuario#" cfsqltype="cf_sql_numeric">
	                    AND UFT.TRU_ESTADO = 1
					</cfif>
					
                    <cfif UR neq ''>
                    	AND TFOR.TFR_FK_UR = <cfqueryparam value="#arguments.UR#" cfsqltype="CF_sql_char">
                    </cfif>
                    AND TREP.TRP_FK_PERIODO(+) = <cfqueryparam value="#arguments.periodo#" cfsqltype="cf_sql_numeric">
					AND TFOR.TFR_FK_CESTADO >= 6 /*SOLO DE MANETA TEMPORAL SE PONE EL ESTADO TRES, SE DEBE DE TRABAJAR UNA MEJOR OPCION PARA JALAR ESTE VALOR*/
            GROUP BY TFOR.TFR_PK_FORMATO,
                     TREP.TRP_FK_PERIODO,
                     CFOR.CFT_NOMBRE,
                     CFOR.CFT_CLAVE,
                     TFOR.TFR_VERSION,
                     EDO.CER_NUMERO_ESTADO,
                     TREP.TRP_FK_RUTA,
                     EDO.CER_PK_ESTADO
            MINUS

           SELECT  TFOR.TFR_PK_FORMATO AS PK,
                    TREP.TRP_FK_PERIODO AS PKPERIODO,
                    CFOR.CFT_NOMBRE     AS NOMBRE,
                    CFOR.CFT_CLAVE      AS CLAVE,
                    TFOR.TFR_VERSION    AS VERSION,
                    EDO.CER_NUMERO_ESTADO AS ESTADO,
                    TREP.TRP_FK_RUTA    AS CESRUTA,
                    EDO.CER_PK_ESTADO AS CESESTADO              
              FROM  CVU.EVTCFORMATO CFOR,
                    CVU.EVTTFORMATO TFOR,
                    CVU.EVTTREPORTE TREP,
                    GRAL.CESCESTADO EDO
             WHERE  CFOR.CFT_PK_FORMATO = TFOR.TFR_FK_CFORMATO
                    AND TFOR.TFR_PK_FORMATO = TREP.TRP_FK_FORMATO(+)
                    AND TREP.TRP_FK_CESTADO = EDO.CER_PK_ESTADO(+)
					AND EDO.CER_NUMERO_ESTADO(+) > 0
                    AND TREP.TRP_FK_PERIODO = <cfqueryparam value="#arguments.periodo#" cfsqltype="cf_sql_numeric">
            GROUP BY TFOR.TFR_PK_FORMATO,
                     TREP.TRP_FK_PERIODO,
                     CFOR.CFT_NOMBRE,
                     CFOR.CFT_CLAVE,
                     TFOR.TFR_VERSION,
                     EDO.CER_NUMERO_ESTADO,
                     TREP.TRP_FK_RUTA,
                     EDO.CER_PK_ESTADO


            ORDER BY NOMBRE ASC
        </cfquery>
        <cfreturn resultado>        
    </cffunction>

    <cffunction name="obtenerPeriodoAnterior" hint="Obtiene el ultimo periodo de un formato">
        <cfargument name="formato" type="numeric" required="yes" hint="pk del formato">
        <cfquery name="resultado" datasource="DS_CVU">
            SELECT  MAX(TRE.TRP_FK_PERIODO) AS PKPERIODOANTERIOR
              FROM  CVU.EVTTREPORTE TRE
            WHERE   TRE.TRP_FK_FORMATO = #formato#
        </cfquery>
        <cfreturn resultado>        
    </cffunction>


    <cffunction name="crearReporte" hint="Crea un repote para un periodo">
        <cfargument name="formato" type="numeric" required="yes" hint="pk del formato">
        <cfargument name="periodoNuevo" type="numeric" required="yes" hint="pk del periodo nuevo">
        <cfargument name="periodoViejo" type="numeric" required="yes" hint="pk del periodo viejo">
        <cfargument name="estado" type="numeric" required="yes" hint="estado del formato">
        <cfargument name="ruta" type="numeric" required="yes" hint="ruta del formato">
            <cfstoredproc procedure="CVU.P_ADMON_PERIODOS.CREAR_FORMATO" datasource="DS_CVU">
                <cfprocparam value="#formato#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#periodoNuevo#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#periodoViejo#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#estado#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#ruta#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha creación: Febrero 2017
    * @author: Alejandro Tovar
    * Descripcion: Obtiene el estado de creacion de la ruta. 
    --->
    <cffunction name="primerEdoRuta" hint="Obtiene el ultimo periodo de un formato">
        <cfargument name="ruta" type="numeric" required="yes">
        <cfquery name="resultado" datasource="DS_GRAL">
            SELECT EDO.CER_PK_ESTADO ESTADO
            FROM GRAL.CESCESTADO EDO
            WHERE EDO.CER_NUMERO_ESTADO = 1
                  AND EDO.CER_FK_RUTA = #ruta#
        </cfquery>
        <cfreturn resultado>        
    </cffunction>


    <cffunction name="actualizarEdoFormato" hint="actualiza el estado del formato(solo para formatos eliminados)">
        <cfargument name="formato" type="numeric" required="yes">
        <cfargument name="periodoNuevo" type="numeric" required="yes">
        <cfargument name="pkEstado" type="numeric" required="yes">
        <cfquery name="resultado" datasource="DS_CVU">
           UPDATE  CVU.EVTTREPORTE TRE 
			
	        set TRP_FK_CESTADO = #pkEstado#  
	        WHERE TRE.TRP_FK_FORMATO = #formato#
	        AND TRE.TRP_FK_PERIODO =  #periodoNuevo#
        </cfquery>
        <cfreturn 1>        
    </cffunction>
	
	
    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
    * Descripcion: Función que registra el cambio de estado en algún registro.
    --->
    <cffunction name="registrarCreacionReporte" returntype="numeric" hint="Cambia el registro del usuario al estado indicado">
        <cfargument name="pkProced"     required="no" hint="pk del procedimiento">
        <cfargument name="cambioEdo"    required="no" hint="pk del estado siguiente">
        <cfargument name="pkRegistro"   required="no" hint="pk del registro afectado">
        <cfargument name="usuario"      required="no" hint="pk del usuario que ejecuta la funcion">
            <cfstoredproc procedure="CVU.P_ADMON_PERIODOS.REGISTRA_CREACION" datasource="DS_CVU">
                <cfprocparam value="#pkProced#"     cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#cambioEdo#"    cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkRegistro#"   cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#usuario#"      cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta"   cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>
    
</cfcomponent>