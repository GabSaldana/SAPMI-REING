<!---
* =========================================================================
* IPN - CSII
* Sistema: SII
* Modulo: Chat
* Sub modulo: Administrador Chat
* Fecha: Junio, 2017
* Descripcion: Model para administracion de Chat
* =========================================================================
--->

<cfcomponent>
   <!---
     * Fecha creacion: 28 Junio, 2017
     * @author Jonathan Martínez
   --->
   <cffunction name="getSubcanales" access="public"  hint="Funcion para obtener los subcanales">
    <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
     <cfscript>
             var spTab = new storedproc();
             spTab.setDatasource("DS_GRAL");
             spTab.setProcedure ("P_CHAT.GET_CANALES");
             spTab.addParam(cfsqltype="cf_sql_numeric",type="in",value=rol);
             spTab.addProcResult(name="canales",resultset=1); 
             var result = spTab.execute();
             return result.getProcResultSets().canales;
         </cfscript>
   </cffunction>


   <!---
     * Fecha creacion: 28 Junio, 2017
     * @author Jonathan Martínez
   --->
   <cffunction name="obtenerProcesos" access="public" returntype="query" hint="Funcion para obtener procesos">
     <cfargument name="rol" type="numeric" hint="Rol del Usuario">
     <cfscript>
             var spTab = new storedproc();
             spTab.setDatasource("DS_GRAL");
             spTab.setProcedure ("P_CHAT.GET_PROCESOS");
             spTab.addParam(cfsqltype="cf_sql_numeric",type="in",value=rol);
             spTab.addProcResult(name="procesos",resultset=1); 
             var result = spTab.execute();
             return result.getProcResultSets().procesos;
         </cfscript>
   </cffunction>

   <!---
     * Fecha creacion: 02 Agosto, 2017
     * @author Jonathan Martínez
   --->
   <cffunction name="guardarChat" access="public"  hint="Funcion para guardar la conversacion">
     <cfargument name="chat" type="array">
     <cfargument name="subcanal" type="string">
         <cfscript>
             var spTab = new storedproc();
             spTab.setDatasource("DS_GRAL");
             spTab.setProcedure ("P_CHAT.GUARDAR_CHAT");

             spTab.addParam(cfsqltype="CF_SQL_VARCHAR", type="in",value=serializeJSON(chat));
             spTab.addParam(cfsqltype="CF_SQL_VARCHAR", type="in",value=subcanal);
             spTab.addParam(cfsqltype="cf_sql_numeric", type="out", variable="resultado");
             
             var result = spTab.execute();     
             return result.getprocOutVariables().resultado;
         </cfscript>
   </cffunction>
   <!---
     * Fecha creacion: 02 Agosto, 2017
     * @author Jonathan Martínez
   --->
   <cffunction name="getChat" access="public"  hint="Funcion para guardar la conversacion">
     <cfargument name="canal" type="string">
     <cfscript>
             var spTab = new storedproc();
             spTab.setDatasource("DS_GRAL");
             spTab.setProcedure ("P_CHAT.GET_CHAT");

             spTab.addParam(cfsqltype="CF_SQL_VARCHAR",type="in",value=canal);

             spTab.addProcResult(name="chat",resultset=1); 

             var result = spTab.execute();
             return result.getProcResultSets().chat;
         </cfscript>
   </cffunction>
   <!---
     * Fecha creacion: 08 Agosto, 2017
     * @author Alejandro Rosales
   --->
   <cffunction name="obtenerAProcesos" access="public"  hint="Funcion para guardar la conversacion">
     <cfquery name="procesos" datasource="DS_GRAL">
             SELECT TCP_PK_PROCESO PK,
                    TCP_PROCESO_NOMBRE NOMBRE,
                    TCP_PROCESO_DESCRIPCION DESCRIPCION
             FROM GRAL.CHTTPROCESO 
             WHERE TCP_PROCESO_ESTADO > 0
             ORDER BY NOMBRE
     </cfquery>
     <cfreturn procesos>
   </cffunction>
   <!---
     * Fecha creacion: 24 Agosto, 2017
     * @author Jonathan Martinez
   --->
   <cffunction name="comprobarNombre" access="public"  hint="Funcion para verificar que el nombre del proceso no se repita">
     <cfargument name="name" type="string">
     <cfquery name="nombre" datasource="DS_GRAL">
             SELECT TCP_PK_PROCESO PK
             FROM   GRAL.CHTTPROCESO 
             WHERE  TCP_PROCESO_NOMBRE = '#name#'
             AND    TCP_PROCESO_ESTADO > 0
     </cfquery>
     <cfreturn nombre>
   </cffunction>
   <!---
        * Fecha creacion: Agosto 08, 2017
        * @author Alejandro Rosales 
     --->
   <cffunction name="agregarProceso" access="remote" hint="Funcion para obtener todos los procesos del sistema">
       <cfargument name="name" type="any" required="yes" />
       <cfargument name="desc" type="any" required="yes" />
       <cfstoredproc procedure="GRAL.P_CHAT.AGREGAR_PROCESO" datasource="DS_GRAL">
             <cfprocparam value="#name#" cfsqltype="CF_SQL_VARCHAR" type="in">
             <cfprocparam value="#desc#" cfsqltype="CF_SQL_VARCHAR" type="in">     
             <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
       </cfstoredproc>
     <cfreturn respuesta>
    </cffunction>
    <!---
        * Fecha creacion: Agosto 08, 2017
        * @author Alejandro Rosales  
     --->
    <cffunction name="eliminarProceso" access="remote" hint="Funcion para eliminar un proceso seleccionado procesos del sistema">
      <cfargument name="pk" type="any" required="yes" />
         <cfstoredproc procedure="GRAL.P_CHAT.ELIMINAR_PROCESO" datasource="DS_GRAL">
             <cfprocparam value="#pk#" cfsqltype="cf_sql_numeric" type="in">
             <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
         </cfstoredproc>
     <cfreturn respuesta>
    </cffunction>
     <!---
        * Fecha creacion: Agosto 08, 2017
        * @author Alejandro Rosales  
     --->
     <cffunction name="mostrarProcesos" access="remote" hint="Funcion para obtener los procesos">
         <cfquery name="procesos" datasource="DS_GRAL">
             SELECT DISTINCT TCP_PROCESO_NOMBRE      AS NOMBRE,
                             TCP_PROCESO_DESCRIPCION AS DESCRIPCION,
                             TCP_PK_PROCESO          AS ID
             FROM   GRAL.CHTTPROCESO
             WHERE  TCP_PROCESO_ESTADO > 0
             ORDER BY NOMBRE
         </cfquery>
         <cfreturn procesos>
     </cffunction>
       <!---
        * Fecha creacion: Agosto 08, 2017
        * @author Alejandro Rosales 
     --->
     <cffunction name="consultaTotalGral" access="remote" hint="Funcion para obtener informacion del proceso rol">
         <cfquery name="relacion" datasource="DS_GRAL">
             SELECT ROL.TRO_ROL_NOMBRE     AS ROL,
                    ROL.TRO_PK_ROL         AS ROLPK,
                    PROCESOS.PKPROCESO     AS PKPROCESO,
                    PROCESOS.PROCESONOMBRE AS PROCESONOMBRE
             FROM GRAL.USRTROL ROL,
                  (SELECT PRC.TCP_PK_PROCESO AS PKPROCESO,
                          PRC.TCP_PROCESO_NOMBRE  AS PROCESONOMBRE,
                          PRR.TPR_FK_ROL AS PKROL
                   FROM GRAL.CHTTPROCESOROL PRR, GRAL.CHTTPROCESO PRC
                   WHERE PRC.TCP_PK_PROCESO = PRR.TPR_FK_PROCESO
                   AND PRC.TCP_PROCESO_ESTADO > 0
                   AND PRR.TPR_FK_ESTADO  > 0) PROCESOS
             WHERE      ROL.TRO_PK_ROL = PROCESOS.PKROL(+)
             ORDER BY   ROL.TRO_PK_ROL
     </cfquery>
     <cfreturn relacion>
    </cffunction>
     <!---
       * Fecha creacion: Agosto 08, 2017
       * @author Alejandro Rosales 
     --->
   <cffunction name="altaProcesosRol" access="remote" hint="Alta de un nuevo proceso/rol">
      <cfargument name="proceso" type="any" required="yes" />
        <cfargument name="rol" type="any" required="yes" />
       <cfstoredproc procedure="P_CHAT.ALTA_PROCESO" datasource="DS_GRAL">
             <cfprocparam value="#proceso#" cfsqltype="cf_sql_numeric" type="in">
             <cfprocparam value="#rol#" cfsqltype="cf_sql_numeric" type="in">     
             <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
         </cfstoredproc>
     <cfreturn respuesta>
    </cffunction>

     <!---
       * Fecha creacion: Agosto 08, 2017
       * @author Alejandro Rosales 
     --->
   <cffunction name="bajaProcesosRol" access="remote" hint="Baja de un nuevo proceso/rol">
      <cfargument name="proceso" type="any" required="yes" />
        <cfargument name="rol" type="any" required="yes" />
       <cfstoredproc procedure="P_CHAT.BAJA_PROCESO" datasource="DS_GRAL">
             <cfprocparam value="#proceso#" cfsqltype="cf_sql_numeric" type="in">
             <cfprocparam value="#rol#" cfsqltype="cf_sql_numeric" type="in">     
             <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
         </cfstoredproc>
     <cfreturn respuesta>
    </cffunction>

     <!---
       * Fecha creacion: Agosto 14, 2017
       * @author Alejandro Rosales 
     --->
   <cffunction name="editarProceso" access="remote" hint="Edicion de un proceso">
      <cfargument name="pk" type="any" required="yes" />
      <cfargument name="name" type="any" required="yes" />  
      <cfargument name="desc" type="any" required="yes" />
      <cfstoredproc procedure="P_CHAT.EDITA_PROCESO" datasource="DS_GRAL">
         <cfprocparam value="#pk#" cfsqltype="cf_sql_numeric" type="in">
        <cfprocparam value="#name#" cfsqltype="CF_SQL_VARCHAR" type="in">     
        <cfprocparam value="#desc#" cfsqltype="CF_SQL_VARCHAR" type="in">           
        <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
      </cfstoredproc>
     <cfreturn respuesta>
    </cffunction>

      <!---
       * Fecha creacion: Agosto 15, 2017
       * @author Jonathan Martinez
     --->
   <cffunction name="inicializarProceso" access="remote" hint="Función para inicializar un proceso">
       <cfargument name="pk" type="any" required="yes"/>
       <cfstoredproc procedure="P_CHAT.INICIALIZA_PROCESO" datasource="DS_GRAL">
         <cfprocparam value="#pk#" cfsqltype="cf_sql_numeric" type="in">          
         <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
       </cfstoredproc>
       <cfreturn respuesta>
   </cffunction>

  
</cfcomponent>