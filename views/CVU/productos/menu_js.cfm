<!---
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Revision
* Fecha:       22 de mayo de 2017
* Descripcion: Contenido js que sera usado por la vista de Menu
* Autor:       Gabriela Saldaña Aguilar
* ================================
--->

<cfprocessingdirective pageEncoding="utf-8"/>

<script type="text/javascript">

	function cargaTablaControl(pkProducto,revistaissn){												
		<!--- REEMPLAZAR CON VARIABLE DE COLDFUSION PARA EL CONTROL --->
		var control = true;
		if(!control){
			cargaTabla(pkProducto,revistaissn);
		}else{
			var btnHtml = '<div class="row"><div class="col-sm-4 col-sm-offset-4"><div class="btn btn-block btn-lg btn-primary" onclick="cargaTabla('+pkProducto+','+revistaissn+')"><i class="fa fa-search"></i>&nbsp;&nbsp;Mostrar Productos en esta Clasificación</div></div></div>'			
			$('#divTabla').html(btnHtml);						
		}
	}

	$(document).ready(function() {
		$("#mdlPrds").modal();
		cargaClasificaciones();
		ocultaMenuDerecho();
	});

	/*MENU DERECHO*/

	function ocultaMenuDerecho(){
		
		$("#menuDerecho").css("display","none");
	}

	function muestraMenuDerecho(){
		
		$("#menuDerecho").css("display","");
	}


	function makeContent( clasificacion, PK_clasificacion ){
		var div = "<li>" +  clasificacion + "</li>"
		return div;
	}

	function cargaClasificaciones(){
		
		$.ajax({
            type: "POST",
            url: "productos/listaClasificacion",
            success: function(data){
            	$("#divClasificacion").html(data);
            }
        });
	}

	function cargaSeleccion(pkproductop){
		muestraMenuDerecho();
		$.post('<cfoutput>#event.buildLink("CVU.productos.getSeleccion")#</cfoutput>', {
			pkPadre: pkproductop,
			vista: 1
			}, 
			function(data){
				if(data==0)
					$('#divSeleccion').html('<div class="alert alert-info"><span class="fa fa-warning"></span>Para regresar a un nivel anterior seleccione una opción en el menu de la izquerda</div><div class="alert alert-info">Para capturar un producto de clic en el boton "NUEVO PRODUCTO"</div> ');	
				else
					$('#divSeleccion').html(data);
			}
	    );	
	}

	function cargahistorial(pkPadrep){
		muestraMenuDerecho();
		$.post('<cfoutput>#event.buildLink("CVU.productos.cargahistorial")#</cfoutput>', {
			pkPadre: pkPadrep
			}, 
			function(data){
				$('#divFiltro').html( data );
			}
	    );	
	}


	<!---
    * Descripcion: Obtiene los productos hijos
    * Fecha: Octubre de 2017
    * @author: Alejandro Tovar
    --->
	function cargaTabla(pkProducto, revistaissn){		
		revistaissn = revistaissn == null ? '' : revistaissn;
		muestraMenuDerecho();
		$('#divTabla').empty();
		$.ajax({
			url: '<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.cargaProductos")#</cfoutput>',
			type: 'POST',			
			data: {
				pkProducto: pkProducto,
				revistaissn: revistaissn
			},
		})
		.done(function(data) {
			$('#divTabla').html(data);		
		});
	}

	<!---
    * Descripcion: cierra el panel de los datos de la fila
    * Fecha: Octubre de 2017
    * @author: Alejandro Tovar
    --->
	function cierraPanelCelda(){
		$("#boxesContraparte").slideToggle( 1000,'easeOutExpo');
		$("#divTabla").show();
	}

	<!---
    * Descripcion: Carga el panel para la captura de nuevos productos 
    * Fecha: Octubre de 2017
    * @author: Marco Torres
    --->
	function capNuevoProducto(pkproducto, revistaissn){
		var producto;
		if((revistaissn == 2) || (revistaissn == 1))
			producto = 84;				//producto artículos
		else{
			producto = pkproducto;
			revistaissn = 0;
		}
		muestraOcultaCaptura();
		$.post('<cfoutput>#event.buildLink("CVU.productos.cargaTabs")#</cfoutput>', {
			pkproducto: producto,
			revistaissn: revistaissn
			}, 
			function(data){
				$('#tabs-producto').html( data );
			}
	    );
	}
	
	<!---
    * Descripcion: Carga el panel para la captura de nuevos productos 
    * Fecha: Octubre de 2017
    * @author: Ana Belem Juarez
    --->
    function cargaTabs(pkPadrep, revistaissn){
    	var producto;
    	if(revistaissn == 1)
			producto = 84;				//producto artículos
		else{
			producto = pkPadrep;
			revistaissn = 0;
		}

		$.post('<cfoutput>#event.buildLink("CVU.productos.cargaTabs")#</cfoutput>', {
			pkproducto: producto,
			revistaissn: revistaissn
			}, 
			function(data){
				$('#tabs-producto').html(data);
			}
		    );	
	}
	
	function muestraOcultaCaptura(){
		$("#divNuevoProducto").slideToggle( 1000,'easeOutExpo');
		$("#divNavegacion").slideToggle( 1000,'easeOutExpo');
	}

/*MENU IZQUIERDO*/



/*MENU DERECHO*/


</script>