<!---
* ============================================================================
* IPN - CSII
* Sistema: SIIIS Cursos
* Modulo: Temarios
* Fecha: 04 de marzo de 2016
* Descripcion: Acceso a datos para asignacion de temas.
* ============================================================================
--->

<cfcomponent>

	<cffunction name="obtenerRoles">
        <cfquery name="roles" datasource="DS_PDIPIMP">
            SELECT  ROL.TRO_PK_ROL      AS PK, 
                    ROL.TRO_ROL_CLAVE   AS NOMBRE
              FROM  PDIPIMP.USRTROL     ROL
             WHERE  ROL.TRO_FK_ESTADO = 2
        </cfquery>
        <cfreturn roles>
    </cffunction>

</cfcomponent>