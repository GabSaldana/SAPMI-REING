<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="index_js.cfm"><style type="text/css">
	.content{
		height: 75vh !important;
		overflow: auto !important;
	}
	.tabcontrol > .content > .body {
		width: 100%;
	}
</style>
<div class="row  wrapper border-bottom white-bg page-heading">
	<div class="col-lg-10">
		<ol class="breadcrumb">
			<cfoutput>
			<li>
				<a href="#event.buildLink('inicio')#">Inicio</a>
			</li>
			<li>
				Solicitud al programa EDI
			</li>
			</cfoutput>
		</ol>
	</div>
	<div class="ibox float-e-margins">
	  	<div class="ibox-content">
	  		<div class="animated shake">
	  		<h3><cfoutput>Estado del investigador en el programa: <span style="color:red;" >#PRC.estatus.estado[1]#</span></cfoutput></h3>
			</div>
			<div id="elemSolicitudes">
		    	<cfloop array="#prc.solicitudesDisponibles.getMovimientosDisponibles()#" index='movimiento'>
					<div class="col-lg-4">
			      		<div class="widget-head-color-box lazur-bg p-lg text-center">
			            	<div class="m-b-md"  style="height:40px;overflow-y:hidden;">
			                	<h2 class="font-bold no-margins"><cfoutput> #movimiento.getNombre()#</cfoutput></h2>
			                </div>
			                <span class="fa fa-sign-in fa-3x"></span>
			            </div>
			            <div class="widget-text-box" style="height:250px;overflow-y:hidden;">
			            	<h4 class="media-heading"><cfoutput> #movimiento.getObservacion()# </cfoutput></h4>
			                <p style="text-align: justify;text-justify: inter-word;height:150px;overflow-y:auto;">
			                	<cfoutput> #movimiento.getDescripcion()#</cfoutput>
	                    	<br>
	                    	<br>
				                <cfif listFind(movimiento.getACCIONESCVE(),'solicEDI.verCNRL','$')>
			                    	<br>
			                    	<button type="button" class="btn btn-danger pull-right" pkMovimiento="<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>" id="getCartaRelacionLaboral"><span class="fa fa-file"></span> Carta de <b>NO</b> Relaci&oacuten laboral</button>
				                </cfif>
						<button type="button" class="btn btn-primary btn-autoevaluacion"><span class="fa fa-check-square-o"></span> Autoevaluación </button>
			                    	<button type="button" class="btn btn-danger pull-right getReporteResultados" pkMovimiento="<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>"><span class="fa fa-file"></span> Reporte de Resultados</button>
			                </p>

			                <div class="text-right" val-pkMov="<cfoutput>#movimiento.getPK_Movimiento()#</cfoutput>">
			                  	<cfif listFind(movimiento.getACCIONESCVE(),'solicEDI.elimina','$')>
			                    	<a class="btn btn-xs btn-danger btn-outline" onclick="cambiarEstado('solicEDI.elimina',<cfoutput>#movimiento.getPKASPIRANTEPROCESO()#</cfoutput>);"><i class="fa fa-trash"></i> Cancelar</a>
			                    </cfif>
			                    <a class="btn btn-xs btn-info  btn-outline bt-GetResumen"><i class="fa fa-search" ></i>Requisitos</a>
		                      	<a class="btn btn-xs btn-primary"><i class="fa fa-search"></i> Seguimiento</a>
			                    <cfif listFind(movimiento.getACCIONESCVE(),'solicEDI.edita','$')>
		                      		<a class="btn btn-xs btn-primary btn-outline bt-solicitud"><i class="fa fa-edit"></i> Editar</a>
		                      	<cfelse>
		                      		<a class="btn btn-xs btn-primary btn-outline bt-solicitud"><i class="fa fa-edit"></i> Aplicar </a>
		                      	</cfif>
		                      	<span class="pull-left badge"> <cfoutput>#movimiento.getNomEdo()#</cfoutput></span>
			                </div>
			            </div>
			      	</div>
				</cfloop>	
				<!--- INI Registro de solicitudes al comite --->
				<div class="col-lg-4">
		      		<div class="widget-head-color-box navy-bg p-lg text-center">
		            	<div class="m-b-md"  style="height:40px;overflow-y:hidden;">
		                	<h2 class="font-bold no-margins">Otras solicitudes al comité</h2>
		                </div>
		                <span class="fa fa-sign-in fa-3x"></span>
		            </div>
		            <div class="widget-text-box" style="height:250px;overflow-y:hidden;">
		            	<h4 class="media-heading"><cfoutput> Otras solicitudes al comité </cfoutput></h4>
		                <p style="text-align: justify;text-justify: inter-word;height:150px;overflow-y:auto;">
		                
		                </p>
		                <div class="text-right">
		                  	<a class="btn btn-xs btn-primary btn-outline bt-comite"><i class="fa fa-edit"></i> Nueva solicitud </a>
		                </div>
		            </div>
		      	</div>
		      	<!--- FIN Registro de solicitudes al comite --->

		      	<cfif prc.recursoIn NEQ 0>
		      		<div class="col-lg-4">
			      		<div class="widget-head-color-box yellow-bg p-lg text-center">
			            	<div class="m-b-md"  style="height:40px;overflow-y:hidden;">
			                	<h2 class="font-bold no-margins">Recurso de inconformidad</h2>
			                </div>
			                <span class="fa fa-sign-in fa-3x"></span>
			            </div>
			            <div class="widget-text-box" style="height:250px;overflow-y:hidden;">
			            	<h4 class="media-heading">Solicitud al recurso de inconformidad</h4>
			                <p style="text-align: justify;text-justify: inter-word;height:150px;overflow-y:auto;">
			                	Fecha limite para aplicar al recurso de inconformidad <b><cfoutput>#prc.recursoIn#</cfoutput></b>
							<br><br><br><br>
								<cfif #prc.edoAsporc.CESESTADO[1]# EQ #application.SIIIP_CTES.ESTADO.APLICO_RI#>
									<span class="alert alert-success">
										<strong>Aplicó RI</strong>
									</span>
								<cfelse>
									<span class="alert alert-warning">
										<strong>No aplicó RI</strong>
									</span>
								</cfif>
							</p>
			                <div class="text-right">
			                  	<a class="btn btn-xs btn-primary btn-outline bt-inconformidad"><i class="fa fa-edit"></i> Nueva solicitud </a>
			                </div>
			            </div>
			      	</div>
		      	</cfif>
			</div>
			
			<div class="row divevaluacionInvr" id="panelSolicitud" style="display: none;">
				<div class="panel panel-primary panel-collapse collapse in ">
					<div class="panel-heading">
						<span class="fa fa-graduation-cap"></span> Captura de solicitud
						<i class="btn btn-primary btn-xs cierraSolicitud pull-right guiacierraSolicitud" data-toggle="tooltip" title="Cerrar Solicitud"><i class="fa fa-times"></i></i>
					</div>
					<div id="divevaluacionInvr" class="panel-collapse collapse in" aria-expanded="true" style="">
						<div class="panel-body">
							<div id="divSolicitud"></div>
						</div>
					</div>
				</div>
			</div>
			<div class=" col-lg-8 pull-right" id="boxesContraparte" style="display:none; width:100%; margin: auto;">
      			<div class="panel panel-primary" style="margin:0px -15px 85px -15px;">
        			<div class="panel-heading"> Edición del producto seleccionado
            			<span class="btn btn-primary btn-xs pull-right guiaCierraEdit" data-toggle="tooltip" title="cerrar" onclick="cierraPanelCelda();">
                        	<i class="fa fa-times"></i>
                  		</span>
        			</div>
        		<div class="panel-body">
        			<div class="text-right"> <font color="#BEAF19">Los campos con (*) son requeridos para EDI </font></div>
            		<div id="formularioLlenado"></div>
            	</div>
    			</div>
			</div>

			<div class="row" id="panelComite" style="display: none;">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<span class="fa fa-graduation-cap"></span> Solicitud al comite
						<i class="btn btn-primary btn-xs cierraComite pull-right" data-toggle="tooltip" title="Cerrar Solicitud al comite"><i class="fa fa-times"></i></i>
					</div>
					<div class="panel-body">
						<div id="divComite"></div>
					</div>
				</div>
			</div>
			
			<div class="row" id="panelAutoEvaluacion" style="display: none;">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<span class="fa fa-check-square-o"></span> AutoEvaluación
						<i class="btn btn-primary btn-xs cierraAutoevaluacion pull-right " data-toggle="tooltip" title="Cerrar AutoEvaluación"><i class="fa fa-times"></i></i>
					</div>
					<div class="panel-body">
						<div id="divAutoevaluacion"></div>
					</div>
				</div>
			</div>

			<div class="row" id="panelInconformidad" style="display: none;">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<div id="divTotElements" class="h4"></div>
						<i class="btn btn-primary btn-xs cierraInconformidad pull-right" style="margin-top: -35px;" data-toggle="tooltip" title="Cerrar inconformidad"><i class="fa fa-times fa-2x"></i></i>
					</div>
					<div class="panel-body">
						<div id="divInconformidad"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal inmodal modaltext" id="modal-requisito" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" style="width:75%;">
        <div class="modal-content" >
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
				<div id="divRequisitos"></div>
	        </div>
        </div>
    </div>
</div>


<div class="modal fade" id="mdlMovs" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Solicitud al programa EDI</h4>
			</div>
			<div class="modal-body">
				<img src="/includes/img/login/aplicacionEDI.jpg" width="300" height="300" class="img-responsive center-block"/><br>
				<h3 class="text-center" style="color:red">AVISO IMPORTANTE</h3>
				<h3 class="text-center">
					Antes de iniciar la solicitud al Programa EDI, es necesario terminar la etapa de migración, revisión y actualización de productos en el CVU. 
					</br></br>Es importante revisar el detalle de su productividad debido a que ya no será necesario hacer una clasificación de productos. 
			</div>
			<div class="modal-footer">
			  	<button type="button" class="btn btn-success" data-dismiss="modal">Cerrar</button>
			</div>
		</div>
	</div>
</div>