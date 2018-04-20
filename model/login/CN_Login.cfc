<!---
* =========================================================================
* IPN - CSII
* Sistema: SIIIS 
* Modulo: Principal
* Sub modulo: Login
* Fecha: Junio 18, 2015
* Descripcion: Componente de Negocio para la autenticacion del usuario
* =========================================================================
--->

<cfcomponent>
	<!---
	* Mod: se considera que cuando es el primer acceso, debe personalizarse la cuenta de usuario
	* Fecha: septiembre, 2016
	* @author Yareli Andrade
	-------------------------------------
	* Fecha creacion: Junio 18, 2015
	* @author Yareli Andrade
	--->
	<cffunction name="validarUsuario" access="public" returntype="struct">
		<cfargument name="usr" type="string" required="yes">
		<cfargument name="psw" type="string" required="yes">
		<cfscript>
			result	= structNew();
			cnResultado = CreateObject('component', 'DAO_login');
			usuario	= cnResultado.getUsuario(usr, psw);
			result.VALIDADO = 0;
			if (usuario.RECORDCOUNT GT 0) {
				if (usuario.ESTADO == 2) {
					result.VALIDADO = 1;
					result.PK = usuario.PK;
					result.ROL = usuario.ROL;
					result.VERTIENTE = usuario.VERTIENTE;
					result.USR = usuario.USR;
					result.MODULO_INICIAL = usuario.MODULO_INICIAL;
					result.UR = usuario.UR;					
					if (usuario.FIRST_ACCESS == 1) {
						result.PSW = usuario.PSW_INICIAL;
					} else {
						result.AP_PAT = usuario.PATERNO;
						result.AP_MAT = usuario.MATERNO;
						result.NOMBRE = usuario.NOMBRE;
						result.EMAIL = usuario.EMAIL;
						result.GENERO = usuario.GENERO;
					}
				} else
					result.VALIDADO = 2;
			}
			return result;
		</cfscript>
	</cffunction>

</cfcomponent>