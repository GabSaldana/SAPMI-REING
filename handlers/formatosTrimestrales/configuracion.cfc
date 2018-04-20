<cfcomponent>
	
	<!---
	* Fecha:		Diciembre 2016		
	* @author: 		Marco Torres.
	--->  
	<cffunction name="index" access="public" returntype="void" output="false" hint="carga la vista general del modulo">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.Formatos = cn.getFormatos();  
			event.setView("formatosTrimestrales/configuracion/administradorFormatos");
		</cfscript>
    </cffunction>
	
	<!---
	* Fecha:		Diciembre 2016		
	* @author: 		Marco Torres.
	--->  
	<cffunction name="getVistaConfiguracion" access="public" returntype="void" output="false"  hint="carga la vista de edicion de un formato">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			event.setView("formatosTrimestrales/configuracion/configuracion").noLayout();
		</cfscript>
    </cffunction>
	
	<!---
	* Fecha:		Diciembre 2016		
	* @author: 		Marco Torres.
	--->  
	<cffunction name="getTabla" access="public" returntype="void" output="false"  hint="carga la vista de la tabla de de hansontable">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.reporte  = cn.getEncabezado(rc.formato); 
			
			event.setView("formatosTrimestrales/configuracion/P3_tablaEncabezado").noLayout();
			//event.setView("formatosTrimestrales/tablaCapturaFormula").noLayout();
		</cfscript>
    </cffunction>
	
	<!---
	* Fecha:		Diciembre 2016		
	* @author: 		Marco Torres.
	--->  
	<cffunction name="getColumna" access="public" returntype="void" output="false" hint="carga la vista de configuracion de las columnas">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.getColumna(rc.fila,rc.columna);

			prc.plantillas = cn.getPlantillas();
			prc.tiposDato = cn.getTiposDato();
			prc.columna  = respuesta.columna ;
			prc.sumandos  = respuesta.sumandos ;
			
			event.setView("formatosTrimestrales/configuracion/columna").noLayout();
		</cfscript>
    </cffunction>
	
	<!---
	* Fecha:		Diciembre 2016		
	* @author: 		Marco Torres.
	--->  
	<cffunction name="getVistaSumandos" access="public" returntype="void" output="false" hint="carga la vista de configuracion de sumandos">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.columna  = cn.getColumna(rc.fila,rc.columna);
			prc.reporte  = cn.getEncabezado(rc.formato); 
			
			event.setView("formatosTrimestrales/configuracion/colSumandos").noLayout();
		</cfscript>
    </cffunction>
	
	<!---
	* Fecha:		Diciembre 2016		
	* @author: 		Marco Torres.
	--->  
	<cffunction name="cargaEncabezado" access="public" returntype="void" output="false" hint="carga la vista para captura de estructura de encabezado">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.reporte  = cn.getEncabezado(rc.formato); 
			
			event.setView("formatosTrimestrales/configuracion/P2_configEncabezado").noLayout();
		</cfscript>
    </cffunction>

	<!---
	* Fecha:		Diciembre 2016		
	* @author: 		Marco Torres.
	--->  
	<cffunction name="cargaInfoGral" access="public" returntype="void" output="false" hint="carga la vista de informacion general">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.formato  = cn.getInfoFormato(rc.formato); 
			prc.clasif  = cn.getClasif();			
			event.setView("formatosTrimestrales/configuracion/P1_infoGeneral").noLayout();
		</cfscript>
    </cffunction>
	
	<!---
	* Fecha:		Diciembre 2016		
	* @author: 		Marco Torres.
	--->  
	<cffunction name="cargaConfigGral" access="public" returntype="void" output="false" hint="carga la vista de configuraciones generales">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			//prc.encabezado  = cn.getEncabezado(rc.formato); 
			prc.Formato = cn.cargaConfigGral(rc.formato);
			event.setView("formatosTrimestrales/configuracion/P4_configGeneral").noLayout();
		</cfscript>
    </cffunction>
	
	<!---
	* Fecha:		Enero 2017		
	* @author: 		Marco Torres.
	--->  
	<cffunction name="cambiarEstadoFT" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.cambiarEstadoFT(rc.pkTformato, rc.accion); 
			event.renderData(type = "json", data = respuesta);
		</cfscript>
    </cffunction>
	 
	
	
	<!--- <cffunction name="guardarInfo" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.guardarInfo(rc.formato, rc.periodo, rc.datos); 
			event.renderData(type = "json", data = respuesta);
		</cfscript>
    </cffunction>
	 --->
	 
	 
	<!---
	* Fecha:		Diciembre 2016		
	* @author: 		Marco Torres.
	--->  
	<cffunction name="cargaVistaNuevoReporte" access="public" returntype="void" output="false"  hint="carga la vista para captura de nuevos reportes">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			//prc.encabezado  = cn.getEncabezado(rc.formato); 
			
			event.setView("formatosTrimestrales/configuracion/nuevoReporte");
		</cfscript>
    </cffunction>
	
	
	<cffunction name="insertarFormato" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta = cn.insertarFormato(rc.clave,rc.nombre,rc.vigencia,rc.uresponsable,rc.instrucciones);
			event.renderData(type = "json",data = respuesta);
		</cfscript>
	</cffunction>

	<cffunction name="actualizarFormato" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta = cn.actualizarFormato(rc.pkFormato,rc.claveFormato,rc.nombreFormato,rc.vigenciaFormato,rc.areaFormato,rc.instrucciones);
			event.renderData(type = "json",data = respuesta);
		</cfscript>
	</cffunction>

	<cffunction name="getUR" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.getUR(rc.pkClasif);	
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>

    <cffunction name="guardarElementosCatalogo" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			catalogo = deserializeJSON(rc.elemCatalogo);			
			respuesta = CN.guardarElementosCatalogo(rc.pkColumna,catalogo);			
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>

    <cffunction name="bloquearparaCaptura" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>				
			respuesta = CN.bloquearparaCaptura(rc.pkColumna,rc.bloqueada);			
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>


    <cffunction name="columnaReferencia" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>		
			respuesta = CN.columnaReferencia(rc.pkColumna,rc.referencia);			
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>

    <cffunction name="setCopiableTrimestre" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>				
			respuesta = CN.setCopiableTrimestre(rc.pkColumna,rc.copiable);			
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>

    <cffunction name="setCalcularTotales" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>				
			respuesta = CN.setCalcularTotales(rc.pkFormato,rc.pkColumna);			
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>

    <cffunction name="setCalcularTotalFinal" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>				
			respuesta = CN.setCalcularTotalFinal(rc.pkFormato,rc.pkColumna);			
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>

    <cffunction name="actualizarNombreColumna" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>				
			respuesta = CN.actualizarNombreColumna(rc.pkColumna,rc.nombre);			
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>
    
    <cffunction name="registrarSumaSecciones" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>				
			respuesta = CN.registrarSumaSecciones(rc.pkFormato,rc.pkPlantilla,rc.pkColumna,rc.pkAsociacion);			
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>    

	<!---
	* Fecha:		Mayo 2017	
	* @author: 		Ana Belem Juarez.
	--->  
    <cffunction name="actualizarOperando" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>				
			respuesta = CN.actualizarOperando(rc.pkColumna,rc.pkDestino,rc.operacion);			
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>
    
    <cffunction name="registrarOperando" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>				
			respuesta = CN.registrarOperando(rc.pkColumna,rc.pkDestino,rc.operacion);			
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>

    <cffunction name="eliminarOperando" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>				
			respuesta = CN.eliminarOperando(rc.pkColumna,rc.pkDestino);			
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>         

    <cffunction name="actualizarDescripcionColumna" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>				
			respuesta = CN.actualizarDescripcionColumna(rc.pkColumna,rc.descripcion);			
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>            

    <cffunction name="guardarPlantillaColumna" access="public" returntype="void" output="false" hint="Relaciona una columna con una plantilla">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>			
			respuesta = CN.guardarPlantillaColumna(rc.pkColumna,rc.pkPlantilla);			
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>

    <cffunction name="actualizarTipoDato" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.actualizarTipoDato(rc.pkColumna,rc.pkTipoDato);	
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>
    
    <cffunction name="getElementosPlantilla" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.getElementosPlantilla(rc.pkPlantilla);	
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>

    <cffunction name="getAsociacionPlantillas" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.getAsociacionPlantillas(rc.pkPlantilla);	
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>

    <cffunction name="getPlantillasAsociadas" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.getPlantillasAsociadas(rc.pkAsociacion);	
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>

    <!---
	* Fecha:		Febrero 2017		
	* @author: 		Daniel Memije
	--->  
	<cffunction name="getInfoCopiar" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.getInfoCopiar(rc.pkTformato);	
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction> 

    <cffunction name="copiarFormato" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.copiarFormato(rc.pkFormato,rc.clave,rc.nombre);	
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>

    <cffunction name="formatoVersion" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.formatoVersion(rc.pkTFormato);	
			event.renderData(type = "json",data = respuesta);
		</cfscript>
    </cffunction>

	<cffunction name="guardarEstructuraReporteP2" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			respuesta  = cn.guardarEstructuraReporteP2(rc.formato, rc.encabezado); 
			event.renderData(type = "json", data = respuesta);
		</cfscript>
    	</cffunction>

	<!---
    * Fecha creación: Enero de 2017
    * @author: SGS
    --->
	<cffunction name="vistaTrimAnteriores" access="public" returntype="void" output="false" hint="Crea la vista del modal informacion de semestres previos">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.columna = cn.getColumna(rc.fila,rc.columna);
			prc.reporte = cn.getEncabezado(rc.formato); 
			event.setView("formatosTrimestrales/configuracion/colTrimestresAnteriores").noLayout();
		</cfscript>
    </cffunction>

    <!---
    * Fecha creación: Enero de 2017
    * @author: SGS
    --->
    <cffunction name="cambiaColumna" hint="Marca o desmarca una celda de la tabla de Información de semestres previos">
		<cfargument name="event" type="any">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.cambiaColumna(rc.pkColumna, rc.pkColOrigen, rc.trimCopiable);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
    * Fecha creación: Febrero de 2017
    * @author: SGS
    --->
    <cffunction name="cambiaConfigGral" hint="Cambia las configuraciones generales">
		<cfargument name="event" type="any">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.cambiaConfigGral(rc.pkFormato, rc.insercionFilas, rc.totalFinal, rc.acumulado);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>
	
	<!---
	* Fecha:		Marzo 2017
	* @author: 		Daniel Memije.
	--->  
	<cffunction name="vistaCatalogoOrigen" access="public" returntype="void" output="false" hint="carga la vista de catalogos dependientes">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>
			prc.columna  = cn.getColumna(rc.fila,rc.columna);
			prc.reporte  = cn.getEncabezado(rc.formato); 	
			prc.informacion = cn.getInfoFormato(rc.formato);
			prc.asociaciones = cn.getAsociacionesCatalogos(prc.informacion.getpkCatalogoOrigen(),prc.columna.columna.getpk_columna());			
			// <cfproperty name="pkCatalogoOrigen"			hint="estructura con las secciones y los valores asociados">
			// <cfproperty name="pkCatalogoDestino"		hint="estructura con las secciones y los valores asociados">	
			event.setView("formatosTrimestrales/configuracion/colCatalogoOrigen").noLayout();
		</cfscript>
    </cffunction>

    <!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
    <cffunction name="seleccionarAsociacionCatalogos" hint="Selecciona una asociacion de catalogos">
		<cfargument name="event" type="any">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>			
			var resultado = CN.seleccionarAsociacionCatalogos(rc.pkFormato, rc.pkAsociacion);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>    

	<!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
	<cffunction name="quitarAsociacionCatalogos" hint="Deselecciona una asociacion de catalogos">
		<cfargument name="event" type="any">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>			
			var resultado = CN.quitarAsociacionCatalogos(rc.pkFormato);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
    <cffunction name="seleccionarColumnaOrigen" hint="Selecciona una columna como origen del catalogo">
		<cfargument name="event" type="any">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>			
			var resultado = CN.seleccionarColumnaOrigen(rc.pkFormato, rc.pkOrigen,rc.pkDestino);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>    

	<!---
    * Fecha creación: Marzo de 2017
    * @author: Daniel Memije
    --->
	<cffunction name="quitarColumnaOrigen" hint="Deselecciona una columna como origen del catalogo">
		<cfargument name="event" type="any">
		<cfset CN = getModel("formatosTrimestrales.CN_FormatosTrimestrales") >
		<cfscript>			
			var resultado = CN.quitarColumnaOrigen(rc.pkFormato);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>
</cfcomponent>
