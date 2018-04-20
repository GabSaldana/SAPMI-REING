<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="opcionesClasificacion_js.cfm">

<div id="indicaciones" class="row">
	<div class="col-md-3" style="padding-left:30px">
        <div class="alert alert-info row pan-indicaciones">
			<br>
			<br>
			<div class="row">
				<div class="col-md-10">
					Los paneles de color amarillo, muestran la lista de las métricas y/o de las dimensiones que se pueden asociar a la columna seleccionada.
				</div>
				<div class="col-md-2">
					<i class="btn btn-warning btn-sm pull-right"  style="font-size: 20px;"><i class="fa fa-window-maximize"></i></i>	
				</div>				
			</div>
			<br>
			<div class="row">
				<div class="col-md-10">	
					Los paneles de color verde, muestran la lista de las métricas y/o de las dimensiones que se pueden asociar al conjunto de columnas seleccionadas.
				</div>
				<div class="col-md-2">	
					<i class="btn btn-primary btn-sm pull-right"  style="font-size: 20px;"><i class="fa fa-window-maximize"></i></i>
                </div>				
			</div>
			<br>
			<div class="row">	
				<div class="col-md-10">
					Los paneles de color azul, muestran la asociación de la métrica y/o de la dimension de la última columna seleccionada.
				</div>	
				<div class="col-md-2">
					<i class="btn btn-success btn-sm pull-right" style="font-size: 20px;"><i class="fa fa-window-maximize"></i></i>
        		</div>				
			</div>
			<br>
			<br>
		</div>
    </div>

<div class="col-md-9">
<div id="acociaciones" class="row">
    <div class="col-md-6">
        <div id="contDimensiones" class="panel panel-warning cont-dimensiones">
            <div class="panel-heading"><strong>Asociación de dimensiónes</strong></div>
            <div class="panel-body">
                <div>
                    <label class="control-label">Dimensión</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <select id="inDimension" class="form-control">     
                            <option value="0" selected="selected">Seleccione una dimensión</option>
                            <cfset total_records = prc.dimensiones.recordcount/>
                            <cfloop index="x" from="1" to="#total_records#">
                                <cfoutput><option value="#prc.dimensiones.PKDIMENSION[x]#" >#prc.dimensiones.NOMBREDIMENSION[x]#</option></cfoutput>
                            </cfloop>
                        </select>
                    </div>
                </div>
                <br>
                <div id="bx-colDim">
                    <label class="control-label">Atributos</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <select id="inColDim" class="form-control">
                        </select>
                    </div>
                </div>
                <br>
                <div id="bx-clasif">
                    <label class="control-label">Clasificación</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <select id="inClasificacion" class="form-control">
                            <option value="0" selected="selected">Seleccione una clasificación</option>
                            <cfset total_records = prc.clasificacion.recordcount/>
                            <cfloop index="x" from="1" to="#total_records#">																				
                                	<cfoutput><option value="#prc.clasificacion.PKCLASIF[x]#" >#prc.clasificacion.NOMBRECLASIF[x]#</option></cfoutput>
                            </cfloop>
                        </select>
                    </div>
                </div>
                <br>
                <div id="btn_dim" align="center">
                    <button id="asociaDimension" type="button" class="btn btn-warning" onclick="asociaDimension();"><span class="fa fa-link"></span> Asociar dimensión</button>
                </div>
            </div>
        </div>
    </div>

    

    <div class="col-md-6">
        <div id="contHechos" class="panel panel-warning cnt-hechos">
            <div class="panel-heading"><strong>Asociación de las métricas</strong></div>
            <div class="panel-body">
                <div>
                    <label class="control-label">Métrica</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <select id="inHecho" class="form-control">
                            <option value="0" selected="selected">Seleccione una métrica</option>
                            <cfset total_records = prc.hechos.recordcount/>
                            <cfloop index="x" from="1" to="#total_records#">
                                <cfoutput><option value="#prc.hechos.PKHECHO[x]#" >#prc.hechos.NOMBREHECHO[x]#</option></cfoutput>    
                            </cfloop>
                        </select>
                    </div>
                </div>
                <br>
                <div id="btn_hecho" align="center">
                    <button id="asociaHecho" type="button" class="btn btn-warning" onclick="asociaHecho();"><span class="fa fa-link"></span> Asociar métrica</button>
                </div>
            </div>
        </div>	
    </div>
</div>


<div id="actualizaciones" class="row">
    <div class="col-md-6"> 
        <div class="actualizaDimension" style="display: none;">
            <div class="panel panel-success cont-actualizar">
                <div class="panel-heading">Actualizar dimensión asociada a la columna <strong></strong></div>
                <div class="panel-body">

                    <input id="pkDimCols" type="hidden">

                    <label class="control-label">Dimensión</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <select id="inDimensionUpdate" class="form-control">     
                            <option value="0" selected="selected">Seleccione una dimensión</option>
                            <cfset total_records = prc.dimensiones.recordcount/>
                            <cfloop index="x" from="1" to="#total_records#">
                                <cfoutput><option value="#prc.dimensiones.PKDIMENSION[x]#" >#prc.dimensiones.NOMBREDIMENSION[x]#</option></cfoutput>
                            </cfloop>
                        </select>
                    </div>
                    <br>
                    <label class="control-label">Atributos</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <select id="inColDimUpdate" class="form-control">
                        </select>
                    </div>
                    <br>
                    <label class="control-label">Clasificación</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <select id="inClasificacionUpdate" class="form-control">
                            <option value="0" selected="selected">Seleccione una clasificación</option>
                            <cfset total_records = prc.clasificacion.recordcount/>
                            <cfloop index="x" from="1" to="#total_records#">
                                <cfoutput><option value="#prc.clasificacion.PKCLASIF[x]#" >#prc.clasificacion.NOMBRECLASIF[x]#</option></cfoutput>
                            </cfloop>
                        </select>
                    </div>
                    <br>
                    <div align="center">
                        <button id="actualizaDimen" type="button" class="btn btn-success" onclick="actualizaDimension();"><span class="fa fa-refresh"></span> Actualizar dimensión</button>
						<button id="desasociarDimen" type="button" class="btn btn-success" onclick="desasociarDimension();"><span class="fa fa-unlink"></span> Desasociar dimensión</button>
                    </div>  
                </div>
            </div>
        </div>
    </div>



    <div class="col-md-6">
        <div class="actualizaHecho" style="display: none;">
            <div class="panel panel-success cont-actHecho">
                <div class="panel-heading">Actualizar métrica asociada a la columna <strong></strong></div>
                <div class="panel-body">
                    <label class="control-label">Métrica</label>

                    <input id="pkHechoColm" type="hidden">

                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <select id="inHechoUpdate" class="form-control">
                            <option value="0" selected="selected">Seleccione una métrica</option>
                            <cfset total_records = prc.hechos.recordcount/>
                            <cfloop index="x" from="1" to="#total_records#">
                                <cfoutput><option value="#prc.hechos.PKHECHO[x]#" >#prc.hechos.NOMBREHECHO[x]#</option></cfoutput>    
                            </cfloop>
                        </select>
                    </div>
                    <br>
                    <div align="center">
						<button id="actualizaHecho" type="button" class="btn btn-success" onclick="actualizaHecho();"><span class="fa fa-refresh"></span> Actualizar métrica</button>
                        <button id="desasociarHecho" type="button" class="btn btn-success" onclick="desasociarHecho();"><span class="fa fa-unlink"></span> Desasociar métrica</button>
                    </div>  
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>

<div class="modal animated fadeIn" id="mdl-Add-hecho" tabindex="-1" role="dialog" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Nueva métrica</h4>
            </div>
            <div class="modal-body">
                <div>
                    <label class="control-label">Nombre de la métrica</label>
                    <div class="input-group">   
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <input type="text" id="nombreHecho" class="form-control" placeholder="Ingresar nombre de la métrica" onkeyup="this.value=this.value.replace(' ', '_')" maxlength="27"/>
                    </div>                   
                </div>
            </div>
            <div class="modal-footer ">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cerrar</button>
                <button class="btn btn-success btn-lg pull-right" onclick="guardaHecho();"><span class="fa fa-check"></span> Guardar</button>           
            </div>
        </div>
    </div>
</div>


<div class="modal animated fadeIn" id="mdl-Add-colDim" tabindex="-1" role="dialog" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Agregar columna</h4>
            </div>
            <div class="modal-body">
                <div>
                    <label class="control-label">Nombre</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <input type="text" id="inNombreCol" class="form-control" placeholder="Ingresar nombre"/>
                    </div>            
                    <br>
                    <label class="control-label">Descripción</label>
                    <div class="input-group">   
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <input type="text" id="inDescCol" class="form-control" placeholder="Ingresar descripción"/>
                    </div>
                </div>
            </div>
            <div class="modal-footer ">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cerrar</button>
                <button class="btn btn-success btn-lg pull-right" onclick="guardaColumnaDim();"><span class="fa fa-check"></span> Guardar</button>           
            </div>
        </div>
    </div>
</div>

