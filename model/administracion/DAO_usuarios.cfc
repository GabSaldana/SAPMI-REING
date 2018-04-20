<!---
============================================================================================
* IPN - CSII
* Sistema: PDIPIMP
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
        <cfquery name="qUsuarios" datasource="DS_PDIPIMP">
            SELECT  TUSUARIO.TUS_PK_USUARIO CVEUSR, 
                    TUSUARIO.TUS_USUARIO_NOMBRE || ' ' || TUSUARIO.TUS_USUARIO_PATERNO || ' ' || TUSUARIO.TUS_USUARIO_MATERNO NOMBRE,
                    TUSUARIO.TUS_USUARIO_USERNAME USRNAME,
                    TUSUARIO.TUS_USUARIO_EMAIL    CORREO,
                    TUSUARIO.TUS_FK_ESTADO EDO,
                    TROL.TRO_ROL_NOMBRE ROL
            FROM    PDIPIMP.USRTUSUARIO   TUSUARIO,
                    PDIPIMP.USRTROL       TROL,
                    PDIPIMP.USRTVERTIENTE TVER
             WHERE  TROL.TRO_PK_ROL = TUSUARIO.TUS_FK_ROL                
               AND  TUS_FK_ESTADO IN (#application.SIE_CTES.ESTADO.EDICION#, #application.SIE_CTES.ESTADO.VALIDADO#)
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
    <cfquery name="qRoles"datasource="DS_PDIPIMP">
        SELECT  TROL.TRO_ROL_NOMBRE ROL, 
                TROL.TRO_PK_ROL     CVE 
          FROM  PDIPIMP.USRTROL       TROL,
                PDIPIMP.USRTVERTIENTE TVER
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
            <cfstoredproc procedure="PDIPIMP.P_ADMON_USUARIOS.GENERAR_PSW" datasource="DS_PDIPIMP">       
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
            <cfstoredproc procedure="PDIPIMP.P_ADMON_USUARIOS.GUARDAR_USUARIO" datasource="DS_PDIPIMP">
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
        <cfstoredproc procedure="PDIPIMP.P_ADMON_USUARIOS.ELIMINAR_USUARIO" datasource="DS_PDIPIMP">
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
        <cfargument name="pkUsu" hint="Clave de usuario">
        <cfargument name="pkEdo" hint="Estado al que se quiere actualizar">
            <cfstoredproc procedure="PDIPIMP.P_ADMON_USUARIOS.CAMBIAR_ESTADO" datasource="DS_PDIPIMP">
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
    <cffunction name="getUsr" hint="Consulta el usuario seleccionado">
        <cfargument name="usr" type="string" required="yes" hint="Pk del usuario">
        <cfargument name="pkUsuario"    type="numeric"  required="yes" hint="Pk del usuario">
        <cfquery name="qUsuario" datasource="DS_PDIPIMP">
            SELECT  
               COUNT(TUSUARIO.TUS_PK_USUARIO) AS USR
            FROM 
                PDIPIMP.USRTUSUARIO TUSUARIO
            WHERE 
                TUSUARIO.TUS_FK_ESTADO = 2
            AND
                TUSUARIO.TUS_USUARIO_USERNAME = '#arguments.usr#'
            AND
                TUSUARIO.TUS_PK_USUARIO <> '#arguments.pkUsuario#'
        </cfquery>
        <cfreturn qUsuario>        
    </cffunction>
    <!---
    * Fecha creacion: agosto, 2016
    * @author Yareli Andrade
    --->    
    <cffunction name="consultarUsuario" hint="Consulta el usuario seleccionado">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="Pk del usuario">
        <cfquery name="qUsuario" datasource="DS_PDIPIMP">
            SELECT  
               TUSUARIO.TUS_USUARIO_NOMBRE NOMBRE, 
               TUSUARIO.TUS_USUARIO_PATERNO PATERNO, 
               TUSUARIO.TUS_USUARIO_MATERNO MATERNO, 
               TUSUARIO.TUS_FK_GENERO AS GENERO,
               TUSUARIO.TUS_FK_UR AS UR,
               TUSUARIO.TUS_FK_ACRONIMO AS ACRO,
               TUSUARIO.TUS_USUARIO_EMAIL AS EMAIL,
               TUSUARIO.TUS_USUARIO_TELEFONO AS TEL,
               TUSUARIO.TUS_USUARIO_EXTENSION AS EXT,
               TUSUARIO.TUS_FK_ROL AS ROL,
               ROL.TRO_ROL_CLAVE AS CVEROL,
               TUSUARIO.TUS_USUARIO_USERNAME USR
            FROM 
                PDIPIMP.USRTUSUARIO TUSUARIO, PDIPIMP.USRTROL ROL
            WHERE 
                TUSUARIO.TUS_PK_USUARIO = '#arguments.pkUsuario#'
                AND TRO_PK_ROL = TUS_FK_ROL
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
            <cfstoredproc procedure="PDIPIMP.P_ADMON_USUARIOS.EDITAR_USUARIO" datasource="DS_PDIPIMP">                
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
        <cfquery name="result"datasource="DS_PDIPIMP">
             SELECT DEP.TUR_PK_UR PK, 
                    DEP.TUR_SIGLA UR, 
                    CDEP.TUR_NOMBRE NOMBRE
             FROM   UR.TURIPN DEP, 
                    UR.TUR_DES CDEP
             WHERE CDEP.TUR_PK_UR = DEP.TUR_PK_UR 
             AND   DEP.TUR_SIGLA IS NOT NULL
        </cfquery>
      <cfreturn result>
    </cffunction>

    <!---
    * Fecha creacion: Agosto, 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="getAcron" access="remote" hint="Funcion que obtiene acrónimos">
        <cfquery name="result" datasource="DS_PDIPIMP">
            SELECT  ACR.CAC_PK_ACRONIMO PK, 
                    ACR.CAC_ACRONIMO    ACRONIM
              FROM  PDIPIMP.GRALCACRONIMO ACR
        </cfquery>
      <cfreturn result>
    </cffunction>  

    <!---
    * Fecha creacion: Agosto, 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="getClaveRol" access="remote" hint="Obtiene pk del rol seleccionado">
    <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
        <cfquery name="result" datasource="DS_PDIPIMP">
            SELECT ROL.TRO_ROL_CLAVE CLAVE
              FROM PDIPIMP.USRTROL ROL
             WHERE ROL.TRO_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
               AND ROL.TRO_PK_ROL = #rol#
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
        <cfargument name="nomUsuario" type="string" required="yes" hint="Nombre del usuario">
        <cfargument name="email" type="string" required="yes" hint="Email del usuario que se quieren obtener los datos">
        <cfargument name="estado" type="numeric" required="yes" hint="Estado en el que se debe encontrar el registro del usaurio a consultar">        
        <cfquery name="usuario" datasource="DS_PDIPIMP">
            SELECT TUS_PK_USUARIO ID,
                   TUS_USUARIO_USERNAME NOMBRE, 
                   TUS_USUARIO_PASSWORD PSW, 
                   TUS_USUARIO_EMAIL EMAIL
            FROM USRTUSUARIO
            WHERE TUS_FK_ESTADO = #estado#
            AND TUS_USUARIO_EMAIL = '#email#'
            AND TUS_USUARIO_USERNAME = '#nomUsuario#'
        </cfquery>
        <cfreturn usuario>
    </cffunction>

    <!---
    * Fecha creacion: Agosto, 2016
    * @author Alejandro Tovar
    --->
    <cffunction name="getEmail"access="remote"hint="Obtiene el email del usuario especificado">
        <cfargument name="userName" type="string" required="yes" hint="Nombre de usuario">         
        <cfquery name="usuario" datasource="DS_PDIPIMP">
            SELECT TUS_USUARIO_EMAIL
            FROM USRTUSUARIO
            WHERE TUS_FK_ESTADO = #application.SIE_CTES.ESTADO.VALIDADO#
            AND TUS_USUARIO_USERNAME = '#userName#'
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
            <cfstoredproc procedure="PDIPIMP.P_ADMON_USUARIOS.CAMBIAR_CONTRASENA" datasource="DS_PDIPIMP">
                <cfprocparam value="#pkUsuario#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#psw#" cfsqltype="cf_sql_varchar" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
  </cffunction>


<!--- --------------------------- Edición de usuarios --------------------------- !--->

	<!---
	* Descripcion:	Función para edición de datos por parte del usuario. 
	* Fecha: 		4 Abril 2017.
	* Autor:		Roberto Cadena.
	--->
	<cffunction name="datosUsuario" access="remote">      
		<cfquery name="usuario" datasource="DS_PDIPIMP">
			SELECT 
				TUS.TUS_PK_USUARIO			AS PKUSUARIO,
				TUS.TUS_USUARIO_NOMBRE		AS NOMBRE,
				TUS.TUS_USUARIO_PATERNO		AS PATERNO,
				TUS.TUS_USUARIO_MATERNO		AS MATERNO,
				TUS.TUS_FK_GENERO			AS GENERO,
				TUS.TUS_USUARIO_EMAIL		AS EMAIL,
				TUS.TUS_FK_ROL              AS PKROL,
				TUS.TUS_USUARIO_USERNAME    AS USR,
				TRO.TRO_ROL_NOMBRE			AS ROL,
				TUR.TUR_NOMBRE				AS UR,
				TUR.TUR_SIGLA				AS SIGLAUR,
				TUS.TUS_FK_ACRONIMO			AS PKACRONIMO,
				CAC.CAC_ACRONIMO			AS ACRONIMO,
				CAC.CAC_ACRONIMO_DESC		AS DESACRONIMO,
				TUS.TUS_USUARIO_TELEFONO	AS TELEFONO,
				TUS.TUS_USUARIO_EXTENSION	AS EXTENSION				
			FROM 
				PDIPIMP.USRTROL		TRO,
				PDIPIMP.USRTUSUARIO	TUS,
				PDIPIMP.GRALCACRONIMO	CAC,
				UR.TUR				TUR
			WHERE
				TUS.TUS_FK_ROL = TRO.TRO_PK_ROL
			AND
				TUS.TUS_FK_UR = TUR.TUR_PK_UR
			AND
				TUS.TUS_FK_ACRONIMO = CAC.CAC_PK_ACRONIMO
			AND
				TUS.TUS_PK_USUARIO =  #Session.cbstorage.usuario.pk#
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
        <cfstoredproc procedure="PDIPIMP.P_ADMON_USUARIOS.EDIT_USR" datasource="DS_PDIPIMP">                
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
        <cfquery name="usuario" datasource="DS_PDIPIMP">
            SELECT 
                COUNT(TUS.TUS_PK_USUARIO)   AS PKUSUARIO
            FROM 
                USRTUSUARIO    TUS
            WHERE
                TUS.TUS_USUARIO_PASSWORD = '#arguments.pass#'
            AND
                TUS.TUS_PK_USUARIO = #arguments.pkUsuario#
        </cfquery>
        <cfreturn usuario>
    </cffunction>

    <cffunction name="editarPass" hint="Edita datos del usuario seleccionado">
        <cfargument name="pkUsuario"    type="numeric"  required="yes" hint="Pk del usuario">
        <cfargument name="pass"         type="string"   required="yes" hint="Contrasenia del usuario">
        <cfstoredproc procedure="PDIPIMP.P_ADMON_USUARIOS.EDIT_PASS" datasource="DS_PDIPIMP">                
            <cfprocparam value="#pkUsuario#"  cfsqltype="cf_sql_numeric" type="in">
            <cfprocparam value="#pass#"       cfsqltype="cf_sql_varchar" type="in">
            <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
        <cfreturn respuesta>
    </cffunction>

    <!---
  * Fecha creacion: Diciembre, 2017
  * @author Jonathan Martínez
  --->
  <cffunction name="obtenerRolesEncuesta" hint="Funcion que obtiene los roles de usuario y sus claves para el formulario de encuesta">
    <cfquery name="qRoles"datasource="DS_PDIPIMP">
        SELECT  TROL.TRO_ROL_NOMBRE ROL, 
                TROL.TRO_PK_ROL     CVE 
          FROM  PDIPIMP.USRTROL       TROL
         WHERE  TROL.TRO_FK_ESTADO    = 2
           AND  TROL.TRO_FK_TIPO = 1
        ORDER BY TROL.TRO_PK_ROL
    </cfquery>
  <cfreturn qRoles>
  </cffunction>

    <!---
    * Fecha creacion: diciembre, 2017
    * @author Jonathan Martinez
    --->    
    <cffunction name="guardarInfoInicial" hint="Guardar informacion inicial de la encuesta">
        <cfargument name="pkUsuario" type="numeric" required="yes" hint="Pk del usuario">
        <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
        <cfargument name="ur" type="string" required="yes" hint="Dependencia del usuario">
        <cfstoredproc procedure="PDIPIMP.P_ADMON_USUARIOS.GUARDA_INFO_INICIAL" datasource="DS_PDIPIMP">                
                <cfprocparam value="#pkUsuario#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#rol#" cfsqltype="cf_sql_numeric" type="in">
                <cfprocparam value="#ur#" cfsqltype="cf_sql_varchar" type="in">
                <cfprocparam variable="respuesta" cfsqltype="cf_sql_numeric" type="out">
            </cfstoredproc>
            <cfreturn respuesta>
    </cffunction>


</cfcomponent>