<!---
* =========================================================================
* IPN - CSII
* Sistema:		SIIE
* Modulo:		Asignación de Responsables
* Fecha:		Marzo de 2017
* Descripcion:	Handler para la asignación de responsables.
* Autor: 		Roberto Cadena
* =========================================================================
--->
<cfcomponent>

	<!--- *********************** Inicio de funciones de Analistas *********************** --->

	<cffunction name="indexAnalistas" access="remote" hint="Muestra todas las dependencias">
		<cfset CN =  getModel("formatosTrimestrales.asignacionResponsables.CN_AsignacionResponsables")>
		<cfscript>
			prc.relacion = CN.getDependencias();
			event.setView("formatosTrimestrales/asignacionResponsables/asignacionAnalistas/administradorAnalistas");
		</cfscript>
	</cffunction>

	<cffunction name="getTablaAnalistas" access="remote" hint="Muestra la tabla de analistas, dependencias y formatos">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfset CN_Formatos = getModel("formatosTrimestrales.asignacionResponsables.CN_AsignacionResponsables")>
		<cfscript>
			prc.relacion = CN_Formatos.getAllFormatosAnalistas(rc.dependencia, rc.val);
			event.setView("formatosTrimestrales/asignacionResponsables/asignacionAnalistas/tablaAnalistas").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="insertarAsociacionAnalistas" access="remote" hint="Inserta un analista a un formato">
		<cfset CN =  getModel("formatosTrimestrales.asignacionResponsables.CN_AsignacionResponsables")>
		<cfscript>
			var resultado = CN.insertarAsociacionAnalistas(rc.idFormato, rc.idAnalista);
			event.renderData(type="text", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="eliminarAsociacionAnalistas" access="remote" hint="elimia la asociación de un analista con formato">
		<cfset CN =  getModel("formatosTrimestrales.asignacionResponsables.CN_AsignacionResponsables")>
		<cfscript>
			var resultado = CN.eliminarAsociacionAnalistas(rc.idFormato, rc.idAnalista);
			event.renderData(type="text", data=resultado);
		</cfscript>
	</cffunction>

	<cffunction name="insertarTodosAnalistas" access="remote" hint="inserta una asociación de un responsable con todos los formatos">
		<cfset CN =  getModel("formatosTrimestrales.asignacionResponsables.CN_AsignacionResponsables")>
		<cfscript>
			CN.insertarTodosAnalistas(rc.idAnalista, rc.idDependencia);
			prc.relacion = CN.getAllFormatosAnalistas(rc.idDependencia, rc.val);
			event.setView("formatosTrimestrales/asignacionResponsables/asignacionAnalistas/tablaAnalistas").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="insertarTodosAnalistasNull" access="remote" hint="inserta una asociación de un responsable con todos los formatos que no fueron asignados">
		<cfset CN =  getModel("formatosTrimestrales.asignacionResponsables.CN_AsignacionResponsables")>
		<cfscript>
			CN.insertarTodosAnalistasNull(rc.idAnalista, rc.idDependencia);
			prc.relacion = CN.getAllFormatosAnalistas(rc.idDependencia, rc.val);
			event.setView("formatosTrimestrales/asignacionResponsables/asignacionAnalistas/tablaAnalistas").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="eliminarTodosAnalistas" access="remote" hint="elimina la asociación de un responsable con todos los formatos">
		<cfset CN =  getModel("formatosTrimestrales.asignacionResponsables.CN_AsignacionResponsables")>
		<cfscript>
			CN.eliminarTodosResponsables(rc.idAnalista, rc.idDependencia);
			prc.relacion = CN.getAllFormatosAnalistas(rc.idDependencia, rc.val);
			event.setView("formatosTrimestrales/asignacionResponsables/asignacionAnalistas/tablaAnalistas").noLayout();
		</cfscript>
	</cffunction>

	<!--- *********************** Inicio de funciones de Responsables *********************** --->

	<cffunction name="indexResponsables" access="remote" hint="Muestra todas las dependencias">
		<cfset CN =  getModel("formatosTrimestrales.asignacionResponsables.CN_AsignacionResponsables")>
		<cfscript>
			prc.relacion = CN.getDependencias();
			event.setView("formatosTrimestrales/asignacionResponsables/asignacionResponsables/administradorResponsables");
		</cfscript>
	</cffunction>

	<cffunction name="getTablaResponsables" access="public" hint="Obtiene todos los formatos y responsables de una dependencia">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfset CN_Formatos = getModel("formatosTrimestrales.asignacionResponsables.CN_AsignacionResponsables")>
		<cfscript>
			prc.relacion = CN_Formatos.getAllFormatosResponsables(rc.dependencia);
			event.setView("formatosTrimestrales/asignacionResponsables/asignacionResponsables/tablaResponsables").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="eliminarTodosResponsables" access="remote" hint="elimina la asociación de un responsable con todos los formatos">
		<cfset CN =  getModel("formatosTrimestrales.asignacionResponsables.CN_AsignacionResponsables")>
		<cfscript>
			CN.eliminarTodosResponsables(rc.idAnalista, rc.idDependencia);
			prc.relacion = CN.getAllFormatosResponsables(rc.idDependencia);
			event.setView("formatosTrimestrales/asignacionResponsables/asignacionResponsables/tablaResponsables").noLayout();
		</cfscript>
	</cffunction>

	<cffunction name="insertarTodosResponsables" access="remote" hint="inserta una asociación de un responsable con todos los formatos">
		<cfset CN =  getModel("formatosTrimestrales.asignacionResponsables.CN_AsignacionResponsables")>
		<cfscript>
			CN.insertarTodosResponsables(rc.idAnalista, rc.idDependencia);
			prc.relacion = CN.getAllFormatosResponsables(rc.idDependencia);
			event.setView("formatosTrimestrales/asignacionResponsables/asignacionResponsables/tablaResponsables").noLayout();
		</cfscript>
	</cffunction>
	
</cfcomponent>
