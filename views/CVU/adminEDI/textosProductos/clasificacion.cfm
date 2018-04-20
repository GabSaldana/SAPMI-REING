<!-----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      CVU edicion productos (copia menu CVU)
* Sub modulo:  -
* Fecha:       04 de diciembre de 2017
* Descripcion: Contenido js que sera usado por la vista de Menu
* Autor:       JLGC    
* ================================
----->

<cfprocessingdirective pageEncoding="utf-8">
<cfset total_records = prc.resultado.recordcount>

<div class="row">
	
	<div id="clasificaciones" class="col-md-4 col-xs-12">
	<!--Aqui comienza el modulo de clasificaiones-->
		<cfloop index="x" from="1" to="#total_records#">
			<div class="tarjetaClasificacion" id_clasificacion="<cfoutput>#prc.resultado.PKCLASIFICACION[x]#</cfoutput>">				
				<div class="row">
					<div class="col-md-3 pull-left">
						<div id="icon">
                            <button type="button" class="btn btn-circle btn-success botonClasificacionProdNom" id_clasificacion="<cfoutput>#prc.resultado.PKCLASIFICACION[x]#</cfoutput>" data-toggle="tooltip" title="Editar nombre del producto">
                                <i class="fa <cfoutput>#prc.resultado.ICONO[x]#</cfoutput>" aria-hidden="true"></i>
                            </button>
						</div>
					</div>
					<div class="col-md-9" style="padding-top: 13pt;">
                        <div class="text-center tarjetaClasificacionNomSel tarjetaClasificacionNomSel<cfoutput>#prc.resultado.PKCLASIFICACION[x]#</cfoutput>" id_clasificacion="<cfoutput>#prc.resultado.PKCLASIFICACION[x]#</cfoutput>">
                            <a style="color: #ffffff; text-decoration: underline; font-weight: bold"><h3><cfoutput>#prc.resultado.CLASIFICACION[x]#</cfoutput></h3></a>
                        </div>

                        <div class="input-group text-center tarjetaClasificacionNomTxt<cfoutput>#prc.resultado.PKCLASIFICACION[x]#</cfoutput> hide" id_clasificacion="<cfoutput>#prc.resultado.PKCLASIFICACION[x]#</cfoutput>">
                            <input type="text" id="productoNombre<cfoutput>#prc.resultado.PKCLASIFICACION[x]#</cfoutput>" name="productoNombre<cfoutput>#prc.resultado.PKCLASIFICACION[x]#</cfoutput>" class="form-control" maxlength="300" value="<cfoutput>#prc.resultado.CLASIFICACION[x]#</cfoutput>" style="color: #000000; text-transform: none;">
                            <span class="input-group-btn">
                                <button type="button" class="btn btn-success" onclick="guardarProductoNombre(<cfoutput>#prc.resultado.PKCLASIFICACION[x]#</cfoutput>);"><i class="fa fa-floppy-o" aria-hidden="true"></i></button>
                            </span>
                        </div>
					</div>
				</div>
			</div>	
		</cfloop>
	</div>

	<div id= "descripciones" class="col-md-8 col-xs-12">
		<cfloop index="x" from="1" to="#total_records#">
				<div class="descripcion" id_descripcion="<cfoutput>#prc.resultado.PKCLASIFICACION[x]#</cfoutput>" style="display:none;">				
					<div class="text-center textoClasificacion">
						<div class="center">
							<h2>Actividades relacionadas con:</h2>
							<ul class="list-group clear-list m-t">
	                            <h3><cfoutput>#prc.resultado.DESCRIPCION[x]#</cfoutput></h3>
						    </ul>
						    <button type="button" class="btn btn-circle btn-success botonSeleccionClasDesc" id_prod="<cfoutput>#prc.resultado.PKCLASIFICACION[x]#</cfoutput>" data-toggle="tooltip" title="Editar descripción de la clasificación" desc_prod='<cfoutput>#prc.resultado.DESCRIPCION[x]#</cfoutput>'>
					            <i class="fa fa-pencil" aria-hidden="true"></i>
					        </button>
						</div>
					</div>	
				</div>	
		</cfloop>
	</div>
	
</div>

<script>
	$(document).ready(function() {
		
		$('.tarjetaClasificacionNomSel').click(function(){
			$('#clasdesc').css('display', 'none');
			cargaSeleccion($(this).attr('id_clasificacion'));
			cargahistorial($(this).attr('id_clasificacion'));
			$("#inPkProductoOrigen").val($(this).attr('id_clasificacion'));
		});

		$('.tarjetaClasificacion').mouseover(function(){
			id= $(this).attr('id_clasificacion');
			selector = 'div[id_descripcion=' + id + ']';
            clasificacion = 'div[id_clasificacion=' + id + ']';
			$('.descripcion').css('display', 'none');
			$(selector).css('display', '');

            $('.tarjetaClasificacion').css('background-color', '#37537D');
            $('.tarjetaClasificacionNomSel').css('background-color', '#37537D');
            $(clasificacion).css('background-color', '#F7AB5A');
		});

		$('.botonSeleccionClasDesc').click(function(){	
			tinyMCE.get("inComent").setContent($(this).attr('desc_prod'));
			$("#inPkProducto").val($(this).attr('id_prod'));
			$("#mdl-editarProductoDescripcion").modal('show');
		});

        $('.botonClasificacionProdNom').click(function(){ 
            $(".tarjetaClasificacionNomSel"+$(this).attr('id_clasificacion')).toggleClass('hide');
            $(".tarjetaClasificacionNomTxt"+$(this).attr('id_clasificacion')).toggleClass('hide');
        });
	});

    /** 
    * Descripcion:    Guarda el nombre del producto
    * Fecha creacion: Diciembre de 2017
    * @author:        JLGC
    */
    function guardarProductoNombre(pkProducto){
        var nombreProducto = $("#productoNombre"+pkProducto).val();
       
        $.post('<cfoutput>#event.buildLink("CVU.Productos.editarProductoNombre")#</cfoutput>', {
            pkProducto:     pkProducto,
            productoNombre: nombreProducto
        }, function(data) {
            if ($.isNumeric(data)  && data > 0) {
                swal("El nombre del producto ha sido modificado", null, "success");
                cargaClasificaciones();
                ocultaMenuDerecho();
                selector = 'div[id_descripcion=' + data + ']';
                clasificacion = 'div[id_clasificacion='+data+']';
                $(selector).css('display', '');
                $(clasificacion).css('background-color', '#F7AB5A');
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
       
        $.post('<cfoutput>#event.buildLink("CVU.Productos.editarProductoDescripcion")#</cfoutput>', {
            pkProducto:     pkProducto,
            productoDescripcion: descripcionProducto
        }, function(data) {
            $("#mdl-editarProductoDescripcion").modal('hide');
            if ($.isNumeric(data)  && data > 0) {
                swal("Las actividades relacionadas han sido modificadas", null, "success");
                cargaClasificaciones();
				ocultaMenuDerecho();
				selector = 'div[id_descripcion=' + data + ']';
    			clasificacion = 'div[id_clasificacion='+data+']';
            	$(selector).css('display', '');
                $(clasificacion).css('background-color', '#F7AB5A');
            }
            else {
                sswal("Error al modificadar las actividades relacionadas", null, "error");
            }
            $('.descripcion' + data).css('display', '');
        });
    }
</script>