<!---
========================================================================
* IPN - CSII
* Sistema: EVALUACION
* Modulo: Reportes concentrados
* Fecha: Marzo de 2017
* Descripcion: handler 
* Autor: Alejandro Tovar
=========================================================================
--->

<cfcomponent>
	<cfproperty name="CN_Formatos" inject="formatosTrimestrales.CN_FormatosTrimestrales">
	
	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="index" access="public" returntype="void" output="false" hint="Lanza una ventana vacia para cargar las asociaciones">
		<cfargument name="event" type="any">
		<cfscript>
			event.setView("formatosTrimestrales/asociacionFormatos/asociacion");
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="getDragDrop" hint="Muestra los formatos disponibles a relacionar">
		<cfscript>
			prc.plantillas = CN_Formatos.getReportes();
			event.setView("formatosTrimestrales/asociacionFormatos/dragDrop").noLayout();
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
    <cffunction name="getReportesAsociados" hint="Obtiene las relaciones de formatos">
		<cfscript>
			prc.asociaciones = CN_Formatos.getAsociacionFormatos();
			event.setView("formatosTrimestrales/asociacionFormatos/tablaAsociaciones").noLayout();
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="setAsociaciones" access="remote" hint="Establece la relacion entre formatos seleccionados">
		<cfscript>
			var resultado =  CN_Formatos.setAsociaciones(rc.nombres, rc.formatos);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="getTabla" access="public" returntype="void" output="false"  hint="carga la vista de la tabla de de hansontable">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN_Utils =  getModel("utils.CN_utilities")>
		<cfscript>
			var formatosYContenedor = CN_Formatos.getFormatosAsociacionContenedor(rc.pkAsociacion);
			var formatos = CN_Formatos.asociarFormatos(formatosYContenedor);
			var formatosAsociados = CN_Formatos.getFormatosAsociacion(rc.pkAsociacion);

			prc.pkFormato = formatos.pkFormato;
			prc.reporte   = formatos.reporte;
			prc.indice 	  = formatos.indice;
			prc.promedio  = formatos.promedio;
			prc.celdasRelacionadas = formatos.celdasRelacionadas;
			prc.pkAsociacion = rc.pkAsociacion;
			prc.formatos = serializeJSON(formatosAsociados);

			/******************************************************************************/
			var asociadas = CN_Formatos.getColumnasAsociadas(rc.pkColumnaOrigen);
			prc.colAsociada = CN_Utils.queryToArraySinStruct(asociadas);

			// Obtiene las plantillas y los elementos que ya fueron asociados a un formato
			prc.plantillas = CN_Formatos.getPlantillas();
			var plantillaAsociada = CN_Formatos.getPlantillaSelected(rc.pkAsociacion).PLANTILLA[1];
			
			if (plantillaAsociada GTE 1){
				prc.plantillaSelect = plantillaAsociada;
				prc.valorElementos = CN_Formatos.getValorElementos(rc.pkAsociacion);
			}else {
				prc.plantillaSelect = 0;
				prc.valorElementos = 0;
			}
			/***************************************************************************************/

			var colores = CN_Formatos.getColoresColumnas(formatosAsociados);
			prc.colores = colores;

			event.setView("formatosTrimestrales/asociacionFormatos/encabezadoPadre").noLayout();
		</cfscript>
    </cffunction>


    <!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="setRelacionColumnas" access="remote" hint="Inserta o actualiza la relacion de columnas">
		<cfscript>
			return CN_Formatos.setRelacionColumnas(rc.pkOrigen, rc.pkAsociado, rc.pkFormato);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="getFormatosAsociacion" access="remote" hint="Obtiene los reportes que estan asociados al un registro de asociacion">
		<cfscript>
			var formato = CN_Formatos.getFormatosAsociacion(rc.pkAsociacion);
			event.renderData(type="json", data=formato);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="getPlantillasAsociadas" access="remote" hint="Obtiene los reportes que estan asociados al un registro de asociacion">
		<cfscript>
			var elementos = CN_Formatos.getPlantillasAsociadas(rc.pkFormato);
			event.renderData(type="json", data=formato);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
	<cffunction name="getElementosByPlantilla" access="remote" hint="Obtiene los elementos relacionados a una plantilla">
		<cfscript>
			var elementos = CN_Formatos.getElementosByPlantilla(rc.pkPlantilla);
			event.renderData(type="json", data=elementos);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	--->
	<cffunction name="guardaClasificacionFormato" access="remote" hint="Guarda la clasificacion del formato en la asociacion">
		<cfscript>
			var resultado = CN_Formatos.guardaClasificacionFormato(rc.pkFormato, rc.pkPlantilla, rc.clasificacion, rc.pkNombreAsociacion);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>	


	<!---
    * Fecha : Abril 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="cambiaEdoAsocColumns" access="remote" hint="Cambia a 0 el estado de la asociacion de las columnas">
		<cfscript>
			var resultado = CN_Formatos.cambiaEdoAsocColumns(rc.pkColOrigen, rc.pkColAsociada, rc.pkFormato);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha : Marzo 2017
    * author : Alejandro Tovar
	---> 
	<cffunction name="resetClasifiacion" access="remote" hint="Resetea clasificaciones de los formatos">
		<cfscript>
			var resultado = CN_Formatos.resetClasifiacion(rc.pkNombreAsociacion, rc.pkPlantilla);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


</cfcomponent> 