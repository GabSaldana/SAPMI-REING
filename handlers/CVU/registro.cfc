<cfcomponent>
	<cfproperty name="populator" inject="wirebox:populator">
	<cfproperty name="wirebox" 	inject="wirebox">
	<cfproperty name="CN"		inject="CVU.CN_CVU">	
	
	<cffunction name="index" hint="">
		<cfargument name="event" type="any">
		<cfscript>			
		</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="investigadorSinNumEmpleado" hint="">
		<cfargument name="event" type="any">
		<cfscript>
			prc.paises = CN.getCatalogoPaises();
			prc.nacionalidades = CN.getCatalogoNacionalidad();
			prc.clasificacion = CN.getClasificacionByFecha();
			event.setView("/CVU/registro/investigadorSinNumEmpleado").noLayout();
		</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="investigadorNumEmpleado" hint="">
		<cfargument name="event" type="any">
		<cfscript>			
			event.setView("/CVU/registro/investigadorNumEmpleado").noLayout();
		</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getUrByFechaClasif" hint="Obtiene el catalogo de dependencias con respecto a una clasificacion">		
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var res = CN.getUrByFechaClasif(rc.clasificacion);
			event.renderData(type="JSON", data=res);
		</cfscript>
  </cffunction>

  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="obtenerDireccion" hint="Obtiene la direccion usando el codigo postal">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			resultado = CN.obtenerDireccion(rc.codigoPostal);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="guardarInvestigadorNumEmpleado" hint="Guarda un investigador con numero de empleado">  	
		<cfargument name="event" type="any">
		<cfscript>			
			var rc = Event.getCollection();
			resultado = CN.guardarInvestigadorNumEmpleado(rc.numEmpleado,rc.curpEmpleado,rc.tipoPlaza,rc.correoEmpleado);
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="guardarInvestigadorSinNumEmpleado" hint="Guarda un investigador SIN numero de empleado">
		<cfargument name="event" type="any">
		<cfscript>			
			var rc = Event.getCollection();
			resultado = CN.guardarInvestigadorSinNumEmpleado(rc.rfc,rc.homoclave,rc.curp,rc.nombre,rc.apPat,rc.apMat,rc.dependencia,rc.calle,rc.pais,rc.nacionalidad,rc.entidad,rc.municipio,rc.cp,rc.colonia,rc.noExt,rc.genero,rc.fechaNacimiento,rc.correo);			
			event.renderData(type = "json", data = resultado);
		</cfscript>
	</cffunction>	

</cfcomponent>
