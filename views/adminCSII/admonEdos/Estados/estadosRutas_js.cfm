<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">
    $('.selectpicker').selectpicker();
    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene los estados relacionados a una ruta.
    --->  
    function consultarEstados(){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.getTablaEstadosRutas")#</cfoutput>', {
            pkProced: $("#inProced").val(),
            pkRuta: $("#inRuta").val()
        },
        function(data){
            $('#tableRutas').html(data);
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Agrega un nuevo estado relacionandolo con una ruta
    --->  
    function addEstado(){
        if($("#validaEstado").valid()){
            $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.addEstado")#</cfoutput>', {
                ruta: $("#inRuta").val(),
                numero: $("#inNumero").val(),
                nombre: $("#inNombre").val(),
                descr: $("#inDescr").val(),
                area: $("#inArea").val()
            }, 
            function(data){
                if (data > 0){
                    $("#mdl-estado").modal('hide');
                    $("#validaEstado")[0].reset();
                    consultarEstados();
                    toastr.success('Guardado correctamente','Estado');
                }else {
                    $("#mdl-estado").modal('hide');
                    $("#validaEstado")[0].reset();
                    toastr.error('Al guardar estado','Error');
                }
            });
        }
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Limpia campos y mensajes de error en la modal para agregar estados.
    --->  
    function limpiaModal(){
        $("#mdl-estado").modal('hide');
        $("#validaEstado")[0].reset();
        $(".form-control").removeClass('error');
        $("label.error").remove();
    }


    <!---
    * Fecha : Diciembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Elimina estado.
    --->  
    function eliminaEstado(){
        $.post('<cfoutput>#event.buildLink("adminCSII.admonEdos.admonEdos.eliminaEstado")#</cfoutput>', {
            pkEstado: $("#pkEstado").val(),
        },
        function(data){
            $("#mdl-borraEstado").modal('hide');
            toastr.success('Eliminado exitosamente','Estado');
            consultarEstados();
        });
    }


    $(document).ready(function() {

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

        consultarEstados();

        $("#validaEstado").validate({
            rules: {
                inNumero:  {required: true, digits: true},
                inNombre: {required: true},
                inDescr: {required: true}
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent());
            },
            submitHandler: function(form){
                return false;
            }
        });

        window.actionEvents = {
            'click .eliminar': function (e, value, row, index) {
                $("#mdl-borraEstado").modal('show');
                $("#pkEstado").val(row.id);
                $("#mdl-borraEstado .modal-body").html('¿Seguro que quiere eliminar el estado?'+ '<br><br>' + '<strong>Nombre:</strong> '+row.nombre + '<br>' + '<strong>Descripción:</strong> '+ row.desc);
            }
        };

    });

</script>