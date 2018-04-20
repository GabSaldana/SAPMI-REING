<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Fecha:       8 de mayo de 2017
* Descripcion: Handler para el modulo de Convenios/Nuevo
* ================================
---->
<cfcomponent >
	<cfproperty name="CN" inject="convenios.Nuevo.CN_Nuevo">
	
	<!---
	* Descripcion:    Carga informacion inicial
	* Fecha creacion: 23 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="index" access="remote" returntype="void" output="false" hint="Carga informacion inicial">
		<cfargument name="pkConvenio"   type="numeric" required="false" default="-1">
		<cfargument name="tipo"         type="numeric" required="false" default="-1">
		<cfargument name="event"        type="any"     required="false" default="-1">
		<cfscript>
			var CN_Consulta 		  = getModel("convenios.Consulta.CN_Consulta");
			var CN_Usuarios 		  = getModel("adminCSII.usuarios.CN_usuarios");
			prc.tiposConvenio = CN.obtenerTiposConvenio();
			prc.Documentos    = CN.obtenerDocumentosConvenio();			
			prc.Acronimos = CN_Usuarios.getAcron();
			prc.Carreras = CN_Consulta.getCarreras();
			prc.Dependencias = CN_Consulta.getDependencias();
			if (StructKeyExists(rc, "pkConvenio") and StructKeyExists(rc, "tipo")){
				prc.pkConvenio    = rc.pkConvenio;
				prc.tipo          = rc.tipo;
			} else {
				prc.pkConvenio    = -1;
				prc.tipo          = -1;
			}
			event.setView("convenios/Nuevo/V_Nuevo");
		</cfscript>
	</cffunction>

	<!--- 
	* Descripcion:    Obtiene un formulario dependiendo del tipo de convenio
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="obtenerTipoConvenioFormulario" hint="Obtiene un formulario dependiendo del tipo de convenio">
		<cfargument name="event" type="any">
		<cfscript>
			var prc.Instituciones = CN.obtenerInstituciones();
			var prc.Modalidades   = CN.obtenerModalidades();
			var rc = event.getCollection();
			switch(rc.pkTipoConvenio) {
				case 2:
					event.setView("convenios/Nuevo/V_NuevoFA").noLayout();
				break;
				case 1:
					event.setView("convenios/Nuevo/V_NuevoFE").noLayout();
				break;
				case 3:
					event.setView("convenios/Nuevo/V_NuevoUC").noLayout();
				break;
			}            
		</cfscript>
	</cffunction>

	<!--- 
	* Descripcion:    Guarda el convenio de tipo Firma Autografa
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="agregarConvenioFirmaAutografa" hint="Guarda el convenio de tipo Firma Autografa">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = event.getCollection();
			var resultado = CN.agregarConvenioFirmaAutografa(rc.tipoConvenio, rc.claveRegistro, rc.nombre, rc.descripcion, rc.modalidad, rc.institucion, rc.fechaInicio, rc.fechaFin, rc.concurrencia, rc.montoIpn, rc.montoConcurrente, rc.montoConacyt, rc.montoTotal, rc.montoTotalDir);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	* Descripcion:    Guarda el convenio de tipo Firma Electronica
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="agregarConvenioFirmaElectronica" hint="Guarda el convenio de tipo Firma Electronica">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = event.getCollection();
			var resultado = CN.agregarConvenioFirmaElectronica(rc.tipoConvenio, rc.claveRegistro, rc.nombre, rc.descripcion, rc.modalidad, rc.institucion, rc.fechaInicio, rc.fechaFin, rc.concurrencia, rc.concurrenciaEsp, rc.montoIpn, rc.montoConcurrente, rc.montoConacyt, rc.montoEspacio, rc.montoTotal, rc.montoTotalDir);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	* Descripcion:    Guarda el convenio de tipo UCMexus
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="agregarConvenioUCMexus" hint="Guarda el convenio de tipo UCMexus">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = event.getCollection();
            var resultado = CN.agregarConvenioUCMexus(rc.tipoConvenio, rc.claveRegistro, rc.nombre, rc.descripcion, rc.institucion, rc.fechaInicio, rc.fechaFin, rc.montoTotal);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	* Descripcion:    Edita el convenio de tipo Firma Autografa
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="editarConvenioFirmaAutografa" hint="Edita el convenio de tipo Firma Autografa">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = event.getCollection();
			var resultado = CN.editarConvenioFirmaAutografa(rc.pkConvenio, rc.nombre, rc.descripcion, rc.modalidad, rc.institucion, rc.fechaInicio, rc.fechaFin, rc.concurrencia, rc.montoIpn, rc.montoConcurrente, rc.montoConacyt, rc.montoTotal, rc.montoTotalDir);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	* Descripcion:    Edita el convenio de tipo Firma Electronica
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="editarConvenioFirmaElectronica" hint="Edita el convenio de tipo Firma Electronica">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = event.getCollection();
			var resultado = CN.editarConvenioFirmaElectronica(rc.pkConvenio, rc.nombre, rc.descripcion, rc.modalidad, rc.institucion, rc.fechaInicio, rc.fechaFin, rc.concurrencia, rc.concurrenciaEsp, rc.montoIpn, rc.montoConcurrente, rc.montoConacyt, rc.montoEspacio, rc.montoTotal, rc.montoTotalDir);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	* Descripcion:    Edita el convenio de tipo UCMexus
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="editarConvenioUCMexus" hint="Edita el convenio de tipo UCMexus">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = event.getCollection();
			var resultado = CN.editarConvenioUCMexus(rc.pkConvenio, rc.nombre, rc.descripcion, rc.institucion, rc.fechaInicio, rc.fechaFin, rc.montoTotal);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!--- 
	* Descripcion:    Agrega un responsable
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="agregarResponsable" hint="Agrega un responsable">
		<cfargument name="event" type="any">
		<cfscript>
			var rc = event.getCollection();
			if (rc.extension == ''){
				rc.extension = 0;
			}
			var resultado = CN.agregarResponsable(rc.numEmpleado, rc.nombre, rc.paterno, rc.materno, rc.correo, rc.extension, rc.pkGrado, rc.pkCarrera, rc.sexo, rc.pkUR, rc.pkConvenio);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

</cfcomponent>
