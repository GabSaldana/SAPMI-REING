<!---
* =========================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: Principal
* Sub modulo: Login
* Fecha: Junio 16, 2015
* Descripcion: Objeto de acceso a datos para la autenticacion del usuario
* =========================================================================
--->

<cfcomponent>

	<!---
	* Fecha creacion: Junio 16, 2015
	* @author Yareli Andrade
	--->
	<cffunction name="getUsuario" access="public" returntype="query">
		<cfargument name="usr" type="string" required="yes">
		<cfargument name="psw" type="string" required="yes">
		<cfquery name="usuario" datasource="DS_GRAL">
			SELECT  TUS_PK_USUARIO PK, 
                    TUS_USUARIO_NOMBRE NOMBRE, 
                    TUS_USUARIO_PATERNO PATERNO, 
                    TUS_USUARIO_MATERNO MATERNO, 
                    TUS_FK_GENERO GENERO, 
                    TUS_USUARIO_EMAIL EMAIL, 
                    TUS_FK_ROL ROL,
                    TUS_USUARIO_USERNAME USR,
                    TUS_FK_ESTADO ESTADO,
                    TUS_USUARIO_PASSWORDINI PSW_INICIAL,
                    TMO_MODULO_URL MODULO_INICIAL,
                    TUS_FK_UR    UR,
                    TVM_FK_VERTIENTE VERTIENTE,
                    CASE
                        WHEN TUS_USUARIO_PASSWORDINI = TUS_USUARIO_PASSWORD THEN 1
                        ELSE 0
                    END FIRST_ACCESS
                FROM USRTUSUARIO, USRTROL, USRTMODULO, USRTVERTIENTE, USRTVERTROLMOD
                WHERE TUS_FK_ESTADO IN (2, 3)   
                AND TUS_USUARIO_PASSWORD = '#psw#'
                AND TUS_USUARIO_USERNAME = '#usr#'
                AND TUS_FK_ROL = TRO_PK_ROL(+)
                AND TRO_MODULOINICIAL = TMO_PK_MODULO(+)
                AND TRO_PK_ROL = TVM_FK_ROL
                AND TVE_PK_VERTIENTE = TVM_FK_VERTIENTE
                AND ROWNUM = 1
		</cfquery>
		<cfreturn usuario>
	</cffunction>
	
</cfcomponent>