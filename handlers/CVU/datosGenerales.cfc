<cfcomponent>	
	<cfproperty name="CN" 	 inject="CVU.CN_CVU">
	
	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="index" hint="Muestra la visata de los datos Generales">
		<cfargument name="event" type="any">
		<cfscript>
			prc.pkPersona = CN.getPersona();
			prc.personaSiga = CN.getInformacionPersonaSiga(prc.pkPersona);
			
			event.setView("CVU/datosGenerales/datosGenerales");
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="vistaEscolaridad" hint="muestra la vista de Escolaridad">
		<cfargument name="event" type="any">
		<cfscript>
			event.setView("CVU/datosGenerales/escolaridad/datosEscolaridad").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="vistaSNI" hint="Muestra la vista de los datos de SNI">
		<cfargument name="event" type="any">
		<cfscript>
			event.setView("CVU/datosGenerales/SNI/datosSNI").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="vistaEmpleos" hint="Muestra la vista de los datos de empleos">
		<cfargument name="event" type="any">
		<cfscript>
			event.setView("CVU/datosGenerales/empleos/datosEmpleos").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="vistaBecas" hint="Muestra la vista de los datos de Becas">
		<cfargument name="event" type="any">
		<cfscript>
			event.setView("CVU/datosGenerales/becas/datosBecas").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getSNI" hint="muestra la tabla de SNI de una respectiva persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.historial = CN.getHistorialSNI(rc.pkPersona);
			prc.nivelSNI = CN.getNivelSNI();
			prc.areaSNI = CN.getAreaSNI();
			prc.pkPersona = rc.pkPersona;
			event.setView("CVU/datosGenerales/SNI/tablaSNI").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getTipoInvestigador" hint="muestra la tabla de SNI de una respectiva persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.redes = CN.getRedesInv();
			prc.redesCheck = CN.getRedesCheck(rc.pkPersona);
			prc.pkPersona = rc.pkPersona;
			event.setView("CVU/datosGenerales/SNI/tipoInvestigador").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEscolaridad" hint="muestra la tabla de escolaridad de una respectiva persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.escolaridad = CN.getEscolaridad(rc.pkPersona);
			prc.nivel = CN.getNiveles();
			prc.pais = CN.getPaises();
			prc.pkPersona = rc.pkPersona;
			event.setView("CVU/datosGenerales/escolaridad/tablaEscolaridad").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEmpleos" hint="muestra la tabla de empleos de una respectiva persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.empleos = CN.getEmpleos(rc.pkPersona);
			prc.pkPersona = rc.pkPersona;
			event.setView("CVU/datosGenerales/empleos/tablaEmpleos").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getBecas" hint="muestra la tabla de Becas de una respectiva persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			prc.Becas = CN.getBecas(rc.pkPersona);
			prc.pkPersona = rc.pkPersona;
			prc.tipoBeca = CN.getCatalogoBecas();
			event.setView("CVU/datosGenerales/becas/tablaBecas").noLayout();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getNivelesBecas" hint="muestra la tabla de Becas de una respectiva persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			resultado.niveles = CN.getNivelesBecas(rc.pkBeca);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addEscolaridad" hint="agrega escolaridad a una persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.addEscolaridad(rc.pkPersona, rc.inNivel, rc.inInstitucion, rc.inPais, rc.inCampoConocimiento, rc.inCheckPNPC, rc.inInicio, rc.inFin, rc.inObtencion, rc.inCedula);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addValidarEscolaridad" hint="agrega una beca a una persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.addValidarEscolaridad(rc.pkEscolaridad);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addSNI" hint="agrega SNI a una persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.addSNI(rc.pkPersona, rc.inNivelSNI,rc.inInicioSNI, rc.inFinSNI, rc.inAreaSNI);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addValidarSNI" hint="agrega una beca a una persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.addValidarSNI(rc.pkPersona);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addEmpleos" hint="agrega un empleo a una persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.addEmpleos(rc.pkPersona, rc.inPuestoEmpleo, rc.inLugarEmpleo, rc.inInicioEmpleo, rc.inFinEmpleo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>


	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addBecas" hint="agrega una beca a una persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.addBecas(rc.pkPersona, rc.inTipoBeca, rc.inNivelBeca, rc.inCheckReceso, rc.inInicio, rc.inFin);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addValidarBecas" hint="agrega una beca a una persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.addValidarBecas(rc.pkPersona);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarEscolaridad" hint="eliminar escolaridad a una persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.eliminarEscolaridad(rc.pkEscolaridad);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Octubre 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarSNI" hint="Elimina registro de SNI">
		<cfscript>
			var rc = Event.getCollection();
			resultado = CN.eliminarSNI(rc.pkSNI);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Octubre 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarEmpleo" hint="Elimina registro de Empleo">
		<cfscript>
			var rc = Event.getCollection();
			resultado = CN.eliminarEmpleo(rc.pkEmpleo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Octubre 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarBeca" hint="Elimina registro de Empleo">
		<cfscript>
			var rc = Event.getCollection();
			resultado = CN.eliminarBeca(rc.pkBeca);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarEscolaridad" hint="consulta una escolaridad con base a un pk de Escolaridad">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado.escolaridad = CN.consultarEscolaridad(rc.pkEscolaridad);
			var resultado.nivel = CN.getNiveles();
			var resultado.pais = CN.getPaises();
			var resultado.paisSelect = CN.getPais(resultado.escolaridad.PAIS[1]);
			var resultado.pkEscolaridad = rc.pkEscolaridad;
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarSNI" hint="consulta una escolaridad con base a un pk de Escolaridad">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado.SNI = CN.consultarSNI(rc.pkSNI);
			var resultado.nivelSNI = CN.getNivelSNI();
			var resultado.pkSNI = rc.pkSNI;
			var resultado.areaSNI = CN.getAreaSNI();
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarEmpleo" hint="consulta un empleo con base a un pk de Empleo">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado.Empleo = CN.consultarEmpleo(rc.pkEmpleo);
			var resultado.pkEmpleo = rc.pkEmpleo;
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarBeca" hint="consulta un Beca con base a un pk de Beca">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado.Beca = CN.consultarBeca(rc.pkBeca);
			var resultado.catBecas = CN.getCatalogoBecas();
			var resultado.nivel = CN.getNivelesBecas(pkBeca);
			var resultado.pkBeca = rc.pkBeca;
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="updateEscolaridad" hint="actualizar escolaridad a una persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.updateEscolaridad(rc.pkPersona, rc.inNivel, rc.inInstitucion, rc.inPais, rc.inCampoConocimiento, rc.inCheckPNPC, rc.inInicio, rc.inFin, rc.inObtencion, rc.inCedula, rc.pkEscolaridad);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="updateSNI" hint="actualizar SNI a una persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.updateSNI(rc.inNivel, rc.inInicio, rc.inFin, rc.pkSNI, rc.inAreaSNI);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="updateEmpleo" hint="actualizar Empleo a una persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.updateEmpleo(rc.inLugar, rc.inPuesto, rc.inInicio, rc.inFin, rc.pkEmpleo);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

		<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="updateBeca" hint="actualizar Beca a una persona">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = CN.updateBeca(rc.inTipoBeca, rc.inNivelBeca, rc.inCheckReceso, rc.inInicio, rc.inFin, rc.pkBeca);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Octubre 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="updateRed" hint="Actualiza los valores de la red de investigadores">
		<cfscript>
			var rc = Event.getCollection();
			resultado = CN.updateRed(rc.pkPersona, rc.pkRed, rc.contenido);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Octubre 2017
	* Autor:	Daniel Memije
	--->
	<cffunction name="vistaInformacionGeneral" hint="Muestra la vista de informacion general">
		<cfargument name="event" type="any">
		<cfscript>
			prc.pkPersona        = CN.getPersona();
			prc.personaSiga      = CN.getInformacionPersonaSiga(prc.pkPersona);
			prc.persona          = CN.getObjetoPersona(prc.pkPersona);
			prc.datosLoc         = CN.getDatosLocalizacion(prc.personaSiga.getPK_PERSONAL());			
			// prc.cp = CN.getCPbyColonia(prc.datosLoc.PK_COLONIA);		
			// prc.domicilioPersona = CN.getDomicilioPersona(prc.cp.cp);
			prc.paises           = CN.getCatalogoPaises();
			event.setView("CVU/datosGenerales/informacionGeneral/informacionGeneral").noLayout();
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Enero 2018
	* Autor:	Daniel Memije
	--->
	<cffunction name="vistaDatosLocalizacion" hint="Muestra la vista de datos de localizacion">
		<cfargument name="event" type="any">
		<cfscript>
			prc.pkPersona        = CN.getPersona();
			prc.personaSiga      = CN.getInformacionPersonaSiga(prc.pkPersona);
			prc.persona          = CN.getObjetoPersona(prc.pkPersona);
			prc.datosLoc         = CN.getDatosLocalizacion(prc.personaSiga.getPK_PERSONAL());			
			// prc.cp = CN.getCPbyColonia(prc.datosLoc.PK_COLONIA);		
			// prc.domicilioPersona = CN.getDomicilioPersona(prc.cp.cp);
			prc.paises           = CN.getCatalogoPaises();
			event.setView("CVU/datosGenerales/datosLocalizacion/datosLocalizacion").noLayout();
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Octubre 2017
	* Autor:	Daniel Memije
	--->
	<cffunction name="vistaListaTelefonos" hint="Muestra la vista de telefonos">
		<cfargument name="event" type="any">
		<cfscript>	
			prc.pkPersona = rc.pkPersona;
			prc.telefonos = CN.getListaTelefonos(rc.pkPersona);
			event.setView("CVU/datosGenerales/datosLocalizacion/listaTelefonos").noLayout();
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Enero 2018
	* Autor:	Daniel Memije
	--->
	<cffunction name="vistaTrayectoriaIpn" hint="Muestra la vista de trayectoria">
		<cfargument name="event" type="any">
		<cfscript>
			prc.pkPersona   = CN.getPersona();
			prc.personaSiga = CN.getInformacionPersonaSiga(prc.pkPersona);
			prc.trayectoria = CN.getTrayectoria(prc.personaSiga.getPK_PERSONAL());			
			event.setView("CVU/datosGenerales/trayectoriaIpn/trayectoriaIpn").noLayout();
		</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="guardarTelefonoPersona" hint="Guarda un telefono de una persona">
  	<cfscript>
			var rc = Event.getCollection();
			resultado = CN.guardarTelefonoPersona(rc.persona,rc.lada, rc.telefono, rc.extension);
			event.renderData(type="json", data=resultado);
		</cfscript>
  </cffunction>

  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="eliminarTelefono" hint="Elimina un telefono por su pk">
		<cfscript>
			var rc = Event.getCollection();
			resultado = CN.eliminarTelefono(rc.pkTelefono);
			event.renderData(type="json", data=resultado);
		</cfscript>
  </cffunction>

  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="editarCorreosLocalizacion" hint="Modifica los correos de localizacion de una persona">
		<cfscript>
			var rc = Event.getCollection();
			resultado = CN.editarCorreosLocalizacion(rc.pkPersonaSIGA,rc.correoIPN,rc.correoAlt);
			event.renderData(type="json", data=resultado);
		</cfscript>
  </cffunction>	

</cfcomponent>
