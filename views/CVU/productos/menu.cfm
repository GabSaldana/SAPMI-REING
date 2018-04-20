<!-----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      CVU
* Sub modulo:  -
* Fecha:       17 de octubre de 2017
* Descripcion: Vista donde se puede revisar la informacion de todos los productos
* ================================
----->

<cfprocessingdirective pageEncoding="utf-8"/>
<cfinclude template="menu_js.cfm">

<style type="text/css">
	#steps-producto>.content {
		margin: 0px 0px 15px 0px !important
	}
	#steps-producto>.content>section {
		width: 97% !important;
    	height: 100% !important;
    	padding: 10px 0px 0px 10px !important;
	}
</style>

<div class="modal fade" id="mdlPrds" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Migración de productos</h4>
			</div>
			<div class="modal-body">
				<img src="/includes/img/login/migdocs.jpg" width="300" height="300" class="img-responsive center-block"/><br>
				<h3 class="text-center" style="color:red">AVISO IMPORTANTE</h3>
				<h3 class="text-center">Los productos capurados en convocatorias anteriores aún están en proceso de migración.</h3>
			</div>
			<div class="modal-footer">
			  	<button type="button" class="btn btn-success" data-dismiss="modal">Cerrar</button>
			</div>
		</div>
	</div>
</div>


<!--CONTENEDOR DEL MENU IZQUIERDO Y DERECHO-->
<div id="divNavegacion" class="row" >
	
	<!--INICIO SECCION IZQUIERDA-->
	<div class="col-md-12 " >
		<div class="ibox ajustado" style="padding-top: 10px;">
		    <div class="ibox-title">
		    	<h5>Seleccione una clasificación para capturar un nuevo producto</h5>
		    	<div class="ibox-tools">
		    		<a class="collapse-link">
		    			<i class="fa fa-chevron-down fa-lg"></i>
		    		</a>
		    	</div>
		    </div>
			<div id="clasdesc" class="ibox-content"> <!--- no-padding --->
				<div id="divClasificacion">
					
				</div>	
			</div>
		</div>
	</div>
	<!--FIN SECCION IZQUIERDA-->

	<!--INICIO SECCION DERECHA-->
	<div class="col-md-12">
		<div id="menuDerecho">
			<!--Navegación-->
			<div class="row" >
				<!--Seccion de apilado-->
				<div class="col-md-4">
					<div class="ibox ajustado" >
					    <div class="ibox-title">
					    	<h5>Elementos Seleccionados</h5><div class="text-right"><button type="button" class="btn btn-primary btn-outline btn-addNuevoProducto guiaAgregarProducto" id="eleNuevo2"> <span class="glyphicon glyphicon-plus"></span> NUEVO PRODUCTO</button></div>
					    </div>
						<div class="ibox-content"> <!--- no-padding --->
							<div id="divFiltro">
							
							</div>			
						</div>
					</div>
				</div>	
				<!--Seccion de filtrado-->
				<div class="col-md-8">
						<div class="ibox ajustado" >
						    <div class="ibox-title">
						    	<h5>Seleccione una opción para filtrar los productos capturados</h5>
						    </div>
							<div class="ibox-content"  style="padding-bottom:0px;"> <!--- no-padding --->
								<div id="divSeleccion">
							
								</div>			
							</div>
						</div>
				</div>	
			</div>
			<!--Seccion de tablas o formularios-->
			<div class="row contenido">
				<div class="col-md-12 ">
					<div class="ibox ajustado">
						    <div class="ibox-title guiaProductos">
						    	<h5>Productos capturados para el rubro seleccionado</h5>
						    	<button class="btn cierra-listasT" style="margin-top: -10px; margin-left: 10px;">Expandir/Cerrar Todos&nbsp;&nbsp;<span class="fa fa-minus"></span></button>
								<div class="input-group pull-right mail-search col-md-12">
									<input id="buscar_inv" class="form-control input-sm" name="search" placeholder="Buscar" type="text" onkeyup="busquedaInv()" style="margin-top: -8px;">
								</div>
						    </div>
							<div class="ibox-content"> <!--- no-padding --->
								<div id="divSeleccion">
									<div id="divTabla">
									</div>
					
									<div class="row" id="boxesContraparte" style="display:none; width:100%; margin: auto;">
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
								</div>
							</div>
					</div>
				</div>	  
			</div> 	
		</div>
	</div>
	<!--FIN SECCION DERECHA-->
</div>

<div id="divNuevoProducto" class="row" style="display:none;">
	<input type="hidden" id="issnPrecargados">
	<input type="hidden" id="anio_issnPrecargados">
	<div class="ibox">
		<div class="ibox-title ">
	    	<h5>Captura de Nuevos Productos</h5>
	    </div>
		<div class="ibox-content"> <!--- no-padding --->
			<div id="tabs-producto">
			</div>
		</div>
	</div>
</div>

<!--Elementos de la guia-->
<ul id="tlyPageGuide" data-tourtitle="Cómo añadir un nuevo producto de investigacion.">

    <li class="tlypageguide_top" data-tourtarget="#divClasificacion">
        <div>
			Clasificación de productos segun el sistema de Evaluación EDI<br>
          	Para ver los productos capturados o dar de alta un nuevo producto de investigación, elige alguna de las clasificaciónes siguientes.
        </div>
    </li>
	<li class="tlypageguide_bottom" data-tourtarget=".collapse-link">
        <div>
			Clasificación de productos segun el sistema de Evaluación EDI<br>
          	Para ver el listado de clasificación de productos, de clic en esta elemento.
        </div>
    </li>
	<li class="tlypageguide_bottom" data-tourtarget=".tarjetaFiltro">
        <div>
		  	Menú de navegación<br>
          	Seleccione alguno de los elementos mostrados para regresar a ese nivel.
        </div>
    </li>
     <li class="tlypageguide_bottom" data-tourtarget=".tarjetaProducto">
        <div>
		  	Catálogo de productos segun el sistema de Evaluación EDI<br>
          	Selecciona las opciones disponibles  para navegar a traves del catálogo de productos, cada rubro que elijas aparecerá a tu izquierda.
        	</br><a class="fa fa-warning"></a> Note que los productos se muestran de acuerdo a la selección de estos elementos.
		</div>
    </li>

	
    <li class="tlypageguide_top" data-tourtarget=".guiaProductos">
        <div>
		 	Productos Capturados<br>
          	Aquí se muestran todos los productos capturados en el último rubro seleccionado.
        	</br><a class="fa fa-warning"></a> Verifique la seccion "Elementos seleccionados" para saber el rubro actual en que se encuentra.
        </div>
    </li>
	
	
    

	<li class="tlypageguide_bottom" data-tourtarget=".guiaAgregarProducto">
        <div>
		  	Captura de nuevos productos<br>
          	Al dar clic en este boton, el sistema abrira el menú de captura, en el nivel actual de selección.
        </div>
    </li>

	<li class="tlypageguide_bottom" data-tourtarget=".guiaRuta">
        <div>
		  	Clasificación del producto<br>
          	En esta sección nos muestra la clasificacón del producto.
        </div>
    </li>
	<!--- edicion de productos --->
	<li class="tlypageguide_bottom" data-tourtarget=".guiaEditProd">
        <div>
		  	Edición del producto<br>
          	De clic para editar la información del producto.
        </div>
    </li>
	<li class="tlypageguide_bottom" data-tourtarget=".guiaCierraEdit">
        <div>
		  	Edición de productos<br>
          	Al dar clic en este elemento cerrara la vista de Edición.
        	</br><a class="fa fa-warning"></a> Los cambios no guardados se perderan.
		</div>
    </li>
	
</ul>					
			

