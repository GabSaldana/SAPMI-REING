<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Fecha:       8 de mayo de 2017
* Descripcion: Componente de Negocio para el modulo de convenios 
* ================================
---->
<cfcomponent>
	<cfproperty name="DAO" inject="convenios.Nuevo.DAO_Nuevo">

	<!---
	* Descripcion:    Obtiene los tipos de convenio
	* Fecha creacion: 23 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="obtenerTiposConvenio" access="remote" returntype="query" hint="Obtiene los tipos de convenio">
		<cfscript>
			return dao.obtenerTiposConvenio();
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene lista del catalogo de documentos
	* Fecha creacion: 05 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="obtenerDocumentosConvenio" access="remote" hint="Obtiene lista del catalogo de documentos">
		<cfscript>
			return dao.obtenerDocumentosConvenio();
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene Instituciones
	* Fecha creacion: 24 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="obtenerInstituciones" access="remote" returntype="query" hint="Obtiene Instituciones">
		<cfscript>
			return dao.obtenerInstituciones();
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene Modalidades
	* Fecha creacion: 6 de Febrero de 2018
	* @author:        Juan Carlos Hernández
	--->
	<cffunction name="obtenerModalidades" access="remote" returntype="query" hint="Obtiene todas las modalidades">
		<cfscript>
			return dao.obtenerModalidades();
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Guarda el convenio de tipo Firma Autografa
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="agregarConvenioFirmaAutografa" hint="Guarda el convenio de tipo Firma Autografa">
		<cfargument name="tipoConvenio"     type="numeric" required="yes" hint="Tipo del convenio">
		<cfargument name="claveRegistro"    type="string"  required="yes" hint="Numero de registro del convenio">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre del convenio">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion del convenio">
		<cfargument name="modalidad"        type="string"  required="yes" hint="Modalidad del convenio">
		<cfargument name="instituto"        type="numeric" required="yes" hint="Institución colaboradora delconvenio">
		<cfargument name="fechaInicio"      type="string"  required="yes" hint="Fecha de inicio del convenio">
		<cfargument name="fechaFin"         type="string"  required="yes" hint="Fecha fin del convenio">
		<cfargument name="concurrencia" 	type="numeric" required="yes" hint="Valor que especifica si el convenio es concurrente">
		<cfargument name="montoIpn"         type="numeric" required="yes" hint="Monto IPN">
		<cfargument name="montoConcurrente" type="numeric" required="yes" hint="Monto en especie">
		<cfargument name="montoConacyt"     type="numeric" required="yes" hint="Monto Conacyt">
		<cfargument name="montoTotal"       type="numeric" required="yes" hint="Monto total">
		<cfargument name="montoTotalDir"    type="numeric" required="yes" hint="Monto total directo">
		<cfscript>
		 	if (concurrencia == 2){
		 		var convenio = DAO.agregarConvenioFirmaAutografa(tipoConvenio, UCase(claveRegistro), UCase(nombre), UCase(descripcion), UCase(modalidad), instituto, fechaInicio, fechaFin, montoIpn, montoConcurrente, montoConacyt, montoTotal, Session.cbstorage.usuario.UR, 2);
		 	}else {
		 		var convenio = DAO.agregarConvenioFirmaAutografa(tipoConvenio, UCase(claveRegistro), UCase(nombre), UCase(descripcion), UCase(modalidad), instituto, fechaInicio, fechaFin, 0, 0, 0, montoTotalDir, Session.cbstorage.usuario.UR, 1);
		 	}
			DAO.agregarConvenio_historial(convenio, Session.cbstorage.usuario.PK, "Registro del Convenio");
			return convenio;
		</cfscript>
	</cffunction>

	<!--- 
	* Descripcion:    Guarda el convenio de tipo Firma Electronica
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="agregarConvenioFirmaElectronica" hint="Guarda el convenio de tipo Firma Electronica">
		<cfargument name="tipoConvenio"     type="numeric" required="yes" hint="Tipo del convenio">
		<cfargument name="claveRegistro"    type="string"  required="yes" hint="Numero de registro del convenio">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre del convenio">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion del convenio">
		<cfargument name="modalidad"        type="string"  required="yes" hint="Modalidad del convenio">
		<cfargument name="instituto"        type="numeric" required="yes" hint="Institución colaboradora delconvenio" default="0">
		<cfargument name="fechaInicio"      type="string"  required="yes" hint="Fecha de inicio del convenio">
		<cfargument name="fechaFin"         type="string"  required="yes" hint="Fecha fin del convenio">
		<cfargument name="concurrencia" 	type="numeric" required="yes" hint="Valor que especifica si el convenio es concurrente">
		<cfargument name="concurrenciaEsp" 	type="numeric" required="yes" hint="Valor que especifica si el convenio es concurrente en Especie">
		<cfargument name="montoIpn"         type="numeric" required="yes" hint="Monto IPN">
		<cfargument name="montoConcurrente" type="numeric" required="yes" hint="Monto en especie">
		<cfargument name="montoConacyt"     type="numeric" required="yes" hint="Monto Conacyt">
		<cfargument name="montoEspacio"   	type="numeric" required="yes" hint="Monto Espacio fisico">
		<cfargument name="montoTotal"       type="numeric" required="yes" hint="Monto total">
		<cfargument name="montoTotalDir"    type="numeric" required="yes" hint="Monto total directo">
		<cfscript>
			if (concurrencia == 2){
				if (concurrenciaEsp == 3){
					var convenio = DAO.agregarConvenioFirmaElectronica(tipoConvenio, UCase(claveRegistro), UCase(nombre), UCase(descripcion), UCase(modalidad), instituto, fechaInicio, fechaFin, montoIpn, montoConcurrente, montoConacyt, montoTotal, Session.cbstorage.usuario.UR, 3, montoEspacio);
				}else{
					var convenio = DAO.agregarConvenioFirmaElectronica(tipoConvenio, UCase(claveRegistro), UCase(nombre), UCase(descripcion), UCase(modalidad), 0, fechaInicio, fechaFin, montoIpn, 0, montoConacyt, montoTotal, Session.cbstorage.usuario.UR, 2, 0);
				}
		 	}else {
		 		var convenio = DAO.agregarConvenioFirmaElectronica(tipoConvenio, UCase(claveRegistro), UCase(nombre), UCase(descripcion), UCase(modalidad), 0, fechaInicio, fechaFin, 0, 0, 0, montoTotalDir, Session.cbstorage.usuario.UR, 1, 0);
		 	}
			DAO.agregarConvenio_historial(convenio, Session.cbstorage.usuario.PK, "Registro del Convenio");
			return convenio;
		</cfscript>
	</cffunction>

	<!--- 
	* Descripcion:    Guarda el convenio de tipo UCMexus
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="agregarConvenioUCMexus" hint="Guarda el convenio de tipo UCMexus">
		<cfargument name="tipoConvenio"     type="numeric" required="yes" hint="Tipo del convenio">
		<cfargument name="claveRegistro"    type="string"  required="yes" hint="Numero de registro del convenio">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre del convenio">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion del convenio">
		<cfargument name="instituto"        type="numeric" required="yes" hint="Institución colaboradora delconvenio">
		<cfargument name="fechaInicio"      type="string"  required="yes" hint="Fecha de inicio del convenio">
		<cfargument name="fechaFin"         type="string"  required="yes" hint="Fecha fin del convenio">
		<cfargument name="montoTotal"       type="numeric" required="yes" hint="Monto total">
		<cfscript>
            var convenio = DAO.agregarConvenioUCMexus(tipoConvenio, UCase(claveRegistro), nombre, descripcion, instituto, fechaInicio, fechaFin, montoTotal, Session.cbstorage.usuario.UR);
			DAO.agregarConvenio_historial(convenio, Session.cbstorage.usuario.PK, "Registro del Convenio");
			return convenio;
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Edita el convenio de tipo Firma Autografa
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="editarConvenioFirmaAutografa" hint="Edita el convenio de tipo Firma Autografa">
		<cfargument name="pkConvenio"       type="numeric" required="yes" hint="Pk del convenio">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre del convenio">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion del convenio">
		<cfargument name="modalidad"        type="string"  required="yes" hint="Modalidad del convenio">
		<cfargument name="instituto"        type="numeric" required="yes" hint="Institución colaboradora delconvenio">
		<cfargument name="fechaInicio"      type="string"  required="yes" hint="Fecha de inicio del convenio">
		<cfargument name="fechaFin"         type="string"  required="yes" hint="Fecha fin del convenio">
		<cfargument name="concurrencia" 	type="numeric" required="yes" hint="Valor que especifica si el convenio es concurrente">
		<cfargument name="montoIpn"         type="numeric" required="yes" hint="Monto IPN">
		<cfargument name="montoConcurrente" type="numeric" required="yes" hint="Monto en especie">
		<cfargument name="montoConacyt"     type="numeric" required="yes" hint="Monto Conacyt">
		<cfargument name="montoTotal"       type="numeric" required="yes" hint="Monto total">
		<cfargument name="montoTotalDir"    type="numeric" required="yes" hint="Monto total directo">
		<cfscript>
			if (concurrencia == 2){
				return DAO.editarConvenioFirmaAutografa(pkConvenio, nombre, descripcion, modalidad, instituto, fechaInicio, fechaFin, montoIpn, montoConcurrente, montoConacyt, montoTotal, 2);
			}else{
				return DAO.editarConvenioFirmaAutografa(pkConvenio, nombre, descripcion, modalidad, instituto, fechaInicio, fechaFin, 0, 0, 0, montoTotalDir, 1);
			}
		</cfscript>
	</cffunction>


	<!--- 
	* Descripcion:    Edita el convenio de tipo Firma Electronica
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="editarConvenioFirmaElectronica" hint="Edita el convenio de tipo Firma Electronica">
		<cfargument name="pkConvenio"       type="numeric" required="yes" hint="Pk del convenio">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre del convenio">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion del convenio">
		<cfargument name="modalidad"        type="string"  required="yes" hint="Modalidad del convenio">
		<cfargument name="instituto"        type="numeric" required="yes" hint="Institución colaboradora delconvenio" default="0">
		<cfargument name="fechaInicio"      type="string"  required="yes" hint="Fecha de inicio del convenio">
		<cfargument name="fechaFin"         type="string"  required="yes" hint="Fecha fin del convenio">
		<cfargument name="concurrencia" 	type="numeric" required="yes" hint="Valor que especifica si el convenio es concurrente">
		<cfargument name="concurrenciaEsp" 	type="numeric" required="yes" hint="Valor que especifica si el convenio es concurrente en Especie">
		<cfargument name="montoIpn"         type="numeric" required="yes" hint="Monto IPN">
		<cfargument name="montoConcurrente" type="numeric" required="yes" hint="Monto en especie">
		<cfargument name="montoConacyt"     type="numeric" required="yes" hint="Monto Conacyt">
		<cfargument name="montoEspacio"   	type="numeric" required="yes" hint="Monto Espacio fisico">
		<cfargument name="montoTotal"       type="numeric" required="yes" hint="Monto total">
		<cfargument name="montoTotalDir"    type="numeric" required="yes" hint="Monto total directo">
		<cfscript>		
			if (concurrencia == 2){
				if (concurrenciaEsp == 3){
					return DAO.editarConvenioFirmaElectronica(pkConvenio, nombre, descripcion, modalidad, instituto, fechaInicio, fechaFin, montoIpn, montoConcurrente, montoConacyt, montoTotal, 3, montoEspacio);
				}else{
					return DAO.editarConvenioFirmaElectronica(pkConvenio, nombre, descripcion, modalidad, 0, fechaInicio, fechaFin, montoIpn, 0, montoConacyt, montoTotal, 2, 0);
				}
		 	}else {
		 		return DAO.editarConvenioFirmaElectronica(pkConvenio, nombre, descripcion, modalidad, 0, fechaInicio, fechaFin, 0, 0, 0, montoTotalDir, 1, 0);
		 	}
		</cfscript>
	</cffunction>

	<!--- 
	* Descripcion:    Edita el convenio de tipo UCMexus
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="editarConvenioUCMexus" hint="Edita el convenio de tipo UCMexus">
		<cfargument name="pkConvenio"       type="numeric" required="yes" hint="Pk del convenio">
		<cfargument name="nombre"           type="string"  required="yes" hint="Nombre del convenio">
		<cfargument name="descripcion"      type="string"  required="yes" hint="Descripcion del convenio">
		<cfargument name="instituto"        type="numeric" required="yes" hint="Institución colaboradora delconvenio">
		<cfargument name="fechaInicio"      type="string"  required="yes" hint="Fecha de inicio del convenio">
		<cfargument name="fechaFin"         type="string"  required="yes" hint="Fecha fin del convenio">
		<cfargument name="montoTotal"       type="numeric" required="yes" hint="Monto total">
		<cfscript>
			return DAO.editarConvenioUCMexus(pkConvenio, nombre, descripcion, instituto, fechaInicio, fechaFin, montoTotal);
		</cfscript>
	</cffunction>
   
	<!--- 
	* Descripcion:    Agrega un responsable
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="agregarResponsable" hint="Agrega un responsable">
		<cfargument name="numEmpleado"      type="numeric"  required="yes" hint="Numero de empleado">
		<cfargument name="nombre"           type="string"   required="yes" hint="Nombre de responsable">
		<cfargument name="paterno"          type="string"   required="yes" hint="Apellido paterno del responsable">
		<cfargument name="materno"          type="string"   required="yes" hint="Apellido materno del responsable">
		<cfargument name="correo"           type="string"   required="yes" hint="Correo del respnsable">
		<cfargument name="extension"        type="numeric"  required="yes" hint="Extensio del responsable">
		<cfargument name="pkGrado"          type="numeric"  required="yes" hint="pk del grado del responsable">
		<cfargument name="pkCarrera"        type="numeric"  required="yes" hint="pk de la carrera del responsable">
		<cfargument name="sexo"             type="numeric"  required="yes" hint="sexo del responsable">
		<cfargument name="pkUR"             type="string"   required="yes" hint="UR del responsable">
		<cfargument name="pkConvenio"       type="numeric"  required="yes" hint="pk del convenio">
		<cfscript>
			return DAO.agregarResponsable(numEmpleado, nombre, paterno, materno, correo, extension, pkGrado, pkCarrera, sexo, pkUR, pkConvenio);
		</cfscript>
	</cffunction>

</cfcomponent>