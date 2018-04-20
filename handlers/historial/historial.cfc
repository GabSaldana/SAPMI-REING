<!---
* =========================================================================
* IPN - CSII
* Sistema: SERO
* Modulo: funciones principales del historial
* Fecha : Febrero de 2017
* Descripcion: handler 
* =========================================================================
--->

<cfcomponent>
	
	<!---
    * Fecha: Febrero 2017
    * @author Alejandro Tovar
	* Descripcion: Obtiene el historial de validacion.
	* -------------------------------
    * Descripcion de la modificacion: Ingresar un nuevo argumento en historialObjeto. Este argumento es el pk del procedimiento.
    * Fecha de la modificacion: 22/05/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
	* -------------------------------
    --->  
	<cffunction name="getHistorial" hint="Obtiene el historial de validacion">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var cnMes = getModel("utils.maquinaEstados.CN_maquinaEstados");
			prc.historial = cnMes.historialObjeto(rc.pkRegistro, rc.pkProcedimiento);
			prc.cambios = cnMes.historialObjetoVal(rc.pkRegistro, rc.pkProcedimiento);
			event.setView("utils/historial/tablaHistorial").noLayout();
		</cfscript>
	</cffunction>


</cfcomponent>