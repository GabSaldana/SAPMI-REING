<!---
* =========================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: Principal
* Sub modulo: Login
* Fecha: agosto, 2016
* Descripcion: Genera menú principal dinámicamente
* =========================================================================
--->

<cfcomponent>

	<!---
    * Fecha creacion: agosto, 2016
    * @author Yareli Andrade
    ---> 
	<cffunction name="getMenu" hint="Obtiene las secciones del menu de acuerdo al usuario">
        <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
        <cfquery name="qModulos" datasource="DS_GRAL">
             SELECT MODULOS.TMO_MODULO_NOMBRE MODULO,
                   RELACION.TVM_ORDENMODULO ORDEN,
                   MODULOS.TMO_MODULO_ICONO ICON,
                   MODULOS.TMO_MODULO_URL URL,
                   MODULOS.TMO_PK_MODULO CVE,
                   MODULOS.TMO_FK_MODULO FK_MODULO,
                   LEVEL NIVEL
            FROM GRAL.USRTMODULO MODULOS,
                 GRAL.USRTVERTROLMOD RELACION
            WHERE RELACION.TVM_FK_ROL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rol#">
            AND   RELACION.TVM_ESTADO = 2
            AND   MODULOS.TMO_FK_ESTADO = 2
            AND   RELACION.TVM_FK_MODULO = MODULOS.TMO_PK_MODULO
            GROUP BY MODULOS.TMO_MODULO_NOMBRE,MODULOS.TMO_MODULO_URL,MODULOS.TMO_MODULO_ICONO,RELACION.TVM_ORDENMODULO,MODULOS.TMO_PK_MODULO,MODULOS.TMO_FK_MODULO,level
            START WITH MODULOS.TMO_FK_MODULO IS NULL
            CONNECT BY PRIOR MODULOS.TMO_PK_MODULO = MODULOS.TMO_FK_MODULO
            ORDER BY LEVEL,RELACION.TVM_ORDENMODULO	
        </cfquery>
        <cfreturn qModulos>
	</cffunction>

    <!---
    * Fecha creacion: 12 de agosto de 2016
    * @author Yareli Andrade
    ---> 
    <cffunction name="getPrivilegios" hint="Obtiene las acciones permitidas de acuerdo al rol de usuario">
        <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
        <cfquery name="qPermisos" datasource="DS_GRAL">
            SELECT  TMOD.TMO_MODULO_NOMBRE MODULO,
                    TACC.TAC_ACCION_NOMBRE ACCION,
                    TACC.TAC_ACCION_CLAVE CLAVE
            FROM
                USRRACCIONROL TROL,
                USRTMODULO TMOD,
                USRTACCION TACC,
                USRTVERTROLMOD TVERROOMOD
            WHERE TROL.RAR_FK_ROL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rol#">
                AND TROL.RAR_FK_ESTADO = 2
                AND TROL.RAR_FK_ACCION = TACC.TAC_PK_ACCION
                AND TACC.TAC_FK_MODULO = TMOD.TMO_PK_MODULO
                AND TVERROOMOD.TVM_FK_ROL = TROL.RAR_FK_ROL
                AND TACC.TAC_ACCION_CLAVE NOT LIKE ('AG')
            ORDER BY TMOD.TMO_PK_MODULO
        </cfquery>
        <cfreturn qPermisos>
    </cffunction>  
</cfcomponent>