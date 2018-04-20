<cfcomponent>

    <cffunction name="obtenerModulos" hint="Obtiene los modulos del sistema">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT
                TMOD.TMO_PK_MODULO AS PK,
                TMOD.TMO_MODULO_NOMBRE AS NOMBRE
            FROM                 
                PDIPIMP.USRTMODULO TMOD
		   WHERE TMO_FK_VERTIENTE = #Session.cbstorage.usuario.VERTIENTE#
			  OR TMO_FK_VERTIENTE = 0	
            ORDER BY PK                   
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="obtenerLista" hint="Obtiene los usuarios del sistema">
        <cfargument name="pkUR" type="string" required="yes" hint="Clave de la unidad responsable">
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT TROL.TRO_ROL_NOMBRE       AS NOMBRE,
                   TROL.TRO_ROL_CLAVE        AS USRNAME,
                   TROL.TRO_ROL_DESC         AS descripcion,
                   TROL.TRO_PK_ROL           AS CVEUSR,
                   TMOD.TMO_MODULO_NOMBRE    AS MODULO,
                   TROL.TRO_FK_ESTADO        AS EDO,
                   TVER.TVE_VERTIENTE_NOMBRE AS VERT
              FROM PDIPIMP.USRTROL       TROL,
                   PDIPIMP.USRTMODULO    TMOD,
                   PDIPIMP.USRTVERTIENTE TVER
             WHERE TROL.TRO_MODULOINICIAL = TMOD.TMO_PK_MODULO(+)
               AND TVER.TVE_PK_VERTIENTE = TROL.TRO_FK_VERTIENTE

                <cfif NOT #ArrayFind(Session.cbstorage.grant, 'privilegios.adminRoles')#>
                    AND TROL.TRO_FK_VERTIENTE = #Session.cbstorage.usuario.VERTIENTE#
                </cfif>

            ORDER BY TVER.TVE_PK_VERTIENTE
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="guardarRol" hint="Guarda nuevo registro en la BD">        
        <cfargument name="nombre"  type="string" required="yes" hint="UR del usuario">
        <cfargument name="clave" type="string" required="yes" hint="Rol del usuario">
        <cfargument name="descripcion" type="string" required="yes" hint="Genero del usuario">
        <cfargument name="prefijo" type="string" required="yes" hint="Acronimo del usuario"> 
        <cfargument name="modulo" type="numeric" required="yes" hint="Modulo en que el rol inicia sesion">
        <cfargument name="vertiente" type="numeric" required="yes" hint="pk de la vertiente">       
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ROLES.GUARDAR_USUARIO" datasource="DS_PDIPIMP">
                <cfprocparam value="#nombre#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#clave#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#descripcion#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#prefijo#" cfsqltype="cf_sql_string" type="in">                
                <cfprocparam value="#modulo#" cfsqltype="cf_sql_numeric" type="in"> 
				<cfprocparam value="#vertiente#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
        
    </cffunction> 

    <cffunction name="obtenerRoles" hint="Obtiene los usuarios del sistema">        
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            Select  TRO_ROL_NOMBRE as Nombre,        
                    TRO_PK_ROL as   PK
            FROM USRTROL TRO
            WHERE 
                TRO_FK_ESTADO= '2'
            ORDER BY Nombre                   
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>


    <cffunction name="consultarUsuario" hint="Consulta el usuario seleccionado">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="Pk del usuario">
        <cfquery name="qUsuario" datasource="DS_PDIPIMP">
            SELECT 
                TROL.TRO_ROL_NOMBRE AS NOMBRE,
                TROL.TRO_ROL_CLAVE AS CVE,
                TROL.TRO_ROL_DESC AS DESCRIPCION,
                TROL.TRO_ROL_PREFIJO AS PREFIJO,
                TROL.TRO_MODULOINICIAL AS MODULO,
                TROL.TRO_FK_VERTIENTE AS PKVERT
            FROM 
                PDIPIMP.USRTROL TROL
            WHERE TROL.TRO_PK_ROL = '#arguments.pkUsuario#'
        </cfquery>
        <cfreturn qUsuario>        
    </cffunction>

    <cffunction name="editarUsuario" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="Pk del Rol">
        <cfargument name="nombre" type="string" required="yes" hint="Titulo del Rol">
        <cfargument name="clave" type="string" required="yes" hint="clave identificadora del Rol">
        <cfargument name="descripcion" type="string" required="yes" hint="descripcion de las funciones del Rol">
        <cfargument name="prefijo" type="string" required="yes" hint="Prefijo del Rol">
        <cfargument name="modulo" type="numeric" required="yes" hint="Modulo en que el rol inicia sesion"> 
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ROLES.EDITAR_USUARIO" datasource="DS_PDIPIMP">                
                <cfprocparam value="#pkUsuario#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#nombre#" cfsqltype="cf_sql_varchar" type="in">
                <cfprocparam value="#clave#" cfsqltype="cf_sql_varchar" type="in">
                <cfprocparam value="#descripcion#" cfsqltype="cf_sql_varchar" type="in">
                <cfprocparam value="#prefijo#" cfsqltype="cf_sql_varchar" type="in">
                <cfprocparam value="#modulo#" cfsqltype="cf_sql_numeric" type="in"> 
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
         
    </cffunction>

    <cffunction name="cambiarEstado" returntype="numeric" hint="Cambia el registro del usuario al estado indicado">
        <cfargument name="pkUsu" hint="Clave de usuario">
        <cfargument name="pkEdo" hint="Estado al que se quiere actualizar">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ROLES.CAMBIAR_ESTADO" datasource="DS_PDIPIMP">
                <cfprocparam value="#pkUsu#"        cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkEdo#"        cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta"   cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
          
    </cffunction>    

  <!--- ------------------------------------------------------------------------------



       Acciones



    ----------------------------------------------------------------------------------->

    <cffunction name="mostrarAcciones" hint="Obtiene los usuarios del sistema">  
        <cfargument name="modulo" type="numeric" required="yes" hint="Clave de la acción formativa">      
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT DISTINCT
                TAC_ACCION_NOMBRE AS nombre, 
                TAC_ACCION_DESC AS descripcion, 
                TAC_ACCION_CLAVE AS CVE, 
                TAC_FK_ESTADO AS EDO,
                TAC_PK_ACCION AS ID
            FROM PDIPIMP.USRTACCION, PDIPIMP.USRRACCIONROL, PDIPIMP.USRTMODULO
            WHERE
                TAC_FK_MODULO = TMO_PK_MODULO   
                <cfif modulo neq " " OR 0>
                    AND TAC_FK_MODULO = #modulo# 
                </cfif>            
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="mostrarMod" hint="Obtiene los usuarios del sistema">        
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT MOD.TMO_MODULO_NOMBRE     AS Nombre, 
                   MOD.TMO_PK_MODULO         AS PK,
                   TVER.TVE_VERTIENTE_NOMBRE AS VERTIENTE
              FROM PDIPIMP.USRTMODULO    MOD,
                   PDIPIMP.USRTVERTIENTE TVER
             WHERE MOD.TMO_FK_ESTADO = 2
               AND TVER.TVE_PK_VERTIENTE = MOD.TMO_FK_VERTIENTE
               ORDER BY TVE_PK_VERTIENTE
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

     <cffunction name="mostrarAcc" hint="Obtiene los usuarios del sistema">        
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT DISTINCT TAC_ACCION_NOMBRE AS Titulo
                from USRTACCION
            ORDER BY TAC_ACCION_NOMBRE
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <cffunction name="guardarAccion" hint="Guarda nuevo registro en la BD">        
        <cfargument name="modulo"  type="numeric" required="yes" hint="Módulo al que pertenece la acción">
        <cfargument name="nombre" type="string" required="yes" hint="titulo de la acción">
        <cfargument name="descripcion" type="string" required="yes" hint="Descripción general de las funciones de la acción">
        <cfargument name="orden" type="numeric" required="yes" hint="Identificador del orden al que pertenecen las acciónes">
        <cfargument name="clave" type="string" required="yes" hint="Identificador de la acción dentro del sistema">
        <cfargument name="icono" type="string" required="yes" hint="imagen relacionada con la acción">        
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ACCIONES.GUARDAR_ACCION" datasource="DS_PDIPIMP">
                <cfprocparam value="#modulo#" cfsqltype="cf_sql_numeric" type="in">
		<cfprocparam value="#estado#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#nombre#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#descripcion#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#orden#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#clave#" cfsqltype="cf_sql_string" type="in">
                <cfprocparam value="#icono#" cfsqltype="cf_sql_string" type="in">               
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>
    
    <cffunction name="consultarInfoAcciones" hint="Consulta el usuario seleccionado">
        <cfargument name="pkAccion" type="numeric" required="yes" hint="Pk del usuario">
        <cfquery name="qUsuario" datasource="DS_PDIPIMP">
            SELECT DISTINCT            
                TROL.TAC_ACCION_NOMBRE AS NOMBRE,
                TROL.TAC_ACCION_DESC AS DESCRIPCION,
                TROL.TAC_ACCION_ORDEN AS ORDEN,
                TROL.TAC_ACCION_CLAVE AS CLAVE,            
                TROL.TAC_ICONO  AS ICONO
            FROM 
                PDIPIMP.USRTACCION TROL
            WHERE TROL.TAC_PK_ACCION = '#arguments.pkAccion#'
        </cfquery>
        <cfreturn qUsuario>        
    </cffunction>

    <cffunction name="editarAccion" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkAccion" type="numeric" required="yes" hint="Pk del Rol">
        <cfargument name="nombre" type="string" required="yes" hint="titulo de la acción">
        <cfargument name="descripcion" type="string" required="yes" hint="Descripción general de las funciones de la acción">
        <cfargument name="orden" type="numeric" required="yes" hint="Identificador del orden al que pertenecen las acciónes">
        <cfargument name="clave" type="string" required="yes" hint="Identificador de la acción dentro del sistema">
        <cfargument name="icono" type="string" required="yes" hint="imagen relacionada con la acción">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ACCIONES.EDITAR_ACCION" datasource="DS_PDIPIMP">                
                <cfprocparam value="#pkAccion#"    cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#nombre#"       cfsqltype="cf_sql_varchar" type="in">
                <cfprocparam value="#descripcion#"  cfsqltype="cf_sql_varchar" type="in">
                <cfprocparam value="#orden#"        cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#clave#"        cfsqltype="cf_sql_varchar" type="in">
                <cfprocparam value="#icono#"        cfsqltype="cf_sql_varchar" type="in">
                <cfprocparam variable="respuesta"   cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>

     <cffunction name="cambiarEstadoAcc" returntype="numeric" hint="Cambia el registro del usuario al estado indicado">
        <cfargument name="pkUsu" hint="Clave de usuario">
        <cfargument name="pkEdo" hint="Estado al que se quiere actualizar">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ACCIONES.CAMBIAR_ESTADO" datasource="DS_PDIPIMP">
                <cfprocparam value="#pkUsu#"        cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#pkEdo#"        cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta"   cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>



    <!--- ------------------------------------------------------------------------------



        GENERAL



    ----------------------------------------------------------------------------------->

    <cffunction name="getNumeroAccionesRol" hint="Consulta el usuario seleccionado">
        <cfargument name="pkModulo" type="numeric" required="yes" hint="Clave del módulo con el que se realiza la busqueda">
        <cfargument name="pkVertiente" type="numeric" required="yes" hint="Clave del módulo con el que se realiza la busqueda">
        <cfquery name="qUsuario" datasource="DS_PDIPIMP">
            SELECT  
                ROL.TRO_ROL_NOMBRE      AS ROL,
                ROL.TRO_PK_ROL          AS ROLPK,
                NVL(ACCIONES.NUMEROACCIONES,0) AS NUMEROACCIONES
            FROM  PDIPIMP.USRTROL ROL,
                    (
                      SELECT  COUNT(*)   AS NUMEROACCIONES,
                         ACR.RAR_FK_ROL  AS PKROL
                      FROM PDIPIMP.USRRACCIONROL  ACR,
                           PDIPIMP.USRTACCION     ACC
                      WHERE  ACC.TAC_PK_ACCION = ACR.RAR_FK_ACCION                            
                            <cfif modulo neq " " OR 0>
                               AND ACC.TAC_FK_MODULO = #pkModulo#
                            </cfif> 
                        AND ACC.TAC_FK_ESTADO = 2
                        AND ACR.RAR_FK_ESTADO = 2
                      GROUP BY  ACR.RAR_FK_ROL 
                    ) ACCIONES
            WHERE  ROL.TRO_PK_ROL = ACCIONES.PKROL(+)
			  AND  ROL.TRO_FK_VERTIENTE = #pkVertiente#
            ORDER BY NUMEROACCIONES DESC
        </cfquery>
        <cfreturn qUsuario>        
    </cffunction>

    <!---
    * Fecha creación: Agosto 2017
    * @author: Alejandro Tovar
    --->
    <cffunction name="getVertienteByModulo" hint="Consulta de la vertiente">
        <cfargument name="pkModulo" type="numeric" required="yes" hint="Pk del modulo">
        <cfquery name="qUsuario" datasource="DS_PDIPIMP">
            SELECT MOD.TMO_FK_VERTIENTE VERT
              FROM PDIPIMP.USRTMODULO MOD
             WHERE MOD.TMO_PK_MODULO = #pkModulo#
        </cfquery>
        <cfreturn qUsuario>        
    </cffunction>


    <cffunction name="consultaTotalGral" hint="Consulta el usuario seleccionado">
       <cfargument name="pkModulo" type="numeric" required="yes" hint="Clave del módulo con el que se realiza la busqueda">
       <cfargument name="pkVertiente" type="numeric" required="yes" hint="Pk de la vertiente">
        <cfquery name="qUsuario" datasource="DS_PDIPIMP">
            SELECT  
                ROL.TRO_ROL_NOMBRE              AS ROL,
                ROL.TRO_PK_ROL                  AS ROLPK,
                ACCIONES.PKACCION               AS PKACCION,
                ACCIONES.ACCIONNOMBRE           AS ACCIONNOMBRE,
                NVL(NUMEROACCIONES.NUMEROACCIONES,0)   AS NUMEROACCIONES,
                ROL.TRO_FK_VERTIENTE

            FROM  PDIPIMP.USRTROL ROL,
                (
                    SELECT  
                        ACC.TAC_PK_ACCION       AS PKACCION,
                        ACC.TAC_ACCION_NOMBRE   AS ACCIONNOMBRE,
                        ACR.RAR_FK_ROL          AS PKROL
                     FROM
                            PDIPIMP.USRRACCIONROL  ACR,
                            PDIPIMP.USRTACCION     ACC
                     WHERE  ACC.TAC_PK_ACCION = ACR.RAR_FK_ACCION
                        AND ACC.TAC_FK_MODULO = #pkModulo#
                        AND ACC.TAC_FK_ESTADO = 2
                        AND ACR.RAR_FK_ESTADO = 2
            ) ACCIONES,
            (
                SELECT  COUNT(*)   AS NUMEROACCIONES,
                        ACR.RAR_FK_ROL      AS PKROL
                  FROM  PDIPIMP.USRRACCIONROL  ACR,
                        PDIPIMP.USRTACCION     ACC
                 WHERE  ACC.TAC_PK_ACCION = ACR.RAR_FK_ACCION
                        AND ACC.TAC_FK_MODULO = #pkModulo#
                        AND ACC.TAC_FK_ESTADO = 2
                        AND ACR.RAR_FK_ESTADO = 2
                GROUP BY  ACR.RAR_FK_ROL 
            ) NUMEROACCIONES
            WHERE  ROL.TRO_PK_ROL = ACCIONES.PKROL(+)
                   AND ROL.TRO_PK_ROL = NUMEROACCIONES.PKROL(+)
                   AND ROL.TRO_FK_VERTIENTE = #pkVertiente#
            ORDER BY ROL
        </cfquery>
        <cfreturn qUsuario>        
    </cffunction>

    <cffunction name="consultarUsuarioNombre" hint="Consulta el usuario seleccionado">
        <cfargument name="nombreUsr" type="string" required="yes" hint="Nombre del usuario">
        <cfquery name="qUsuario" datasource="DS_PDIPIMP">
            SELECT 
                TROL.TRO_ROL_NOMBRE AS NOMBRE,                
                TROL.TRO_ROL_DESC AS DESCRIPCION,                
                TROL.TRO_PK_ROL AS PK
            FROM 
                PDIPIMP.USRTROL TROL
            WHERE TROL.TRO_ROL_NOMBRE = '#arguments.nombreUsr#'
        </cfquery>
        <cfreturn qUsuario>        
    </cffunction>

    <cffunction name="bajaAccrol" hint="Guarda nuevo registro en la BD"> 
        <cfargument name="edo"  type="numeric" required="yes" hint="PK de la acción al que pertenece la acción/rol"> 
        <cfargument name="rol" type="numeric" required="yes" hint="PK del rol al que pertenece la acción/rol">      
        <cfargument name="accion"  type="numeric" required="yes" hint="PK de la acción al que pertenece la acción/rol">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ACCIONESROLES.BAJA_ACCION_ROL" datasource="DS_PDIPIMP">
                <cfprocparam value="#edo#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#rol#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#accion#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>

    <cffunction name="altaAccionRol" hint="Guarda nuevo registro en la BD"> 
        <cfargument name="edo"  type="numeric" required="yes" hint="PK de la acción al que pertenece la acción/rol">
        <cfargument name="rol" type="numeric" required="yes" hint="PK del rol al que pertenece la acción/rol">       
        <cfargument name="accion"  type="numeric" required="yes" hint="PK de la acción al que pertenece la acción/rol">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_ACCIONESROLES.ALTA_ACCION_ROL" datasource="DS_PDIPIMP">
                <cfprocparam value="#edo#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#rol#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#accion#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creación: Agosto 2017
    * @author: Alejandro Tovar
    --->
    <cffunction name="obtieneVertientes" hint="Obtiene las vertientes del sistema">
        <cfquery name="qVertiente" datasource="DS_PDIPIMP">
            SELECT TVER.TVE_PK_VERTIENTE     AS PKVERT,
                   TVER.TVE_VERTIENTE_NOMBRE AS NOMVERTIENTE
              FROM PDIPIMP.USRTVERTIENTE TVER
             WHERE TVER.TVE_FK_ESTADO = 2
        </cfquery>
        <cfreturn qVertiente>
    </cffunction>


</cfcomponent>