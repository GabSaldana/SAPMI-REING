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
			prc.Anios  = CN.obtenerAnios();
			event.setView("acumulados/acumulados");
		</cfscript>
    </cffunction>


	<cffunction name="obtenerFormatos" hint="Obtiene los formatos de un periodo">
		<cfargument name="event" type="any">
		<cfargument name="rc">	
		<cfset CN_Formatos = getModel("formatosTrimestrales.CN_FormatosTrimestrales")>
		<cfscript>
			prc.Formatos  = CN_Formatos.obtenerFormatos(rc.anio);
			event.setView("acumulados/tablaAcumulados").noLayout();
		</cfscript>
	</cffunction>


	<cffunction name="obtenerReporte" access="public" returntype="void" output="false" hint="Obtiene un reporte de un periodo">
		<cfargument name="event" type="any">
		<cfargument name="rc">
		<cfset CN_Formatos = getModel("formatosTrimestrales.CN_FormatosTrimestrales")>
		<cfscript>
			prc.Reporte = CN_Formatos.getInfoAcumulado(rc.formato, rc.anio);
			event.setView("acumulados/consulta").noLayout();
		</cfscript>
    </cffunction>

</cfcomponent> 