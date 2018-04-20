<!---
* =========================================================================
* IPN - CSII
* Sistema:	EVALUACION 
* Modulo:	Edicion de Plantillas para los Formatos Trimestrales  con Columna de Tipo Catalago
* Fecha:    
* Descripcion:	
* Autor: 
* =========================================================================
--->
	
<cfprocessingdirective pageEncoding="utf-8">
<link rel="stylesheet" type="text/css" href="/views/formatosTrimestrales/formatosTrimestrales.css"/>
<cfinclude template="plantillas_js.cfm">
<div class="container">
	<input type="hidden" id="in-formatos" name="formatos">
	<div class="ibox col-md-12" id="cont-Allreportes">
		<div class="ibox-title">
			<h4>Plantillas</h4>
		</div>
		<div class="ibox-content">
			<div class="row">
				<div class="col-md-4">
					<button class="btn btn-primary btn-outline pull-left dim bt-nuevoRep">
						<i class="fa fa-plus success"></i> Nueva Plantilla
					</button>
				</div>
			</div>
			<div class="row" >
				<table id="tablaFormatos" function ="getIndex" class="table table-striped table-responsive" data-page-size="5" data-pagination="true" data-search="true" data-search-accent-neutralise="true">
					<thead>
						<tr>
						<th class="text-left"	data-field="Nombre"		data-sortable="true" width="60%">Nombre</th>
						<th class="text-center" data-field="Elementos"	data-sortable="true" width="10%">Elementos</th>
						<th class="text-center" data-field="Capturar" 	data-sortable="true" width="10%">Capturar</th>
						<th class="text-center" data-field="Acciones" 	data-sortable="true" width="10%">Acciones</th>
						</tr>
					</thead>
					<cfoutput query="prc.plantillas">
						<tr>
							<td class="text-left">#NOMBRE_PLANTILLA#</td> 
							<td class="text-center">#NUMERO_COLUMNA#</td>							
							<td class="text-center">
								<button class="btn btn-primary btn-sm reporte dim btn-outline" data-rep-id="#prc.plantillas.PK_PLANTILLA#" title="Capturar">
									<i class="fa fa-pencil"></i>
								</button>
							</td> 
							<td class="text-center">
								<button class="btn btn-sm btn-info  buscarAsociados" data-rep-id="#prc.plantillas.PK_PLANTILLA#" title="Formatos">
									<i class="fa fa-search "></i> 
								</button>
								<button class=" btn btn-sm btn-primary copiar" data-repid="#prc.plantillas.PK_PLANTILLA#" data-nombre ="#prc.plantillas.NOMBRE_PLANTILLA#" title="copiar plantilla">
								<i class="fa fa-copy"></i> 
							</button>
								<button class=" btn btn-sm btn-danger eliminar " data-rep-id="#prc.plantillas.PK_PLANTILLA#" title="Eliminar">
									<i class="fa fa-trash"></i>
								</button>
							</td>				                			         
						</tr>    
					</cfoutput>
				</table>   
			</div>				
		</div>
	</div>
</div>	

<div class="row">
	<div class="panel panel-primary" id="contNuevaPlantilla" style="display:none">
		<div class="panel-heading">
			<span class="btn btn-primary btn-xs pull-right bt-cerrar-captura" title="Cerrar Encabezado" style="font-size: 22px;">
				<i class="fa fa-times"></i>
			</span>
			<h4>Nueva Plantilla:</h4>
		</div>
		<div class="panel-body">
			<div id="divNuevaPlantilla"  style="height: 800px"></div>
		</div>
	</div>
</div>
	
<div class="row">
	<div class="panel panel-primary" id="contEditarPlantilla" style="display:none">
		<div class="panel-heading">
			<span class="btn btn-primary btn-xs pull-right bt-cerrar-captura" title="Cerrar Encabezado" style="font-size: 22px;">
				<i class="fa fa-times"></i>
			</span>
			<h4>Plantilla:</h4>
		</div>
		<div class="panel-body">
			<div id="divEditarPlantilla"  style="height: 800px">
			</div>				
		</div>
	</div>
</div>

<div id="modal-Copia" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
				<h4 class="modal-title titulo">Copia de plantilla</h4>
				<br>
				<div class="col-md-4 id= ">Nombre de la nueva plantilla:</div>
				<div class="input-group">
					<input type="hidden" id="num">
					<input type="text" class="form-control" id="nombre">
					<div class="input-group-btn">
						<button type="button" class="btn btn-primary btn-xs dim pull-left ml5" style="margin-right: 15px" onclick="guardaCopia(num, nombre)">
							<i class="glyphicon glyphicon-floppy-disk" style="font-size:21px;"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="modal-Formatos" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
				<h4 class="modal-title titulo"></h4>
				<br>
				<table id="tblFormatosRel" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" height="200">
					<thead>
						<tr>
							<th data-sortable="true" data-field="id" class="text-center">id</th>         
							<th data-sortable="true" data-field="tema">#</th>
							<th data-sortable="true" data-field="formato">Formato</th> 
							<th data-sortable="true" data-field="claveFor">Clave Formato</th> 
							<th data-sortable="true" data-field="nomCol">Nombre Columna</th>
							<th data-sortable="true" data-field="actualizacion">Fecha Actualización</th> 
							<th class="text-center"  data-field="accion" data-formatter="actionFormatter" data-events="actionEvents">Acciones</th>
						</tr>
					</thead>
				</table>	
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
			</div>
		</div>
	</div>
</div>

<script>
	$('#tblplantilla').bootstrapTable();
	$('#tblFormatosRel').bootstrapTable();
	$('#tblFormatosRel').bootstrapTable('hideColumn', 'id'); 	
</script>

<!--- Guia --->
<ul id="tlyPageGuide" data-tourtitle="Edición de plantillas.">
	<li class="tlypageguide_left" data-tourtarget=".bt-nuevoRep">
		<div>Nueva plantilla<br>
			De clic en el botón <i class="fa fa-plus" style="font-size:21px;"></i> para crear una nueva plantilla.
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".search">
		<div>Buscar<br>
			En la tabla puede realizar una búsqueda por datos específicos.
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".reporte">
		<div>Capturar<br>
			De clic en el botón <i class="fa fa-pencil" style="font-size:21px;"></i> para editar la plantilla seleccionada.
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".gia-datos">
		<div>
			Área para captura de información de la plantillas: En esta área puede agregar información directamente de un archivo Microsoft Excel, sólo necesita copiar y pegar. 
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".gia-guardar-plant">
		<div>
			Escriba el nombre de la plantilla y a continuación de clic en el botón guardar.
			<i class="glyphicon glyphicon-floppy-disk" style="font-size:21px;"></i>
		</div>
	</li> 
	<li class="tlypageguide_top" data-tourtarget=".guardar">
		<div>
			Una vez concluidas sus modificaciones de clic en el botón guardar. 
			<i class="glyphicon glyphicon-floppy-disk" style="font-size:21px;"></i> para salvar sus modificaciones.
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".buscarAsociados">
		<div>Formatos asociados<br>
			De clic en el botón <i class="fa fa-search" style="font-size:21px;"></i> para ver los formatos de la plantilla seleccionada.
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".copiar">
		<div>Copiar plantilla<br>
			De clic en el botón <i class="fa fa-copy" style="font-size:21px;"></i> para copiar la plantilla seleccionada.
		</div>
	</li>  
	<li class="tlypageguide_top" data-tourtarget=".eliminar">
		<div>Eliminar plantilla<br>
			De clic en el botón <i class="fa fa-trash" style="font-size:21px;"></i> para eliminar la plantilla seleccionada.
		</div>
	</li> 
</ul>