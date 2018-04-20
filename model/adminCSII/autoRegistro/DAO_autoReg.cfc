<cfcomponent>


    <!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
    * Descripcion: Obtiene los cursos disponibles para inscripcion
    ---> 
    <cffunction name="getOfertaCursos" hint="Obtiene los cursos disponibles para inscripcion">
        <cfargument name="pkVertiente" hint="">
        <cfquery name="qOferta" datasource="DS_ACCFRM">
            SELECT  TC.TCC_PK_CURSOCALENDARIO       AS PK,
                    TAF.CCU_NOMBRE                  AS NOMBRE, 
                    TAF.CCU_DESCRIPCION             AS DESCRIPCION,            
                    TAF.CCU_OBJETIVOGENERAL         AS OBJETIVO,
                    TC.TCC_COSTOEXTERNOS            AS EXTERNO, 
                    TC.TCC_COSTOIPN                 AS INTERNO,
                    TC.TCC_SEDE                     AS SEDE,
                    TH.FECHAS                       AS DIAS,
                    TC.TCC_FK_ESTADO                AS EDO
              FROM  TCURSOCALENDARIO                TC,
                    CCURSO                          TAF,
                    (SELECT TCH_FK_CURSOCALENDARIO  AS PK,
                            LISTAGG(TCH_DIA, ', ') WITHIN GROUP (ORDER BY TCH_DIA) AS FECHAS
                       FROM TCURSOHORARIO
                   GROUP BY TCH_FK_CURSOCALENDARIO) TH            
             WHERE  TC.TCC_PK_CURSOCALENDARIO       = TH.PK
                    AND TC.TCC_FK_CURSO             = TAF.CCU_PK_CURSO 
                    AND TC.TCC_FK_ESTADO            =3
          ORDER BY  EDO, TC.TCC_FK_CURSO, PK   



        </cfquery>
        <cfreturn qOferta>
    </cffunction>


    <!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
    * Descripcion: Obtiene el prefijo del rol
    ---> 
    <cffunction name="getPrefijo" hint="Obtiene el prefijo del rol">
        <cfargument name="pkRol" hint="">
        <cfquery name="qOferta" datasource="DS_GRAL">
            SELECT ROL.TRO_ROL_PREFIJO AS PREF
              FROM GRAL.USRTROL ROL
             WHERE ROL.TRO_PK_ROL = #pkRol#
        </cfquery>
        <cfreturn qOferta>
    </cffunction>


    <!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
    * Descripcion: Registra un participante
    ---> 
    <cffunction name="registraParticipante" access="public" hitn="Registra un participante">
        <cfargument name="acr"       hint="">
        <cfargument name="nomb"      hint="">
        <cfargument name="pat"       hint="">
        <cfargument name="mat"       hint="">
        <cfargument name="gen"       hint="">
        <cfargument name="rfc"       hint="">
        <cfargument name="hom"       hint="">
        <cfargument name="proc"      hint="">
        <cfargument name="tel"       hint="">
        <cfargument name="ext"       hint="">
        <cfargument name="mail"      hint="">
        <cfargument name="empresa"   hint="">
        <cfargument name="pkUsuario" hint="">
        <cfstoredproc procedure="ACCFRM.P_AUTOREGISTRO.REGISTRAPARTICIPANTE" datasource="DS_ACCFRM">
            <cfprocparam value="#acr#"       cfsqltype="cf_sql_numeric"  type="in">
            <cfprocparam value="#nomb#"      cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#pat#"       cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#mat#"       cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#gen#"       cfsqltype="cf_sql_numeric"  type="in">
            <cfprocparam value="#rfc#"       cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#hom#"       cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#proc#"      cfsqltype="cf_sql_numeric"  type="in">
            <cfprocparam value="#tel#"       cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#ext#"       cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#mail#"      cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#empresa#"   cfsqltype="cf_sql_string"   type="in">
            <cfprocparam value="#pkUsuario#" cfsqltype="cf_sql_numeric"  type="in">
            <cfprocparam variable="resultado"   cfsqltype="cf_sql_numeric" type="out">
        </cfstoredproc>
    <cfreturn resultado>
  </cffunction>

  <!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
    * Descripcion: obtiene el catalogo de acronimos
    ---> 
    <cffunction name="getAcronimo" hint="Obtiene comentarios de un registro">
        <cfquery name="qOferta" datasource="DS_GRAL">
            SELECT ACR.CAC_PK_ACRONIMO AS PK,
                   ACR.CAC_ACRONIMO    AS NOMBRE
              FROM GRAL.GRALCACRONIMO ACR
        </cfquery>
        <cfreturn qOferta>
    </cffunction>

    <!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
    * Descripcion: obtiene el catalogo de genero
    ---> 
    <cffunction name="getGenero" hint="Obtiene comentarios de un registro">
        <cfquery name="qOferta" datasource="DS_GRAL">
            SELECT GEN.CGE_PK_GENERO     AS PK,
                   GEN.CGE_GENERO_NOMBRE AS NOMBRE
              FROM GRAL.GRALCGENERO GEN
             WHERE GEN.CGE_FK_ESTADO = 2
        </cfquery>
        <cfreturn qOferta>
    </cffunction>

    <!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
    * Descripcion: obtiene el catalogo de procedencias
    ---> 
    <cffunction name="getProcedencia" hint="obtiene el catalogo de procedencias">
        <cfquery name="qOferta" datasource="DS_ACCFRM">
            SELECT PRO.CPD_PK_PROCEDENCIA AS PK,
                   PRO.CPD_NOMBRE         AS NOMBRE
              FROM ACCFRM.CPROCEDENCIA PRO
             WHERE PRO.CPD_FK_ESTADO = 2
        </cfquery>
        <cfreturn qOferta>
    </cffunction>


    <!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
    * Descripcion: obtiene el nombre de usuario y contraseña
    ---> 
    <cffunction name="getPwd" access="public" returntype="query" hint="obtiene el nombre de usuario y contraseña">
        <cfargument name="email"  type="string" required="yes" hint="Email del usuario que se quieren obtener los datos">
        <cfargument name="estado" type="numeric" required="yes" hint="Estado en el que se debe encontrar el registro del usaurio a consultar">
        <cfargument name="usr"    type="string" required="yes" hint="nombre de usuario">
        <cfquery name="usuario" datasource="DS_GRAL">
            SELECT USU.TUS_USUARIO_USERNAME NOMBRE, 
                   USU.TUS_USUARIO_PASSWORD PSW, 
                   USU.TUS_USUARIO_EMAIL    EMAIL
              FROM GRAL.USRTUSUARIO USU
             WHERE USU.TUS_FK_ESTADO        = #estado#
               AND USU.TUS_USUARIO_EMAIL    = '#email#'
               AND USU.TUS_USUARIO_USERNAME = '#usr#'
        </cfquery>
        <cfreturn usuario>
    </cffunction>


    <!---
    * Fecha: Agosto de 2017
    * @author Alejandro Tovar
    * Descripcion: Registra un usuario en la tabla USRTUSUARIO
    ---> 
    <cffunction name="guardarUsuario" hint="Registra un usuario en la tabla USRTUSUARIO">        
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
        <cfstoredproc procedure="ACCFRM.P_AUTOREGISTRO.GUARDAR_USUARIO" datasource="DS_ACCFRM">
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



</cfcomponent>