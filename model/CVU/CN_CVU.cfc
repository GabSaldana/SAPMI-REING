<cfcomponent>

	<cfproperty name="dao" 		 		 	inject="CVU/DAO_CVU">	
	<cfproperty name="populator" 		inject="wirebox:populator">
	<cfproperty name="wirebox" 	 		inject="wirebox">
	<cfproperty name="cache" 	 			inject="cachebox:default">
	<cfproperty name="cnMes" 	 			inject="utils.maquinaEstados.CN_maquinaEstados">
	<cfproperty name="cnCom"     		inject="adminCSII.comentarios.CN_comentarios">
	<cfproperty name="cnEmail" 	 		inject="utils.email.CN_service">
	<cfproperty name="cnUtils" 	 		inject="utils.CN_utilities">
	<cfproperty name="cnUsuarios" 	inject="adminCSII.usuarios.CN_usuarios">
	<cfproperty name="CNSOL"      	inject="EDI.solicitud.CN_solicitud">
	
	
	<cffunction name="init">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getCatalogoNacionalidad" hint="Obtiene el catalogo de nacionalidades">
		<cfscript>
			return dao.getCatalogoNacionalidad();
		</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getCatalogoPaises" hint="Obtiene el catalogo de paises">
		<cfscript>
			return dao.getCatalogoPaises();
		</cfscript>
	</cffunction>	

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getClasificacionByFecha" hint="Obtiene el catalogo de clasificaciones">
		<cfscript>
			return dao.getClasificacionByFecha(now());
		</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getUrByFechaClasif" hint="Obtiene el catalogo de dependencias con respecto a una clasificacion">		
		<cfargument name="nivel" type="string" required="yes">
		<cfscript>
			return dao.getUrByFechaClasif(now(),nivel);
		</cfscript>
  </cffunction>

  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="obtenerDireccion" hint="Obtiene la direccion usando el codigo postal">
      <cfargument name="codigoPostal" hint="Codigo postal">
      <cfscript>
          return DAO.obtenerDireccion(codigoPostal);
      </cfscript>
  </cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getPersona" hint="Obtiene el pk de una persona">
		<cfscript>
			return DAO.getPersona(Session.cbstorage.usuario.PK);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getPaises" hint="Obtiene todos los paises">
		<cfscript>
			return DAO.getPaises();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getPais" hint="Obtiene un pais con base a su pk">
		<cfargument name="pkPais" type="numeric"	required="yes" hint="pk del pais">
		<cfscript>
			return DAO.getPais(pkPais);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEscolaridad" hint="Obtiene la escolaridad con base en un pk">
	<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
			return DAO.getEscolaridad(pkPersona);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getEmpleos" hint="Obtiene los Empleos con base en un pk">
	<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
			return DAO.getEmpleos(pkPersona);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getBecas" hint="Obtiene las Becas con base en un pk">
	<cfargument name="pkPersona" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
			return DAO.getBecas(pkPersona);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getNiveles" hint="Obtiene todos los niveles educativos existentes">
		<cfscript>
			return DAO.getNiveles();
		</cfscript>
	</cffunction>
	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getNivelesBecas" hint="Obtiene todos los niveles de una beca">
	<cfargument name="pkBeca" type="numeric" required="yes" hint="pk de la persona">
		<cfscript>
			return DAO.getNivelesBecas(pkBeca);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getCatalogoBecas" hint="Obtiene todas las becas">
		<cfscript>
			return DAO.getCatalogoBecas();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addEscolaridad" hint="agrega escolaridad a una persona">
		<cfargument name="pkPersona"			type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="inNivel"				type="numeric"	required="yes" hint="pk del nivel educatuvo">
		<cfargument name="inInstitucion"		type="string"	required="yes" hint="escuela">
		<cfargument name="inPais"				type="numeric"	required="yes" hint="pk del pais">
		<cfargument name="inCampoConocimiento"	type="string"	required="yes" hint="campo de conocimiento">
		<cfargument name="inCheckPNPC"			type="numeric"	required="yes" hint="pertenece a PNPC">
		<cfargument name="inInicio"				type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"				type="date"		required="yes" hint="fecha de fin">
		<cfargument name="inObtencion"			type="date"		required="yes" hint="fecha de obtencion">
		<cfargument name="inCedula"				type="numeric"	required="yes" hint="cedula obtenida">
		<cfscript>
			return DAO.addEscolaridad(pkPersona, inNivel, inInstitucion, inPais, inCampoConocimiento, inCheckPNPC, inInicio, inFin, inObtencion, inCedula);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addValidarEscolaridad" hint="agrega SNI a una persona">
		<cfargument name="pkEscolaridad"		type="numeric"	required="yes" hint="pk del registro">		
		<cfscript>			
			var pkProceso = CNSOL.getProcesosEDI().getPKPROCESO();
			var pkPersona = Session.cbstorage.persona.pk;			
			return DAO.addValidarEscolaridad(pkEscolaridad, pkPersona, pkProceso);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addBecas" hint="agrega Becas a una persona">
		<cfargument name="pkPersona"		type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="inTipoBeca"		type="numeric"	required="yes" hint="pk tipo beca">
		<cfargument name="inNivelBeca"		type="numeric"	required="yes" hint="pk nivel beca">
		<cfargument name="inCheckReceso"	type="numeric"	required="yes" hint="esta en receso">
		<cfargument name="inInicio"			type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"			type="date"		required="yes" hint="fecha de fin">
		<cfscript>
			return DAO.addBecas(pkPersona, inTipoBeca, inNivelBeca, inCheckReceso, inInicio, inFin);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addValidarBecas" hint="agrega SNI a una persona">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de la persona">
		<cfscript>
			return DAO.addValidarBecas(pkPersona);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addSNI" hint="agrega SNI a una persona">
		<cfargument name="pkPersona"			type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="inNivel"				type="numeric"	required="yes" hint="pk del nivel educatuvo">
		<cfargument name="inInicio"				type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"				type="date"		required="yes" hint="fecha de fin">
		<cfargument name="inAreaSNI"			type="numeric"	required="yes" hint="pk del area">
		<cfscript>
			return DAO.addSNI(pkPersona, inNivel, inInicio, inFin, inAreaSNI);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addValidarSNI" hint="agrega SNI a una persona">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de la persona">
		<cfscript>
			return DAO.addValidarSNI(pkPersona);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="addEmpleos" hint="agrega Empleos a una persona">
		<cfargument name="pkPersona"			type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="inPuesto"				type="string"	required="yes" hint="pk lugar">
		<cfargument name="inLugar"				type="string"	required="yes" hint="pk lugar">
		<cfargument name="inInicio"				type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"				type="date"		required="yes" hint="fecha de fin">
		<cfscript>
			return DAO.addEmpleos(pkPersona, inPuesto, inLugar, inInicio, inFin);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarEscolaridad" hint="eliminar escolaridad a una persona">
		<cfargument name="pkEscolaridad"	type="numeric"	required="yes" hint="pk de la escolaridad">
		<cfscript>
			return DAO.eliminarEscolaridad(pkEscolaridad);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Octubre 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarSNI" access="remote" hint="Actualiza los valores de la red de investigadores">
		<cfargument name="pkSNI"	type="numeric"	required="yes" hint="pk del SNI">
		<cfscript>
			return DAO.eliminarSNI(pkSNI);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Octubre 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarEmpleo" access="remote" hint="Actualiza los valores de la red de investigadores">
		<cfargument name="pkEmpleo"	type="numeric"	required="yes" hint="pk del Empleo">
		<cfscript>
			return DAO.eliminarEmpleo(pkEmpleo);
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Octubre 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="eliminarBeca" access="remote" hint="Actualiza los valores de la red de investigadores">
		<cfargument name="pkBeca"	type="numeric"	required="yes" hint="pk del Beca">
		<cfscript>
			return DAO.eliminarBeca(pkBeca);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarEscolaridad" hint="consulta una escolaridad con base a un pk de Escolaridad">
		<cfargument name="pkEscolaridad"	type="numeric"	required="yes" hint="pk de la escolaridad">
		<cfscript>
			return DAO.consultarEscolaridad(pkEscolaridad);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarSNI" hint="consulta SNI con base a un pk de Escolaridad">
		<cfargument name="pkSNI"	type="numeric"	required="yes" hint="pk del registro de SNI">
		<cfscript>
			return DAO.consultarSNI(pkSNI);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarEmpleo" hint="consulta un empleo con base a un pk de Escolaridad">
		<cfargument name="pkEmpleo"	type="numeric"	required="yes" hint="pk del registro de Empleo">
		<cfscript>
			return DAO.consultarEmpleo(pkEmpleo);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="consultarBeca" hint="consulta un Beca con base a un pk de Escolaridad">
		<cfargument name="pkBeca"	type="numeric"	required="yes" hint="pk del registro de Beca">
		<cfscript>
			return DAO.consultarBeca(pkBeca);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="updateEscolaridad" hint="actualiza escolaridad a una persona">
		<cfargument name="pkPersona"			type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="inNivel"				type="numeric"	required="yes" hint="pk del nivel educatuvo">
		<cfargument name="inInstitucion"		type="string"	required="yes" hint="escuela">
		<cfargument name="inPais"				type="numeric"	required="yes" hint="pk del pais">
		<cfargument name="inCampoConocimiento"	type="string"	required="yes" hint="campo de conocimiento">
		<cfargument name="inCheckPNPC"			type="numeric"	required="yes" hint="pertenece a PNPC">
		<cfargument name="inInicio"				type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"				type="date"		required="yes" hint="fecha de fin">
		<cfargument name="inObtencion"			type="date"		required="yes" hint="fecha de obtencion">
		<cfargument name="inCedula"				type="numeric"	required="yes" hint="cedula obtenida">
		<cfargument name="pkEscolaridad"		type="numeric"	required="yes" hint="pk de la escolaridad">
		<cfscript>
			return DAO.updateEscolaridad(pkPersona, inNivel, inInstitucion, inPais, inCampoConocimiento, inCheckPNPC, inInicio, inFin, inObtencion, inCedula, pkEscolaridad);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="updateSNI" hint="actualiza SNI a una persona">
		<cfargument name="inNivel"		type="numeric"	required="yes" hint="pk del nivel educatuvo">
		<cfargument name="inInicio"		type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"		type="date"		required="yes" hint="fecha de fin">
		<cfargument name="pkSNI"		type="numeric"	required="yes" hint="pk de la SNI">
		<cfargument name="inAreaSNI"	type="numeric"	required="yes" hint="pk del area">
		<cfscript>
			return DAO.updateSNI(inNivel, inInicio, inFin, pkSNI, inAreaSNI);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="updateEmpleo" hint="actualiza Empleo a una persona">
		<cfargument name="inLugar"		type="string"	required="yes" hint="lugar donde fue empleado">
		<cfargument name="inPuesto"		type="string"	required="yes" hint="puesto del empleado">
		<cfargument name="inInicio"		type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"		type="date"		required="yes" hint="fecha de fin">
		<cfargument name="pkEmpleo"		type="numeric"	required="yes" hint="pk de la Empleo">
		<cfscript>
			return DAO.updateEmpleo(inLugar, inPuesto, inInicio, inFin, pkEmpleo);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="updateBeca" hint="actualiza Beca a una persona">
		<cfargument name="inTipoBeca"	type="numeric"	required="yes" hint="lugar donde fue empleado">
		<cfargument name="inNivelBeca"	type="numeric"	required="yes" hint="puesto del empleado">
		<cfargument name="receso"		type="numeric"	required="yes" hint="Esta en receso">
		<cfargument name="inInicio"		type="date"		required="yes" hint="fecha de inicio">
		<cfargument name="inFin"		type="date"		required="yes" hint="fecha de fin">
		<cfargument name="pkBeca"		type="numeric"	required="yes" hint="pk de la Beca">
		<cfscript>
			return DAO.updateBeca(inTipoBeca, inNivelBeca, receso, inInicio, inFin, pkBeca);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getHistorialSNI" hint="obtiene el historial de SNI">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de la persona">
		<cfscript>
			return DAO.getHistorialSNI(pkPersona);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getNivelSNI" hint="obtiene los niveles de SNI">
		<cfscript>
			return DAO.getNivelSNI();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getRedesInv" hint="obtiene las redes de investigación">
		<cfscript>
			return DAO.getRedesInv();
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getRedesCheck" hint="obtiene las redes de investigación">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de la persona">
		<cfscript>
			return DAO.getRedesCheck(pkPersona);
		</cfscript>
	</cffunction>

	<!--- 
	*Fecha:	Octubre de 2017
	*Autor:	Roberto Cadena
	--->
	<cffunction name="getAreaSNI" hint="obtiene las areas de SNI">
		<cfscript>
			return DAO.getAreaSNI();
		</cfscript>
	</cffunction>

	<!---
	* Fecha:	Octubre 2017
	* Autor:	Roberto Cadena
	--->
	<cffunction name="updateRed" access="remote" hint="Actualiza los valores de la red de investigadores">
		<cfargument name="pkPersona"	type="numeric"	required="yes" hint="pk de la persona">
		<cfargument name="pkRed"		type="numeric"	required="yes" hint="pk de la red de investigacion">
		<cfargument name="contenido"	type="numeric"	required="yes" hint="contenido de la red">
		<cfscript>
			return DAO.updateRed(pkPersona, pkRed, contenido);
		</cfscript>
	</cffunction>

  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="guardarInvestigadorNumEmpleado" hint="Guarda un investigador CON numero de empleado">
      <cfargument name="numEmpleado" 		type="string" required="true" hint="Numero de Empleado">
	  	<cfargument name="curpEmpleado" 	type="string" required="true" hint="CURP del Empleado">
	  	<cfargument name="tipoPlaza" 			type="string" required="true" hint="Categoria de la Plaza">
	  	<cfargument name="correoEmpleado" type="string" required="true" hint="Correo del empleado">
      <cfscript>
      		var respuesta = {}; // Crea la estructura de respuesta
      		respuesta.pkPersona = DAO.registrar_investigador(numEmpleado,curpEmpleado,tipoPlaza,correoEmpleado); // Inserta una nueva persona con la validacion de SIGA
      		var datosPersona = 0;
      		if(respuesta.pkPersona > 0){
      			datosPersona = QueryGetRow(DAO.getInformacionPersona(respuesta.pkPersona),1);
      			var user = Left(datosPersona.TPS_PERSONA_NOMBRE,1)&datosPersona.TPS_PERSONA_PATERNO&Left(datosPersona.TPS_PERSONA_MATERNO,1);
      			var pass = cnUsuarios.generarPsw();
      			respuesta.usuario = cnUsuarios.guardarUsuario(datosPersona.TPS_FK_UR, '62', datosPersona.TPS_FK_GENERO, '6', datosPersona.TPS_PERSONA_NOMBRE, datosPersona.TPS_PERSONA_PATERNO, datosPersona.TPS_PERSONA_MATERNO, user, pass, datosPersona.TPS_CORREO_IPN, '000000', '0000');
      			DAO.setUsuarioPersona(respuesta.pkPersona, respuesta.usuario);
      			cnUsuarios.recuperarPwd(datosPersona.TPS_CORREO_IPN);
      		}else{      			
						datosPersona = 0;
	      	}     
	      	respuesta.datosPersona = datosPersona;

          return respuesta;
      </cfscript>
  </cffunction>
  
  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="guardarInvestigadorSinNumEmpleado" hint="Guarda un investigador SIN numero de empleado">
  	<cfargument name="rfc" 							type="string" required="true" hint="rfc del empleado">
  	<cfargument name="homoclave" 				type="string" required="true" hint="homoclave del empleado">
  	<cfargument name="curp" 						type="string" required="true" hint="curp del empleado">
  	<cfargument name="nombre" 					type="string" required="true" hint="nombre del empleado">
  	<cfargument name="apPat" 						type="string" required="true" hint="apPat del empleado">
  	<cfargument name="apMat" 						type="string" required="true" hint="apMat del empleado">
  	<cfargument name="dependencia"			type="string" required="true" hint="dependencia del empleado">
  	<cfargument name="calle"						type="string" required="true" hint="dependencia del empleado">  	
  	<cfargument name="pais" 						type="string" required="true" hint="pais del empleado">
  	<cfargument name="nacionalidad" 		type="string" required="true" hint="nacionalidad del empleado">
  	<cfargument name="entidad" 					type="string" required="true" hint="entidad del empleado">
  	<cfargument name="municipio"				type="string" required="true" hint="municipio del empleado">
  	<cfargument name="cp"								type="string" required="true" hint="cp del empleado">  	  	  
  	<cfargument name="colonia"					type="string" required="true" hint="colonia del empleado">
  	<cfargument name="noExt"						type="string" required="true" hint="noExt del empleado">
  	<cfargument name="genero" 					type="string" required="true" hint="genero del empleado">
  	<cfargument name="fechaNacimiento" 	type="string" required="true" hint="fechaNacimiento del empleado">
  	<cfargument name="correo" 					type="string" required="true" hint="correo del empleado">
  	<cfscript>
  		var respuesta = {};
			respuesta.pkPersona = DAO.registrar_investigador_sin_ne(rfc,homoclave,curp,nombre,apPat,apMat,dependencia,pais,nacionalidad,entidad,genero,fechaNacimiento,correo);  		
			var datosPersona = 0;
			if(respuesta.pkPersona > 0){
				datosPersona = QueryGetRow(DAO.getInformacionPersona(respuesta.pkPersona),1);
				var user = Left(datosPersona.TPS_PERSONA_NOMBRE,1)&datosPersona.TPS_PERSONA_PATERNO&Left(datosPersona.TPS_PERSONA_MATERNO,1);
				var pass = cnUsuarios.generarPsw();
				respuesta.usuario = cnUsuarios.guardarUsuario(datosPersona.TPS_FK_UR, '62', datosPersona.TPS_FK_GENERO, '6', datosPersona.TPS_PERSONA_NOMBRE, datosPersona.TPS_PERSONA_PATERNO, datosPersona.TPS_PERSONA_MATERNO, user, pass, datosPersona.TPS_CORREO_IPN, '000000', '0000');
				DAO.setUsuarioPersona(respuesta.pkPersona, respuesta.usuario);
				DAO.setDomocilioPersona(respuesta.pkPersona,calle,pais,entidad,municipio,cp,colonia,noExt,'');
				cnUsuarios.recuperarPwd(datosPersona.TPS_CORREO_IPN);
			}else{      			
				datosPersona = 0;
			}     
			respuesta.datosPersona = datosPersona;
			return respuesta;  		
  	</cfscript>
  </cffunction>

  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getInformacionPersonaSiga" hint="Obtiene la informacion de una persona con su pk">  	
  	<cfargument name="pkPersona" hint="pk de la persona (CVU)">
  	<cfscript>  		
  		var personaCVU       = dao.getInformacionPersona(pkPersona.PKPERSONA[1]);
  		var pkPersonaSIGA    = personaCVU.TPS_FK_PERSONA_SIGA[1];
  		var datosPersonaSIGA = dao.getInformacionPersonaSiga(pkPersonaSIGA);
  		var personaSIGA      = populator.populateFromQuery(wirebox.getInstance("CVU/B_PersonaSIGA"),datosPersonaSIGA,1);
  		return personaSIGA;
  	</cfscript>  
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getDomicilioPersona" hint="Obtiene la informacion del domicilio de una persona con su pk">
		<cfargument name="pkPersona" hint="pk de la persona (CVU)">
		<cfscript>			
			var datosDomicilio = DAO.getDomicilioPersona(pkPersona.PKPERSONA[1]);			
			var domicilio      = populator.populateFromQuery(wirebox.getInstance("CVU/B_Domicilio"),datosDomicilio,1);
			var datosDomicilioUR = DAO.obtenerDireccion(domicilio.getCP());
			domicilio.setDOM_UR(datosDomicilioUR);			
			return domicilio;			
			// return DAO.obtenerDireccion(CP);
		</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getCPbyColonia" hint="Obtiene el cp usando el pk de la colonia">
    <cfargument name="pkColonia" hint="pk de la Colonia">
  	<cfscript>
  		return QueryGetRow(DAO.getCPbyColonia(pkColonia),1);
  	</cfscript>
</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getObjetoPersona" hint="Obtiene la informacion de una persona (CVU)">
  	<cfargument name="pkPersona" hint="Pk de la persona">
  	<cfscript>
  		var datosPersona  = DAO.getObjetoPersona(pkPersona.PKPERSONA[1]);
  		var objetoPersona = populator.populateFromQuery(wirebox.getInstance("CVU/B_Persona"),datosPersona,1);
  		return objetoPersona;
  	</cfscript>
  </cffunction>

  <!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getListaTelefonos" hint="Obtiene la lista de telefonos de una persona">
  	<cfargument name="pkPersona" hint="Pk de la persona">  
  	<cfscript>
  		return DAO.getListaTelefonos(pkPersona);
  	</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="guardarTelefonoPersona" hint="Guarda un telefono de una persona">
		<cfargument name="pkPersona" 	type="string" required="true" hint="pk de la persona">
		<cfargument name="lada"      	type="string" required="true" hint="lada"> 	
		<cfargument name="telefono"  	type="string" required="true" hint="telefono"> 	
		<cfargument name="extension" 	type="string" required="true" hint="extension"> 
		<cfscript>
			return DAO.guardarTelefonoPersona(pkPersona,lada,telefono,extension);
		</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="eliminarTelefono" hint="Elimina un telefono por su pk">
		<cfargument name="pkTelefono" type="string" required="true" hint="pk del telefono">
		<cfscript>
			return DAO.eliminarTelefono(pkTelefono);
		</cfscript>
</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="editarCorreosLocalizacion" hint="Modifica los correos de localizacion de una persona">
		<cfargument name="pkPersonaSIGA"  type="string" required="true" hint="pk de la persona">
		<cfargument name="correoIPN"  		type="string" required="true" hint="correo institucional">					
		<cfargument name="correoAlt"  		type="string" required="true" hint="correo alternativo">					
		<cfscript>
			return DAO.editarCorreosLocalizacion(pkPersonaSIGA,correoIPN,correoAlt);
		</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Octubre de 2017
  * @author: Daniel Memije
  --->
  <cffunction name="getDatosLocalizacion" hint="Obtiene la informacion de localizacion (SIGA) de una persona con su pk">
  	<cfargument name="pkPersonaSIGA" hint="Pk de la persona (SIGA)">
  	<cfscript>  		
  		var res = {};
  		var datosLocalizacion = DAO.getDatosLocalizacion(pkPersonaSIGA);  	  		
  		var locObj = populator.populateFromQuery(wirebox.getInstance("CVU/B_Localizacion"),datosLocalizacion,1);
  		if(len(locObj.getPK_COLONIA()) AND locObj.getPK_COLONIA() > 0){  		
				locObj.setCP(this.getCPbyColonia(locObj.getPK_COLONIA()).CP);
				locObj.setDATOS_COLONIA(DAO.obtenerDireccion(locObj.getCP()));  		  		
  		}
  		return locObj;  		
  	</cfscript>  	
	</cffunction>


	<!---
	* Fecha creacion: Diciembre de 2017
	* @author: Alejandro Rosales
	--->
	<cffunction name="getEstadoInvestigador" hint="Obtiene el estado de un investigador actual">
		<cfargument name="curp" hint="curp de la persona a consultar">
		<cfscript>  		
			return dao.getEstadoInvestigador(curp);
		</cfscript>  	
	</cffunction>

	<!---
	  * Fecha creacion: Enero de 2018
	  * @author: Daniel Memije
	  --->
	<cffunction name="getTrayectoria" hint="Obtiene la informacion de la trayectoria de un investigador">
		<cfargument name="pkPersonaSiga" hint="Pk de la persona">  
		<cfscript>
			return dao.getPlazasActivas(pkPersonaSiga);
		</cfscript>
	</cffunction>

	<!---
  * Fecha creacion: Enero de 2018
  * @author: Daniel Memije
  --->
  <cffunction name="getArbolDependencia" hint="Obtiene el arbol jerarquico de un departamento/division/direccion a traves de la dependencia.">
  	<cfargument name="departamento" hint="departamento"> 
  	<cfscript>			
  		var arbol = [];
  		var niveles = 1;
  		var finish = false;  	
  		var ramaFinal = departamento;
  		while(!finish){
  			nivel = DAO.getArbolDependencia(departamento,ramaFinal);  		
  			renglon = queryGetRow(nivel, 1);  			
  			arbol[niveles] = renglon;
  			niveles++;
  			if(renglon.ur eq renglon.dependencia or niveles eq 5){
					renglon.CATEGORIA = 'Dependencia:';
					finish = true;
				}
  		}
  		return arbol;
  	</cfscript>
	</cffunction>	


</cfcomponent>
