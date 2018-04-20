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
<cfinclude template="asociacion_js.cfm">
<cfset total_records = prc.plantillas.recordcount>
<cfoutput>
<div class="container" >
	<input type="hidden" id="in-formatos" name="formatos"> 	
	<div class="row" id="cont-Allreportes">
		<div class="col-md-12">
			<div class="panel panel-primary">
			    <div class="panel-heading" id="Explicacion">					
					<a href="#event.buildLink('formatosTrimestrales.plantillas.indexAsociados')#">
						<span class="btn btn-primary btn-xs pull-right bt-cerrar-captura" title="Cerrar Encabezado" style="font-size: 22px;">
							<i class="fa fa-times"></i>
						</span>
					</a>
					<h4>Selección de Plantillas<h4>
				</div>
				<div class="panel-body">					
					<div class="row">
						<div class="col-md-4">
							<div class="alert alert-info row">
				  				<strong>Info!</strong>
				  				<br>
				  				Seleccione y arrastre las plantillas, a la zona gris:
							</div>
						</div>
						<div class="pull-right col-md-8">
						 	<div class="input-group">
								<input type="text" class="form-control" id="in-buscar" placeholder="Buscar...">
								<span class="input-group-btn">
									<button type="submit" class="btn btn-default">
										<span class="glyphicon glyphicon-search">
											<span class="sr-only">Buscar Plantillas...</span>
										</span>
									</button>
								</span>
							</div>
						</div> 
					</div>
					<div class="row">
						<div class="col-md-4">
							<div class="row">
								<div class="col-md-4">
									<h4>Plantillas Seleccionadas:</h4>
								</div>
								<div class="col-md-8">
									<button class="btn btn-primary  dim  ml5 pull-right col-md-12" id="bt-configuracion">
										<i class="fa fa-gear  success"> Asociar Elementos</i>
									</button>
								</div>
							</div>								
							<div id="asociacion" class="row contenedorDropAsociacion guia-Contenedor" style="overflow:auto;background-color:##f5f6f7; height:700px;z-index:1;">
							</div>
						</div>
						<div class="col-md-8 " > 
							<div class="row contenedorDropPlantillas" style="height:700px; overflow:auto">
								<cfloop index="x" from="1" to="#total_records#">
									<div class="col-md-6 col-sm-12 cont-reporte" name="#prc.plantillas.NOMBRE_PLANTILLA[x]#" data-rep-id="#prc.plantillas.PK_PLANTILLA[x]#">
						                <div class="ibox" data-rep-id="#prc.plantillas.PK_PLANTILLA[x]#">
						                    <div class="ibox-content el-contenido">
						                        <div class="el-descripcion pull-left">
						                            <div class="el-nombre">
														 <span>Numero de Elementos: </span><strong>#prc.plantillas.NUMERO_COLUMNA[x]#<strong>
													</div>
						                            <div class="el-cont-desc small m-t-xs">
						                               #prc.plantillas.NOMBRE_PLANTILLA[x]#
						                            </div>
						                        </div>
						                        <span class="el-copiar-rep buscarAsociados  bt-superior" data-rep-id="#prc.plantillas.PK_PLANTILLA[x]#" >
						                        	<i class="fa fa-search"></i>
						                        </span>
						                        <div class="el-vista-previa-rep " data-rep-id="#prc.plantillas.PK_PLANTILLA[x]#" title="Configurar Formatos">
						                             <i class="select-reporte fa fa-arrow-down fa-5x"></i>
						                        </div>
						                        
						                    </div>
						                </div>
						            </div>
								</cfloop>
							</div>
						</div> 
					</div>
				</div>
			</div>
		</div>
	</div>	
</cfoutput>
<div class="row">
	<div class="panel panel-primary" id="contNuevaPlantilla" style="display:none">
		<div class="panel-heading">
			<span class="btn btn-primary  btn-xs pull-right bt-cerrar-captura" title="Cerrar Encabezado" style="font-size: 22px;">
				<i class="fa fa-times"></i>
			</span>
			<strong><span id="displayNombre"><h4>Nueva plantilla</h4></span></strong>
        </div>		
		<div class="panel-body">
			<div id="divNuevaPlantilla"  style="height: 800px">
			</div>
		</div>
	</div>
</div>
	
<div class="row">
	<div class="panel panel-primary" id="contEditarPlantilla" style="display:none">
	    <div class="panel-heading">
		    <span class="btn btn-primary  btn-xs pull-right bt-cerrar-captura" title="Cerrar Encabezado" style="font-size: 22px;">
		    	<i class="fa fa-times"></i>
		    </span>
				<strong><span id="displayNombre"><h4>Plantilla:</h4></span></strong>
		</div>
		<div class="panel-body">
			<div id="divEditarPlantilla"  style="height: 800px">
			</div>				
		</div>
	</div>
</div>
	
<div class="row">
	<div class="panel panel-primary" id="contAsociacion" style="display:none">
	    <div class="panel-heading">
		    <span class="btn btn-primary  btn-xs pull-right bt-cerrar-captura" title="Cerrar Encabezado" style="font-size: 22px;">
		    	<i class="fa fa-times"></i>
		    </span>
				<strong><span id="displayNombre"><h4>Asociación de Elementos:</h4></span></strong>
		</div>
		<div class="panel-body">
			<div id="divAsociacion"  style="height: 800px">
			</div>				
		</div>
	</div>
</div>

</div>
<div id="modal-Formatos" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
  <div class="modal-dialog  modal-lg">
    <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                <h4 class="modal-title titulo"></h4>
				<br>
				<table id="tblFormatosRel" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" height="200">
				 	<thead>
				        <tr>
				            <th data-field="id" class="text-center" >id</th>         
            				<th data-field="tema" 	data-sortable="true">#</th>
				            <th data-field="formato"	data-sortable="true">Formato</th> 
				            <th data-field="claveFor"	data-sortable="true">Clave Formato</th> 
				            <th data-field="nomCol"	data-sortable="true">Nombre Columna</th>
				            <th data-field="actualizacion"	data-sortable="true">Fecha Actualizaci&oacute;n</th> 
            				<th class="text-center" data-field="accion" data-formatter="actionFormatter" data-events="actionEvents">Acciones</th>
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
<!---  ---------------(1. Primer panel selección de plantillas)------------------  --->
<ul id="tlyPageGuide" data-tourtitle="Edición de plantillas.">
	<li class="tlypageguide_top" data-tourtarget="#Explicacion">
		<div>
			La asociación de plantillas dentro del SIE fue implementada con el objetivo de mejorar y simplificar la representación de información de los reportes generados en el sistema, es a través de esta función que es posible representar fielmente la estructura de aquellas columnas que requieren por su naturaleza la clasificación de su información por subsecciones de información. Utilizando las Plantillas registradas es posible generar las “Subsecciones” específicas que requiere un reporte, dichas subsecciones pueden tener características únicas, la cual solo puede ser expresado en un reporte a través de la configuración del usuario. 
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget="#in-buscar">
		<div>Recuadro de búsqueda<br>
		En el recuadro de búsqueda puede realizar la búsqueda de plantillas específicas, conforme se introduzca el título de la plantilla la lista se irá reduciendo hasta mostrar únicamente aquellas plantillas que coincidan con el título del recuadro de búsqueda.	
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".contenedorDropPlantillas">
		<div>Contenedor de Plantillas<br>
			Listado de plantillas registradas que pueden ser elegidas para realizar una asociación de plantillas. Cada recuadro representa una plantilla, es posible consultar los datos de la plantilla seleccionando el icono <i class="fa fa-arrow-down"></i>, o visualizar la relación de reportes del sistema que utilizan dicha plantilla dando click en el botón <i class="fa fa-search"></i>. Por último, para seleccionar una plantilla para integrar una nueva asociación, seleccione el recuadro de la plantilla con el botón izquierdo del mouse y sin soltar el botón arrastre el recuadro hasta la zona gris “Plantillas seleccionadas” (Número 4). 
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guia-Contenedor">
		<div>
			El área de plantillas seleccionadas contiene aquellas plantillas candidatas a conformar una nueva asociación de plantillas, una asociación puede tener distintos niveles de clasificación, esto significa que puede estar conformada por 2 o más plantillas.
			<br>Configuración<br>
			La primera plantilla seleccionada conforma el primer nivel de subsecciones de un reporte que utiliza plantillas asociadas, de tal forma que un elemento de la plantilla 1A, puede contener 1 o más elementos de la plantilla 2B. del mismo modo al asociar 3 plantillas, un elemento de la plantilla 1A contendrá uno o más elementos de la plantilla 2B, que a su vez podrá contener uno o más elementos de la plantilla 3C de tal forma que esta agrupación de elementos permite clasificar la información del reporte de forma fidedigna cuando un reporte solicite utilizar dicha asociación de plantillas.
	</li>		
	<li class="tlypageguide_top" data-tourtarget="#bt-configuracion">		
		<div>
			Al oprimir el botón <i class="fa fa-gear  success" style="font-size:21px;"></i> se creará una “plantilla asociada” con las plantillas incluidas en la sección “Plantillas seleccionadas”.
	</li>	
	<li class="tlypageguide_top" data-tourtarget=".gia-datos">
		<div>
			Área para captura de información de la plantillas:
			<br>
			En esta area puede agregar información directamente de un archivo excel, solo necesita copiar y pegar. 
		</div>
	</li>

	<!--- -------(2. Segundo panel Distribución de elementos guardado de la asociación)----------- --->
	
	<li class="tlypageguide_top" data-tourtarget=".guia-asociacion">
		<div>
			Las plantillas con las cabeceras de las tablas y sus elementos están denotados por colores según la plantilla correspondiente.
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".elementoPadre">
		<div>
			El recuadro marcado pertenece a la plantilla denominada 1A, uno o más elementos de la plantilla ubicada al lado derecho (2B) pueden ser incluidos dentro del recuadro perteneciente a la plantilla superior, de forma que los datos de la plantilla 2B sean clasificados dentro de cada elemento de la plantilla 1A. Para asociar un elemento de la plantilla inferior a un elemento de la plantilla superior en necesario seleccionar con el botón izquierdo del mouse el recuadro del elemento a asociar, posteriormente y sin soltar el botón arrastre el recuadro del elemento y colóquelo en el recuadro de la plantilla superior,  coloque los elementos de las plantillas inferiores dentro de las plantillas superiores desplazándose con el mouse hasta formar la clasificación que necesita configurar.
		</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".nombreAsociacion">
		<div>
			Nombre de la asociación de plantillas<br>
			El recuadro sugiere de forma automática un nombre para la asociación de plantillas utilizando los nombres de las plantillas asociadas, utilizar un nombre que permita identificar a la asociación es importante ya que dicha asociación debe ser seleccionada durante la configuración de las columnas de reportes.
		</div>
	</li>			
	<li class="tlypageguide_top" data-tourtarget="#bt-guardaAsociacion">
		<div>
			Guardar Asociación<br>
			Una vez que se ha realizado la asociación de plantillas, es necesario seleccionar el botón <i class="glyphicon glyphicon-floppy-disk" style="font-size:21px;"></i> para concluir el registro de la asociación.
		</div>
	</li>	
</ul>