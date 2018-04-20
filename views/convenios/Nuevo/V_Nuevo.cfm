<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Convenios
* Fecha:       Junio de 2017
* Descripcion: Vista donde se puede dar de alta un convenio
* Autor:       SGS
* ================================
---->

<cfprocessingdirective pageEncoding="utf-8">
<link href="/includes/css/fileinput.css" media="all" rel="stylesheet" type="text/css">

<cfinclude template="V_Nuevo_js.cfm">

<cfif prc.pkConvenio neq -1> 
	<cfoutput><input type="hidden" id="hfPkConvenio"    value="#prc.pkConvenio#"></cfoutput>
	<cfoutput><input type="hidden" id="tipoDelConvenio" value="#prc.tipo#"></cfoutput>
<cfelse>
	<input type="hidden" id="hfPkConvenio" value="0">
</cfif>
<input type="hidden" id="hfPkResponsable" value="0">
<div class="row noPadding">
	<div class="col-md-12" style="margin-bottom: 63px;">
		<div class="panel panel-convenio">
			<div class="panel-heading panelBotonera-encabezado" style="padding-bottom: 10px;">
				<div class="panelBotonera-titulo">
					<strong>Agregar convenio</strong>
				</div>
			</div>
			<div class="panel-body panelFondo pt10 pb10">
				<div class="tabs-container">
					<ul class="nav nav-tabs">
						<li class="active guiaInfoGral"      id="tabChNewGen"><a data-toggle="tab" href="#tabNewGen-1"><i class="fa fa-circle-o"></i>Generales</a></li>
						<li class="hide guiaInfoResponsable" id="tabChNewRes"><a data-toggle="tab" href="#tabNewRes-2"><i class="fa fa-circle-o"></i>Responsable</a></li>
						<li class="hide guiaInfoArchivos"    id="tabChNewArc"><a data-toggle="tab" href="#tabNewArc-3"><i class="fa fa-circle-o"></i>Archivos</a></li>
					</ul>
					<div class="tab-content">
						<div id="tabNewGen-1" class="tab-pane active">
							<div class="panel-body">
								<form class="form">  
									<div class="row">    
										<div class="form-group col-md-4 col-md-offset-1">
											<label class="labelConvenio"><span class="text-warning">*</span> Tipo de convenio :</label>
											<select id="tipoConvenio" name="tipoConvenio" class="form-control guiaFormTipo">
												<option value="0">Seleccione un tipo de convenio...</option>
												<cfset total_records = prc.tiposConvenio.recordcount />
												<cfloop index="x" from="1" to="#total_records#">
													<cfoutput><option value="#prc.tiposConvenio.PK[x]#">#prc.tiposConvenio.NOMBRE[x]#</option></cfoutput>
												</cfloop>
											</select>
										</div>
										<div class="form-group col-md-3">
											<label class="labelConvenio"> Número de Folio:</label>
											<input type="text" id="claveRegistro" name="claveRegistro" class="form-control guiaFormRegistro" maxlength="30" disabled="true">
										</div>
										<div class="form-group col-md-3" id="formRegistroSIP" hidden="true">
											<label class="labelConvenio"> Número de Registro SIP:</label>
											<input type="text" id="numRegistroSIP" name="numRegistroSIP" class="form-control guiaFormRegistro" maxlength="30" disabled="true">
										</div>
									</div>
									<div class="hr-line-dashed"></div>
									<div id="tipoConvenioFormulario">
										<div class="well col-md-10 col-md-offset-1">Seleccione un tipo de convenio para llenar el formulario</div>
									</div>
								</form>
							</div>
						</div>

						<div id="tabNewRes-2" class="tab-pane hide">
							<div class="panel-body">
								<form id="formResponsable">
									<div class="row">
										<div class="form-group col-md-9 col-md-offset-1">
											<label class="labelConvenio"><span class="text-warning">*</span> Número de empleado :</label>
											<div class="input-group">
												<input type="text" id="numeroEmpleadoRes" name="numeroEmpleadoRes" class="form-control guiaFormNumeroEmp" maxlength="10">
												<span class="input-group-btn">
													<button type="button" onclick="buscarResponsable()" class="btn btn-convenio guiaFormReBuscaEmp" data-tooltip="tooltip" title="Buscar empleado">
														<i class="fa fa-search fa-lg" aria-hidden="true"></i>
													</button>
												</span>
											</div>
											<label id="numeroEmpleadoRes-error" class="error" for="numeroEmpleadoRes" style="display: none;"></label>
										</div>
									</div>
									<div class="row">
										<div class="form-group col-md-3 col-md-offset-1">
											<label class="labelConvenio"><span class="text-warning">*</span> Nombre :</label>
											<input type="text" id="nombreResp" name="nombreResp" class="form-control guiaFormReNombre" maxlength="20">
										</div>
										<div class="form-group col-md-3">
											<label class="labelConvenio"><span class="text-warning">*</span> Paterno :</label>
											<input type="text" id="paternoResp" name="paternoResp" class="form-control guiaFormRePaterno" maxlength="20">
										</div>
										<div class="form-group col-md-3">
											<label class="labelConvenio"><span class="text-warning">*</span> Materno :</label>
											<input type="text" id="maternoResp" name="maternoResp" class="form-control guiaFormReMaterno" maxlength="20">
										</div>
									</div>
									<div class="row">   
										<div class="form-group col-md-3 col-md-offset-1">
											<label class="labelConvenio"> Sexo :</label>
											<select id="sexoResp" name="sexoResp" class="form-control guiaFormReSexo">
												<option value="">Seleccione una opción...</option>
												<option value="1">Masculino</option>
												<option value="2">Femenino</option>
											</select>
										</div>    
										<div class="form-group col-md-6">
											<label class="labelConvenio"> Dependencia Académica :</label>
											<select id="dependenciaResp" name="dependenciaResp" class="form-control guiaFormReDependencia">
												<option value="">Seleccione una Dependencia...</option>
												<cfset total_records = prc.Dependencias.recordcount />
												<cfloop index="x" from="1" to="#total_records#">
													<cfoutput><option value="#prc.Dependencias.CLAVE_UR[x]#">#prc.Dependencias.SIGLAS_UR[x]# - #prc.Dependencias.NOMBRE_UR[x]#</option></cfoutput>
												</cfloop>
											</select>
										</div>
									</div>
									<div class="row">    
										<div class="form-group col-md-6 col-md-offset-1">
											<label class="labelConvenio"><span class="text-warning">*</span> Carrera :</label>
											<select id="carreraResp" name="carreraResp" class="form-control guiaFormReCarrera">
												<option value="">Seleccione una Carrera...</option>
												<cfset total_records = prc.Carreras.recordcount />
												<cfloop index="x" from="1" to="#total_records#">
													<cfoutput><option value="#prc.Carreras.PK_CARRERA[x]#">#prc.Carreras.NOMBRE_CARRERA[x]#</option></cfoutput>
												</cfloop>
											</select>
										</div>
										<div class="form-group col-md-3">
											<label class="labelConvenio"><span class="text-warning">*</span> Acronimo  :</label>
											<select id="gradoAcademicoResp" name="gradoAcademicoResp" class="form-control guiaFormReGradoAcademico">
												<option value="">Seleccione un Acronimo...</option>
												<cfset total_records = prc.Acronimos.recordcount />
												<cfloop index="x" from="1" to="#total_records#">
													<cfoutput><option value="#prc.Acronimos.PK[x]#">#prc.Acronimos.ACRONIM[x]# - #prc.Acronimos.ACRONDESC[x]#</option></cfoutput>
												</cfloop>
											</select>
										</div>
									</div>
									<div class="row">    
										<div class="form-group col-md-6 col-md-offset-1">
											<label class="labelConvenio"><span class="text-warning">*</span> Correo electrónico :</label>
											<input type="text" id="correoResp" name="correoResp" class="form-control guiaFormReCorreo only-mail" maxlength="30">
										</div>
										<div class="form-group col-md-3">
											<label class="labelConvenio"><span class="text-warning">*</span> Extensión :</label>
											<input type="text" id="extensionResp" name="extensionResp" class="form-control guiaFormReExtension" maxlength="30">
										</div>
									</div>
								</form>    
							</div>
						</div>

						<div id="tabNewArc-3" class="tab-pane hide">
							<div class="panel-body">
								<input id="pkRegistroComentario" type="hidden" value="">
								<div id="docs" class="ibox-content" style="border: none;">
									<div id="docsConvenio"></div>
									<div id="docsOfSuficienciaPresup"></div>
									<div id="docsNombTitularDep"></div>
									<div id="docsCartaConcurrencia"></div>
									<div id="docsOfSolicitudRev"></div>
									<div id="docsAnexoUnico"></div>
									<div id="docsActaConstitutiva"></div>
									<div id="docsPoderNotarialRep"></div>
									<div id="docsNombramientoRepLegal"></div>
									<div id="docsRfc"></div>
									<div id="docsComprobanteDomicilio"></div>
									<div id="docsIdentificacionRepLegal"></div>
									<div id="docsConvocatoria"></div>
									<div id="docsTerminosReferencia"></div>
									<div id="docsNombDirectorUr"></div>
									<div id="docsOtro"></div>
									<div id="docsResultados"></div>
									<div id="docsAnexos"></div>       
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--- INI PANEL ANEXO --->
	<div class="hide col-md-12" id="divPanelAnexo">
		<div class="panel panel-convenio panelFondo" id="PanelAnexo">
			<div class="panel-heading panelBotonera-encabezado">
				<div class="panelBotonera-titulo">
					<strong>Convenio</strong>
				</div>
				<div class="panelBotonera">
					<button type="button" class="btn btn-convenio btn-circle" data-toggle="modal" data-target="#divModalAnexo" data-toggle="tooltip" data-placement="top" data-original-title="Ver PDF del convenio">
						<i class="fa fa-clone fa-lg" aria-hidden="true"></i>
					</button>
					<button type="button" class="btn btn-convenio btn-circle fullscreen-link" data-toggle="tooltip" data-placement="top" data-original-title="Expander PDF">
						<i class="fa fa-expand fa-lg" aria-hidden="true"></i>
					</button>
					<button type="button" class="btn btn-convenio btn-circle close-link" id="cierraPanelAnexo" data-toggle="tooltip" data-placement="top" data-original-title="Cerrar">
						<i class="fa fa fa-times fa-lg" aria-hidden="true"></i>
					</button>
				</div>
			</div>
			<div class="panel-body">
				<div class="embed-responsive embed-responsive-4by3">
					<iframe id="frmAnexo" frameborder="0" class="embed-responsive-item" src="…"></iframe>
				</div>
			</div>
		</div>
	</div>
	<!--- FIN PANEL ANEXO --->  

	<div class="footer fixed text-center">
		<button type="button" class="btn btn-convenio btn-circle btn-lg mr10 guiaBtnNewGuardarCvn"          onclick="agregarConvenio();"                    data-tooltip="tooltip" title="Guardar convenio"                    id="btn-guardar">
			<i class="fa fa-floppy-o" aria-hidden="true"></i>
		</button>
		<button type="button" class="btn btn-convenio btn-circle btn-lg mr10 hide guiaBtnNewGuardarCambCvn" onclick="editarConvenio();"                     data-tooltip="tooltip" title="Guardar cambios del convenio"        id="btn-editar">
			<i class="fa fa-floppy-o" aria-hidden="true"></i>
		</button>
		<button type="button" class="btn btn-convenio btn-circle btn-lg mr10 hide guiaBtnNewGuardarRes"     onclick="agregarResponsable();"                 data-tooltip="tooltip" title="Agregar responsable"                 id="btn-agregarResp">
			<i class="fa fa-user-plus" aria-hidden="true"></i>
		</button>
		<button type="button" class="btn btn-convenio btn-circle btn-lg mr10 guiaBtnNewLimpiarCvn"          onclick="limpiarCamposConvenio();"              data-tooltip="tooltip" title="Limpiar información del convenio"    id="btn-limpiarConvenio">
			<i class="fa fa-eraser" aria-hidden="true"></i>
		</button>
		<button type="button" class="btn btn-convenio btn-circle btn-lg mr10 hide guiaBtnNewLimpiarRes"     onclick="limpiarCamposResponsable();"           data-tooltip="tooltip" title="Limpiar información del responsable" id="btn-limpiarResp">
			<i class="fa fa-eraser" aria-hidden="true"></i>
		</button>
		<button type="button" class="btn btn-convenio btn-circle btn-lg mr10 hide guiaBtnNewValidar"        onclick="CambiaEstadoNuevoConvenioValidar();"   data-tooltip="tooltip" title="Validar convenio"                    id="btn-validarConvenioNuevo">
			<i class="fa fa-unlock-alt" aria-hidden="true"></i>
		</button>
		<button type="button" class="btn btn-convenio btn-circle btn-lg mr10 guiaBtnNewConsultar"           onclick="busquedaConvenios();"                  data-tooltip="tooltip" title="Búsqueda convenios">
			<i class="fa fa fa-search" aria-hidden="true"></i>
		</button>
	</div>
</div>

<div id="divModalAnexo" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				 <h4 class="modal-title">Acta de nacimiento</h4>
			</div>
			<div class="modal-body">
				<div class="embed-responsive embed-responsive-4by3">
					<iframe src="" frameborder="0" class="embed-responsive-item"></iframe>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="divModalAgregarArchivo" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				 <h4 class="modal-title">Agrega archivo del convenio</h4>
			</div>
			<div class="modal-body">
				<div class="form row">
					<div class="form-group col-md-10 col-md-offset-1">
						<label class="control-label">Descripción :</label><br>
						<input type="text" class="form-control" id="txtDescripcion">
					</div>
					<div class="form-group col-md-4 col-md-offset-1">
						<label class="control-label">Tipo :</label><br>
						<label class="control-label">Convenio</label>
					</div>
					<div class="form-group col-md-5">
						<label class="control-label">Archivo :</label><br>
						<input type="file" class="form-control" name="fileupload" value="fileupload" id="fileupload">
					</div>
					<div class="form-group col-md-1 mt25">
						<button type="button" class="btn btn-convenio btn-circle" data-toggle="tooltip" data-placement="top" data-original-title="Agregar archivo">
							<i class="fa fa-plus fa-lg" aria-hidden="true"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="mdl-addComentarioCambioEstado" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" style="z-index: 999999 !important;">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="padding: 10px 30px 70px;">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: -20px;"><h1><strong>&times;</strong></h1></button>
				<h2 class="pull-left">¿Desea agregar un comentario?</h2>
			</div>
			<div class="modal-body">
				<input id="inRegistro" type="hidden" value="">
				<input id="inAccion"   type="hidden" value="">
				<div class="panel-group hide" id="accordion">
					<div class="panel panel-default">
						<div class="panel-heading">
							<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" class="collapsed" style="color: #333;">
								<h5 class="panel-title">Destinatarios<i class="fa fa-chevron-down pull-right"></i></h5>
							</a>
						</div>
						<div id="collapseOne" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
							<div class="panel-body destinatarios"></div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-1 control-label pull-left"><h4>Asunto:</h4></label>
					<div class="col-sm-11"><input id="inAsunto" type="text" class="form-control" value=""></div>
				</div>
				<br><br>
				<div class="checkbox checkbox-danger">&nbsp;&nbsp;&nbsp;
					<input id="inPrior" class="styled" type="checkbox">
					<label for="inPrior">
						<i class='fa fa-exclamation'></i> Prioritario
					</label>
				</div>
				<textarea id="inComent" name="inComent"></textarea>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default ml5" onclick="cambiarEstado(0);">Omitir</button>
				<button type="button" class="btn btn-success pull-right ml5" onclick="cambiarEstado(1);">Guardar comentario</button>
			</div>
		</div>
	</div>
</div>

<style type="text/css">
	.mce-tooltip{
		z-index: 9999999 !important;
	}
	.mce-floatpanel{
		z-index: 9999999 !important;
	}
</style>

<ul id="tlyPageGuide" data-tourtitle="Listado de convenios">
	<li class="tlypageguide_top" data-tourtarget=".guiaInfoGral">
		<div>
			Muestra de forma detallada la información general del convenio
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaInfoResponsable">
		<div>
			Muestra de forma detallada la información general del responsable del convenio
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaInfoArchivos">
		<div>
			Muestra de forma detallada la información general de los archivos contenidos en el convenio
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaFormTipo">
		<div>
			Filtro de selección para tipo de convenio, necesario para mostrar el formulario donde capturaría la información necesaria
		</div>
	</li>    
	<li class="tlypageguide_top" data-tourtarget=".guiaFormRegistro">
		<div>
			Campo número de folio, se genera automáticamente al registrar un convenio, con el podrá identificar el convenio
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormNombre">
		<div>
			Campo nombre identifica al convenio con un pequeño nombre, este siempre iniciara con una letra
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormDescripcion">
		<div>
			Campo descripción breve del convenio, este siempre iniciara con una letra
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormModalidad">
		<div>
			Campo modalidad a la que pertenece el convenio
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormInstitucion">
		<div>
			Campo Institución colaboradora que provee de los medios para el convenio
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormFechaIni">
		<div>
			Campo fecha de inicio de vigencia del convenio
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormFechaFin">
		<div>
			Campo fecha de fin de vigencia del convenio
		</div>
	</li>
	 <li class="tlypageguide_top" data-tourtarget=".guiaFormConcurrencia">
		<div>
			Seleccionar si el convenio es concurrente.
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormMontoIPN">
		<div>
			Campo monto IPN del convenio 
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormMontoEspecie">
		<div>
			Campo monto en especie concurrente del convenio 
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormMontoCONACYT">
		<div>
			Campo monto CONACYT del convenio
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormMontoTotal">
		<div>
			Campo total es la suma del monto IPN con el monto CONACYT 
		</div>
	</li>
	 <li class="tlypageguide_top" data-tourtarget=".guiaFormInMontoTotal">
		<div>
			Campo para ingresar el monto total del convenio.
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormNumeroEmp">
		<div>
			El campo número de empleado deberá ser único, con el podrá identificar el responsable del convenio
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaFormReBuscaEmp">
		<div>
			De clic aquí para realizar la busqueda del empleado
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaFormReNombre">
		<div>
			Campo nombre del responsable
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormRePaterno">
		<div>
			Campo apellido paterno del responsable
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormReMaterno">
		<div>
			Campo apellido materno del responsable
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaFormReSexo">
		<div>
			Campo para seleccionar el sexo del responsable
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormReDependencia">
		<div>
			Campo Dependencia Académica del responsable
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormReCarrera">
		<div>
			Campo carrera del responsable
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormReGradoAcademico">
		<div>
			Campo grado académico del responsable
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormReCorreo">
		<div>
			Campo correo electrónico del responsable
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaFormReExtension">
		<div>
			Campo extensión del responsable
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".guiaBtnNewGuardarCvn">
		<div>
			De clic aquí para realizar el guardado del convenio
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaBtnNewGuardarCambCvn">
		<div>
			De clic aquí para realizar el guardado de los cambios del convenio
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaBtnNewGuardarRes">
		<div>
			De clic aquí para agregar el responsable del convenio
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaBtnNewLimpiarCvn">
		<div>
			De clic aquí para limpiar la información del convenio
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaBtnNewLimpiarRes">
		<div>
			De clic aquí para limpiar la información del responsable
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaBtnNewValidar">
		<div>
			De clic aquí para realizar la validación del convenio
		</div>
	</li>
	 <li class="tlypageguide_top" data-tourtarget=".guiaBtnNewConsultar">
		<div>
			De clic aquí para ver la lista completa de convenios
		</div>
	</li>
	 <li class="tlypageguide_top" data-tourtarget=".guiaFormConcurrencia">
		<div>
			Seleccionar si el convenio es concurrente.
		</div>
	</li>
	 <li class="tlypageguide_top" data-tourtarget=".guiaFormInMontoTotal">
		<div>
			Campo para ingresar el monto total del convenio.
		</div>
	</li>	
</ul>

<script type="text/javascript">

	$(document).ready(function() {
		obtieneDocumentos(<cfoutput>#prc.tipo#</cfoutput>);///
	});


	function obtieneDocumentos(tipo){

		if (tipo == -1){
			return;
		}

		if (tipo == 1){ // FE
			convocatoria(parseInt(1));  //obligatorio
			terminosReferencia(parseInt(1)); //obligatorio
			resultados(parseInt(1)); //obligatorio
			ofSuficienciaPresup(parseInt(0)); //opcional
			nombTitularDep(parseInt(0)); //opcional
			cartaConcurrencia(parseInt(0)); //opcional

		}  else if(tipo == 2){ // FA
			ofSolicitudRev(parseInt(1)); //obligatorio
			convenio(parseInt(1)); //obligatorio
			anexoUnico(parseInt(1)); //obligatorio
			actaConstitutiva(parseInt(1)); //obligatorio
			poderNotarialRep(parseInt(1)); //obligatorio
			nombramientoRepLegal(parseInt(1)); //obligatorio
			rfc(parseInt(1)); //obligatorio
			comprobanteDomicilio(parseInt(1)); //obligatorio
			identificacionRepLegal(parseInt(1)); //obligatorio
			convocatoria(parseInt(0)); //opcional
			terminosReferencia(parseInt(0)); //opcional
			nombDirectorUr(parseInt(0)); //opcional
			otro(parseInt(0)); //opcional
			resultados(parseInt(0)); //opcional
			

		} else if (tipo == 3){ // UC
			convenio(parseInt(1)); //obligatorio
			ofSolicitudRev(parseInt(1)); //obligatorio
			convocatoria(parseInt(1)); //obligatorio
		}        
	}


	function anexoUnico(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 316,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'anexoUnico()'
		}, function(data) {
			$("#docsAnexoUnico").html(data);         
		});
	}

	function actaConstitutiva(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 317,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'actaConstitutiva()'
		}, function(data) {
			$("#docsActaConstitutiva").html(data);  
		});
	}

	function nombramientoRepLegal(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 320,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'nombramientoRepLegal()'
		}, function(data) {
			$("#docsNombramientoRepLegal").html(data);
		});
	}

	function poderNotarialRep(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 321,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'poderNotarialRep()'
		}, function(data) {
			$("#docsPoderNotarialRep").html(data);
		});
	}

	function rfc(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 322,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'rfc()'
		}, function(data) {
			$("#docsRfc").html(data);
		});
	}

	function comprobanteDomicilio(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 323,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'comprobanteDomicilio()'
		}, function(data) {
			$("#docsComprobanteDomicilio").html(data);
		});
	}

	function ofSolicitudRev(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 325,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'ofSolicitudRev()'
		}, function(data) {
			$("#docsOfSolicitudRev").html(data);
		});
	}

	function cartaConcurrencia(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 326,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'cartaConcurrencia()'
		}, function(data) {
			$("#docsCartaConcurrencia").html(data);
		});
	}

	function anexos(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 327,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'anexos()'
		}, function(data) {
			$("#docsAnexos").html(data);
		});
	}

	function convenio(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 328,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'convenio()'
		}, function(data) {
			$("#docsConvenio").html(data);
		});
	}

	function terminosReferencia(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 329,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'terminosReferencia()'
		}, function(data) {
			$("#docsTerminosReferencia").html(data);
		});
	}

	function resultados(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 330,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'resultados()'
		}, function(data) {
			$("#docsResultados").html(data);
		});
	}

	function ofSuficienciaPresup(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 331,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'ofSuficienciaPresup()'
		}, function(data) {
			$("#docsOfSuficienciaPresup").html(data);
		});
	}

	function nombTitularDep(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 332,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'nombTitularDep()'
		}, function(data) {
			$("#docsNombTitularDep").html(data);
		});
	}

	function convocatoria(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 333,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'convocatoria()'
		}, function(data) {
			$("#docsConvocatoria").html(data);
		});
	}

	function identificacionRepLegal(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 901,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'identificacionRepLegal()'
		}, function(data) {
			$("#docsIdentificacionRepLegal").html(data);
		});
	}

	function nombDirectorUr(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 902,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'nombDirectorUr()'
		}, function(data) {
			$("#docsNombDirectorUr").html(data);
		});
	}

	function otro(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 903,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'otro()'
		}, function(data) {
			$("#docsOtro").html(data);
		});
	}

</script>
