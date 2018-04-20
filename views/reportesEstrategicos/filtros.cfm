					<div class="ibox float-e-margins parametroS">
		                <div class="ibox-title">
		                    <h5>Seleccione los Parámetros del Reporte</h5>
		                    <div class="ibox-tools">
		                        <a class="collapse-link">
		                            <i class="fa fa-chevron-up"></i>
		                        </a>
		                    </div>
		                    
		                </div>
		                <div class="ibox-content">                    
		                    <fieldset  class="form-horizontal">
		                       <form id="formRE2">
	                            <div class="container-fluid">
	                                <div class="row-fluid clearfix">
	                                    <div class="col-sm-9 column">
	                                        <div class="row">
	                                            <div class="form-group">
	                                                <label class="col-sm-3 control-label">Métrica</label>
	                                                <div class="col-sm-6">
	                                                    <div id="hechos"></div>  
	                                                </div>
	                                                  
	                                                
	                                            </div>
	                                        </div>
	                                    </div>
	                                    <div class="col-sm-3">
	                                    <div class="row">
	                                                    <select class="form-control m-b singleSelect" id="operacion" name="operacion" data-title="Operación">
	                                                        <option></option>
	                                                    </select>
	                                                    </div>
	                                                </div>
	                                    
	                                    <div class="col-sm-9 column">
	                                        <div class="row">
	                                            <div class="form-group">
	                                                <label class="col-sm-3 control-label">Filas</label>     
	                                                <div class="col-sm-6">
	                                                    <select class="form-control m-b singleSelect param" id="ejeX" name="ejeX" data-title="Eje X">
	                                                        <option></option>
	                                                    </select>  
	                                                </div>
	                                            </div>
	
	                                        </div>
	                                        <div class="row">
		                                         <div class="text-center"> 
	                                       			<button class="btn btn-default  btn-outline nextBtn" id="exchange"><span class="fa fa-exchange fa-rotate-90"></span></button>
	                                        
												</div>
	                                        </div>
	                                        <div class="row">
	                                            <div class="form-group">        
	                                                <label class=" col-sm-3 control-label">Columnas</label>
	                                                <div class="col-sm-6">          
	                                                    <select class="form-control m-b singleSelect param" id="etiqueta" data-title="Clasificación">
	                                                        <option></option>
	                                                    </select>  
	                                                </div>
	                                            </div>
	
	                                        </div>
	                                    </div>
	                               	</div>
	                            </div>
	                        </form>                                                 
		                    </fieldset>
		                </div> 
		            </div>


					<form id="formRE">
        

	                    <div class="ibox float-e-margins tiempo" id="iboxTiempo">
	                        <div class="ibox-title">
	                            <h5>Periodo de consulta</h5> 
	
	                            <div class="ibox-tools">
	                                <a name="tiempo" class="clearOptions">
	                                    <i class="fa fa-eraser" title="Borrar" data-toggle="tooltip"></i>
	                                </a>
	                                <a class="collapse-link">
	                                    <i class="fa fa-chevron-up"></i>
	                                </a>
	                                
	                            </div>
	                        </div>
	                        <div class="ibox-content">
	                            <fieldset  class="form-horizontal">                                
	                                <div id="tiempo" class="tipo" data-type="0">
	                                </div>
	                            </fieldset>
	                        </div> 
	                        
	                        
	                    </div>
	
	                    <div class="ibox float-e-margins dependencia">
	                        <div class="ibox-title">
	                            <h5>Filtros de Dependencias</h5>
	                            <div class="ibox-tools">
	                                <a name="depen" class="clearOptions">
	                                    <i class="fa fa-eraser" title="Borrar" data-toggle="tooltip"></i>
	                                </a>
	                                <a class="collapse-link">
	                                    <i class="fa fa-chevron-up"></i>
	                                </a>
	                            </div>
	                            
	                        </div>
	                        <div class="ibox-content">
	                            <fieldset  class="form-horizontal">
	                                <div id="depen" class="tipo" data-type="1">
	                                </div>
	                            </fieldset>
	                        </div> 
	                    </div>
	
	                    <div class="ibox float-e-margins otros">
	                        <div class="ibox-title">
	                            <h5>Otros filtros</h5>
	                            <div class="ibox-tools">
	                                <a name="dimRes" class="clearOptions">
	                                    <i class="fa fa-eraser" title="Borrar" data-toggle="tooltip"></i>
	                                </a>
	                                <a class="collapse-link">
	                                    <i class="fa fa-chevron-up"></i>
	                                </a>
	                            </div>
	                            
	                        </div>
	                        <div class="ibox-content"> <!--- no-padding --->
	                            <fieldset  class="form-horizontal">
	                                <div id="dimRes" class="tipo" data-type="2">
	                                </div>
	                            </fieldset>
	
	                        </div>
	                    </div>   
					</form>    