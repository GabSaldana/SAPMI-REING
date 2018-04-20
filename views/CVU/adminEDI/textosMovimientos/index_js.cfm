<cfprocessingdirective pageEncoding="utf-8">

<script>
	$(document).ready(function() {
        tinymce.init({
            selector: "textarea#inComent",
            language: 'es_MX',
            height: 250,
            resize: false,
            menubar: false,
            plugins: 'textcolor',
            toolbar: 'undo redo | bold italic | forecolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent',

            spellchecker_callback: function(method, data, success) {
                if (method == "spellcheck") {
                    var words = data.match(this.getWordCharPattern());
                    var suggestions = {};

                    for (var i = 0; i < words.length; i++) {
                        suggestions[words[i]] = ["First", "second"];
                    }

                    success({words: suggestions, dictionary: true});
                }

                if (method == "addToDictionary") {
                    success();
                }
            }
        });

        $('.botonSelNombre').click(function(){   
            $(".divMovimientoNombreText"+$(this).attr('id_movimiento')).toggleClass('hide');
            $(".divMovimientoNombreInput"+$(this).attr('id_movimiento')).toggleClass('hide');
        });

        $('.botonSelObservacion').click(function(){   
            $(".divMovimientoObservacionText"+$(this).attr('id_movimiento')).toggleClass('hide');
            $(".divMovimientoObservacionInput"+$(this).attr('id_movimiento')).toggleClass('hide');
        });

        $('.botonSelDescripcion').click(function(){  
            tinyMCE.get("inComent").setContent($(this).attr('des_movimiento'));
            $("#inPkMovimiento").val($(this).attr('id_movimiento'));
            $("#mdl-editarMovimientoDescripcion").modal('show');
        });
	});

    /** 
    * Descripcion:    Guarda el nombre del movimiento
    * Fecha creacion: Diciembre de 2017
    * @author:        JLGC
    */
    function guardarMovimientoNombre(pkMovimiento){
        var movimientoNombre = $("#movimientoNombre"+pkMovimiento).val();
        
        $.post('<cfoutput>#event.buildLink("EDI.solicitud.editarMovimientoNombre")#</cfoutput>', {
            pkMovimiento:     pkMovimiento,
            movimientoNombre: movimientoNombre
        }, function(data) {
            if ($.isNumeric(data)  && data > 0) {
                swal("El nombre del movimiento ha sido modificado", null, "success");
                document.location = '<cfoutput>#event.buildLink("EDI.solicitud.textosMovimientos")#</cfoutput>';
            }
            else {
                swal("Error al modificadar el nombre del movimiento", null, "error");
            }
        });
    }

    /** 
    * Descripcion:    Guarda la observacion del movimiento
    * Fecha creacion: Diciembre de 2017
    * @author:        JLGC
    */
    function guardarMovimientoObservacion(pkMovimiento){
        var movimientoObservacion = $("#movimientoObservacion"+pkMovimiento).val();

        $.post('<cfoutput>#event.buildLink("EDI.solicitud.editarMovimientoObservacion")#</cfoutput>', {
            pkMovimiento:          pkMovimiento,
            movimientoObservacion: movimientoObservacion
        }, function(data) {
            if ($.isNumeric(data)  && data > 0) {
                swal("La observación del movimiento ha sido modificada", null, "success");
                document.location = '<cfoutput>#event.buildLink("EDI.solicitud.textosMovimientos")#</cfoutput>';
            }
            else {
                swal("Error al modificadar la observación del movimiento", null, "error");
            }
        });
    }

    /** 
    * Descripcion:    Guarda la descripción del movimiento
    * Fecha creacion: Diciembre de 2017
    * @author:        JLGC
    */
    function guardarMovimientoDescripcion(){
        var movimientoDescripcion  = tinyMCE.activeEditor.getContent();
        var pkMovimiento = $("#inPkMovimiento").val();
       
        $.post('<cfoutput>#event.buildLink("EDI.solicitud.editarMovimientoDescripcion")#</cfoutput>', {
            pkMovimiento:          pkMovimiento,
            movimientoDescripcion: movimientoDescripcion
        }, function(data) {
            $("#mdl-editarMovimientoDescripcion").modal('hide');
            if ($.isNumeric(data)  && data > 0) {
                swal("La descripción del movimiento ha sido modificada", null, "success");
                document.location = '<cfoutput>#event.buildLink("EDI.solicitud.textosMovimientos")#</cfoutput>';
            }
            else {
                swal("Error al modificadar la descripción del movimiento", null, "error");
            }
        });
    }
</script>