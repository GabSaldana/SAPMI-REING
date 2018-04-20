<!---
* =========================================================================
* IPN - CSII
* Sistema: PIMP
* Modulo: Administrador de reportes
* Fecha : octubre de 2016
* Descripcion: handler 
* Autor: Alejandro Rosales 
* =========================================================================
--->

<cfcomponent>

	<cfproperty name="cn" inject="preguntas/CN_preguntas">
	
	<cffunction name="index" hint="Modificación de preguntas">
		<cfscript>

			Event.setView("preguntas/preguntas");
			
		</cfscript>
	</cffunction>
</cfcomponent>