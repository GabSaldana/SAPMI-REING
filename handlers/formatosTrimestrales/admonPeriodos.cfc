<!---
========================================================================
* IPN - CSII
* Sistema: EVALUACION
* Modulo: Administración de periodos
* Fecha: Enero de 2017
* Descripcion: handler 
* Autor: SGS
=========================================================================
--->

<cfcomponent>
	<cfproperty name="CN" inject="formatosTrimestrales.admonPeriodos.CN_periodos">
	
	<cffunction name="index" access="public" returntype="void" output="false" hint="Obtiene los trimestres existentes al cargar la pagina">
		<cfargument name="event" type="any">
		<cfscript>
			prc.Periodos  = CN.obtenerPeriodos();
			event.setView("formatosTrimestrales/admonPeriodos/administradorPeriodos");
		</cfscript>
    </cffunction>

    <cffunction name="obtenerAnios" hint="Obtiene los años que ya fueron usados para crear trimestres">
		<cfargument name="event" type="any">	
		<cfscript>
			var resultado = CN.obtenerAnios();
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="agregarPeriodo" hint="Agrega un periodo nuevo">
		<cfargument name="event" type="any">	
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.agregarPeriodo(rc.anio);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="obtenerPeriodos" hint="Obtiene los trimestres existentes">
		<cfargument name="event" type="any">	
		<cfscript>
			var resultado = CN.obtenerPeriodos();
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="obtenerFormatos" hint="Obtiene los formatos de un periodo">
		<cfargument name="event" type="any">
		<cfargument name="rc">	
		<cfscript>
			prc.Formatos  = CN.obtenerFormatos(rc.periodo);
			event.setView("formatosTrimestrales/admonPeriodos/tablaFormatos").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="obtenerReporte" access="public" returntype="void" output="false" hint="Obtiene un reporte de un periodo">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfset CN_Formatos = getModel("formatosTrimestrales.CN_FormatosTrimestrales")>
		<cfscript>
			prc.Reporte = CN_Formatos.getInfoReporte(rc.formato, rc.periodo);
			prc.acciones = CN_Formatos.getReporte(prc.Reporte.getpkReporte());
			event.setView("formatosTrimestrales/captura/consulta").noLayout();
		</cfscript>
    </cffunction>

	<cffunction name="obtenerPeriodoAnterior" hint="Obtiene el ultimo periodo de un formato">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.obtenerPeriodoAnterior(rc.formato);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

    <cffunction name="crearReporte" hint="Crea un repote para un periodo">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.crearReporte(rc.formato, rc.periodoNuevo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
	* Fecha:		Febrero 2017		
	* @author: 		Alejandro Tovar
	--->  
	<cffunction name="cambiarEstadoPer" access="public" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfset CN =  getModel("formatosTrimestrales.admonPeriodos.CN_Periodos") >
		<cfscript>
			respuesta  = cn.cambiarEstadoPer(rc.pkRegistro, rc.accion, rc.nombreFormato, rc.periodoFormato, rc.claveFormato); 
			event.renderData(type = "json", data = respuesta);
		</cfscript>
    </cffunction>

</cfcomponent> 