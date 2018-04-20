<cfprocessingdirective pageEncoding="utf-8">

    <cfoutput>
        <div class="row" id="cont-Allreportes">
            <div class="col-md-12">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="alert alert-info row">
                                <strong>Info!</strong>
                                <br>
                                Seleccione y arrastre los formatos a la zona gris:
                            </div>
                        </div>
                        <div class="pull-right col-md-8">
                            <div class="input-group">
                                <input type="text" class="form-control" id="in-buscar" placeholder="Buscar..." onkeypress="busqueda();">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" onclick="busqueda();">
                                        <span class="glyphicon glyphicon-search">
                                            <span class="sr-only">Buscar reportes...</span>
                                        </span>
                                    </button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="row">
                                <div class="col-md-4">
                                    <h4>Formatos Seleccionados:</h4>
                                </div>
                                <div class="col-md-8">
                                    <button class="btn btn-primary dim ml5 pull-right col-md-12" id="bt-configuracion"> <i class="fa fa-gear success">  Asociar formatos</i> </button>
                                </div>
                            </div>
                            <div id="asociacion" class="row contenedorDropAsociacion" style="overflow:auto;background-color:##f5f6f7; height:700px;z-index:1;">
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="row contenedorDropPlantillas" style="height:700px; overflow:auto">
                                <cfloop index="x" from="1" to="#prc.plantillas.recordcount#">
                                    <div class="col-md-6 cont-reporte" style="height:120px" name="#prc.plantillas.NOMBREFORMATO[x]#" data-form-id="#prc.plantillas.PKFORMATO[x]#">
                                        <div class="widget style1 blue-bg" style="height:100px">
                                            <div class="row">
                                                <div class="col-xs-4">
                                                    <i class="fa fa-file fa-3x"></i>
                                                </div>
                                                <div class="col-xs-8 text-right nomb" style="height:80px, overflow:inherit">
                                                    <span> #prc.plantillas.NOMBREFORMATO[x]# </span><br>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </cfloop>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </cfoutput>


<script>

$(document).ready(function() {

    $('.skin-4').removeAttr('style');

    <!---
    * Fecha      : Diciembre 2016
    * Autor      : Marco Torres
    * Descripcion: Carga el reporte seleccionado
    * --->
    $('.el-vista-previa-rep').click(function(){
        $('#cont-Allreportes').slideToggle( 1000,'easeOutExpo');
        $('#contEditarPlantilla').slideToggle( 1000,'easeOutExpo');
        $('#displayNombre').text($('.el-cont-desc',$(this).parent()).text());
        cargarEdicion($(this).attr('data-rep-id'));
        
    });

    <!---
    * Fecha      : Diciembre 2016
    * Autor      : Marco Torres
    * Descripcion: Carga la vista para generar reportes nuevos
    * --->
    $('.bt-nuevoRep').click(function(){
        $('#cont-Allreportes').slideToggle( 1000,'easeOutExpo');
        $('#contNuevaPlantilla').slideToggle( 1000,'easeOutExpo');
        
        cargarNuevo();
    });
    
    <!---
    * Fecha      : Diciembre 2016
    * Autor      : Marco Torres
    * Descripcion: Carga la vista para generar reportes nuevos
    * --->
    $('.bt-cerrar-captura').click(function(){
        $('#cont-Allreportes').slideToggle( 1000,'easeInExpo');
        $(this).parent().parent().slideToggle( 1000,'easeInExpo');
    }); 
    
    <!---
    * Fecha      : Diciembre 2016
    * Autor      : Marco Torres
    * Descripcion: Carga la vista para generar reportes nuevos
    * --->
    $('.buscarAsociados').click(function(){
        verFormatosRelacionados($(this).attr('data-rep-id'));
    });
    
    $('.el-eliminar').click(function(){
        $buttton = $(this);
        if (confirm('¿Desea eliminar esta plantilla? \n Esta accion es irreversible')) { 
            var pk_plantilla = $(this).attr('data-rep-id');
            $.post('<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.borraPlantilla")#</cfoutput>', { pk_plantilla: pk_plantilla}, 
                function(data){
                    if(data == 1){
                        $buttton.closest('div.cont-reporte').remove();
                    }
                }
            );
        }
    }); 
    
    $( ".cont-reporte" ).draggable({
        revert: "invalid", 
        containment: ".wrapper-content",
        cursor: "move",     
        zIndex:800,
        helper:function(event,ui){
            var element=$("<div></div>");
            return element.append($(this).html());
        }       
    });
        
    $(".contenedorDropAsociacion").droppable({
        accept: " .cont-reporte",
        activeClass: "dropActive",  
        drop: function( event, ui ) {
            var formatoSelect = [];
            $('#asociacion').children('.cont-reporte').each(function(){
                formatoSelect.push($(this).attr('data-form-id'));
            });
            if (formatoSelect.length < 35){
                $(this).append(ui.draggable);
                ui.draggable.removeClass('col-md-6 ').addClass('col-md-12');
            }else{
                toastr.error('Error','Las sociaciones como máximo pueden tener 35 plantillas.');
            }
        }
    });
    
    $(".contenedorDropPlantillas").droppable({
        accept: " .cont-reporte",
        //activeClass: "dropActive",    
        drop: function( event, ui ) {
            $(this).append(ui.draggable);
            ui.draggable.removeClass('col-md-12').addClass('col-md-6');
        }
    });
    
    $('#bt-configuracion').click(function(){
        
        $("#tabla").empty();
        var nombres = '';
        var cont = 0;
        $('#asociacion').children('.cont-reporte').each(function(){
            if (cont <= 1){
                if(nombres == ''){
                    nombres = nombres + $(this).attr('name');
                }else {
                    nombres = nombres + '-'+ $(this).attr('name');
                }
            }

            cont++;
        });


        var formatoSelect = [];
        $('#asociacion').children('.cont-reporte').each(function(){
            formatoSelect.push($(this).attr('data-form-id'));  
        });
        if (formatoSelect.length > 1){
            
            var formatos = JSON.stringify(formatoSelect);
            $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.setAsociaciones")#</cfoutput>',{
                nombres:nombres,
                formatos:formatos
                }, 
                function(data){
                    if (data > 1){
                        toastr.success('Formatos asociadios correctamente.');
                        dragDrop();
                        $("#box-formatosRegistrados").hide();
                        cargarRelacionFormatos(data);
                    }
                }
            );
        }else {
            toastr.error('Al menos se deben asociar 2 reportes');
        }
    });


    toastr.options = {
        "closeButton": true,
        "debug": false,
        "progressBar": true,
        "preventDuplicates": false,
        "newestOnTop": true,
        "positionClass": "toast-top-right",
        "onclick": null,
        "showDuration": "400",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "2000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    };

});

    <!---
    * Fecha      : Marzo 2017
    * Autor      : Alejandro Tovar
    * Descripcion: Obtiene la vista que muestra los formatos asociados.
    * --->
    function cargarRelacionFormatos(pkAsociacion){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.getTabla")#</cfoutput>', {
                pkColumnaOrigen: 0,
                pkAsociacion: pkAsociacion
            }, 
            function(data){
                $("#box-asociaColumnas").show();
                $('#tabla').html( data );
            }
        );
    }


    <!---
    * Fecha      : Marzo 2017
    * Autor      : Marco Torres
    * Descripcion: Busqueda de formatos.
    * --->
    function busqueda(){
        var tex = $("#in-buscar").val().toUpperCase();
        var tex2 = $("#in-buscar").val();
        /*oculta todos los reportes*/
        $('.contenedorDropPlantillas .cont-reporte').hide();
        /*muestra todos los que contengan el texto*/
        $('.nomb').each(function(){
            if($(this).text().includes(tex) || $(this).text().includes(tex2)){
                $(this).parents().show();
            }
        });
        $('.el-cont-desc').each(function(){
            if($(this).text().includes(tex)){
                $(this).parents().show();
            }
        });
    }


</script>

