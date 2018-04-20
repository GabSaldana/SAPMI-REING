<!---
* =========================================================================
* IPN - CSII
* Sistema:		SIIIS
* Modulo:		Tiempos
* Fecha:		Agosto de 2017
* Descripcion:	Administracion de los tiempos de los convenios
* Autor:		Roberto Cadena
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="tiempos_js.cfm">

<script type="text/javascript" src="/includes/js/jquery/jquery-tableExport/tableExport.js"></script>
<script type="text/javascript" src="/includes/js/jquery/jquery-tableExport/bootstrap-table-export.js"></script>


<div class="row wrapper border-bottom white-bg page-heading">
	<div class="col-lg-10">
		<h2>Administración de tiempos</h2>
		<ol class="breadcrumb">
			<cfoutput>
			<li>
				<a href="#event.buildLink('inicio')#">Inicio</a>
			</li>
			<li class="active">
				<strong>Tiempos</strong>
			</li>
			</cfoutput>
		</ol>
	</div>
</div>

<div class="wrapper wrapper-content animated fadeIn">
	<div class="ibox float-e-margins">
		<div class="ibox-title listaUsuarios">
			<h5>Seleccionar el tipo de documento</h5>
		</div>
		<div class="ibox-content">
			<div class="row">
				<div class="col-md-4">
					<div class="form-group">
						<label class="font-normal"><span><i class="fa fa-folder-o"></i></span> Procedimiento:</label>
						<div class="input-group">
							<select class="selectpicker guiaProcedimiento" data-live-search="true" data-style="btn-success btn-outline" id="proced" title="Seleccionar un procedimiento...">
								<cfoutput query="prc.proced">
									<option value="#PKPROCED#">#PROCED#</option>
								</cfoutput>
							</select>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="ibox-title listaUsuarios">
			<h5>Tiempo transcurrido</h5>
		</div>
		<div class="ibox-content" style="position: relative;">
			<div id="toolbar">
				<div class="col-sm-9">
					<div class="col-sm-2">
						<div class="form-group date">
							<label class="font-normal"> Despu&#233;s de:</label>
							<div class="input-group">
								<input id="fechaInicio" name="fechaInicio" type="text" value="" class="form-control buscador guiaHistorialInicio" disabled>
								<span class="input-group-addon" data-toggle="tooltip" data-placement="top" title="" data-original-title="Seleccionar Fecha de Inicio">
									<span class="fa fa-calendar"></span>
								</span>
							</div>
						</div>
					</div>
					<div class="col-sm-2">
						<div class="form-group date">
							<label class="font-normal"> Antes de:</label>
							<div class="input-group">
								<input id="fechaFin" name="fechaFin" type="text" value="" class="form-control buscador guiaHistorialFin" disabled>
								<span class="input-group-addon" data-toggle="tooltip" data-placement="top" title="" data-original-title="Seleccionar Fecha de Fin">
									<span class="fa fa-calendar"></span>
								</span>
							</div>
						</div>
					</div>

					<div class="col-sm-4">
						<div class="form-group">
							<label class="font-normal"><span><i class="fa fa-sort-numeric-asc"></i></span> Estado:</label>
							<div class="input-group col-sm-6">
								<select class="selectpicker buscador guiaHistorialEstado" data-live-search="true" data-style="btn-success btn-outline" id="estado" title="Seleccionar un estado...">
								</select>
							</div>
						</div>
					</div>

					<div class="col-sm-4">
						<div class="form-group">
							<label class="font-normal"><span><i class="fa fa-user"></i></span> Rol:</label>
							<div class="input-group col-sm-6">
								<select class="selectpicker buscador guiaHistorialRol" data-live-search="true" data-style="btn-success btn-outline" id="rol" title="Seleccionar un rol..."> 
								</select>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="divtablaTiempos"></div>
			<div><br><br><br></div>
		</div>
	</div>
</div>

<div id="modal-historial" class="modal inmodal fade modaltext"  tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
	<div class="modal-dialog modal-lg">
		<div class="modal-content animated">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title">Control de Estados</h4>
			</div>
			<div class="modal-body" style="overflow-y:auto;">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-lg ml5" data-dismiss="modal">Cerrar</button>
			</div>
		</div>
	</div>
</div>

<!--- Guia --->
<ul id="tlyPageGuide" data-tourtitle="Tiempos.">
    <li class="tlypageguide_top" data-tourtarget=".guiaProcedimiento">
        <div> Seleccion de Procedimientos <br>
            En esta sección se encuentran los procedimientos registrados.
        </div>
    <li class="tlypageguide_top" data-tourtarget=".guiaHistorialInicio">
        <div> Filtro de fecha <br>
            Filtra los registros desde una fecha dada.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaHistorialFin">
        <div> Filtro de fecha <br>
            Filtra los registros hasta una fecha dada.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaHistorialEstado">
        <div> Filtro por estado <br>
            Filtra los registros por el estado.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaHistorialRol">
        <div> Filtro por rol <br>
            Filtra los registros por el rol.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".search">
        <div> Búsqueda <br>
            Puede realizar la búsqueda de un registro.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".export">
        <div> Exportar <br>
            Puede exportar la tabla a EXCEL.
        </div>
    </li>
    <li class="tlypageguide_left" data-tourtarget=".columns">
        <div> Mostrar o ocultar columnas <br>
            Permite la facilidad de mostrar u ocultar las columnas.
        </div>
    </li> 
    <li class="tlypageguide_bottom" data-tourtarget=".guiaControlEstados">
        <div> Control de estados <br>
            Permite ver el control de estados de ese registro.
        </div>
    </li> 
</ul>