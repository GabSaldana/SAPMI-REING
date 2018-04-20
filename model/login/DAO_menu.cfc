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
             SELECT  DISTINCT TMOD.TMO_PK_MODULO CVE,
                TMO_FK_MODULO   FK_MODULO,
                TMO_MODULO_URL URL, 
                TMO_MODULO_ICONO ICON,
                TMO_MODULO_NOMBRE MODULO,
                TMO_MODULO_ORDEN ORDEN
            FROM USRRACCIONROL TROL,
                 USRTMODULO TMOD,
                 USRTACCION TACC,
                 USRTVERTROLMOD TVERROOMOD
            WHERE
                TROL.RAR_FK_ROL = #rol#
                AND TROL.RAR_FK_ESTADO = 2
                AND TROL.RAR_FK_ACCION = TACC.TAC_PK_ACCION
                AND TACC.TAC_FK_MODULO = TMOD.TMO_PK_MODULO
                AND TVERROOMOD.TVM_FK_ROL = TROL.RAR_FK_ROL
            ORDER BY ORDEN		
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
                TAC_ACCION_CLAVE CLAVE
            FROM
                USRRACCIONROL TROL,
                USRTMODULO TMOD,
                USRTACCION TACC,
                USRTVERTROLMOD TVERROOMOD
            WHERE TROL.RAR_FK_ROL = #rol#
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