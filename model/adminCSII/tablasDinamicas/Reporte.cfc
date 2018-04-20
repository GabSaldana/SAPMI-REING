<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Reportes Adhoc
* Sub modulo: Explorador de conjuntos de datos 
* Fecha: 10 de Septiembre  de 2015
* Descripcion: 
* Objeto de negocio para los reportes 
* Autor:Arturo Christian Santander Maya 
* ================================
--->

<cfcomponent accessors="true">
	<cfproperty name="id">
	<cfproperty name="conjunto">
	<cfproperty name="nombre">
	<cfproperty name="padre">
	<cfproperty name="descripcion">
	<cfproperty name="contenido">
	<cfproperty name="definicionVis">
	<cfproperty name="fechaCreacion">
	<cfproperty name="fechaUltMod">
	<cfproperty name="fechaPub">
	<cfproperty name="visualizaciones" type="array">

	

	

	<cffunction name="init">
		<cfscript>
			visualizaciones=[];
			padre="--";
			return this;
		</cfscript>
	</cffunction>	

	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="agregarVisualizacion" hint="Agrega una visualizacion al reporte">
		<cfargument name="visualizacion">
		<cfscript>
			arrayAppend(visualizaciones, visualizacion);
		</cfscript>
	</cffunction>

	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="obtenerVisualizacionPorId" hint="Obtiene  una de las visualizaciones agregadas al reporte" >
		<cfargument name="idVis">
			<cfscript>
				for (var visualizacion in visualizaciones){
					if(visualizacion.getId() eq idVis){
						return visualizacion;
					}
				}
				return;
			</cfscript>
		
	</cffunction>

	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->

	<cffunction name="eliminarVisualizacion" hint="Elimina una visualizacion asociada al reporte">
		<cfargument name="idVis">
		<cfscript>
				for (var i =1;i<=arrayLen(visualizaciones);i++){
					if(visualizaciones[i].getId() eq idVis){
						ArrayDeleteAt(visualizaciones,i);
				
					}
				}
			
		</cfscript>
	</cffunction>

	<!---
		*Fecha :29 de octubre de 2015
		* @author Arturo Christian Santander Maya 
  	--->


	<cffunction name="obtenerDefinicionesVis" hint="Retorna un arreglo de estructuras con la definicion de cada una de las visualizaciones creadas">
		<cfscript>
			var definiciones=[];
			for (var visualizacion in visualizaciones){
				var visDef={};
				visDef["id"]=visualizacion.getId();
				visDef["definicion"]=visualizacion.getDefinicion();
				arrayAppend(definiciones, visDef);
			}
			return definiciones;
			
		</cfscript>
	</cffunction>

</cfcomponent>