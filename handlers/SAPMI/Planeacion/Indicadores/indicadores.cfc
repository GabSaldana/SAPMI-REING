<cfcomponent>

	<cffunction name="index" hint="carga la vista general del modulo">
		<cfargument name="rc">
		<cfargument name="prc">
		<cfargument name="event" type="any">
		<cfset cn =  getModel("SAPMI.Planeacion.Indicadores.CN_Indicadores") >
		<cfscript>
			prc.Formatos = cn.getIndicadores(); 
			event.setView("SAPMI/Planeacion/Indicadores/principal");
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
		<cfset CN =  getModel("SAPMI.Planeacion.Indicadores.CN_Indicadores") >
		<cfscript>
			respuesta  = cn.cambiarEstadoFT(rc.pkTindicador, rc.accion); 
			event.renderData(type = "json", data = respuesta);
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

</cfcomponent>