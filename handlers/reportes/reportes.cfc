<!---
* =========================================================================
* IPN - CSII
* Sistema: PIMP
* Modulo: funciones principales consulta de reportes
* Fecha : octubre de 2016
* Descripcion: handler 
* Autor: Alejandro Rosales 
* =========================================================================
--->

<cfcomponent>

	<cfproperty name="cn" inject="reportes/CN_reportes">
	 
	<!---
	 	 *Fecha :18 de septiembre de 2017
	 	 *@author Alejandro Rosales 
     --->
	<cffunction name="index" hint="Funcion principal">
	<cfargument name="Event" type="any">
		<cfscript>
			prc.reportes=cn.obtenerReportes();
			event.setView("/reportes/administradorReportes");
		</cfscript>
	</cffunction>

	<!---
	 	 *Fecha :18 de septiembre de 2017
	 	 *@author Alejandro Rosales 
     --->
	<cffunction name="cargarReportes" hint="Carga los reportes de los conjuntos de datos">
		 <cfscript>
			 prc.reportes=cn.obtenerReportes();
			 event.setView("reportes/administradorReportes");
		 </cfscript>
	 </cffunction>

	 <!---
		 * Fecha : 20 de Marzo de 2017
		 * Autor : Jonathan Martinez
	 --->	
	 <cffunction name="getReporte"  hint="Obtiene la información necesaria para la creacion de la Tabla">
		 <cfargument name="event" type="any">
		 <cfscript>
			 if(isDefined("rc.filtros")) 	
				 filtro = cn.getFiltroConsulta(session.cbstorage.conjunto.ID, rc.filtros, session.cbstorage.conjunto.NOMBRE);
			 else
			     filtro = "";
			 var prc.encabezados = cn.obtenerDatos(session.cbstorage.conjunto.ID,session.cbstorage.conjunto.NOMBRE,rc.columnas,filtro,1);
			 var prc.filas = cn.obtenerDatos(session.cbstorage.conjunto.ID,session.cbstorage.conjunto.NOMBRE,rc.filas,filtro,0);
			 var prc.lenColumna = cn.getColumnaLen(rc.columnas);
			 var vals = deserializeJSON(rc.valores);          	
			 if(arrayLen(vals) > 0)
				 var prc.valores = cn.getConjuntoTabla(session.cbstorage.conjunto.ID,prc.encabezados,prc.lenColumna,prc.filas,session.cbstorage.conjunto.NOMBRE,vals);	
			 event.setView("/reportes/tablaContenidos").noLayout();
		 </cfscript>  
	 </cffunction>
</cfcomponent>