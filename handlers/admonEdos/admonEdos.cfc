<cfcomponent>
	<cfproperty name="cnEdos" inject="admonEdos.CN_estados">


	<cffunction name="index" access="remote" returntype="void" output="false">
		<cfargument name="event" type="any">
		<cfscript>			
		</cfscript>
		<cfset event.setView("admonEdos/procedimientos")>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Obtiene la tabla con los procedimientos disponibles.
    --->  
	<cffunction name="obtenerProced" hint="Obtiene procedimientos">
		<cfargument name="event" type="any">
		<cfscript>
			prc.proced = cnEdos.obtenerProced();
			event.setView("admonEdos/tablaProced").noLayout();
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Obtiene la vista principal para visualizar las rutas.
    --->
	<cffunction name="setRutas" hint="Obtiene las rutas ligadas a un procedimiento">
		<cfargument name="Event" type="any">
		<cfscript>
			prc.valor = rc.pkProcedimiento;
			event.setView("admonEdos/Rutas/rutas");
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Obtiene la tabla con las rutas disponibles en algún procedimiento.
    --->  
	<cffunction name="getTablaEstados" hint="Obtiene la vista de las rutas">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.rutas = cnEdos.setRutas(rc.pkProcedimiento);
			event.setView("admonEdos/Rutas/tablaRutas").noLayout();
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Obtiene la vista principal para visualizar los estados relacionados a una ruta.
    --->  
	<cffunction name="setEstados" hint="Obtiene vista donde se mostraran los estados de las rutas">
		<cfargument name="Event" type="any">
		<cfscript>
			prc.pkRuta 	 = rc.pkRuta;
			prc.pkProced = rc.pkProced;
			prc.areas = cnEdos.getDependencias();
			event.setView("admonEdos/Estados/estadosRutas");
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Obtiene la tabla con los estados disponibles en alguna ruta.
    --->  
	<cffunction name="getTablaEstadosRutas" hint="Obtiene los estados pertenecientes a una ruta">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.rutas = cnEdos.getTablaEstadosRutas(rc.pkRuta, rc.pkProced);
			event.setView("admonEdos/Estados/tablaEdosRuta").noLayout();
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Funcion que agrega un nuevo estado relacionado a una ruta
    --->  
	<cffunction name="addEstado" hint="Guarda nuevo estado relacionado a un prodedimiento">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnEdos.addEstado(rc.ruta, rc.numero, rc.nombre, rc.descr);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Obtiene la vista principal para visualizar las relaciones con que cuenta una ruta.
    --->
	<cffunction name="setRelaciones" hint="Obtiene las relaciones rol-estados">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.ruta = rc.pkRuta;
			prc.proced = rc.pkProced;
			Request.rol = cnEdos.getRoles();
			Request.edo = cnEdos.getEstados(rc.pkRuta);
			Request.proced = cnEdos.getProced(rc.pkProced);
			Request.tipoOper = cnEdos.getTipoOper();
			event.setView("admonEdos/Relacion/relacion");
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Obtiene la tabla con las relaciones con que cuenta una ruta.
    --->
	<cffunction name="setTablaRelaciones" hint="Obtiene vista de las relaciones">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.rel = cnEdos.setRelaciones(rc.pkRuta);
			event.setView("admonEdos/Relacion/tablaRelacion").noLayout();
		</cfscript>
	</cffunction>


    <!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Obtiene las acciones que puede realizar algún rol.
    --->
	<cffunction name="getAcciones" hint="Obtiene las acciones del sistema">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnEdos.getAcciones(rc.pkRol);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Agrega una nueva relacion entre el rol-acción, y establece sus estados.
    --->
	<cffunction name="addEdoAccion" hint="Guarda la relacion entre los estados y el rol">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnEdos.addEdoAccion(rc.accionRol, rc.edoAct, rc.edoSig);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Obtiene las acciones que generan un cambio de estado, y lo representa en un grafo.
    --->
	<cffunction name="getDatoGrafo" hint="Obtiene la vista para mostrar la vista del grafo">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.rutas = cnEdos.setRelaciones(rc.pkRuta);
			event.setView("admonEdos/Rutas/grafo").noLayout();
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Función que cambia el estado de la relación accion-rol.
    --->
	<cffunction name="cambiarEdoRel" hint="Cambia el estado de las relaciones">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnEdos.cambiarEdoRel(rc.pkRel);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Obtiene las operaciones que se pueden realizar al ejecutar una acción.
    --->
	<cffunction name="setTablaAccOpe" hint="Obtiene tabla de operaciones">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.rel = cnEdos.setTablaAccOpe(rc.pkRelacion);
			event.setView("admonEdos/Relacion/tablaAccionOperacion").noLayout();
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Funcion que relaciona operaciones con alguna acción.
    --->
	<cffunction name="relacionaAccionOperacion" hint="Relaciona operaciones y acciones">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnEdos.relacionaAccionOperacion(rc.pkOperacion, rc.pkTipoOper, rc.pkRelacion);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!---
    * Fecha: Noviembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Función que cambia el estado de la relación acción-operación.
    --->
	<cffunction name="cambiarEdoOper" hint="Cambia estado de la relacion operacion accion">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnEdos.cambiarEdoOper(rc.pkOper);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
    * Fecha: Diciembre de 2016
    * @author Alejandro Tovar
	* Descripcion: Función que cambia el estado de un estado.
    --->
	<cffunction name="eliminaEstado" hint="Cambia estado de la relacion operacion accion">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnEdos.eliminaEstado(rc.pkEstado);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
    * Fecha: Octubre de 2016
    * @author SGS
    --->
	<cffunction name="setTablaOpe" hint="Obtiene las operaciones para la tabla de procedimientos">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.oper = cnEdos.setTablaOpe(rc.pkProcedimiento);
			event.setView("admonEdos/tablaOperaciones").noLayout();
		</cfscript>
	</cffunction>

	<!---
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
	<cffunction name="addOperacion" hint="Guarda la operacion">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnEdos.addOperacion(rc.oper, rc.desc, rc.proced);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
	<cffunction name="addRuta" hint="Guarda la ruta">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnEdos.addRuta(rc.ruta, rc.proced);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
	<cffunction name="cambiarEdoRuta" hint="Cambia el estado de las rutas">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cnEdos.cambiarEdoRuta(rc.pkRuta);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

</cfcomponent>