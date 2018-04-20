<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

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

    var validateForm = $("#validaModalidad").validate({
        rules: {
            inNombre:    {required: true}
        },
        errorPlacement: function (error, element) {
            error.insertAfter($(element).parent());
        },
        submitHandler: function(form){
            return false;
        }
    }); 

	consultarListaModalidades();

	$(".btn-crear").on("click", function() {        
        limpiarFormMod();
        validateForm.resetForm();
        $(".form-control").removeClass('error');
        $("#mdl-admon-modalidad .modal-title").text("Agregar Modalidad");
        $("#btn-admon-modalidad").switchClass("btn-editar","btn-agregar");
        $("#btn-admon-modalidad").html('<span class="fa fa-check"></span> Guardar');
    });

    $(document).on("click", ".btn-agregar", function() {
        if($("#validaModalidad").valid()){
            var nombre      = $("#inNombre").val();
            $.post('<cfoutput>#event.buildLink("convenios.admonModalidades.agregarModalidad")#</cfoutput>', {   
                nombre:         nombre
            }, function(data){ 
                if(data > 0){
                    consultarListaModalidades();
                    $('#mdl-admon-modalidad').modal('hide');
                    toastr.success('Registrado exitosamente','Modalidad');
                    limpiarFormMod();
                }
                else
                    toastr.error('Hubo un problema al tratar de guardar el registro.');
            });
        }
    });

    $(document).on("click", ".btn-editar", function() {
        if($("#validaModalidad").valid()){
            var pk          = $("#mdl-admon-modalidad").attr("data-inst");
            var nombre      = $("#inNombre").val();
            $.post('<cfoutput>#event.buildLink("convenios.admonModalidades.editarModalidad")#</cfoutput>', {   
                pk:             pk,
                nombre:         nombre
            }, function(data){ 
                if(data > 0){
                    consultarListaModalidades();
                    $('#mdl-admon-modalidad').modal('hide');
                    toastr.success('Actualizado exitosamente','Modalidad');
                    limpiarFormMod();
                }
                else
                    toastr.error('Hubo un problema al tratar de actualizar el registro.');
            });
        }
    });

    window.actionEvents = {        
        'click .eliminar-modalidad': function (e, value, row) {            
            modificarModal('Eliminar', row.id, row.nombre)        
        },        
        'click .editar-modalidad': function (e, value, row, index) {
            limpiarFormMod();
            validateForm.resetForm();
            $(".form-control").removeClass('error');
            $("#mdl-admon-modalidad").attr("data-inst", row.id);             
            $("#mdl-admon-modalidad .modal-title").text('Editar Modalidad');
            $("#btn-admon-modalidad").switchClass("btn-agregar","btn-editar");
            $("#btn-admon-modalidad").html('<span class="fa fa-check"></span> Actualizar');
            $.post('<cfoutput>#event.buildLink("convenios.admonModalidades.consultarModalidad")#</cfoutput>', { 
                pkMod: row.id
            }, function(data){
                if(data.ROWCOUNT > 0){
                    $('#inNombre').val(data.DATA.NOMBRE.toString());
                   }
                else
                    toastr.error('Hubo un problema al realizar la consulta de la Modalidad');
            });
        },     
    };

    $("#btn-estado-modalidad").on("click", function() {
        if ($(this).attr('data-action') == 'eliminar')
            actualizarInstitucion(3, 'Eliminado', 'eliminar');
        else if ($(this).attr('data-action') == 'validar')
            actualizarInstitucion(2, 'Validado', 'validar');
        else if ($(this).attr('data-action') == 'cancelar')
            actualizarInstitucion(1, 'Cancelado', 'cancelar');
    });

});

function modificarModal(titulo, mod, nombre) {
    var body = $('#mdl-estado-modalidad .modal-body');            
    body.empty();
    $("#mdl-estado-modalidad .modal-title").text(titulo + " Modalidad");
    $("#btn-estado-modalidad").attr("data-action", titulo.toLowerCase());
    var conf = $('<p>').text("¿Confirma que desea " + titulo.toLowerCase() + " la modalidad seleccionada?");
    conf.attr("pkMod", mod);
    body.append(conf);
    var texto = $('<p>').append($('<strong>').text("Nombre: "));
    texto.append(nombre);
    texto.append('<br>');
    body.append(texto);
}

function actualizarInstitucion(edo, successMsg, errorMsg) {
    var pk = $('#mdl-estado-modalidad').find('p').attr('pkMod');
    $("#mdl-estado-modalidad").modal('hide');
    $.post('<cfoutput>#event.buildLink("convenios.admonModalidades.actualizarModalidad")#</cfoutput>', {
            pk: pk, estado: edo
        }, function(data) {
        if(data > 0) {
            consultarListaModalidades();
            toastr.success(successMsg + ' correctamente', 'Modalidad');
        } else
            toastr.error('Hubo un problema al tratar de ' + errorMsg + ' la modalidad.');
    });
}

function consultarListaModalidades(){
    $.post('<cfoutput>#event.buildLink("convenios.admonModalidades.getModalidades")#</cfoutput>', function(data){
        $('#listaModalidades').html( data );      
    });
}

function limpiarFormMod(){
    $("#validaModalidad")[0].reset();
}

</script>