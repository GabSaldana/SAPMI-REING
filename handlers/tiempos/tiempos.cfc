<!---
* =========================================================================
* IPN - CSII
* Sistema:		SIIIS
* Modulo:		Handler de la administración de los tiempos
* Fecha:		Agosto de 2017
* Descripcion:	Controlador de la administración de los tiempos
* Autor:		Roberto Cadena
* =========================================================================
--->
<cfcomponent>

	<cfproperty name="CN" inject="tiempos.CN_tiempos">

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="index" hint="Muestra la vista del administrador de tiempos">
		<cfscript>
			prc.proced = CN.getProced();
			event.setView("/tiempos/index");
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getFiltros" hint="Obtiene todas las areas">
		<cfscript>
			var rc = Event.getCollection();
			filtro.area =	CN.getAllAreas(rc.proced);
			filtro.estado =	CN.getAllEstados(rc.proced);
			filtro.rol =	CN.getAllRoles(rc.proced);
			event.renderData(type="json", data=filtro);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Agosto 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="getTiempo" hint="Obtiene el tiempo que ha estado en cada estado">
		<cfscript>
			var rc = Event.getCollection();
			prc.tiempo = CN.getTiempo(rc.proced, rc.area, rc.estado, rc.rol, rc.fechaInicio, rc.fechaFin);
			event.setView("/tiempos/tablaTiempos").noLayout();
		</cfscript>
	</cffunction>

</cfcomponent>