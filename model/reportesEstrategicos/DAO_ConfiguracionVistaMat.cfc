<!---
* ============================================================================
* IPN - CSII
* Sistema: SII
* Modulo: Principal
* Sub modulo: Pruebas
* Fecha: 10 de diciembre de 2015
* Descripcion: Acceso a datos para la configuración de reportes estratégicos.
* ============================================================================
--->

<cfcomponent>

    <!---
    * Fecha creacion: 11 de diciembre de 2015
    * @author Yareli Licet Andrade Jimenez
    --->    
    <cffunction name="agregarConfiguracion" access="remote" hint="Guarda nueva configuracion de reportes estrategicos"> 
        <cfargument name="idUsuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfargument name="idConjunto" type="numeric" required="yes" hint="Clave del conjunto de datos">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre de la configuracion">
        <cfargument name="descripcion" type="string" required="no" hint="Descripcion de la configuracion">
        <cfargument name="configuracion" type="string" required="yes" hint="JSON de la configuracion">   
        <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.GUARDAR_REPORTE" datasource="DS_PDIPIMP">
            <cfprocparam value="#idUsuario#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#idConjunto#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#nombre#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#descripcion#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#configuracion#" cfsqltype="cf_sql_string" type="in">         
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>            
    </cffunction>  

    <!---
    * Fecha creacion: 14 de diciembre de 2015
    * @author Yareli Licet Andrade Jimenez
    --->
    <cffunction name="obtenerConfiguracion"access="remote" hint="Obtiene las configuraciones disponibles para un conjunto de datos especifico">
        <cfargument name="idUsuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfargument name="idConjunto" type="numeric" required="yes" hint="Clave del conjunto de datos">
        <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.OBTENER_REPORTE" datasource="DS_PDIPIMP">
            <cfprocparam value="#idUsuario#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#idConjunto#" cfsqltype="cf_sql_numeric" type="in">        
            <cfprocresult name="resConfiguracion">
        </cfstoredproc>
    <cfreturn resConfiguracion>
    </cffunction>

    <!---
    * Fecha creacion: 14 de diciembre de 2015
    * @author Yareli Licet Andrade Jimenez
    --->    
    <cffunction name="cargarCongiguracion" access="remote" hint="Consulta los parametros de una configuracion definida">
        <cfargument name="idUsuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfargument name="idConjunto" type="numeric" required="yes" hint="Clave del conjunto de datos">
        <cfargument name="idConfiguracion" type="numeric" required="yes" hint="Clave de la configuracion">
        <cftry>
            <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.CONSULTAR_CONFIGURACION" datasource="DS_PDIPIMP">
                <cfprocparam value="#idUsuario#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#idConjunto#" cfsqltype="cf_sql_numeric" type="in">    
                <cfprocparam value="#idConfiguracion#" cfsqltype="cf_sql_numeric" type="in">         
                <cfprocresult name="resParametros">
            </cfstoredproc>
            <cfreturn resParametros>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>

    <!---   
    * Fecha creacion: 26 de enero de 2016
    * @author Yareli Andrade
    --->
    <cffunction name="eliminarReporte" access="remote" hint="Elimina el reporte seleccionado">
        <cfargument name="idReporte" type="numeric" required="yes" hint="Clave del reporte estrategico">
        <cfargument name="idUsuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfargument name="idConjunto" type="numeric" required="yes" hint="Clave del conjunto de datos">
        <cftry>
            <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.ELIMINAR_REPORTE" datasource="DS_PDIPIMP">
                <cfprocparam value="#idReporte#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#idUsuario#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#idConjunto#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>

    <!---   
    * Fecha creacion: 03 de febrero de 2016
    * @author Yareli Andrade
    --->
    <cffunction name="actualizarReporte" access="remote" hint="Actualiza el reporte seleccionado">
        <cfargument name="idReporte" type="numeric" required="yes" hint="Clave del reporte estrategico">
        <cfargument name="idUsuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfargument name="idConjunto" type="numeric" required="yes" hint="Clave del conjunto de datos">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre de la configuracion">
        <cfargument name="descripcion" type="string" required="no" hint="Descripcion de la configuracion">
        <cfargument name="configuracion" type="string" required="yes" hint="JSON de la configuracion">
        <cftry> 
            <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.EDITAR_REPORTE" datasource="DS_PDIPIMP">
                <cfprocparam value="#idReporte#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#idUsuario#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#idConjunto#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#nombre#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#descripcion#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#configuracion#" cfsqltype="cf_sql_string" type="in">         
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
            <cfcatch>
                <cfreturn 0>
            </cfcatch>
        </cftry>
    </cffunction>

    <!---
    *Funciones para el Modulo de Compartir
    * Fecha creacion: 16 de febrero de 2017
    * @author Jonathan Martinez
    --->
    <cffunction name="obtenerConfiguracionShare"access="remote" hint="Obtiene las configuraciones disponibles que han sido compartidas">
        <cfargument name="idUsuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfargument name="idConjunto" type="numeric" required="yes" hint="Clave del conjunto de datos">
        <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.OBTENER_REPORTE_SHARE" datasource="DS_PDIPIMP">
            <cfprocparam value="#idUsuario#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#idConjunto#" cfsqltype="cf_sql_numeric" type="in">        
            <cfprocresult name="resConfiguracion">
        </cfstoredproc>
    <cfreturn resConfiguracion>
    </cffunction>

    <!---
    * Fecha creacion: 15 de febrero de 2017
    * @author Jonathan Martinez
    --->
    <cffunction name="obtenershareUserG"access="remote" hint="Obtiene los Usuarios para Compartir">
        <cfargument name="idUsuario" type="numeric" required="yes" hint="Clave del usuario">
        <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.OBTENER_USERS" datasource="DS_PDIPIMP">
             <cfprocparam value="#idUsuario#" cfsqltype="cf_sql_numeric" type="in">        
            <cfprocresult name="resshareUser">
        </cfstoredproc>
    <cfreturn resshareUser>
    </cffunction>

     <!---
    * Fecha creacion: 17 de febrero de 2017
    * @author Jonathan Martinez
    * Fecha modificacion: 8 de Marzo de 2017
    * @author Jonathan Martinez
    * Fecha modificacion: 9 de Marzo de 2017
    * @author Alejandro Rosales
    --->
    <cffunction name="obtenershareUserS"access="remote" hint="Obtiene los Usuarios a los Cuales ya se les Compartio">
        <cfargument name="idReporte" type="numeric" required="yes" hint="Clave del Reporte">
        <cfquery name="resshareUser" datasource="DS_PDIPIMP">
          SELECT U.TUS_PK_USUARIO AS PK_USUARIO, R.TRU_DATOS AS PRIVILEGIO, R.TRU_PK_REPORTEUSUARIO AS PK_RELACION
    FROM USRTUSUARIO U, RESTREPORTEUSUARIO R
   WHERE     U.TUS_PK_USUARIO = R.TRU_FK_USUARIO
         AND R.TRU_FK_REPORTE = #idReporte#
         AND U.TUS_FK_ESTADO IN (1, 2)
         AND R.TRU_FK_ESTADO IN (1, 2)
ORDER BY PK_USUARIO
      </cfquery>
    <cfreturn resshareUser>
    </cffunction>

    <!---
   * Fecha creacion: 31 de marzo de 2017
   * @author Jonathan Martinez
   --->
   <cffunction name="obtenerreportes"access="remote" hint="Obtiene los reportes a los que se puede relacionar">
        <cfargument name="idUsuario" type="numeric" required="yes" hint="Clave del Usuario">
        <cfargument name="idConjunto" type="numeric" required="yes" hint="Clave del conjunto">
        <cfargument name="idReporte" type="ANY" required="yes" hint="Clave del Reporte">
        <cfquery name="reportes" datasource="DS_PDIPIMP">
            SELECT      R.PK_CONFIGURACION          AS IDREP, 
                        R.NOMBRE_CONFIGURACION      AS NOMBRE, 
                        R.DESCRIPCION_CONFIGURACION AS DES,
                        R.CONFIGURACION             AS CONFIG,
                        R.FECHA_ULTIMA_MODIFICACION AS FECHA
            FROM    RESTCONFIGURACION R
            WHERE   R.FK_USUARIO            = #idUsuario#
            AND     R.FK_CONJUNTO_DE_DATOS  = #idConjunto#
            AND     R.PK_CONFIGURACION  NOT IN (#idReporte#)
            AND     R.FK_ESTADO IN (1, 2)
            ORDER BY IDREP
        </cfquery>
   <cfreturn reportes>
   </cffunction>
    <!---
   * Fecha creacion:4 de abril de 2017
   * @author Jonathan Martinez
   --->
   <cffunction name="obtenerarbolreportes"access="remote" hint="Obtiene todos los reportes involucrados en la relacion">
        <cfargument name="idsReportes" type="any" required="yes" hint="Clave del Reporte">
        <cfquery name="reportes" datasource="DS_PDIPIMP">
            SELECT      R.PK_CONFIGURACION          AS IDREP
            FROM    RESTCONFIGURACION R
            WHERE   R.FK_RELACIONREPORTE IN (#idsReportes#)
            AND     R.FK_ESTADO IN (1, 2)
            ORDER BY IDREP
        </cfquery>
   <cfreturn reportes>
   </cffunction>
    <!---
    * Fecha creacion: 31 de marzo de 2017
    * @author Jonathan Martinez
    --->
    <cffunction name="obtenerrelacionReport"access="remote" hint="Obtiene el reporte al cual esta relacionado">
         <cfargument name="idReporte" type="numeric" required="yes" hint="Clave del Reporte">
         <cfquery name="relacion" datasource="DS_PDIPIMP">
             SELECT      R.FK_RELACIONREPORTE         AS IDREP 
             FROM    RESTCONFIGURACION R
             WHERE   R.PK_CONFIGURACION = #idReporte#
             AND     R.FK_ESTADO IN (1, 2)
             ORDER BY IDREP
         </cfquery>
    <cfreturn relacion>
    </cffunction>
    <!---
    * Fecha creacion: 31 de marzo de 2017
    * @author Jonathan Martinez
    --->    
    <cffunction name="agregarRelacion" access="remote" hint="Guarda la relacion del reporte"> 
        <cfargument name="idReporte" type="numeric" required="yes" hint="Clave del reporte">
        <cfargument name="idRelacion" type="numeric" required="yes" hint="Clave del reporte a relacionar">
        <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.GUARDAR_RELACION" datasource="DS_PDIPIMP">
            <cfprocparam value="#idReporte#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#idRelacion#" cfsqltype="cf_sql_numeric" type="in">      
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>            
    </cffunction>  
     <!---
    * Fecha creacion: 20 de febrero de 2017
    * @author Jonathan Martinez
    * Fecha modificacion: 8 de Marzo de 2017
    * @author Jonathan Martinez
    --->
    <cffunction name="obtenershareupdate"access="remote" hint="Obtiene los Usuarios a los Cuales ya se les Compartio eliminandolos">
        <cfargument name="idReporte" type="numeric" required="yes" hint="Clave del Reporte">
        <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.OBTENER_SHAREUSER" datasource="DS_PDIPIMP">
             <cfprocparam value="#idReporte#" cfsqltype="cf_sql_numeric" type="in">        
            <cfprocresult name="resshareUser">
        </cfstoredproc>
    <cfreturn resshareUser>
    </cffunction>


    <!---
    * Fecha creacion: 16 de febrero de 2017
    * @author Jonathan Martinez
    --->    
    <cffunction name="agregarShare" access="remote" hint="Guarda un Usuario para Compartir"> 
        <cfargument name="idUsuario" type="numeric" required="yes" hint="Clave del usuario a Compartir">
        <cfargument name="idReporte" type="string" required="yes" hint="Clave del Reporte">
        <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.GUARDAR_SHARE" datasource="DS_PDIPIMP">
            <cfprocparam value="#idUsuario#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#idReporte#" cfsqltype="cf_sql_numeric" type="in">      
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>            
    </cffunction>  

    <!---
    * Fecha creacion: 20 de febrero de 2017
    * @author Jonathan Martinez
    --->    
    <cffunction name="actualizaShare" access="remote" hint="Actualiza un usuario en la lista de Compartir"> 
        <cfargument name="idUsuario" type="numeric" required="yes" hint="Clave del usuario a Compartir">
        <cfargument name="idReporte" type="string" required="yes" hint="Clave del Reporte">
        <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.EDITAR_SHARE" datasource="DS_PDIPIMP">
            <cfprocparam value="#idUsuario#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#idReporte#" cfsqltype="cf_sql_numeric" type="in">      
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>            
    </cffunction>

    <!---
    * Fecha creacion: 07 de Marzo de 2017
    * @author Alejandro Rosales
    --->    
    <cffunction name="getReporte" access="remote" hint="Obtiene la configuracion de un reporte a partir del PK"> 
        <cfargument name="idReporte" type="numeric" required="yes" hint="Clave del Reporte">
        <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.GET_REPORTE" datasource="DS_PDIPIMP">
            <cfprocparam value="#idReporte#" cfsqltype="cf_sql_numeric" type="in">   
            <cfprocresult name="resReporte">           
        </cfstoredproc>
        <cfreturn resReporte>            
    </cffunction>

    <!--- 
    * Fecha creacion: 09 de Marzo de 2017
    * @author Alejandro Rosales
    --->
    <cffunction name ="setPrivilegio" access="remote" hint = "Cambia el tipo de privilegio de una relacion">
        <cfargument name = "idRelacion" type="numeric" required="yes" hint="id de la relacion">
         <cfargument name="estado" type="numeric" required="yes" hint="nuevo estado">  
        <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.ACTUALIZA_PRIVILEGIO" datasource="DS_PDIPIMP">
            <cfprocparam value="#idRelacion#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#estado#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
                
        <cfreturn respuesta>
    </cffunction>

    <!--- 
    * Fecha creacion: 31 de Marzo de 2017
    * @author Alejandro Rosales
    --->
    <cffunction name="getReportRelated" access="remote" hint = "Obtiene el reporte relacionado">
        <cfargument name="pkReporte" type="numeric" required="yes" hint="pkReporte a consultar">
        <cfquery name = "resultado" datasource="DS_PDIPIMP">
            SELECT FK_RELACIONREPORTE R, DESCRIPCION_CONFIGURACION D FROM PDIPIMP.RESTCONFIGURACION WHERE PK_CONFIGURACION = #pkReporte#
        </cfquery>
        <cfreturn resultado>
    </cffunction>

     <!--- 
    * Fecha creacion: 27 de Septiembre de 2017
    * @author Alejandro Rosales
    --->
    <cffunction name="altaShare" access="remote" hint="Alta comparticion de reportes">
        <cfargument name="idReporte" type="numeric" required="true" hint="pk del reporte">
        <cfargument name="idUsuario" type="numeric" required="true" hint="pk de usuario">
            <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.ALTA_SHARE" datasource="DS_PDIPIMP">
            <cfprocparam value="#idReporte#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#idUsuario#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>
    </cffunction>

     <!--- 
    * Fecha creacion: 27 de Septiembre de 2017
    * @author Alejandro Rosales
    --->
    <cffunction name="bajaShare" access="remote" hint="Alta comparticion de reportes">
        <cfargument name="idReporte" type="numeric" required="true" hint="pk del reporte">
        <cfargument name="idUsuario" type="numeric" required="true" hint="pk de usuario">
            <cfstoredproc procedure="PDIPIMP.P_REPORTES_ESTRATEGICOS.BAJA_SHARE" datasource="DS_PDIPIMP">
            <cfprocparam value="#idReporte#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#idUsuario#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>
    </cffunction>

   <!---
    * Fecha: Octubre 03, 2017
    * Autor: Alejandro Rosales
    --->
    <cffunction name="getEstadoPrivilegio" access="remote" hint = "Obtiene el reporte relacionado">
        <cfargument name="idRelacion" type="any" required="true" hint="pk relacion">
        <cfquery name = "resultado" datasource="DS_PDIPIMP">
            SELECT NVL(RESTREPORTEUSUARIO.TRU_DATOS,0) P FROM  RESTREPORTEUSUARIO WHERE RESTREPORTEUSUARIO.TRU_PK_REPORTEUSUARIO = #idRelacion#
        </cfquery>
        <cfreturn resultado.P>
    </cffunction>



</cfcomponent>
