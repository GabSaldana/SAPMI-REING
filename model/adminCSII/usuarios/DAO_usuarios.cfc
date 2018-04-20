<!---
============================================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: administración de usuarios
* Fecha: agosoto/2016
* Descripcion: acceso a datos para la administración de usuarios.
* Autor: Yareli Andrade
============================================================================================
--->

<cfcomponent> 

    <!---
    * Fecha creación: agosto, 2016
    * @author: Yareli Andrade
    --->
    <cffunction name="obtenerUsuarios" hint="Obtiene los usuarios del sistema">
        <cfargument name="pkUR" type="string" required="yes" hint="Clave de la unidad responsable">
        <cfquery name="qUsuarios" datasource="DS_GRAL">
            SELECT  TUSUARIO.TUS_PK_USUARIO       CVEUSR, 
                    TUSUARIO.TUS_USUARIO_NOMBRE || ' ' || TUSUARIO.TUS_USUARIO_PATERNO || ' ' || TUSUARIO.TUS_USUARIO_MATERNO NOMBRE,
                    TUSUARIO.TUS_USUARIO_USERNAME USRNAME,
                    TUSUARIO.TUS_FK_ESTADO        EDO,
                    TUSUARIO.TUS_USUARIO_EMAIL    CORREO,
                    TROL.TRO_ROL_NOMBRE           ROL,
                    TVER.TVE_VERTIENTE_NOMBRE     VERT
              FROM  GRAL.USRTUSUARIO   TUSUARIO,
                    GRAL.USRTROL       TROL,
                    GRAL.USRTVERTIENTE TVER
             WHERE  TROL.TRO_PK_ROL = TUSUARIO.TUS_FK_ROL                
               AND  TUS_FK_ESTADO IN (1,2)
               AND  TVER.TVE_PK_VERTIENTE = TROL.TRO_FK_VERTIENTE

                    <cfif NOT #ArrayFind(Session.cbstorage.grant, 'usuarios.adminRoles')#>
				        AND TROL.TRO_FK_VERTIENTE = #Session.cbstorage.usuario.VERTIENTE#
                    </cfif>

            ORDER BY TVER.TVE_PK_VERTIENTE
        </cfquery>
        <cfreturn qUsuarios>        
    </cffunction>

    <!---
    * Fecha creacion: agosto, 2016
    * @author Yareli Andrade
    --->
    <cffunction name="obtenerRoles" hint="Funcion que obtiene los roles de usuario y sus claves">
        <cfquery name="qRoles"datasource="DS_GRAL">
            SELECT  TROL.TRO_ROL_NOMBRE ROL, 
                    TROL.TRO_PK_ROL     CVE 
              FROM  GRAL.USRTROL       TROL,
                    GRAL.USRTVERTIENTE TVER
             WHERE  TROL.TRO_FK_ESTADO    = 2
               AND  TVER.TVE_PK_VERTIENTE = TROL.TRO_FK_VERTIENTE
					<cfif structkeyexists(Session.cbstorage,'grant')>
                        <cfif NOT #ArrayFind(Session.cbstorage.grant, 'usuarios.adminRoles')#>
	                        AND TROL.TRO_FK_VERTIENTE = #Session.cbstorage.usuario.VERTIENTE#
	                    </cfif>
	                </cfif>
            ORDER BY TVER.TVE_VERTIENTE_NOMBRE
        </cfquery>
        <cfreturn qRoles>
    </cffunction>

    <!---
    * Fecha creación: agosto, 2016
    * @author: Yareli Andrade
    --->
    <cffunction name="generarPsw" hint="Genera contrasenia de usuario">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.GENERAR_PSW" datasource="DS_GRAL">       
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_varchar" type="out">
        </cfstoredproc>
        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creacion: agosto, 2016
    * @author Yareli Andrade
    --->    
    <cffunction name="guardarUsuario" hint="Guarda nuevo registro en la BD">        
        <cfargument name="ur"  type="string" required="yes" hint="UR del usuario">
        <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
        <cfargument name="genero" type="numeric" required="yes" hint="Genero del usuario">
        <cfargument name="acronimo" type="string" required="no" hint="Acronimo del usuario">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre del usuario">
        <cfargument name="apaterno" type="string" required="yes" hint="Apellido paterno del usuario">
        <cfargument name="amaterno" type="string" required="yes" hint="Apellido materno del usuario">
        <cfargument name="usr"  type="string" required="yes" hint="Nombre de usuario del nuevo registro">
        <cfargument name="psw"  type="string" required="yes" hint="Contrasenia del nuevo registro">        
        <cfargument name="email" type="string" required="yes" hint="Correo electronico del usuario">
        <cfargument name="tel" type="string" required="yes" hint="Telefono del usuario">
        <cfargument name="ext" type="string" required="yes" hint="Extension del usuario">       
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.GUARDAR_USUARIO" datasource="DS_GRAL">
            <cfprocparam value="#ur#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#rol#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#genero#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#acronimo#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#nombre#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#apaterno#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#amaterno#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#usr#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#psw#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#email#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#tel#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam value="#ext#" cfsqltype="cf_sql_string" type="in">
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creación: agosto, 2016
    * @author: Alejandro Tovar
    --->
    <cffunction name="eliminaUsuario" access="public" returntype="numeric">
        <cfargument name="pkUsu" hint="">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.ELIMINAR_USUARIO" datasource="DS_GRAL">
                <cfprocparam value="#pkUsu#"        cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam variable="resultado"   cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
        <cfreturn resultado>
    </cffunction>

    <!---
    * Fecha creación: agosto, 2016
    * @author: Yareli Andrade
    --->
    <cffunction name="cambiarEstado" returntype="numeric" hint="Cambia el registro del usuario al estado indicado">
        <cfargument name="pkUsu" type="numeric" required="yes" hint="Clave de usuario">
        <cfargument name="pkEdo" type="numeric" required="yes" hint="Estado al que se quiere actualizar">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.CAMBIAR_ESTADO" datasource="DS_GRAL">
            <cfprocparam value="#pkUsu#"        cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#pkEdo#"        cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam variable="respuesta"   cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creacion: agosto, 2016
    * @author Yareli Andrade
    --->    
    <cffunction name="consultarUsuario" hint="Consulta el usuario seleccionado">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="Pk del usuario">
        <cfquery name="qUsuario" datasource="DS_GRAL">
            SELECT TUSUARIO.TUS_USUARIO_NOMBRE    AS NOMBRE, 
                   TUSUARIO.TUS_USUARIO_PATERNO   AS PATERNO, 
                   TUSUARIO.TUS_USUARIO_MATERNO   AS MATERNO, 
                   TUSUARIO.TUS_FK_GENERO         AS GENERO,
                   TUSUARIO.TUS_FK_UR             AS UR,
                   TUSUARIO.TUS_FK_ACRONIMO       AS ACRO,
                   TUSUARIO.TUS_USUARIO_EMAIL     AS EMAIL,
                   TUSUARIO.TUS_USUARIO_TELEFONO  AS TEL,
                   TUSUARIO.TUS_USUARIO_EXTENSION AS EXT,
                   TUSUARIO.TUS_FK_ROL            AS ROL,
                   ROL.TRO_ROL_CLAVE              AS CVEROL,
                   TUSUARIO.TUS_USUARIO_USERNAME  AS USR
            FROM   GRAL.USRTUSUARIO TUSUARIO, 
                   GRAL.USRTROL     ROL
            WHERE  TUSUARIO.TUS_PK_USUARIO = '#arguments.pkUsuario#'
              AND  ROL.TRO_PK_ROL = TUSUARIO.TUS_FK_ROL
        </cfquery>
        <cfreturn qUsuario>        
    </cffunction>

    <!---
    * Fecha creacion: agosto, 2016
    * @author Yareli Andrade
    --->    
    <cffunction name="editarUsuario" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="Pk del usuario">
        <cfargument name="nombre" type="string" required="yes" hint="Nombre del usuario">
        <cfargument name="apaterno" type="string" required="yes" hint="Apellido paterno del usuario">
        <cfargument name="amaterno" type="string" required="yes" hint="Apellido materno del usuario">
        <cfargument name="genero" type="numeric" required="yes" hint="Genero del usuario">
        <cfargument name="tel" type="string" required="yes" hint="Telefono del usuario">
        <cfargument name="ext" type="string" required="yes" hint="Extension del usuario">
        <cfargument name="email" type="string" required="yes" hint="Correo electronico del usuario">
        <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
        <cfargument name="user" type="string" required="yes" hint="Nombre de usuario">
        <cfargument name="acronimo" type="numeric" required="yes" hint="Acronimo del usuario">
        <cfargument name="psw" type="string" required="no" default="" hint="Nueva contraseña">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.EDITAR_USUARIO" datasource="DS_GRAL">                
            <cfprocparam value="#pkUsuario#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#nombre#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#apaterno#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#amaterno#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#genero#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#tel#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#ext#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#email#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#rol#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#user#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#acronimo#" cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#psw#" cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>
    </cffunction>

    <!---
    * Fecha creacion: Agosto, 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="getUr"access="remote"hint="Funcion que obtiene unidades responsables">        
        <cfquery name="result"datasource="DS_URS">
            -- SELECT  PUR.TUR_PK_UR           PK_PUR,
            --         PUR.TUR_NOMBRE          NOMBRE_PUR,
            --         TUR.TUR_PK_UR           PK_UR,
            --         TUR.TUR_NOMBRE          NOMBRE_UR        
            -- FROM    URS.URSTCLASIFICACION   TCL,
            --         URS.URSTURS             TUR,
            --         URS.URSTURS             PUR
            -- WHERE   TUR.TUR_FK_CLASIFICACION = TCL.TCL_PK_CLASIFICACION
            -- AND     TUR.TUR_FK_PADRE = PUR.TUR_PK_UR
            -- ORDER BY PUR.TUR_NOMBRE ASC,PUR.TUR_NOMBRE ASC

             SELECT * FROM (
						   SELECT  TUR.TUR_CLAVEANTERIOR   AS CVEANTERIOR,
						           PUR.TUR_PK_UR           AS PK_PUR,
						           PUR.TUR_NOMBRE          AS NOMBRE_PUR,
						           TUR.TUR_PK_UR           AS PK_UR,
						           TUR.TUR_NOMBRE          AS NOMBRE_UR,
                                   TUR.TUR_CLAVE           AS CLAVE_UR    
						   FROM    URS.URSTCLASIFICACION   TCL,
						           URS.URSTURS             TUR,
						           URS.URSTURS             PUR
						   WHERE   TUR.TUR_FK_CLASIFICACION = TCL.TCL_PK_CLASIFICACION
						   AND     TUR.TUR_FK_PADRE = PUR.TUR_PK_UR
						   AND     TUR.TUR_FK_URTIMEFIN IS NULL
						   AND     TUR.TUR_PK_UR NOT IN (SELECT TUE_FK_UR FROM URS.URSTUREXCLUIDA)
						   UNION SELECT  '000000' AS CVEANTERIOR, 0 AS PK_PUR, 'OTROS' AS NOMBRE_PUR, 0 AS PK_UR, 'DEPENDENCIA EXTERNA' AS NOMBRE_UR, '' AS CLAVE_UR FROM DUAL
						) ORDER BY CVEANTERIOR
        </cfquery>
      <cfreturn result>
    </cffunction>

    <!---
    * Fecha creacion: Agosto, 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="getAcron" access="remote" hint="Funcion que obtiene acrónimos">
        <cfquery name="result" datasource="DS_GRAL">
            SELECT ACR.CAC_PK_ACRONIMO PK, 
                   ACR.CAC_ACRONIMO    ACRONIM,
                   ACR.CAC_ACRONIMO_DESC    ACRONDESC
              FROM GRAL.GRALCACRONIMO ACR
        </cfquery>
      <cfreturn result>
    </cffunction>  

    <!---
    * Fecha creacion: Agosto, 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="getClaveRol" access="remote" hint="Obtiene pk del rol seleccionado">
    <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
        <cfquery name="result" datasource="DS_GRAL">
            SELECT ROL.TRO_ROL_CLAVE CLAVE
              FROM GRAL.USRTROL ROL
             WHERE ROL.TRO_FK_ESTADO = 2
               AND ROL.TRO_PK_ROL    = #rol#
        </cfquery>
        <cfreturn result>
    </cffunction>

    <!---
    * Mod: se considera el estado en el que se debe encontrar el usuario a consultar
    * Fecha: septiembre, 2016
    * @author Yareli Andrade
    -------------------------------------
    * Fecha creacion: Agosto, 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="getPwd" access="public" returntype="query" hint="Obtiene los datos que seran enviados en la recuperación de constraseña">
        <cfargument name="email" type="string" required="yes" hint="Email del usuario que se quieren obtener los datos">
        <cfargument name="estado" type="numeric" required="yes" hint="Estado en el que se debe encontrar el registro del usaurio a consultar">        
        <cfquery name="usuario" datasource="DS_GRAL">
            SELECT USU.TUS_USUARIO_USERNAME NOMBRE, 
                   USU.TUS_USUARIO_PASSWORD PSW, 
                   USU.TUS_USUARIO_EMAIL    EMAIL
              FROM GRAL.USRTUSUARIO USU
             WHERE USU.TUS_FK_ESTADO        = #estado#
               AND USU.TUS_USUARIO_EMAIL    = '#email#'
                OR USU.TUS_USUARIO_USERNAME = '#email#'
        </cfquery>
        <cfreturn usuario>
    </cffunction>

    <!---
    * Fecha creacion: Agosto, 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="getEmail"access="remote"hint="Obtiene el email del usuario especificado">
        <cfargument name="userName" type="string" required="yes" hint="Nombre de usuario">         
        <cfquery name="usuario" datasource="DS_GRAL">
            SELECT USU.TUS_USUARIO_EMAIL
              FROM GRAL.USRTUSUARIO USU
             WHERE USU.TUS_FK_ESTADO =  2
               AND USU.TUS_USUARIO_USERNAME = '#userName#'
        </cfquery>
        <cfreturn usuario>
    </cffunction>

    <!---
      * Fecha creacion: Octubre, 2016
      * @author Alejandro Tovar
    --->
    <cffunction name="cambiarPwd" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="Pk del usuario">
        <cfargument name="psw" type="string" required="no" default="" hint="Nueva contraseña">
            <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.EDIT_PASS" datasource="DS_GRAL">
                <cfprocparam value="#pkUsuario#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#psw#" cfsqltype="cf_sql_varchar" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
  </cffunction>


<!--- --------------------------- Edición de usuarios --------------------------- !--->

	<!---
    * Descripcion:  Función para edición de datos por parte del usuario. 
    * Fecha:        4 Abril 2017.
    * Autor:        Roberto Cadena.
    --->
    <cffunction name="datosUsuario" access="remote">
        <cfquery name="usuario" datasource="DS_GRAL">
            SELECT 
                TUS.TUS_PK_USUARIO          AS PKUSUARIO,
                TUS.TUS_USUARIO_NOMBRE      AS NOMBRE,
                TUS.TUS_USUARIO_PATERNO     AS PATERNO,
                TUS.TUS_USUARIO_MATERNO     AS MATERNO,
                TUS.TUS_FK_GENERO           AS GENERO,
                TUS.TUS_USUARIO_EMAIL       AS EMAIL,
                TUS.TUS_FK_ROL              AS PKROL,
                TUS.TUS_USUARIO_USERNAME    AS USR,
                TRO.TRO_ROL_NOMBRE          AS ROL,
                TUS.TUS_FK_ACRONIMO         AS PKACRONIMO,
                CAC.CAC_ACRONIMO            AS ACRONIMO,
                CAC.CAC_ACRONIMO_DESC       AS DESACRONIMO,
                TUS.TUS_USUARIO_TELEFONO    AS TELEFONO,
                ROL.TRO_ROL_CLAVE           AS CVEROL,
                TUS.TUS_USUARIO_EXTENSION   AS EXTENSION
            FROM 
                USRTROL        TRO,
                USRTUSUARIO    TUS,
                GRALCACRONIMO  CAC,
                GRAL.USRTROL   ROL
            WHERE
                TUS.TUS_FK_ROL = TRO.TRO_PK_ROL
            AND
                TUS.TUS_FK_ACRONIMO = CAC.CAC_PK_ACRONIMO(+)
            AND
                TUS.TUS_PK_USUARIO =  #Session.cbstorage.usuario.pk#
            AND
                ROL.TRO_PK_ROL = TUS.TUS_FK_ROL
        </cfquery>
        <cfreturn usuario>
    </cffunction>

    <cffunction name="editarUsr" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkUsuario"    type="numeric"  required="yes" hint="Pk del usuario">
        <cfargument name="nombre"       type="string"   required="yes" hint="Nombre del usuario">
        <cfargument name="apaterno"     type="string"   required="yes" hint="Apellido paterno del usuario">
        <cfargument name="amaterno"     type="string"   required="yes" hint="Apellido materno del usuario">
        <cfargument name="genero"       type="numeric"  required="yes" hint="Genero del usuario">
        <cfargument name="tel"          type="string"   required="yes" hint="Telefono del usuario">
        <cfargument name="ext"          type="string"   required="yes" hint="Extension del usuario">
        <cfargument name="email"        type="string"   required="yes" hint="Correo electronico del usuario">
        <cfargument name="user"         type="string"   required="yes" hint="Nombre de usuario">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.EDIT_USR" datasource="DS_GRAL">                
            <cfprocparam value="#pkUsuario#"    cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#nombre#"       cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#apaterno#"     cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#amaterno#"     cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#genero#"       cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#tel#"          cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#ext#"          cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#email#"        cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam value="#user#"         cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam variable="respuesta"   cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>
    </cffunction>

    <cffunction name="getPass" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkUsuario"    type="numeric"  required="yes" hint="Pk del usuario">
        <cfargument name="pass"         type="string"   required="yes" hint="Contrasenia del usuario">
        <cfquery name="usuario" datasource="DS_GRAL">
            SELECT 
                COUNT(TUS.TUS_PK_USUARIO)   AS PKUSUARIO
            FROM 
                USRTUSUARIO    TUS
            WHERE
                TUS.TUS_USUARIO_PASSWORD = #arguments.pass#
            AND
                TUS.TUS_PK_USUARIO = #arguments.pkUsuario#
        </cfquery>
        <cfreturn usuario>
    </cffunction>

    <cffunction name="getUsr" hint="Consulta el usuario seleccionado">
        <cfargument name="usr" type="string" required="yes" hint="Pk del usuario">
        <cfargument name="pkUsuario"    type="numeric"  required="yes" hint="Pk del usuario">
        <cfquery name="qUsuario" datasource="DS_GRAL">
            SELECT  
               COUNT(TUSUARIO.TUS_PK_USUARIO) AS USR
            FROM 
                USRTUSUARIO TUSUARIO
            WHERE 
                TUSUARIO.TUS_FK_ESTADO = 2
            AND
                TUSUARIO.TUS_USUARIO_USERNAME = '#arguments.usr#'
            AND
                TUSUARIO.TUS_PK_USUARIO <> '#arguments.pkUsuario#'
        </cfquery>
        <cfreturn qUsuario>        
    </cffunction>

    <cffunction name="editarPass" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkUsuario"    type="numeric"  required="yes" hint="Pk del usuario">
        <cfargument name="pass"         type="string"   required="yes" hint="Contrasenia del usuario">
        <cfstoredproc procedure="GRAL.P_ADMON_USUARIOS.EDIT_PASS" datasource="DS_GRAL">                
            <cfprocparam value="#pkUsuario#"  cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#pass#"       cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>
    </cffunction>


    <!---
    * Fecha : Octubre del 2017
    * Autor : Alejandro Tovar
    --->
    <cffunction name="getPersona" hint="obtiene los datos de la persona asociada a un usuario">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="pk del usuario">
        <cfquery name="qFileName" datasource="DS_CVU">
            SELECT  PER.TPS_PK_PERSONA AS PK
              FROM  CVU.CVUTPERSONA PER
             WHERE  PER.TPS_FK_USUARIO = #pkUsuario#
        </cfquery>
        <cfreturn qFileName>
    </cffunction>

    <!---
    * Fecha : Enero del 2017
    * Autor : Ana Belem Juárez Méndez
    --->
    <cffunction name="getUsuarioContrasena" hint="obtiene el nombre y la contraseña de un usuario, el cual es identificado por su pkusuario">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="pk del usuario">
        <cfquery name="qContrasena" datasource="DS_GRAL">
            SELECT  TUS.TUS_USUARIO_PASSWORD AS CONTRASENA,
                    TUS.TUS_USUARIO_USERNAME AS NOMBRE
              FROM  GRAL.USRTUSUARIO TUS
             WHERE  TUS.TUS_PK_USUARIO = #pkUsuario#
        </cfquery>
        <cfreturn qContrasena>
    </cffunction>

    <!--- 
    *Fecha: Febrero de 2018
    *Autor: Ana Belem Juárez Méndez
    --->
    <cffunction name="getRolDeUsuario" hint="Obtiene el rol de un usuario">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="pk del usuario">
        <cfquery name="qRol" datasource="DS_GRAL">
            SELECT  TUS.TUS_USUARIO_PASSWORD AS CONTRASENA,
                    TUS.TUS_USUARIO_USERNAME AS NOMBRE
              FROM  GRAL.USRTUSUARIO TUS
             WHERE  TUS.TUS_PK_USUARIO = #pkUsuario#
        </cfquery>
        <cfreturn qRol>
    </cffunction>

</cfcomponent>