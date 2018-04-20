<!---
* =========================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: administración de usuarios
* Sub modulo: 
* Fecha: agosto/2016
* Descripcion: handler para mostrar el menu principal 
* Autor: Yareli Andrade
* =========================================================================
--->

<cfcomponent>	
	<!---
	* Fecha creación: agosto, 2016
	* @author Yareli Andrade
	-------------------------------------
	* Fecha creacion: mayo, 2017
	* @author SGS
	--->
	<cffunction name="index" hint="Redirecciona a la vista principal del sistema">
		<cfargument name="event" type="any">
		<cfscript>
			event.setView("inicio");
		</cfscript>
	</cffunction>

</cfcomponent>
