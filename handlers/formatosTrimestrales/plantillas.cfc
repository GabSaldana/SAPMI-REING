<cfcomponent>
 
   <cffunction name="index" access="remote" hint="">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			prc.plantillas = CN.getAllPlantillas();
			event.setView("formatosTrimestrales/plantillas/plantillas/administradorPlantillas");
		</cfscript>
	</cffunction>
	
	<cffunction name="nuevaPlantilla" access="remote" hint="">
		<cfscript>
			event.setView("formatosTrimestrales/plantillas/plantillas/nuevaPlantillas").noLayout();
		</cfscript>
	</cffunction>
	
	<cffunction name="editarPlantilla" access="remote" hint="">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			resultado= CN.getPlantilla(rc.pkPlantilla);
			prc.elementosPlant = resultado;
			prc.pkPlantilla= rc.pkPlantilla;
			event.setView("formatosTrimestrales/plantillas/plantillas/editarPlantilla").noLayout();
		</cfscript>
	</cffunction>
	
	<cffunction name="setPlantilla" access="remote" hint="">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			resultado = CN.setPlantilla(rc.nombrePlantilla,rc.valoresPlantilla);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>
	
	<cffunction name="updateValorPlantilla" access="remote" hint="">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			resultado = CN.updateValorPlantilla(rc.pk_plantilla,rc.datos);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>
	
	
	<cffunction name="borraPlantilla" access="remote" hint="">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			resultado = CN.borraPlantilla(rc.pk_plantilla);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:		26/08/2016		
	* @author: 		Marco Torres.
	--->  
	<cffunction name="getFormatosRelacionados" access="remote" hint="Obtiene los Formatos Relacionados a la Plantilla">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			resultado = CN.getFormatosRelacionados(rc.pk_plantilla);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha:		AGOSTO 2016		
	* @author: 		Marco Torres.
	--->  
	<cffunction name="actualizarCatalogo" access="remote" hint="Obtiene los Formatos Relacionados a la Plantilla">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			resultado = CN.actualizarCatalogo(rc.pkColumna);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>
	
	<cffunction name="copiarPlantilla" access="remote" hint="Copia contenido de una plantilla">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas")>
		<cfscript>
			resultado = CN.copiarPlantilla(rc.pkPlantilla, nombre);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>

	<!-----******************************Inicio Funciones del modulo de asociacion***************************************************************
	******************************************************************************************************************************************  --->
	
	<cffunction name="indexAsociacion" access="remote" hint="">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			prc.plantillas = CN.getAllPlantillas();
			event.setView("formatosTrimestrales/plantillas/asociacion/asociacionPlantillas");
		</cfscript>
	</cffunction>
	
	<cffunction name="vistaAsociarElementos" access="remote" hint="">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			plantSeleccionadas = deserializeJSON(rc.plantSelect);
			prc.plantillas= CN.getPlantillaSeleccionadas(plantSeleccionadas);
			prc.nombres = rc.nombres;
			event.setView("formatosTrimestrales/plantillas/asociacion/asociacionElementos").noLayout();
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha:		ENERO 2017		
	* @author: 		Roberto Cadena.
	--->  

	<cffunction name="asociarPlantilla" access="remote" hint="asocia las plantillas padres con las plantillas hijos">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			plantSeleccionadas = deserializeJSON(rc.plantSelect);
			const = CN.crearAsociacion(rc.nombreA);
			resultado = CN.asociarPlantilla(plantSeleccionadas, const);
			asociacionesElementos = deserializeJSON(rc.asociaciones);
			resultado = CN.asociarElementos(asociacionesElementos, const);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>

	<cffunction name="indexAsociados" access="remote" hint="Muestra todas las asociaciones">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			prc.asociaciones = CN.getPlantillasAsociadas();
			event.setView("formatosTrimestrales/plantillas/asociacion/plantillaAsociada");
		</cfscript>
	</cffunction> 	

	 <cffunction name="cargarPlantillas" access="remote" hint="devuelve los elementos de las plantilla de una asociación">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			prc.plantillas = CN.cargarPlantillas(rc.pkAsociacion);
			event.setView("formatosTrimestrales/plantillas/asociacion/asociacionEditarElemento").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="asociarPlantillaEditada" access="remote" hint="edita las asociaciones de las plantillas padres con las plantillas hijos">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			CN.eliminarElementosAsociados(rc.pkAsociado);
			CN.actualizarNombre( rc.pkAsociado, rc.nombre);
			asociacionesElementos = deserializeJSON(rc.asociaciones);
			resultado = CN.asociarElementos(asociacionesElementos, rc.pkAsociado);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>

	<cffunction name="eliminarAsociacion" access="remote" hint="elimina una asociación">
		<cfset CN =  getModel("formatosTrimestrales.plantillas.CN_Plantillas") >
		<cfscript>
			resultado = CN.eliminarAsociacion(rc.pkAsociacion);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>
</cfcomponent>
