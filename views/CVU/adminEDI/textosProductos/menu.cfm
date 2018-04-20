<!-----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      CVU edicion productos (copia menu CVU)
* Sub modulo:  -
* Fecha:       04 de diciembre de 2017
* Descripcion: Vista donde se puede revisar la informacion de todos los productos
* Autor:       JLGC
* ================================
----->

<cfprocessingdirective pageEncoding="utf-8"/>
<cfinclude template="menu_js.cfm">
<input id="inPkProducto"       type="hidden" value="0">
<input id="inPkProductoOrigen" type="hidden" value="0">

<!--CONTENEDOR DEL MENU IZQUIERDO Y DERECHO-->
<div id="divNavegacion" class="row" style="padding-top: 20px;">
	
	<!--INICIO SECCION IZQUIERDA-->
	<div class="col-md-12 ">
		<div class="ibox float-e-margins">
		    <div class="ibox-title">
		    	<h5>Seleccione una clasificación para editar un producto</h5>
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
			<div class="row">
				<!--Seccion de apilado-->
				<div class="col-md-4">
					<div class="ibox float-e-margins">
					    <div class="ibox-title">
					    	<h5>Elementos Seleccionados</h5>
					    </div>
						<div class="ibox-content"> <!--- no-padding --->
							<div id="divFiltro">
							
							</div>			
						</div>
					</div>
				</div>	
				<!--Seccion de filtrado-->
				<div class="col-md-8">
					<div class="ibox float-e-margins">
					    <div class="ibox-title">
					    	<h5>Seleccione una opción para filtrar los productos</h5>
					    </div>
						<div class="ibox-content"> <!--- no-padding --->
							<div id="divSeleccion">
						
							</div>
						</div>
					</div>
				</div>	
			</div>
		</div>
	</div>
	<!--FIN SECCION DERECHA-->
</div>

<div id="mdl-editarProductoDescripcion" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" style="z-index: 999999 !important;">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="padding: 10px 30px 70px;">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: -20px;"><h1><strong>&times;</strong></h1></button>
                <h2 class="pull-left">¿Editar descripción del producto?</h2>
            </div>
            <div class="modal-body">
                <textarea id="inComent" name="inComent"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default ml5" class="close" data-dismiss="modal">Omitir</button>
                <button type="button" class="btn btn-success pull-right ml5" onclick="guardarProductoDescripcion();">Guardar</button>
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
</ul>					
			

