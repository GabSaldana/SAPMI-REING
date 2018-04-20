<!---
========================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: Administración de correos
* Fecha: Noviembre de 2016
* Descripcion: handler 
* Autor: SGS
=========================================================================
--->


<cfcomponent>
	<cfproperty name="cnAdmonCorreos" inject="adminCSII.admonCorreos.CN_correos">

	<cffunction name="index" access="remote" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfset event.setView("adminCSII/admonCorreos/correos")>
	</cffunction>

	<cffunction name="obtenerCorreos" hint="Obtiene correos para la tabla de correos">
		<cfargument name="event" type="any">	
		<cfscript>
			prc.correo = cnAdmonCorreos.obtenerCorreos();
			event.setView("adminCSII/admonCorreos/tablaCorreos").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="obtenerVistaCorreo" hint="Obtiene vista previa de un correo">
		<cfargument name="event" type="any">	
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.obtenerVistaCorreo(rc.pkCorreo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="cambiarEstadoCorreo" hint="Cambia el estado de un correo">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.cambiarEstadoCorreo(rc.pk);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="obtenerBody" hint="Obtiene el cuerpo del correo">
		<cfargument name="event" type="any">	
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.obtenerBody(rc.pkCorreo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="agregarCorreo" hint="Agrega un nuevo correo">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.agregarCorreo(rc.nombre, rc.desc, rc.nombreContenido, rc.contenido, rc.pkHead, rc.pkFoot);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="editarCorreo" hint="Edita un correo">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.editarCorreo(rc.pk, rc.nombre, rc.desc, rc.nombreContenido, rc.contenido, rc.pkHead, rc.pkFoot);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="obtieneHeader" hint="Obtiene las plantillas header para la tabla">
		<cfargument name="Event" type="any">
		<cfscript>
			prc.plantilla = cnAdmonCorreos.obtieneHeader();
			event.setView("adminCSII/admonCorreos/tablaPlantillas").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="obtieneFooter" hint="Obtiene las plantillas footer para la tabla">
		<cfargument name="Event" type="any">
		<cfscript>
			prc.plantilla = cnAdmonCorreos.obtieneFooter();
			event.setView("adminCSII/admonCorreos/tablaPlantillas").noLayout();
		</cfscript>
	</cffunction>
	
	<cffunction name="agregarHeader" hint="Agrega una nueva plantilla header">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.agregarHeader(rc.nombre, rc.desc, rc.contenido);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="agregarFooter" hint="Agrega una nueva plantilla footer">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.agregarFooter(rc.nombre, rc.desc, rc.contenido);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="editarHeader" hint="Edita una plantilla header">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.editarHeader(rc.pk, rc.nombre, rc.desc, rc.contenido);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="editarFooter" hint="Edita una plantilla fotter">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.editarFooter(rc.pk, rc.nombre, rc.desc, rc.contenido);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="obtenerVistaHeader" hint="Obtiene vista previa de una plantilla header">
		<cfargument name="event" type="any">	
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.obtenerVistaHeader(rc.pkPlant);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="obtenerVistaFooter" hint="Obtiene vista previa de una plantilla footer">
		<cfargument name="event" type="any">	
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.obtenerVistaFooter(rc.pkPlant);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="cambiarEstadoHeader" hint="Cambia el estado de una plantilla header">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.cambiarEstadoHeader(rc.pk);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="cambiarEstadoFooter" hint="Cambia el estado de una plantilla footer">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.cambiarEstadoFooter(rc.pk);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="obtieneHeaderCarrusel" hint="Obtiene las plantillas header del carrusel">
		<cfargument name="event" type="any">	
		<cfscript>
			var resultado = cnAdmonCorreos.obtieneHeaderCarrusel();
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="obtieneFooterCarrusel" hint="Obtiene las plantillas footer del carrusel">
		<cfargument name="event" type="any">	
		<cfscript>
			var resultado = cnAdmonCorreos.obtieneFooterCarrusel();
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="obtieneEtiquetas" hint="Obtiene las etiquetas disponibles para el correo">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.obtieneEtiquetas(rc.pkBody);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="agregarEtiqueta" hint="Agrega una etiqueta al correo">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.agregarEtiqueta(rc.pkBody, rc.nombre, rc.descripcion);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="cambiarEstadoEtiqueta" hint="Cambia el estado de una etiqueta">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnAdmonCorreos.cambiarEstadoEtiqueta(rc.pkEti);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="getHistorialCorreos" hint="Cambia el estado de una etiqueta">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.correos = cnAdmonCorreos.getHistorialCorreos(rc.fechaInicio, rc.fechaFin);
			event.setView("adminCSII/admonCorreos/historialCorreos").noLayout();
		</cfscript>
	</cffunction>
	
	<cffunction name="getCorreo" hint="Obtiene el contenido del correo">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			resultado = cnAdmonCorreos.getCorreo(rc.pkHistorial);
			event.renderData(type="json", data=resultado.DESCRIPCION);
		</cfscript>
	</cffunction>

</cfcomponent>