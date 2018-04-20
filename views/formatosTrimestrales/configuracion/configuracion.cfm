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
</br>
 <div class="container" >

	<div class="row">

		<div id="cont-formato" class="col-md-12">
			<div id="cont-infoGral" class="row">
				<div class="col-md-12">
					<div class="panel-group" id="accordion">
                    	<div id="infoGeneralesPanel" class="panel panel-primary">
                           <div class="panel-heading" style="overflow:hidden">
                               <h5 class="panel-title" >
                                	<i class="btn btn-primary btn-xs pull-right" onclick="cerrarConfiguracion()" title="Editar Encabezado" style="font-size: 20px;"><i class="fa fa-times"></i> </i>
                                  	<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">Información General</a>
			            		</h5>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse in">
                                <div class="panel-body">
                                	<div id="divInfoGral">
          							</div>
								</div>
                            </div>
                        </div>
                        <div id="configGeneralesPanel" class="panel panel-primary" >
                            <div class="panel-heading" >
                                <h5 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">Configuraciones Generales</a>
                                </h5>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse">
                                <div class="panel-body">
                                	<div id="divConfigGral">
          							</div>
								</div>
                            </div>
                        </div>
                   </div>
				</div>
		    </div>
		    
			<div id="cont-vistaPrevia" class="row">
				<div class="col-md-12">
					<div id="vistaPreviaPanel" class="panel panel-success">
			            <div class="panel-heading"  style="overflow:hidden">
			            	<i class="btn btn-success btn-xs pull-right" id="vistaPreviaBtn" onclick="cargaEncabezado()" title="Editar Encabezado" style="font-size: 20px;"><i class="fa fa-edit "></i> </i>
			                <strong>
			                Vista Previa
							</strong>
			                <br>Seleccione una columna para configuración
			            </div>
			            <div class="panel-body">
			            
			            	<div id="tabla">
							</div>
						</div>
			        </div>
		        </div>
		    </div>
		    <div id="cont-config" class="row" style="display:none">
				<div class="col-md-12">
					<div class="panel panel-success">
			            <div class="panel-heading"   style="overflow:hidden">
			                 Vista de Edición
			            	<i class="btn btn-success btn-xs pull-right" onclick="cargaVistaPrevia()" title="Vista Previa" style="font-size: 20px;"><i class="fa fa-times"></i> </i>
			            </div>
			            <div class="panel-body">
			            	<div id="tablaConfig" style="height:500px" >
							</div>
						</div>
			        </div>
		        </div>
		    </div>
		</div>

		<div id="cont-columna" class="col-md-4" style="display:none" >
			<div id="columnaPanel" class="panel panel-warning">
	            <div class="panel-heading">
	                Información de columna
	            	<i class="btn btn-warning btn-xs pull-right" onclick="cerrarColumna()" title="Vista Previa" style="font-size: 18px;"><i class="fa fa-times"></i> </i>
			   </div>
	            <div class="panel-body">
	           		<div id="confColumna">
					</div>
				</div>
	        </div>
		</div>

	</div>
	
	 
</div>
