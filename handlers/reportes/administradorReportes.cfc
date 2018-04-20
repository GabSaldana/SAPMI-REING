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

	<cfproperty name="cn" inject="reportes/CN_reportes">
	
	<cffunction name="explorarReporte" hint="Exploracion de un reporte">
		<cfargument name="Event" hint="Exploracion de un archivo">
		<cfscript>
			var conjuntoDatos = cn.getNombreConjuntoDatos(rc.idCon);	
			getPlugin("SessionStorage").setVar("conjunto", conjuntoDatos);							
			prc.tabla=cn.obtenerTablaPorId(rc.idRep);
			Event.setView("reportes/exploradorReporte");
			
		</cfscript>
	</cffunction>
</cfcomponent>