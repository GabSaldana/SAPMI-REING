<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo:Editor de Visualizaciones
* Fecha 25 de agosto de 2015
* Descripcion: 
* Controlador para el submodulo de edicion de Visualizaciones
* Autor:Arturo Christian Santander Maya 
* ================================
--->

	
<cfcomponent>
	<cfproperty name="cnConjuntos" inject="tablasDinamicas/CN_ConjuntosDatos">
	
	
	

	
	<!---
		*Fecha :30 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->
	<cffunction name="obtenerFiltrosColumna" hint="Obtiene los filtros posibles para una columna">
		<cfscript>
			var resultado=cnConjuntos.obtenerFiltrosColumna(rc.idCon,rc.idCol);
			event.renderData( type="json", data=resultado);

		</cfscript>	

	</cffunction>


	

</cfcomponent>