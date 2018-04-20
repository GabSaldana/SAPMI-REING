<cfprocessingdirective pageEncoding="utf-8">

<cfset total_records = prc.opcionesProductos.recordcount>
	<cfset i=0>
	<cfset size=3>
	<cfset number_of_rows = ceiling(total_records / size)  >
<div>	
	<cfloop index="current" from="1" to="#number_of_rows#" >
		<div class="row" id="opcionProductos">
			<cfloop index="x" from= "#i+1#" to="#i+size#" step="1">
				<cfif prc.opcionesProductos.PRODUCTO[x] neq "">
					<div class="col-md-4 col-xs-6" style="padding:3px;padding_bottom:0px;">
						<div class="contact-box primary tarjetaProducto" revista="<cfoutput>#prc.opcionesProductos.REVISTAISSN[x]#</cfoutput>">			
							 
                            <div class="text-center textoseleccion">
								<div class="text-center tarjetaProductoNomSel tarjetaProductoNomSel<cfoutput>#prc.opcionesProductos.PKPRODUCTO[x]#</cfoutput>" id_prod="<cfoutput>#prc.opcionesProductos.PKPRODUCTO[x]#</cfoutput>">
									<a style="color: #ffffff; text-decoration: underline; font-weight: bold"><cfoutput>#prc.opcionesProductos.PRODUCTO[x]#</cfoutput></a>
								</div>

								<div class="input-group text-center tarjetaProductoNomTxt<cfoutput>#prc.opcionesProductos.PKPRODUCTO[x]#</cfoutput> hide" id_prod="<cfoutput>#prc.opcionesProductos.PKPRODUCTO[x]#</cfoutput>">
                                    <input type="text" id="productoNombre<cfoutput>#prc.opcionesProductos.PKPRODUCTO[x]#</cfoutput>" name="productoNombre<cfoutput>#prc.opcionesProductos.PKPRODUCTO[x]#</cfoutput>" class="form-control" maxlength="300" value="<cfoutput>#prc.opcionesProductos.PRODUCTO[x]#</cfoutput>" style="color: #000000; text-transform: none;">
									<span class="input-group-btn">
										<button type="button" class="btn btn-success" onclick="guardarProductoNombre(<cfoutput>#prc.opcionesProductos.PKPRODUCTO[x]#</cfoutput>);"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>
									</span>
								</div>
							</div>	
                            <div align="center" style="padding-top: 5px;"> 
                                <button type="button" class="btn btn-circle btn-success botonSeleccionProdNom" id_prod="<cfoutput>#prc.opcionesProductos.PKPRODUCTO[x]#</cfoutput>" data-toggle="tooltip" title="Editar nombre del producto">
                                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                                </button>
                                <button type="button" class="btn btn-circle btn-success botonSeleccionProdDesc" id_prod="<cfoutput>#prc.opcionesProductos.PKPRODUCTO[x]#</cfoutput>" data-toggle="tooltip" title="Editar descripción del producto" desc_prod='<cfoutput>#prc.opcionesProductos.DESCRIPCION[x]#</cfoutput>'>
                                    <i class="fa fa-pencil" aria-hidden="true"></i>
                                </button>
                            </div> 
							<div class="descProducto" align="center"> 
								<p>
									<cfoutput>#prc.opcionesProductos.DESCRIPCION[x]#</cfoutput>
								</p>
							</div>	
						</div>
					</div>
				</cfif>
				<cfset i=x>
			</cfloop>
		</div>		
	</cfloop>
</div>	

<script>
	$(document).ready(function() {		
		$('.tarjetaProductoNomSel').click(function(){	
			cargaSeleccion($(this).attr('id_prod'));
			cargahistorial($(this).attr('id_prod'));
            $("#inPkProductoOrigen").val($(this).attr('id_prod'));
		});

		$('.botonSeleccionProdNom').click(function(){	
			$(".tarjetaProductoNomSel"+$(this).attr('id_prod')).toggleClass('hide');
			$(".tarjetaProductoNomTxt"+$(this).attr('id_prod')).toggleClass('hide');
		});

		$('.botonSeleccionProdDesc').click(function(){	
			tinyMCE.get("inComent").setContent($(this).attr('desc_prod'));
			$("#inPkProducto").val($(this).attr('id_prod'));
			$("#mdl-editarProductoDescripcion").modal('show');
		});
	});

	/** 
    * Descripcion:    Guarda el nombre del producto
    * Fecha creacion: Diciembre de 2017
    * @author:        JLGC
    */
    function guardarProductoNombre(pkProducto){
    	var nombreProducto = $("#productoNombre"+pkProducto).val();
        var origen = $("#inPkProductoOrigen").val();
       
        $.post('<cfoutput>#event.buildLink("CVU.Productos.editarProductoNombre")#</cfoutput>', {
            pkProducto:     pkProducto,
            productoNombre: nombreProducto
        }, function(data) {
            if ($.isNumeric(data)  && data > 0) {
                swal("El nombre del producto ha sido modificado", null, "success");
                cargaSeleccion(origen);
                cargahistorial(origen);
            }
            else {
                swal("Error al modificadar el nombre del producto", null, "error");
            }
        });
    }

	/** 
    * Descripcion:    Guarda la descripción del producto
    * Fecha creacion: Diciembre de 2017
    * @author:        JLGC
    */
    function guardarProductoDescripcion(){
        var descripcionProducto  = tinyMCE.activeEditor.getContent();
        var pkProducto = $("#inPkProducto").val();
        var origen = $("#inPkProductoOrigen").val();
		
        $.post('<cfoutput>#event.buildLink("CVU.Productos.editarProductoDescripcion")#</cfoutput>', {
            pkProducto:     pkProducto,
            productoDescripcion: descripcionProducto
        }, function(data) {
            $("#mdl-editarProductoDescripcion").modal('hide');
            if ($.isNumeric(data)  && data > 0) {
                swal("La descripción del producto ha sido modificada", null, "success");
                cargaSeleccion(origen);
                cargahistorial(origen);
            }
            else {
                swal("Error al modificadar la descripción del producto", null, "error");
            }
        });
    }
</script>