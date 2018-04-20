<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript" src="/includes/js/jquery/jquery-tableExport/tableExport.js"></script>
<script type="text/javascript" src="/includes/js/jquery/jquery-tableExport/bootstrap-table-export.js"></script>
<cfinclude template="nomina_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
	<div class="col-lg-10">
		<h2>Nómina</h2>
		<ol class="breadcrumb">
			<cfoutput>
				<li>
					<a href="#event.buildLink('inicio')#">Inicio</a>
				</li>
				<li class="active">
					<strong>Nómina</strong>
				</li>
			</cfoutput>
		</ol>
	</div>
</div>
<br>
<div class="ibox float-e-margins">
	<ul class="nav nav-tabs">
		<li class="active"><a data-toggle="tab" href="#menu1" onclick="javascript:$('.botonesNomina').show();">Enviar a nómina</a></li>
		<li><a data-toggle="tab" href="#menu2" onclick="enviadosNominaSimple(-1);">Enviados a nómina</a></li>
	</ul>

	<div class="tab-content">
		<div id="menu1" class="tab-pane fade in active">
			<div class="ibox-content">
				<div class="row">
					<div class="col-sm-6">
						<label class='control-label'>Estado de la solicitud:</label><br>
						<label class="checkbox-inline">
							<input id="solAt" type="checkbox">Solicitud atendida
						</label>
						<label class="checkbox-inline">
							<input id="solRI" type="checkbox">Solicito RI
						</label>
					</div>
				</div><br>

				<div class="row">
					<div class="col-sm-6">
					<label class='control-label'>Nivel mayor a cero:</label><br>
						<div class='radio radio-primary radio-inline'>
							<input value='1' id="mayorCero" name='mayorCero' type='radio'>
							<label for="mayorCero"><i class='fa fa-lg fa-check'></i> Sí</label></div><div class='radio radio-primary radio-inline'>
							<input value='0' id="mayorCeroNo" name='mayorCero' checked='checked' type='radio'>
							<label for="mayorCeroNo"><i class='fa fa-lg fa-close'></i> No</label>
						</div>
					</div>
				</div><br>

				<form id="formNomina" role="form" onsubmit="return false;">
					<div class="row">
						<div class="col-sm-6">
							<label class="control-label">Clave</label>
							<div class="input-group">
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-pushpin"></span>
								</span>
								<input id="inClave" name="inClave" type="text" class="form-control" placeholder="Clave">
							</div>
						</div>
						<div class="col-sm-6">
							<label class="control-label">Clave año de gracia</label>
							<div class="input-group">
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
								<input id="inClaveGracia" name="inClaveGracia" type="text" class="form-control" placeholder="Clave año de gracia">
							</div>
						</div>
					</div><br>
					<div class="row">
						<div class="col-sm-6">
							<label class="control-label">Clave residencia</label>
							<div class="input-group">
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-pushpin"></span>
								</span>
								<input id="inClaveRes" name="inClaveRes" type="text" class="form-control" placeholder="Clave residencia">
							</div>
						</div>
						<div class="col-sm-6">
							<label class="control-label">Oficio</label>
							<div class="input-group">
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-file"></span>
								</span>
								<input id="cveOficio" name="cveOficio" type="text" class="form-control" placeholder="Oficio">
							</div>
						</div>
					</div>
				</form>
				<br><br>
				<div id="tablaNomina" class="row"></div>
			</div>
		</div>
		<div id="menu2" class="tab-pane fade ibox-content">
			<div id="tablaEnviadosNomina" class="row"></div>
		</div>
	</div>
</div>

<div class="botonesNomina footer fixed text-center">
	<button class="btn btn-lg btn-circle btn-success fa fa-search" data-toggle="tooltip" title="Buscar"		    onclick="getNomina();"></button>
	<button class="btn btn-lg btn-circle btn-info fa fa-eraser"    data-toggle="tooltip" title="Limpiar campos" onclick="limpiaBusqueda();"></button>
	<button class="btn btn-lg btn-circle btn-danger fa fa-money"   data-toggle="tooltip" title="Generar nómina" onclick="guardarNomina();"></button>
</div>

<form id="iframeDocumentos" action="<cfoutput>#event.buildLink('EDI.solicitud.generarDocumento')#</cfoutput>" method="post" target="_blank">
    <input type="hidden" id="tipoDocTxt" name="tipoDocTxt">
    <input type="hidden" id="oficioTxt"  name="oficioTxt">
</form>
