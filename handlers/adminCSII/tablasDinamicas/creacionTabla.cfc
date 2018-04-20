<!---
* =========================================================================
* IPN - CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo:Creación de Tablas
* Fecha : 15 de Marzo de 2017
* Autores: Alejandro Rosales 
		   Jonathan Martinez 
* Descripcion: Manejador para la creación de Tablas.
* =========================================================================
--->

 <cfcomponent>
	 <cfproperty name="cnTabla" inject="adminCSII.tablasDinamicas.CN_Tabla">
	 <!---
		 * Fecha : 20 de Marzo de 2017
		 * Autor : Jonathan Martinez
	 --->	
	 <cffunction name="getTabla"  hint="Obtiene la información necesaria para la creacion de la Tabla">
		 <cfargument name="event" type="any">
		 <cfscript>
			 if(isDefined("rc.filtros")) 	
				 filtro = cnTabla.getFiltroConsulta(session.cbstorage.conjunto.ID, rc.filtros, session.cbstorage.conjunto.NOMBRE);
			 else
			     filtro = "";
			 var prc.encabezados = cnTabla.obtenerDatos(session.cbstorage.conjunto.ID,session.cbstorage.conjunto.NOMBRE,rc.columnas,filtro,1);
			 var prc.filas = cnTabla.obtenerDatos(session.cbstorage.conjunto.ID,session.cbstorage.conjunto.NOMBRE,rc.filas,filtro,0);
			 var prc.lenColumna = cnTabla.getColumnaLen(rc.columnas);
			 var vals = deserializeJSON(rc.valores);          	
			 if(arrayLen(vals) > 0)
				 var prc.valores = cnTabla.getConjuntoTabla(session.cbstorage.conjunto.ID,prc.encabezados,prc.lenColumna,prc.filas,session.cbstorage.conjunto.NOMBRE,vals);	
			 event.setView("adminCSII/tablasDinamicas/tablaContenidos").noLayout();

		 </cfscript> 
		 <!--- <cfdump var="#prc.valores#" abort="true"> ---> 
	 </cffunction>
	 <!---
		 * Fecha : 23 de Marzo de 2017
		 * Autor : Jonathan Martinez
	 --->	
	 <cffunction name="guardarTabla"  hint="Guarda la tabla creada">
		 <cfargument name="event" type="any">
		 <cfscript>
			 prc.guardar = cnTabla.guardarTabla(rc.nombre,rc.descripcion,session.cbstorage.conjunto.ID,session.cbstorage.usuario.PK,rc.columnas,rc.filas,rc.valores,rc.filtros);
		 </cfscript>
		 <cfreturn prc.guardar>
	 </cffunction>
	 <!---
		 * Fecha : 24 de Marzo de 2017
		 * Autor : Jonathan Martinez
	 --->	
	 <cffunction name="actualizarTabla"  hint="Actualiza una tabla">
		 <cfargument name="event" type="any">
		 <cfscript>
			 prc.actualizar = cnTabla.actualizarTabla(rc.idTab,rc.nombre,rc.descripcion,rc.columnas,rc.filas,rc.valores,rc.filtros);
		 </cfscript>
		 <cfreturn prc.actualizar>
	 </cffunction>
</cfcomponent>