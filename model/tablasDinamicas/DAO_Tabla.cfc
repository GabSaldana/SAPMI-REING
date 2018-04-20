<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: DAO Tabla
* Fecha 16 de Marzo de 2017
* Descripcion:
* DAO para el modulo de tablas
* Autores: Alejandro Rosales
           Jonathan Martinez
* ================================
--->
 <cfcomponent>
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
       * Fecha creacion: 23 de marzo de 2017
       * @author Jonathan Martinez
     ---> 
     <cffunction name="guardarTabla" access="public">
         <cfargument name="nombre" type="string" required="yes" hint="Nombre de la Tabla">
         <cfargument name="descripcion" type="string" required="yes" hint="Descripcion de la Tabla">
         <cfargument name="pkConjunto" type="numeric" required="yes" hint="Id del conjunto de datos">
         <cfargument name="pkUsuario" type="numeric" required="yes" hint="Id del usuario creador">
         <cfstoredproc procedure="PDIPIMP.P_TABLASDINAMICAS.GUARDAR_TABLA" datasource="DS_PDIPIMP">
             <cfprocparam value="#nombre#" cfsqltype="CF_SQL_VARCHAR" type="in">
             <cfprocparam value="#descripcion#" cfsqltype="CF_SQL_VARCHAR" type="in">
             <cfprocparam value="#pkConjunto#" cfsqltype="cf_sql_numeric" type="in">
             <cfprocparam value="#pkUsuario#" cfsqltype="cf_sql_numeric" type="in">      
             <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
         </cfstoredproc>
         <cfreturn respuesta> 
     </cffunction>
     <!---
       * Fecha creacion: 23 de marzo de 2017
       * @author Jonathan Martinez
     ---> 
     <cffunction name="actualizarTabla" access="public">
         <cfargument name="pkTabla" type="numeric" required="yes" hint="Id de de la tabla">
         <cfargument name="nombre" type="string" required="yes" hint="Nombre de la Tabla">
         <cfargument name="descripcion" type="string" required="yes" hint="Descripcion de la Tabla">
         <cfstoredproc procedure="PDIPIMP.P_TABLASDINAMICAS.ACTUALIZAR_TABLA" datasource="DS_PDIPIMP">
             <cfprocparam value="#pkTabla#" cfsqltype="cf_sql_numeric" type="in">
             <cfprocparam value="#nombre#" cfsqltype="CF_SQL_VARCHAR" type="in">
             <cfprocparam value="#descripcion#" cfsqltype="CF_SQL_VARCHAR" type="in">     
             <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
         </cfstoredproc>
         <cfreturn respuesta> 
     </cffunction>
     <!---
       * Fecha creacion: 23 de marzo de 2017
       * @author Jonathan Martinez
     ---> 
     <cffunction name="guardarColumna" access="public">
         <cfargument name="pkTabla" type="numeric" required="yes" hint="Id de la tabla">
         <cfargument name="pkColumna" type="numeric" required="yes" hint="Id de la columna">
         <cfargument name="tipo" type="string" required="yes" hint="Tipo de columna en la tabla">
         <cfargument name="orden" type="numeric" required="yes" hint="Posicion">
         <cfstoredproc procedure="PDIPIMP.P_TABLASDINAMICAS.GUARDAR_COLUMNA" datasource="DS_PDIPIMP">
             <cfprocparam value="#pkTabla#" cfsqltype="cf_sql_numeric" type="in">
             <cfprocparam value="#pkColumna#" cfsqltype="cf_sql_numeric" type="in">
             <cfprocparam value="#tipo#" cfsqltype="CF_SQL_VARCHAR" type="in">
             <cfprocparam value="#orden#" cfsqltype="cf_sql_numeric" type="in">      
             <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
         </cfstoredproc>
         <cfreturn respuesta> 
     </cffunction>
     <!---
       * Fecha creacion: 24 de marzo de 2017
       * @author Jonathan Martinez
     ---> 
     <cffunction name="actualizarColumna" access="public">
         <cfargument name="pkTabla" type="numeric" required="yes" hint="Id de la tabla">
         <cfargument name="pkColumna" type="numeric" required="yes" hint="Id de la columna">
         <cfargument name="tipo" type="string" required="yes" hint="Tipo de columna en la tabla">
         <cfargument name="orden" type="numeric" required="yes" hint="Posicion">
           <cfstoredproc procedure="PDIPIMP.P_TABLASDINAMICAS.ACTUALIZAR_COLUMNA" datasource="DS_PDIPIMP">
               <cfprocparam value="#pkTabla#" cfsqltype="cf_sql_numeric" type="in">
               <cfprocparam value="#pkColumna#" cfsqltype="cf_sql_numeric" type="in">
               <cfprocparam value="#tipo#" cfsqltype="CF_SQL_VARCHAR" type="in">
               <cfprocparam value="#orden#" cfsqltype="cf_sql_numeric" type="in">      
               <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
           </cfstoredproc>
           <cfreturn respuesta> 
     </cffunction>
     <!---
       * Fecha creacion: 28 de marzo de 2017
       * @author Jonathan Martinez
     ---> 
     <cffunction name="guardarFiltro" access="public">
         <cfargument name="pkTabla" type="numeric" required="yes" hint="Id de la tabla">
         <cfargument name="pkColumna" type="numeric" required="yes" hint="Id de la columna">
         <cfargument name="pkFiltro" type="numeric" required="yes" hint="Id del filtro que se está aplicando">
         <cfargument name="valor" type="string" required="yes" hint="Valor del filtro">
         <cfstoredproc procedure="PDIPIMP.P_TABLASDINAMICAS.GUARDAR_FILTRO" datasource="DS_PDIPIMP">
             <cfprocparam value="#pkTabla#" cfsqltype="cf_sql_numeric" type="in">
             <cfprocparam value="#pkColumna#" cfsqltype="cf_sql_numeric" type="in">
             <cfprocparam value="#pkFiltro#" cfsqltype="cf_sql_numeric" type="in">
             <cfprocparam value="#valor#" cfsqltype="CF_SQL_VARCHAR" type="in">      
             <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
         </cfstoredproc>
         <cfreturn respuesta> 
     </cffunction>
     <!---
       * Fecha creacion: 29 de marzo de 2017
       * @author Jonathan Martinez
     ---> 
     <cffunction name="actualizarFiltro" access="public">
         <cfargument name="pkTabla" type="numeric" required="yes" hint="Id de la tabla">
         <cfargument name="pkColumna" type="numeric" required="yes" hint="Id de la columna">
         <cfargument name="pkFiltro" type="numeric" required="yes" hint="Id del filtro que se está aplicando">
         <cfargument name="valor" type="string" required="yes" hint="Valor del filtro">
           <cfstoredproc procedure="PDIPIMP.P_TABLASDINAMICAS.ACTUALIZAR_FILTRO" datasource="DS_PDIPIMP">
               <cfprocparam value="#pkTabla#" cfsqltype="cf_sql_numeric" type="in">
               <cfprocparam value="#pkColumna#" cfsqltype="cf_sql_numeric" type="in">
               <cfprocparam value="#pkFiltro#" cfsqltype="cf_sql_numeric" type="in">
               <cfprocparam value="#valor#" cfsqltype="CF_SQL_VARCHAR" type="in">       
               <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
           </cfstoredproc>
         <cfreturn respuesta> 
     </cffunction>
     <!---
       * Fecha creacion: 23 de marzo de 2017
       * @author Jonathan Martinez
     ---> 
     <cffunction name="obtenerTablasUsrCon" hint="Obtiene los identificadores de las tablas que pertenecen a un usuario y a un conjunto determinados">
         <cfargument name="idUsr">
         <cfargument name="idCon">
           <cfquery  name="obtenerTabUsrCon" datasource="DS_PDIPIMP">  
              SELECT  T.TTD_PK_TABLA AS idTab
              FROM  TDITTABLAS T
              WHERE T.TTD_FK_CONJUNTODATOS = '#idCon#'
              AND   T.TTD_FK_USUARIOCREADOR = '#idUsr#'
              AND   T.TTD_FK_ESTADO IN (1,2)
              ORDER BY  T.TTD_PK_TABLA
           </cfquery>
         <cfreturn obtenerTabUsrCon> 
     </cffunction>
     <!---
       * Fecha creacion: 28 de marzo de 2017
       * @author Jonathan Martinez
     ---> 
     <cffunction name="obtenerTablasCompartidas" hint="Obtiene los identificadores las tablas compartidas con el usuario">
         <cfargument name="idUsr">
         <cfargument name="idCon">
           <cfquery  name="obtenerTabCom" datasource="DS_PDIPIMP">  
              SELECT  T.TTU_FK_TABLA AS idTab
              FROM  TDITTABLAUSUARIO T, TDITTABLAS TA
              WHERE T.TTU_FK_TABLA = TA.TTD_PK_TABLA 
              AND   TA.TTD_FK_CONJUNTODATOS = '#idCon#'
              AND   T.TTU_FK_USUARIO = '#idUsr#'
              AND   TA.TTD_FK_ESTADO IN (1,2)
              AND   T.TTU_FK_ESTADO  IN (1,2)
              ORDER BY  T.TTU_FK_TABLA
           </cfquery>
         <cfreturn obtenerTabCom> 
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
       * Fecha creacion: 23 de marzo de 2017
       * @author Jonathan Martinez
     ---> 
     <cffunction name="eliminarTabla" hint="Elimina una Tabla">
         <cfargument name="idTab">
         <cfscript>
           var spTab = new storedproc(); 
           spTab.setDatasource("DS_PDIPIMP"); 
           spTab.setProcedure("P_TABLASDINAMICAS.ELIMINAR_TABLA"); 
              
           spTab.addParam(cfsqltype="cf_sql_numeric",type="in",value=idTab);
           spTab.addParam(cfsqltype="cf_sql_varchar",type="out", variable="resultado"); 
          
           var result = spTab.execute();     
           return  result.getprocOutVariables().resultado ;
         </cfscript>
     </cffunction>
     <!---
       * Fecha creacion: 28 de marzo de 2017
       * @author Jonathan Martinez
     ---> 
     <cffunction name="eliminarTablaC" hint="Elimina una Tabla compartida">
         <cfargument name="idTab">
         <cfargument name="idUsu">
         <cfscript>
           var spTab = new storedproc(); 
           spTab.setDatasource("DS_PDIPIMP"); 
           spTab.setProcedure("P_TABLASDINAMICAS.ELIMINAR_TABLASHARE"); 
              
           spTab.addParam(cfsqltype="cf_sql_numeric",type="in",value=idTab);
           spTab.addParam(cfsqltype="cf_sql_numeric",type="in",value=idUsu);
           spTab.addParam(cfsqltype="cf_sql_varchar",type="out", variable="resultado"); 
          
           var result = spTab.execute();     
           return  result.getprocOutVariables().resultado ;
         </cfscript>
     </cffunction>
     <!---
       * Fecha creacion: 27 de marzo de 2017
       * @author Jonathan Martinez
     ---> 
     <cffunction name="copiarTabla" hint="Realiza un copia de la Tabla seleccionada">
         <cfargument name="idTab">
         <cfargument name="idUsr">
         <cfscript>
           var spTab = new storedproc(); 
           spTab.setDatasource("DS_PDIPIMP"); 
           spTab.setProcedure("P_TABLASDINAMICAS.COPIAR_TABLA"); 
          
           spTab.addParam(cfsqltype="cf_sql_numeric",type="in",value=idTab);
           spTab.addParam(cfsqltype="cf_sql_numeric",type="in",value=idUsr);
           spTab.addParam(cfsqltype="cf_sql_numeric",type="out", variable="idTabC"); ; 
        
           var result = spTab.execute(); 
           return result.getprocOutVariables().idTabC;
         </cfscript>
     </cffunction>
     <!---
       * Fecha creacion: 28 de marzo de 2017
       * @author Jonathan Martinez
     ---> 
     <cffunction name="compartirTabla" hint="Comparte una tabla con un grupo de usuarios">
         <cfargument name="idTab">
         <cfargument name="idUsu">
         <cfargument name="usuarios">
         <cfscript>
           var spTab = new storedproc();
           spTab.setDatasource("DS_PDIPIMP");
           spTab.setProcedure("P_TABLASDINAMICAS.COMPARTIR_TABLA");

           spTab.addParam(cfsqltype="cf_sql_numeric",type="in",value=idTab);
           spTab.addParam(cfsqltype="cf_sql_numeric",type="in",value=idUsu);
           spTab.addParam(cfsqltype="cf_sql_varchar",type="in",value=usuarios);

           var result = spTab.execute();
           return;
         </cfscript>
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
       * Fecha creacion: 23 de mayo de 2017
       * @author Alejandro Rosales
     ---> 
     <cffunction name="getListColumna" access="public" returntype="query">
         <cfargument name="vista" type="string" required="yes">
         <cfargument name="nombreC" type="string" required="yes">
         <cfquery name="respuesta" datasource="DS_PDIPIMP">
          SELECT DISTINCT #nombreC# 
             FROM #vista#
                ORDER BY #nombreC# DESC
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

     <cffunction name="getExisteURCLAVE" access="public" returntype="query">
       <cfargument name = "nombreC" type="string" required="yes">
       <cfquery name="respuesta" datasource="DS_PDIPIMP">
         
         SELECT COUNT (*) VAL
            FROM ALL_TAB_COLUMNS
                WHERE TABLE_NAME = #PreserveSingleQuotes(nombreC)# AND COLUMN_NAME = 'DURURCLAVE'
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