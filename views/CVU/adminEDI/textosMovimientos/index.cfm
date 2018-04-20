<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="index_js.cfm">
<input id="inPkMovimiento" type="hidden" value="0">
<div class="row  wrapper border-bottom white-bg page-heading">
	<div class="col-lg-10">
		<h3>Movimientos sin discriminación por estado de investigador</h3>
		<ol class="breadcrumb">
			<cfoutput>
			<li>
				<a href="#event.buildLink('inicio')#">Inicio</a>
			</li>
			<li>
				Edición de los textos del catálogo de movimientos
			</li>
			</cfoutput>
		</ol>
	</div>
	<div class="ibox float-e-margins">
	  	<div class="ibox-content">
	  		<div id="elemSolicitudes">
		    	<cfloop array="#prc.solicitudesDisponibles.getMovimientosDisponibles()#" index='movimiento'>
					<div class="col-lg-4">
			      		<div class="widget-head-color-box lazur-bg p-lg text-center">
			            	<div class="m-b-md" style="height:40px;overflow-y:hidden;">
								<div class="text-center divMovimientoNombreText<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>" id_movimiento="<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>">
									<h2 class="font-bold no-margins"><cfoutput>#movimiento.getNombre()#</cfoutput></h2>
								</div>

								<div class="input-group text-center divMovimientoNombreInput<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput> hide" id_movimiento="<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>">
                                    <input type="text" id="movimientoNombre<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>" name="movimientoNombre<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>" class="form-control" maxlength="100" value="<cfoutput>#movimiento.getNombre()#</cfoutput>" style="color: #000000; text-transform: none;">
									<span class="input-group-btn">
										<button type="button" class="btn btn-success" onclick="guardarMovimientoNombre(<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>);"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>
									</span>
								</div>
			                </div>
			            </div>
			            <div class="widget-text-box" style="height:250px;overflow-y:scroll;">
                             <div style="text-align: center;">
                                <button type="button" class="btn btn-circle btn-success botonSelNombre" id_movimiento="<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>" data-toggle="tooltip" title="Editar título del movimiento">
                                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                                </button>

                                <button type="button" class="btn btn-circle btn-success botonSelObservacion" id_movimiento="<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>" data-toggle="tooltip" title="Editar subtitulo del movimiento">
                                    <i class="fa fa-pencil-square" aria-hidden="true"></i>
                                </button>

                                <button type="button" class="btn btn-circle btn-success botonSelDescripcion" id_movimiento="<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>" data-toggle="tooltip" title="Editar descripción del movimiento" des_movimiento='<cfoutput>#movimiento.getDescripcion()#</cfoutput>'>
                                    <i class="fa fa-pencil" aria-hidden="true"></i>
                                </button>
                            </div>

                            <div class="text-center divMovimientoObservacionText<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>" id_movimiento="<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>">
                                <h4 class="media-heading"><cfoutput> #movimiento.getObservacion()#</cfoutput></h4>
                            </div>

                            <div class="input-group text-center divMovimientoObservacionInput<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput> hide" id_movimiento="<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>">
                                <input type="text" id="movimientoObservacion<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>" name="movimientoObservacion<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>" class="form-control" maxlength="100" value="<cfoutput>#movimiento.getObservacion()#</cfoutput>" style="color: #000000; text-transform: none;">
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-success" onclick="guardarMovimientoObservacion(<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>);"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                                </span>
                            </div>

                            <div><cfoutput>#movimiento.getDescripcion()#</cfoutput></div>
                            
			            </div>
			      	</div>
				</cfloop>	
			</div>

		</div>
	</div>
</div>

<div id="mdl-editarMovimientoDescripcion" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" style="z-index: 999999 !important;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="padding: 10px 30px 70px;">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: -20px;"><h1><strong>&times;</strong></h1></button>
                <h2 class="pull-left">¿Editar descripción del movimiento?</h2>
            </div>
            <div class="modal-body">
                <textarea id="inComent" name="inComent"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default ml5" class="close" data-dismiss="modal">Omitir</button>
                <button type="button" class="btn btn-success pull-right ml5" onclick="guardarMovimientoDescripcion();">Guardar</button>
            </div>
        </div>
    </div>
</div>