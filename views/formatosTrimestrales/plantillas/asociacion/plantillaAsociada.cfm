<cfprocessingdirective pageEncoding="utf-8">
<link rel="stylesheet" type="text/css" href="/views/formatosTrimestrales/formatosTrimestrales.css">
<cfinclude template="plantillaAsociada_js.cfm">
<div class="container" id="Panel1">
<input type="hidden" id="in-formatos" name="formatos">
	<div class="ibox col-md-12" id="cont-Allreportes">
		<div class="ibox-title"><h4>Plantillas Asociadas</h4></div>
		<div class="ibox-content">
			<cfoutput>
				<a href="#event.buildLink('formatosTrimestrales.plantillas.indexAsociacion')#">
					<button class="btn btn-primary btn-outline pull-left dim guia-nuevaAso">
						<i class="fa fa-plus"></i> Nueva Asociacion
					</button>
				</a>
			</cfoutput>
			<div class="ibox-content">
				<table id="tablaFormatos" class="table table-striped table-responsive" data-page-size="16" data-pagination="true" data-search="true" data-search-accent-neutralise="true">
					<thead>
						<tr>
							<th class="text-left"	data-sortable="true"  data-field="Nombre">	 Nombre</th>
							<th class="text-center" data-sortable="true"  data-field="Capturar">Capturar</th>
							<th class="text-center" data-sortable="true"  data-field="Acciones">Acciones</th>
						</tr>
					</thead>
					<cfoutput query="prc.asociaciones">
						<tr>
							<td class="text-left" >
								#nombre#
							</td>
							<td class="text-center">
								<button class="btn btn-sm btn-primary btn-outline dim editar" onclick="cargarPlantillas(#PKASOCIACION#)" title="Capturar">
									<i class="fa fa-pencil"></i>
								</button> 
							</td>
							<td class="text-center ">
								<button class="btn btn-sm btn-danger eliminar" onclick="eliminarAsociacion(#PKASOCIACION#)" title="Eliminar">
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
	<div class="panel panel-primary" id="contAsociacion" style="display:none">
		<div class="panel-heading">
			<span class="btn btn-primary btn-xs pull-right bt-cerrar-captura" title="Cerrar Encabezado" onclick="location.reload();" style="font-size: 22px;">
				<i class="fa fa-times"></i>
			</span>
				<strong><span id="displayNombre"><h4>Asociación de Elementos:</h4></span></strong>
		</div>
		<div class="panel-body">
			<div id="divAsociacion"  style="height: 800px"></div>				
		</div>
	</div>
</div>

<!--- Guia --->
<ul id="tlyPageGuide" data-tourtitle="Edición de plantillas.">
	<li class="tlypageguide_left" data-tourtarget=".guia-asociacion">
		<div>
			Las plantillas son las cabeceras de las tablas y sus elementos están denotados por colores según la plantilla correspondiente.
		</div>
	</li>
	<li class="tlypageguide_left" data-tourtarget=".guia-nuevaAso">
		<div>Nueva Asociación<br>
			De clic en el botón <i class="fa fa-plus" style="font-size:21px;"></i> para crear una nueva asociación de plantillas.
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".search">
		<div>Buscar<br>
			En la tabla puede realizar una búsqueda por datos específicos.
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".editar">
		<div>
			De clic en el botón <i class="fa fa-pencil" style="font-size:21px;"></i> para editar la asociación seleccionada.
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".eliminar">
		<div>
			De clic en el botón <i class="fa fa-trash" style="font-size:21px;"></i> para eliminar la plantilla seleccionada.
		</div>
	</li>

	<!--- -------------(Panel asociación color verde)------------ ------------- --->
	<li class="tlypageguide_top" data-tourtarget=".nombreAsociacion">
		<div>
			Escriba en el recuadro el nombre de la plantilla. 
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guardar">
		<div>
			Al seleccionar el botón <i class="glyphicon glyphicon-floppy-disk" style="font-size:21px;"></i> se guardarán las modificaciones realizadas a la  asociación de plantillas.
	</li>
/ul>