<!DOCTYPE html>
<cfprocessingdirective pageEncoding="utf-8">
<html>
    <head>
        <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">

	    <title>PDI | IPN</title>

	    <!-- Hojas de estilo -->

		<link rel="stylesheet" href="/includes/css/jquery-ui/jquery-ui.css">
	    <link rel="stylesheet" href="/includes/font-awesome/css/font-awesome.css">
	    <link rel="stylesheet" href="/includes/css/plugins/toastr/toastr.min.css">

	    <link rel="stylesheet" href="/includes/bootstrap/3.3.4/css/bootstrap.min.css">
	    <link rel="stylesheet" href="/includes/bootstrap/bootstrap-select/bootstrap-select.min.css">
	    <link rel="stylesheet" href="/includes/bootstrap/bootstrap-table/bootstrap-table.min.css">
	    <link rel="stylesheet" href="/includes/bootstrap/bootstrap-treeview/bootstrap-treeview.css">
	    <link rel="stylesheet" href="/includes/bootstrap/bootstrap-toggle/bootstrap-toggle.min.css">
	    <link rel="stylesheet" href="/includes/bootstrap/bootstrap-checkbox/bcheckbox.css">
	    <link rel="stylesheet" href="/includes/css/inspinia/animate.css">
	    <link rel="stylesheet" href="/includes/css/inspinia/style.css">
	    <!--- <link rel="stylesheet" href="/includes/css/plugins/iCheck/custom.css">
	     --->
	    <link rel="stylesheet" href="/includes/css/plugins/steps/jquery.steps.css">
	    <link rel="stylesheet" href="/includes/css/plugins/pageguide/pageguide.min.css">

		<link href="/includes/css/plugins/datapicker/datepicker3.css" rel="stylesheet">
		
		<link rel="stylesheet" type="text/css" href="/includes/css/tablasDinamicas.css"/>

		<link rel="stylesheet" href="/includes/js/slick/slick.css"/>
  	    <link rel="stylesheet" href="/includes/js/slick/slick-theme.css"/>
  	    <link rel="stylesheet" href="/includes/css/estiloChat.css"/>

		
	    <!-- jQuery -->
		<script type="text/javascript" src="/includes/js/jquery/jquery-2.1.4.min.js"></script>
		<script type="text/javascript" src="/includes/js/jquery/jquery-ui/jquery-ui-1.11.4.min.js"></script>
		<script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.14.0/jquery.validate.min.js"></script>
		<script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.14.0/localization/messages_es.min.js"></script>
		<script type="text/javascript" src="/includes/js/jquery/nestable/jquery.nestable.js"></script>
		
		<!--- Bootstrap --->
		<script type="text/javascript" src="/includes/bootstrap/3.3.4/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/includes/bootstrap/bootstrap-select/bootstrap-select.min.js"></script>
    	<script type="text/javascript" src="/includes/bootstrap/bootstrap-table/bootstrap-table.min.js"></script>
		<script type="text/javascript" src="/includes/bootstrap/bootstrap-table/locale/bootstrap-table-es-MX.js"></script>
		<script type="text/javascript" src="/includes/bootstrap/bootstrap-table/extensions/accent-neutralise/bootstrap-table-accent-neutralise.js"></script>
		<script type="text/javascript" src="/includes/bootstrap/bootstrap-treeview/bootstrap-treeview.js"></script>
		<script type="text/javascript" src="/includes/bootstrap/bootstrap-toggle/bootstrap-toggle.min.js"></script>
		<!--- <script type="text/javascript" src="/includes/js/plugins/iCheck/icheck.min.js"></script>
		 --->	
		<!-- jsPDF -->
		<script type="text/javascript" src="/includes/js/jspdf/jspdf.min.js"></script>
		<script type="text/javascript" src="/includes/js/jspdf/jspdf.plugin.autotable.src.js"></script>
		
		
		<!-- Plugins -->
		<script type="text/javascript" src="/includes/js/inspinia/inspinia.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/metisMenu/jquery.metisMenu.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/pageguide/pageguide.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/toastr/toastr.min.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/vis/vis.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/steps/jquery.steps.min.js"></script>		

		<script src="/includes/js/plugins/datepicker/bootstrap-datepicker.js"></script>
		<script src="/includes/js/plugins/datepicker/locales/bootstrap-datepicker.es.js"></script>
		<link rel="stylesheet" type="text/css" href="/includes/js/handsontable/handsontable0.15.0-beta6/handsontable.full.min.css">
		<script type="text/javascript" src="/includes/js/handsontable/handsontable0.15.0-beta6/handsontable.full.js"></script>
		<script type="text/javascript" src="/includes/js/tinymce/tinymce.js"></script>
		<script type="text/javascript" src="/includes/js/slick/slick.min.js"></script>
		<script type="text/javascript" src="/includes/js/slick/slick.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/redipsTable/redips-table.js"></script>

		<!-- iCheck -->
    	<script src="/includes/js/inspinia/plugins/iCheck/icheck.min.js"></script>

    	<!--- FusionCharts --->
    	<script type="text/javascript" src="/includes/js/fusioncharts/fusioncharts.js"></script>
		<script type="text/javascript" src="/includes/js/fusioncharts/themes/fusioncharts.theme.zune.js"></script>	
		<script type="text/javascript" src="/includes/js/fusioncharts/themes/fusioncharts.theme.carbon.js"></script>	
		<script type="text/javascript" src="/includes/js/fusioncharts/themes/fusioncharts.theme.fint.js"></script>	
		<script type="text/javascript" src="/includes/js/fusioncharts/themes/fusioncharts.theme.ocean.js"></script>	

		
    	<cfinclude template="Main_js.cfm">

    </head>

    <!--- <body class="boxed-layout"> --->
    <body class="skin-4">
    	<div id="wrapper">        
        	<cfoutput>
    		<nav class="navbar-default navbar-static-side" role="navigation">
		        <div class="sidebar-collapse">
		            <ul class="nav" id="side-menu">
		                <li class="nav-header">

		                    <div class="dropdown profile-element">
		                            <!--- <span> --->
		                                <!--- <img alt="image" style="width:105px" src="/includes/img/logo/LogoSII_mini.png"> --->
		                           
		                               <!---  <cfif #Session.cbstorage.usuario.GENERO# EQUAL 1>	 --->
		                                	<img alt="image" class="img-circle" src="/includes/img/menu/man.png">
		                              <!---   <cfelse>
		                                	<img alt="image" class="img-circle" src="/includes/img/menu/woman.png">
		                                </cfif> --->
		                            <!--- </span> --->
		                            <a data-toggle="dropdown" class="dropdown-toggle" href="">
			                            <span class="clear"> 			                            	
			                            	<span class="block m-t-xs"> <strong class="font-bold">  #Session.cbstorage.usuario.NOMBRE# #Session.cbstorage.usuario.AP_PAT#</strong> <b class="caret"></b>
			                             	</span>   
			                             	<input type="hidden" id="username" value="#Session.cbstorage.usuario.NOMBRE# #Session.cbstorage.usuario.AP_PAT#">
			                             	<input type="hidden" id="userrol" value="#Session.cbstorage.usuario.ROL#">
			                         	</span> 
			                         	
		                         	</a>
		                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
		                                <li><a href="#event.buildLink('login.cerrarSesion')#">Cerrar Sesión</a></li>
		                                <li><a data-toggle="modal" href="##mdl-desactivar" >Desactivar cuenta</a></li>
		                            </ul>		                        
		                    </div>
		                    <div class="logo-element">
		                        PDI
		                    </div>
		                </li>

		                <cfloop index="x" from="1" to="#Session.cbstorage.menu.recordcount#">
							<cfif ((#Session.cbstorage.menu.ICON[x]# NEQ '') AND (#Session.cbstorage.menu.URL[x]# NEQ ''))>
								<li>
				                    <a href="#event.buildLink('#Session.cbstorage.menu.URL[x]#')#"><i class="#Session.cbstorage.menu.ICON[x]#"></i><span class="nav-label">#Session.cbstorage.menu.MODULO[x]#</span></a>
				                </li>
							<cfelseif (#Session.cbstorage.menu.ICON[x]# NEQ '')>
								<li>
				                    <a><i class="#Session.cbstorage.menu.ICON[x]#"></i><span class="nav-label">#Session.cbstorage.menu.MODULO[x]#</span><span class="fa arrow"></span></a>
				                    <ul class="nav nav-second-level">
				                    	<cfloop index="m" from="1" to="#Session.cbstorage.menu.recordcount#">
				                    		<cfif #Session.cbstorage.menu.CVE[x]# EQ #Session.cbstorage.menu.FK_MODULO[m]#>
				                    			<li><a href="#event.buildLink('#Session.cbstorage.menu.URL[m]#')#">#Session.cbstorage.menu.MODULO[m]#</a></li>
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

		                <!--- imagen pendiente a modificar ubicacion <div class="col-lg-4">
		                	<img   alt="image" src="/includes/img/logo/IPN.png">
		                </div> --->
		                
		                <ul class="nav navbar-top-links navbar-right">
		                    <!--- <img  alt="image" src="/includes/img/logo/IPN.png"> --->
		                     <li>
								 <small><span class="fa fa-book" style="color: ##0174DF;"></span><a href="http://148.204.106.69:8080/REPOSITORIO_DATOS_SESION/index.html" target="_blank"> Documentos de Consulta</a></small>
							</li>
		                    
		                    <li>
								 <button id="guiaPaginaActual" class="btn btn-outline btn-success btn-circle" style="padding: 0px 0px !important; margin-top: -5px; font-size: 16px !important;"><i class="fa fa-question"></i></button>
							</li>
							<li>
								<button class="btn btn-outline btn-success btn-circle" style="padding: 0px 0px !important; margin-top: -5px; font-size: 16px !important;" onclick="getUsuariosMain();">
									<i class="fa fa-user"></i>
								</button>
							</li>
		                    <li>
								<a class="dropdown-toggle count-info" onclick="consultarComentarios(<cfoutput>#application.SIE_CTES.TIPOCOMENTARIO.TODOS#</cfoutput>);">
									<i class="fa fa-envelope"></i>
									<span id="noVistos" class="label label-primary"></span>
								</a>
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

		<cfoutput>
		    <form id="endSession" action="#event.buildLink('login.cerrarSesion')#" method="post">
		    </form>
		</cfoutput>
		<div class="modal inmodal fade modaltext" id="mdl-cubrir" tabindex="-1" role="dialog" aria-hidden="true">
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


		<div id="mdl-msjs" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-hidden="true">
		    <div class="modal-dialog" id="mdl-xl">
		        <div class="modal-content">
		        	<input id="inpkTipoComentario" type="hidden" value="">
		            <div class=""> 
		            	<div class="row">
					        <div class="col-lg-2">
					            <div class="ibox float-e-margins">
					                <div class="ibox-content mailbox-content">
					                    <div class="file-manager">
					                        <a class="btn btn-block btn-primary compose-mail">Carpetas</a>
					                        <div class="space-25"></div>

					                        <div id="arbol"></div>

					                        <div class="clearfix"></div>
					                    </div>
					                </div>
					            </div>
					        </div>

					        <div class="comentarios"></div>

					    </div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" onclick="cerrarComentarios();">Cerrar</button>
		            </div>
		        </div>	
		    </div>
		</div>

		<!--- Modal (EDITAR usuarios) --->
		<div id="mdl-admon-usuario-Main" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" data-usr="<cfoutput>#Session.cbstorage.usuario.pk#</cfoutput>" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title">Editar Usuarios</h4>
					</div>
					<div class="modal-body" id="admonUsuarios-Main">
					</div>
				</div>
			</div>
		</div>

	</body>
</html>   
