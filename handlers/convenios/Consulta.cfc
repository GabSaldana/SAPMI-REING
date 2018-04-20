<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Fecha:       8 de mayo de 2017
* Descripcion: Handler para el modulo de Convenios/Consulta
* ================================
---->
<cfcomponent >
	<cfproperty name="cn"      inject="convenios.Consulta.CN_Consulta">
	<cfproperty name="cnNuevo" inject="convenios.Nuevo.CN_Nuevo">
	
	<!---
	* Descripcion:    Carga informacion inicial
	* Fecha creacion: 23 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	** comentarios 
	--->
	<cffunction name="index" access="public" returntype="void" output="false" hint="Carga informacion inicial">
		<cfargument name="Event" type="any">
		<cfscript>
			prc.tablaConvenios  = (Session.cbstorage.usuario.ROL == application.SIIIP_CTES.ROLES.ANALISTADEP or
									Session.cbstorage.usuario.ROL == application.SIIIP_CTES.ROLES.RESPONSABLEDEP or
									Session.cbstorage.usuario.ROL == application.SIIIP_CTES.ROLES.TITULARDEP)
								? cn.getTablaConvenios(0, 0, 0, Session.cbstorage.usuario.UR) : cn.getTablaConvenios(0, 0, 0, 0);
			prc.URClasificacion = cn.obtenerURClasificacion();
			prc.tiposConvenio   = cnNuevo.obtenerTiposConvenio();
			prc.Instituciones   = cnNuevo.obtenerInstituciones();
			prc.Documentos      = cnNuevo.obtenerDocumentosConvenio();
			
			Event.setView("convenios/Consulta/V_Consulta");
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Carga listado de convenios para la vista tabla Convenios
	* Fecha creacion: 23 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         pkEstado, PK del Estado 
	*                 pkClasif, PK de la clasificacion
	*                 pkUR, PK de la UR  
	--->
	<cffunction name="cargarTablaConvenios" hint="Carga listado de convenios para la vista tabla Convenios">
		<cfargument name="Event" type="any">
		<cfscript>
			prc.tablaConvenios  = (Session.cbstorage.usuario.ROL == application.SIIIP_CTES.ROLES.ANALISTADEP or
									Session.cbstorage.usuario.ROL == application.SIIIP_CTES.ROLES.RESPONSABLEDEP or
									Session.cbstorage.usuario.ROL == application.SIIIP_CTES.ROLES.TITULARDEP)
								? cn.getTablaConvenios(0, 0, 0, Session.cbstorage.usuario.UR) : cn.getTablaConvenios(rc.tipo, rc.numEstado, rc.pkClasif, rc.pkUR);
			Event.setView("convenios/Consulta/T_Consulta").noLayout();
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Cambia el estado de un registro
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="cambiarEstadoConvenio" hint="Cambia el estado de un registro">
		<cfargument name="Event" type="any">
		<cfscript>
			var resultado = cn.cambiarEstadoConvenio(rc.pkRegistro, rc.accion, rc.asunto, rc.comentario, rc.prioridad, rc.destinatarios, rc.tipoComent);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Consulta el numero de archivos requeridos ya cargados
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="archivosRequeridosCargados" hint="Consulta el numero de archivos requeridos ya cargados">
		<cfargument name="Event" type="any">
		<cfscript>
			var resultado  = cn.archivosRequeridosCargados(rc.pkRegistro, rc.tipoConvenio);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Consulta si tiene un responsable asignado
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	--->
	<cffunction name="responsableAsignado" hint="Consulta si tiene un responsable asignado">
		<cfargument name="Event" type="any">
		<cfscript>
			var resultado  = cn.responsableAsignado(rc.pkRegistro);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha: Noviembre de 2016
	* @author Alejandro Tovar
	* Descripcion: Función que obtiene los usuarios para enviar comentario.
	--->
	<cffunction name="getUsuComentario" hint="Usuarios que pueden recibir un comentario">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cn.getUsuComentario(pkElemento,tipoElemento);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Fecha: Noviembre de 2016
	* @author Alejandro Tovar
	* Descripcion: Función que obtiene el asunto del tipo de comentario
	--->
	<cffunction name="asuntoComentario" hint="Usuarios que pueden recibir un comentario">
		<cfargument name="Event" type="any">
		<cfscript>
			var rc = Event.getCollection();
			var resultado = cn.asuntoComentario(rc.pkTipoComent);
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene la informacion del convenio por PK de convenio y su responsable
	* Fecha creacion: 09 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         pkConvenio, PK del convenio
	*                 pkTipo, PK del tipo de convenio
	--->
	<cffunction name="getVistabyPKConvenioTipo" hint="Obtiene la informacion del convenio por PK de convenio y su responsable">
		<cfargument name="Event" type="any">
		<cfscript>
			prc.Documentos = cnNuevo.obtenerDocumentosConvenio();

			switch(rc.pkTipo) {
				case 1: // Firma electronica
					 prc.InfoConvenio = cn.getVistaFEbyPKConvenio(rc.pkConvenio);
					 Event.setView("convenios/Consulta/V_ConsultaFE").noLayout();
					 break;
				case 2: // Firma autografa
					 prc.InfoConvenio = cn.getVistaFAbyPKConvenio(rc.pkConvenio);
					 Event.setView("convenios/Consulta/V_ConsultaFA").noLayout();
					 break;
				case 3: // UC-Mexus
					 prc.InfoConvenio = cn.getVistaUCbyPKConvenio(rc.pkConvenio);
					 Event.setView("convenios/Consulta/V_ConsultaUC").noLayout();
					 break;
			}
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene los estados para llenar el combo select
	* Fecha creacion: Julio de 2017
	* @author:        SGS
	--->
	<cffunction name="obtenerSelectEstados" access="remote" returntype="void" output="false" hint="Obtiene los estados para llenar el combo select">
		<cfscript>      
			resultado = cn.obtenerEstados(rc.tipoConvenio);              
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Carga catalogo de UR's por clasificacion
	* Fecha creacion: 23 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         pkURClasificacion, PK de la clasificacion de UR  
	--->
	<cffunction name="obtenerURbyClasificacion" access="remote" returntype="void" output="false" hint="Carga catalogo de UR's por clasificacion">
		<cfscript>		
			resultado = cn.obtenerURbyClasificacion(rc.pkURClasificacion);				
			event.renderData(type="json", data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Obtiene el empleado por el numero de empleado
	* Fecha creacion: 06 de junio de 2017
	* @author:        Jose Luis Granados Chavez
	* @param:         numEmpleado, Numero de empleado
	--->
	<cffunction name="obtenerEmpleadoByNumEmpleado" hint="Obtiene el empleado por el numero de empleado">
		<cfscript>
			resultado = cn.obtenerEmpleadoByNumEmpleado(rc.numEmpleado);
			event.renderData(type="json",data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Edita un convenio existente
	* Fecha creacion: 25 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="editarConvenio" hint="Edita un convenio existente">
		<cfscript>
			resultado = cn.editarConvenio(rc.PK, rc.FKTIPO, rc.FKINSTITUCION, rc.NOMBRE, rc.DESCRIPCION, rc.FECHAVIGINI, rc.FECHAVIGFIN, 
										  rc.MONTOLIQUIDO, rc.MONTOESPECIE, rc.MONTOCONACYT, rc.MONTOTOTAL);
			event.renderData(type="json",data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Edita un responsable existente    
	* Fecha creacion: 30 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="editarResponsable" hint="Edita un responsable existente">
		<cfscript>
			resultado = cn.editarResponsable(rc.PK, rc.NOMBRE, rc.PATERNO, rc.MATERNO, rc.EXTENSION);
			event.renderData(type="json",data=resultado);
		</cfscript>
	</cffunction>

	<!---
	* Descripcion:    Edita el responsable existente en el convenio    
	* Fecha creacion: 30 de mayo de 2017
	* @author:        Jose Luis Granados Chavez
	--->
	<cffunction name="editarConvenioConResponsable" hint="Edita el responsable existente en el convenio">
		<cfscript>
			resultado = cn.editarConvenioConResponsable(rc.PK, rc.FKRESPONSABLE);
			event.renderData(type="json",data=resultado);
		</cfscript>
	</cffunction>

	 <!---
	* Descripcion:    Obtiene la informacion del convenio por PK de convenio y su responsable
	* Fecha creacion: Junio de 2017
	* @author:        SGS
	* @param:         pkConvenio, PK del convenio
	*                 pkTipo, PK del tipo de convenio
	--->
	<cffunction name="obtenerDatosEditar" hint="Obtiene la informacion del convenio por PK de convenio y su responsable">
		<cfargument name="Event" type="any">
		<cfscript>
			switch(rc.tipo) {
				case 1: // Firma electronica
					 resultado = cn.getEditarFEbyPKConvenio(rc.pkConvenio);
					 event.renderData(type="json",data=resultado);
					 break;
				case 2: // Firma autografa
					 resultado = cn.getEditarFAbyPKConvenio(rc.pkConvenio);
					 event.renderData(type="json",data=resultado);
					 break;
				case 3: // UC-Mexus
					 resultado = cn.getEditarUCbyPKConvenio(rc.pkConvenio);
					 event.renderData(type="json",data=resultado);
					 break;
			}
		</cfscript>
	</cffunction>

</cfcomponent>
