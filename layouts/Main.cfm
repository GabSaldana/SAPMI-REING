<!DOCTYPE html>
<cfprocessingdirective pageEncoding="utf-8"> 
<html>
    <head>
        <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>SIIIP | IPN</title>

	    <!-- Hojas de estilo -->
	    <link rel="stylesheet" href="/includes/css/plugins/toastr/toastr.min.css"> <!--- DEBE PONERSE ANTES DE INSPINIA --->
	    <!--- <link rel="stylesheet" href="/includes/css/sisemec.css"> --->
	    <link rel="stylesheet" href="/includes/css/jquery-ui/jquery-ui.css">
	    <link rel="stylesheet" href="/includes/font-awesome/css/font-awesome.css">
	    <link rel="stylesheet" href="/includes/bootstrap/3.3.4/css/bootstrap.min.css">
	    <link rel="stylesheet" href="/includes/bootstrap/bootstrap-select/bootstrap-select.min.css">
	    <link rel="stylesheet" href="/includes/bootstrap/bootstrap-table/bootstrap-table.min.css">
	    <link rel="stylesheet" href="/includes/bootstrap/bootstrap-checkbox/bcheckbox.css">	    
	    <link rel="stylesheet" href="/includes/bootstrap/bootstrap-treeview/bootstrap-treeview.css">
	    <link rel="stylesheet" href="/includes/bootstrap/bootstrap-toggle/bootstrap-toggle.min.css">
	    <link rel="stylesheet" href="/includes/bootstrap/bootstrap-touchspin/jquery.bootstrap-touchspin.css">
	    <link rel="stylesheet" href="/includes/bootstrap/bootstrap-clockpicker/clockpicker.css">
	    <link rel="stylesheet" href="/includes/css/inspinia/animate.css">
	    <link rel="stylesheet" href="/includes/css/inspinia/style.css">
	    <link rel="stylesheet" href="/includes/css/plugins/steps/jquery.steps.css">
	    <link rel="stylesheet" href="/includes/css/plugins/pageguide/pageguide.min.css">
	    <link rel="stylesheet" href="/includes/css/plugins/datapicker/datepicker3.css">
	    <link rel="stylesheet" href="/includes/css/CVU/productos/menuproductos.css">
	    <link rel="stylesheet" href="/includes/js/plugins/vis/vis.css">
	    <link rel="stylesheet" href="/includes/js/slick/slick.css"/>
	    <link rel="stylesheet" href="/includes/js/slick/slick-theme.css"/>
  	    <link rel="stylesheet" href="/includes/js/plugins/jstree/themes/default/style.min.css" />
	    <link rel="stylesheet" href="/includes/css/plugins/sweetalert/sweetalert.css">
		<link rel="stylesheet" href="/includes/css/tablasDinamicas.css"/>
		<link rel="stylesheet" href="/includes/css/estiloChat.css"/>
		<link rel="stylesheet" href="/includes/css/plugins/select2/select2.min.css"/>
		<link rel="stylesheet" href="/includes/css/plugins/rangeSlider/ion.rangeSlider.css">
		<link rel="stylesheet" href="/includes/css/plugins/rangeSlider/ion.rangeSlider.skinFlat.css">
		<link rel="stylesheet" href="/includes/css/plugins/rangeSlider/normalize.css">
		<link rel="stylesheet" href="/includes/css/maqueta3L/maqueta3L.css">

		<cfswitch expression="#Session.cbstorage.usuario.VERTIENTE#"> 
			<cfcase value="23"><!--- CONVENIOS ---> 
				<link rel="stylesheet" href="/includes/css/convenios.css">
			</cfcase> 
			<cfcase value="1"><!--- EDI ---> 
				<link rel="stylesheet" href="/includes/css/edi.css">	
			</cfcase> 
			<cfdefaultcase></cfdefaultcase> 
		</cfswitch> 

		<!-- jQuery -->
		<script type="text/javascript" src="/includes/js/jquery/jquery-2.1.4.min.js"></script>
		<script type="text/javascript" src="/includes/js/jquery/jquery-ui/jquery-ui.min.js"></script>
		<script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.15.0/jquery.validate.min.js"></script>
		<script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.15.0/localization/messages_es.min.js"></script>
		<script type="text/javascript" src="/includes/js/jquery/nestable/jquery.nestable.js"></script>
		<script type="text/javascript" src="/includes/js/jquery/jquery-block-ui/jquery.blockUI.js"></script>	
	

		
		<!--- Bootstrap --->
		<script type="text/javascript" src="/includes/bootstrap/3.3.4/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/includes/bootstrap/bootstrap-select/bootstrap-select.min.js"></script>
	    <script type="text/javascript" src="/includes/bootstrap/bootstrap-table/bootstrap-table.min.js"></script>
		<script type="text/javascript" src="/includes/bootstrap/bootstrap-table/locale/bootstrap-table-es-MX.js"></script>
		<script type="text/javascript" src="/includes/bootstrap/bootstrap-table/extensions/accent-neutralise/bootstrap-table-accent-neutralise.js"></script>
		<script type="text/javascript" src="/includes/bootstrap/bootstrap-treeview/bootstrap-treeview.js"></script>
		<script type="text/javascript" src="/includes/bootstrap/bootstrap-toggle/bootstrap-toggle.min.js"></script>
		<script type="text/javascript" src="/includes/bootstrap/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
		<script type="text/javascript" src="/includes/bootstrap/bootstrap-clockpicker/clockpicker.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/sweetalert/sweetalert.js"></script>		

		<!-- jsPDF -->
		<script type="text/javascript" src="/includes/js/jspdf/jspdf.min.js"></script>
		<script type="text/javascript" src="/includes/js/jspdf/jspdf.plugin.autotable.src.js"></script>

		<!-- Plugins -->
		<script type="text/javascript" src="/includes/js/inspinia/inspinia.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/metisMenu/jquery.metisMenu.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/pageguide/pageguide.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/toastr/toastr.min.js"></script>	
		<script src="/includes/js/plugins/datepicker/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/vis/vis.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/jstree/jstree.min.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/steps/jquery.steps.min.js"></script>
		<script src="/includes/js/fileinput.min.js"></script>
		<script src="/includes/js/fileinput_locale_es.js"></script>
		<link rel="stylesheet" type="text/css" href="/includes/js/handsontable/handsontable0.15.0-beta6/handsontable.full.min.css">
		<script type="text/javascript" src="/includes/js/handsontable/handsontable0.15.0-beta6/handsontable.full.js"></script>
		<script type="text/javascript" src="/includes/js/tinymce/tinymce.min.js"></script>
		<script type="text/javascript" src="/includes/js/tinymce/tinymce.js"></script>
		<script type="text/javascript" src="/includes/js/tinymce/jquery.tinymce.min.js"></script>
		<script type="text/javascript" src="/includes/js/slick/slick.min.js"></script>
		<script type="text/javascript" src="/includes/js/slick/slick.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/rangeSlider/ion.rangeSlider.js"></script>

		<!--- FusionCharts --->
    	<script type="text/javascript" src="/includes/js/fusioncharts/fusioncharts.js"></script>
		<script type="text/javascript" src="/includes/js/fusioncharts/themes/fusioncharts.theme.zune.js"></script>
		<script type="text/javascript" src="/includes/js/fusioncharts/themes/fusioncharts.theme.carbon.js"></script>
		<script type="text/javascript" src="/includes/js/fusioncharts/themes/fusioncharts.theme.fint.js"></script>
		<script type="text/javascript" src="/includes/js/fusioncharts/themes/fusioncharts.theme.ocean.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/select2/select2.full.min.js"></script>	
		<script type="text/javascript" src="/includes/js/maqueta3L/maqueta3L.js"></script> 	
		<cfinclude template="Main_js.cfm">

		<style>
			.modal-content{
				max-height: 95vh;
				overflow-y: auto;
			}

			.modal-lg{
				width: 65vw;
			}

			.blink {
			    animation-duration: 3s;
			    animation-name: blink;
			    animation-iteration-count: infinite;
			    animation-timing-function: steps(2, start);
			    width: 120%;
			    margin-left: 40%;
			    opacity: .8
			}
			@keyframes blink {
			    60% {
			        visibility: hidden;
			    }
			}

			ul.breadcrumb {
			    padding: 10px 16px;
			    list-style: none;
			    background-color: #eee;
			}
			ul.breadcrumb li {
			    display: inline;
			    font-size: 18px;
			}
			ul.breadcrumb li+li:before {
			    padding: 8px;
			    color: black;
			    content: "/\00a0";
			}
			ul.breadcrumb li a {
			    color: #0275d8;
			    text-decoration: none;
			}
			ul.breadcrumb li a:hover {
			    color: #01447e;
			    text-decoration: underline;
			}

		</style>

    </head>

    <body>
    	<div id="wrapper">
        	<cfoutput>
    		<nav class="navbar-default navbar-static-side" role="navigation">
		        <div class="sidebar-collapse">
		            <ul class="nav" id="side-menu">
		                <li class="nav-header">
		                    <div class="dropdown profile-element">
                                <cfif #Session.cbstorage.usuario.GENERO# EQUAL 1>
                                	<img alt="image" class="img-circle" src="/includes/img/menu/man.png">
                                <cfelse>
                                	<img alt="image" class="img-circle" src="/includes/img/menu/woman.png">
                                </cfif>
	                            <a data-toggle="dropdown" class="dropdown-toggle">
		                            <span class="clear">
		                            	<span class="block m-t-xs"> <strong class="font-bold">  #Session.cbstorage.usuario.NOMBRE# #Session.cbstorage.usuario.AP_PAT#</strong> <b class="caret"></b>
		                             	</span>
		                             	<input type="hidden" id="username" value="#Session.cbstorage.usuario.NOMBRE# #Session.cbstorage.usuario.AP_PAT#">
		                             	<input type="hidden" id="userrol"  value="#Session.cbstorage.usuario.ROL#">  
		                         	</span>
	                         	</a>
	                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
	                                <li><a href="#event.buildLink('login.cerrarSesion')#">Cerrar sesión</a></li>
	                                <li><a data-toggle="modal" href="##mdl-desactivar" >Desactivar cuenta</a></li>
	                            </ul>     
	                            <input type="hidden" id="pkeval" value="'#Session.cbstorage.usuario.PK#'">
		                    </div>

		                    <div class="logo-element">SIIIP</div>

		                </li>
					    
					    <cfloop index="menulevel1" array="#Session.cbstorage.menu#">
					    	<cfif arrayLen(menulevel1.NIVEL2) EQ 0>
					    		<li class="#event.getActiveLink('#menulevel1.URL#')#">
				                    <a href="#event.buildLink('#menulevel1.URL#')#"><i class="#menulevel1.ICONO#"></i><span class="nav-label">#menulevel1.NOMBRE#</span></a>
				                </li>
					    	<cfelse>
					    		<li class="#event.getActiveLink('#menulevel1.URL#')#">
				                    <a onclick="agregaRuta('#event.buildLink('#menulevel1.URL#')#');"><i class="#menulevel1.ICONO#"></i><span class="nav-label">#menulevel1.NOMBRE#</span><span class="fa arrow"></span></a>
				                    <ul class="nav">
			                    		<cfloop index="menulevel2" array="#menulevel1.NIVEL2#">
			                    			<cfif arrayLen(menulevel2.NIVEL3) EQ 0>
			                    				<li class="#event.getActiveLink('#menulevel2.URL#')#">
								                    <a href="#event.buildLink('#menulevel2.URL#')#"><i class="#menulevel2.ICONO#"></i><span class="nav-label">#menulevel2.NOMBRE#</span></span></a>
								                </li>
								            <cfelse>
								               	<li class="#event.getActiveLink('#menulevel2.URL#')#">
					                    			<a onclick="agregaRuta('#event.buildLink('#menulevel1.URL#')#');">#menulevel2.NOMBRE#</a>
					                    			<ul class="nav">
						                    			<cfloop index="menulevel3" array="#menulevel2.NIVEL3#">
						                    				<li class="#event.getActiveLink('#menulevel3.URL#')#">
						                    					<a href="#event.buildLink('#menulevel3.URL#')#"><i class="#menulevel3.ICONO#"></i><span class="nav-label">#menulevel3.NOMBRE#</span></a>
						                    				</li>
									                    </cfloop>
								                    </ul>
												</li>
											</cfif>
				                    	</cfloop>
									</ul>
				                </li>
					    	</cfif>
						</cfloop>
		            </ul>
		        </div>
		    </nav>
		    </cfoutput>


			 <!--- Inicia Chat--->
			 <div class="small-chat-box fadeInRight animated">
	            <div class="heading" draggable="true">
	                <label class="tituloChat">Chat</label>
	                <div class="minimizar">
	                	<i class="fa fa-minus"></i>
	                </div>
	                <div class="adjuntar">
	                 	<label for="file">
	        			 	<i class="	glyphicon glyphicon-paperclip"></i>
	    			    </label>
	    			    <input id="file" type="file" onchange="saveFile(this);"/>
	                </div>
	            </div>
	            <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 234px;">
	             	<div class="content" style="overflow: auto; width: auto; height: 234px;"> </div>
				</div>
				<div class="process" style="overflow: auto; width: 150px; height: 320px;">
				 	<div class="heading" draggable="true">
	                	Procesos
	                </div>
				</div>
	            <div class="form-chat">
	                <div class="input-group input-group-sm msgbox">
	                	<textarea class="form-control" rows="1" cols="20" wrap="hard" id="msg" style="resize: none;"></textarea>
	                    <span class="input-group-btn"> 
	                     	<button class="btn btn-primary enviar" type="button"> 
	                     	 	<i class="fa fa-paper-plane"></i>
	                		</button> 
	                	</span>
	            	</div>
	            </div>
	        </div>
	        <div id="small-chat">
	            <span class="badge badge-success pull-right bandeja"></span>
	            <a class="open-chat">
	            	<i class="fa fa-comments"></i>
	            </a>
	        </div>
	        <cfoutput>
	        	<cfwebsocket name="myWS" onMessage="messageHandler" subscribeTo='#Session.cbstorage.subcanales#' onError="errorHandler">
	        </cfoutput>
	         <!--- Termina Chat--->


		    <div id="page-wrapper" class="gray-bg">
		        <div class="row border-bottom">
                	<nav class="navbar navbar-static-top white-bg" role="navigation" style="margin-bottom: 0">
		                <div class="navbar-header col-lg-1">
		                    <a class="navbar-minimalize minimalize-styl-2 btn btn-primary "><i class="fa fa-bars"></i> </a>
		                </div>						

						<ul class="nav navbar-top-links navbar-left">
							<br>
							<cfoutput>
			                <cfloop index="x" from="1" to="#Session.cbstorage.avisos.recordcount#">

								<div class="blink">
									<a class="btn btn-danger btn-rounded btn-block" href="#event.buildLink('#Session.cbstorage.avisos.RUTA[x]#')#">
										<i class="fa fa-info-circle"></i> 
										<b>#Session.cbstorage.avisos.NOMBRE_DESC[x]#</b>
									</a>
								</div><br>
							</cfloop>
							</cfoutput>
						</ul>

		                <ul class="nav navbar-top-links navbar-right">	
			                <li>La sesión se cerrara automáticamente en <span id='CuentaAtras'></span> minutos</li>		             
			                <li class="dropdown">
			                	<button id="guiaPaginaActual" class="btn btn-primary btn-circle btn-navbar-guia animated rubberBand"><i class="fa fa-question-circle"></i></button>
							</li>
							<cfoutput>
							<cfif not #Session.cbstorage.usuario.VERTIENTE# EQUAL 22 OR #Session.cbstorage.usuario.VERTIENTE# EQUAL 1>
			                    <li class="dropdown">
									<a class="dropdown-toggle count-info" onclick="consultarComentarios(#application.SIIIP_CTES.TIPOCOMENTARIO.TODOS#);">
										<i class="fa fa-envelope"></i>
										<span id="noVistos" class="label" style="background-color: ##f0e8c8;">#Session.cbstorage.nuevos#</span>
									</a>
								</li>
							</cfif>
							</cfoutput>
							<li class="dropdown">
								<button class="dropdown-toggle count-info btn btn-outline btn-success btn-circle btn-navbar-guia" onclick="getUsuariosMain();">
									<i class="fa fa-user"></i>
								</button>
							</li>
		                    <li>
		                    	<cfoutput>
		                        <a href="#event.buildLink('login.cerrarSesion')#">
		                            <i class="fa fa-sign-out"></i> Cerrar sesión
		                        </a>
		                        </cfoutput>
		                    </li>
		                </ul>
		            </nav>
		            <cfoutput>
			            <cfset evento = event.getCurrentView()>
			            <cfset lista = evento.Split('/')>
			            <cfset arreglo = ArrayNew(1)>
			            <cfloop from="1" to="#ArrayLen(lista)#" index="cont">
			            	<cfif NOT ((lista[cont] EQ "SAPMI") OR (cont EQ ArrayLen(lista)))>
			            		<cfset arrayAppend(arreglo,lista[cont])>
							</cfif>
						</cfloop>
			            <ul class="breadcrumb" id="rutaModuloSAPMI">
			            	<cfif ArrayLen(lista) EQ 1>
			            		<li>Inicio</li>
			            	<cfelse>
			            		<cfloop from="1" to="#ArrayLen(arreglo)#" index="elemento">
				            		<cfif elemento EQ ArrayLen(arreglo)>
				            			<li>#arreglo[elemento]#</li>
				            		<cfelse>
				            			<cfset ruta = 'SAPMI.' & arreglo[elemento]>
				            			<li><a href="#event.buildLink('#ruta#')#">#arreglo[elemento]#</a></li>
									</cfif>
								</cfloop>
							</cfif>
						</ul>
					</cfoutput>
		        </div>
		        <cfoutput>
		           	#renderView()#
		        </cfoutput>
		    </div>	
    	</div>


	    <div class="modal inmodal fade modaltext" id="mdl-desactivar" tabindex="-1" role="dialog" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		                <h4 class="modal-title">Desactivación de cuenta</h4>
		            </div>
		            <div class="modal-body">
						<p>¿Confirma que desea desactivar su cuenta de usuario?</p>
						<p><strong>Una vez inhabilitada la cuenta, su sesión se cerrará automáticamente y ya no podrá acceder al sistema.</strong></p>
		            </div>
		            <div class="modal-footer ">
		                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> No</button>
		                <button class="btn btn-success btn-lg pull-right" id="btn-desactivar"><span class="fa fa-check"></span> Sí</button>
		            </div>
		        </div>
		    </div>
		</div>


	    <div id="mdl-msjs" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-hidden="true">
		    <div class="modal-dialog" id="mdl-xl">
		        <div class="modal-content">
		        	<input id="inpkTipoComentario" type="hidden" value="">
		            <div class="modal-body"> 
		            	<div class="row">
					        <div class="col-lg-2">
					            <div class="ibox float-e-margins">
					                <div class="ibox-content mailbox-content">
					                    <div class="file-manager">
					                        <a class="btn btn-block btn-primary compose-mail">Carpetas</a>
					                        <div class="space-25"></div>

					                        <div id="arbol">					                        	
					                        	<ul class="folder-list m-b-md" style="padding: 0">							                          
					                        		<li data-toggle="tooltip" data-placement="right" title="" data-original-title="Todos los comentarios"><a onclick="consultarComentarios(0);"><i class="fa fa-comment"></i> Comentarios</a></li>
					                        		<cfif #Session.cbstorage.usuario.VERTIENTE# EQ 2>
							                          <li data-toggle="tooltip" data-placement="right" title="" data-original-title="Comentarios de Convenios"><a onclick="consultarComentarios(3);"><i class="fa fa-files-o"></i> Comentarios de Convenios</a></li>							                          
					                        		</cfif>
						                          <li data-toggle="tooltip" data-placement="right" title="" data-original-title="Comentarios de Documentos"><a onclick="consultarComentarios(6);"><i class="fa fa-file-text-o"></i> Comentario de documentos</a></li>
						                        </ul>		
					                        </div>
					                        <div class="clearfix"></div>
					                    </div>
					                </div>
					            </div>
					        </div>
					        <div class="comentarios"></div>
					    </div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
		            </div>
		        </div>	
		    <div>
		</div>

		<div id="contenedorVisorDocumentos" style="display:none;overflow:hidden;height:100%;" class="embed-responsive">	
			<div id="agregarDocto" style="height:100%">				 				
			</div>			
		</div> 

		<div class="modal inmodal fade modaltext" id="modal_comentarios_container" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog modal-lg contnido"></div>
		</div>

		<cfoutput>
			<form id="endSession" action="#event.buildLink('login.cerrarSesion')#" method="post"> </form>
		</cfoutput>

		<!--- Modal (EDITAR usuarios) --->
		<div id="mdl-admon-usuario-main" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" data-usr="<cfoutput>#Session.cbstorage.usuario.pk#</cfoutput>" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Datos del Usuario</h4>
					</div>
					<div id="admonUsuarios"> </div>
				</div>
			</div>
		</div>

		<div class="modal inmodal modaltext" id="mdl-cubrir" tabindex="-1" role="dialog" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		            </div>
		            <div class="modal-body">
						<div class="text-center">
							<img alt="" width="128" height="128" src="/includes/img/main/loading.gif"/>
							<h4>Procesando... </h4>
			        	</div>
			        </div>
		        </div>
		    </div>
		</div>
		
    </body>
</html>
