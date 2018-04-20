<!---
* =========================================================================
* IPN - CSII
* Sistema: SIIIS 
* Modulo: Principal
* Sub modulo: Login
* Fecha: agosto, 2015
* Descripcion: Genera el menú principal dinámicamente
* =========================================================================
--->

<cfcomponent>
	
	<!---
	* Fecha creacion: agosto, 2016
	* @author Yareli Andrade
	--->    
    <cffunction name="getMenu" access="remote" hint="Obtiene las secciones del menu de acuerdo al rol de usuario">
        <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
		<cfscript>
			daoMenu = CreateObject('component', 'DAO_menu');		
			return daoMenu.getMenu(rol);
		</cfscript>
    </cffunction>

    <!---
	* Fecha creacion: agosto, 2016
	* @author Yareli Andrade
	--->    
    <cffunction name="getPrivilegios" hint="Obtiene las acciones permitidas de acuerdo al rol de usuario">
        <cfargument name="rol" type="numeric" required="yes" hint="Rol del usuario">
		<cfscript>
			permisos = [];
			daoMenu = CreateObject('component', 'DAO_menu');		
			privilegios = daoMenu.getPrivilegios(rol);			
			for (var i = 1; i <= privilegios.recordcount; i++){
				arrayAppend(permisos, privilegios.CLAVE[i]);
			}
			return permisos;
		</cfscript>

    </cffunction>

</cfcomponent>