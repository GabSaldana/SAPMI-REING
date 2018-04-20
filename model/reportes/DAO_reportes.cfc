<!---
* =========================================================================
* IPN - CSII
* Sistema: PIMP
* Modulo: Consulta de reportes generados
* Fecha : septiembre 2017
* Descripcion: DAO de reportes
* Autor: Alejandro Rosales 
* =========================================================================
--->


<cfcomponent>

	<!---
	 	 *Fecha :18 de septiembre de 2017
	 	 *@author Alejandro Rosales 
     --->
	<cffunction name="obtenerReportePK" hint="Obtencion de los reportes generados pk">
		 <cfquery  name="result" datasource="DS_PDIPIMP">  
  				SELECT  T.TTD_PK_TABLA AS idRep
              FROM  PDIPIMP.TDITTABLAS T,
                    PDIPIMP.MEDTCONJUNTODATOS CD
              WHERE  T.TTD_FK_ESTADO IN (1,2)
                        AND CD.TCD_PK_CONJUNTODATOS = T.TTD_FK_CONJUNTODATOS
                        AND CD.TCD_FK_ESTADO = 2
              ORDER BY  T.TTD_PK_TABLA
           </cfquery>
         <cfreturn result>
	</cffunction>

	 <!---
       * Fecha creacion: 23 de marzo de 2017
       * @author Jonathan Martinez
     ---> 
     <cffunction name="obtenerTablaPorId" hint="Obtiene los datos para crear un objeto de tablas">
         <cfargument name="idTab">
         <cfscript>
           var spTab = new storedproc(); 
           spTab.setDatasource("DS_PDIPIMP"); 
           spTab.setProcedure("PDIPIMP.P_TABLASDINAMICAS.OBTENER_TABLAPORID"); 
             
           spTab.addParam(cfsqltype="cf_sql_numeric",type="in",value=idTab);
                
           spTab.addProcResult(name="tabla",resultset=1); 
           spTab.addProcResult(name="columnas",resultset=2); 
           spTab.addProcResult(name="filas",resultset=3); 
           spTab.addProcResult(name="valores",resultset=4);
           spTab.addProcResult(name="filtros",resultset=5); 
              
           var result = spTab.execute(); 
              
           var tabsConsultas={};
           tabsConsultas["tabla"]=result.getProcResultSets().tabla;
           tabsConsultas["columnas"]=result.getProcResultSets().columnas;
           tabsConsultas["filas"]=result.getProcResultSets().filas;
           tabsConsultas["valores"]=result.getProcResultSets().valores;
           tabsConsultas["filtros"]=result.getProcResultSets().filtros;
           return tabsConsultas;   
         </cfscript>
     </cffunction>

     <!---
       * Fecha creacion: 16 de marzo de 2017
       * @author Alejandro Rosales
     ---> 
     <cffunction name="getNombreConjuntoDatos" access="public" returntype="query">
         <cfargument name="pkConjunto" type="numeric" required="yes">
         <cfquery name="respuesta" datasource="DS_PDIPIMP">
              SELECT TCD.TCD_NOMBRE TIT, 
                     CVI.CVI_NOMBRE REF,
                     TCD.TCD_DESCRIPCION DES                 
                FROM PDIPIMP.MEDTCONJUNTODATOS    TCD,
                     PDIPIMP.MEDTVISTACONJUNTO            TVI,
                     PDIPIMP.MEDCVISTA             CVI
                WHERE TCD.TCD_PK_CONJUNTODATOS = TVI.TVI_FK_CONJUNTODATOS
                      AND CVI.CVI_PK_VISTA = TVI.TVI_FK_VISTA
                      AND TCD.TCD_PK_CONJUNTODATOS = #pkConjunto#          
         </cfquery>
         <cfreturn respuesta>
     </cffunction>
    <!---
       * Fecha creacion: 22 de marzo de 2017
       * @author Alejandro Rosales
     ---> 
     <cffunction name="getValoresFiltro" access="public" returntype="query">
         <cfargument name="nombreC" type="string" required="yes">
         <cfargument name="vista" type="string" required="yes">
         <cfargument name="filtroColumna" type="string" required="yes">
         <cfargument name="filtroFila" type="string" required="yes">
         <cfargument name="filtroUR" type="string" required="yes">
         <cfquery name="respuesta" datasource="DS_PDIPIMP">
           SELECT SUM(#nombreC#) S 
           FROM #vista#  #PreserveSingleQuotes(filtroColumna)# 
                         #PreserveSingleQuotes(filtroFila)# #preserveSingleQuotes(filtroUR)#
         </cfquery>
       <cfreturn respuesta>
     </cffunction>

     <!---
       * Fecha creacion: 16 de marzo de 2017
       * @author Alejandro Rosales
     ---> 
     <cffunction name="getNombre" access="public" returntype="query">
         <cfargument name="pkConjunto" type="numeric" required="yes">
         <cfargument name="pkCampo" type="numeric" required="yes">
         <cfquery name="respuesta" datasource="DS_PDIPIMP">
            SELECT TCO.TCO_COLUMNAREF N, LEVEL ORD
              FROM PDIPIMP.MEDTCOLUMNA TCO,
                   PDIPIMP.MEDTCONJUNTOCOLUMNA TCC,
                   PDIPIMP.MEDTVISTACONJUNTO TVI,
                   PDIPIMP.MEDTCONJUNTODATOS TCD
             WHERE     TCD.TCD_PK_CONJUNTODATOS = #pkConjunto#
                   AND TCC.TCC_FK_COLUMNA = TCO.TCO_PK_COLUMNA
                   AND TCD.TCD_PK_CONJUNTODATOS = TVI.TVI_FK_CONJUNTODATOS
                   AND TCC.TCC_FK_VISTACONJUNTO = TVI.TVI_PK_VISTACONJUNTO
                   AND TCO.TCO_PK_COLUMNA = #pkCampo#
             START WITH TCC.TCC_FK_PADRE IS NULL
             CONNECT BY PRIOR TCC.TCC_PK_CONJUNTOCOLUMNA = TCC.TCC_FK_PADRE
         </cfquery>
         <cfreturn respuesta>
     </cffunction>

     <!---
       * Fecha creacion: 16 de marzo de 2017
       * @author Alejandro Rosales
     ---> 
     <cffunction name="getValoresNombre" access="public" returntype="query">
         <cfargument name="nombreC" type="string" required="yes">
         <cfargument name="vista" type="string" required="yes">
         <cfargument name="filtro" type="string" required="yes">
         <cfquery name="respuesta" datasource="DS_PDIPIMP">
            SELECT DISTINCT #nombreC# 
            FROM #vista# #PreserveSingleQuotes(filtro)# 
            ORDER BY #nombreC#
         </cfquery>
         <cfreturn respuesta>
     </cffunction>
      <!---
       * Fecha creacion: 27 de marzo de 2017
       * @author Alejandro Rosales
     ---> 
     <cffunction name="getColumnaFiltro" access="public" returntype="query">
         <cfargument name="pkConjunto" type="numeric" required="yes">
         <cfargument name="pkCampo" type="numeric" required="yes">
         <cfargument name="pkFiltro" type="numeric" required="yes">
         <cfquery name="respuesta" datasource="DS_PDIPIMP"> 
           SELECT TCO.TCO_COLUMNAREF N, CFI.CFI_REPRESENTACION F,LEVEL ORD
           FROM PDIPIMP.MEDTCOLUMNA TCO,
                PDIPIMP.MEDTCONJUNTOCOLUMNA TCC,
                PDIPIMP.MEDTVISTACONJUNTO TVI,
                PDIPIMP.MEDTCONJUNTODATOS TCD,
                PDIPIMP.MEDTCOLFILTRO TCOLF,
                PDIPIMP.MEDCFILTRO CFI
           WHERE TCD.TCD_PK_CONJUNTODATOS = #pkConjunto#
           AND TCC.TCC_FK_COLUMNA = TCO.TCO_PK_COLUMNA
           AND TCD.TCD_PK_CONJUNTODATOS = TVI.TVI_FK_CONJUNTODATOS
           AND TCC.TCC_FK_VISTACONJUNTO = TVI.TVI_PK_VISTACONJUNTO
           AND TCO.TCO_PK_COLUMNA = TCOLF.TCF_FK_COLUMNA
           AND TCOLF.TCF_FK_FILTRO = CFI.CFI_PK_FILTRO
           AND TCO.TCO_PK_COLUMNA = #pkCampo#
           AND CFI.CFI_PK_FILTRO = #pkFiltro#
           START WITH TCC.TCC_FK_PADRE IS NULL
           CONNECT BY PRIOR TCC.TCC_PK_CONJUNTOCOLUMNA = TCC.TCC_FK_PADRE
         </cfquery>
       <cfreturn respuesta>
     </cffunction>
      <!---
       * Fecha creacion: 12 de febrero de 2018
       * @author Alejandro Rosales
     ---> 
     <cffunction name="getNombreValores" access="public" returntype="query">
         <cfargument name="pkConjunto" type="numeric" required="yes">
         <cfargument name="pkCampo" type="numeric" required="yes">
         <cfquery name="respuesta" datasource="DS_PDIPIMP">
            SELECT TCO.TCO_NOMBRE N, LEVEL ORD
              FROM PDIPIMP.MEDTCOLUMNA TCO,
                   PDIPIMP.MEDTCONJUNTOCOLUMNA TCC,
                   PDIPIMP.MEDTVISTACONJUNTO TVI,
                   PDIPIMP.MEDTCONJUNTODATOS TCD
             WHERE     TCD.TCD_PK_CONJUNTODATOS = #pkConjunto#
                   AND TCC.TCC_FK_COLUMNA = TCO.TCO_PK_COLUMNA
                   AND TCD.TCD_PK_CONJUNTODATOS = TVI.TVI_FK_CONJUNTODATOS
                   AND TCC.TCC_FK_VISTACONJUNTO = TVI.TVI_PK_VISTACONJUNTO
                   AND TCO.TCO_PK_COLUMNA = #pkCampo#
             START WITH TCC.TCC_FK_PADRE IS NULL
             CONNECT BY PRIOR TCC.TCC_PK_CONJUNTOCOLUMNA = TCC.TCC_FK_PADRE
         </cfquery>
         <cfreturn respuesta>
     </cffunction>

</cfcomponent>