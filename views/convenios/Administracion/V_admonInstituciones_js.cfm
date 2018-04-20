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

    var validateForm = $("#validaInstitucion").validate({
        rules: {
            inNombre:    {required: true},
            inUbicacion: {required: true}
        },
        errorPlacement: function (error, element) {
            error.insertAfter($(element).parent());
        },
        submitHandler: function(form){
            return false;
        }
    }); 

	consultarListaInstituciones();

	$(".btn-crear").on("click", function() {        
        limpiarFormIns();
        validateForm.resetForm();
        $(".form-control").removeClass('error');
        $("#mdl-admon-institucion .modal-title").text("Agregar Institución");
        $("#btn-admon-institucion").switchClass("btn-editar","btn-agregar");
        $("#btn-admon-institucion").html('<span class="fa fa-check"></span> Guardar');
    });


    $(document).on("click", ".btn-agregar", function() {
        if($("#validaInstitucion").valid()){
            var nombre      = $("#inNombre").val();
            var ubicacion   = $("#inUbicacion").val();
            var descripcion = $("#inDescripcion").val();
            $.post('<cfoutput>#event.buildLink("convenios.admonInstituciones.agregarInstitucion")#</cfoutput>', {   
                nombre:         nombre, 
                ubicacion:      ubicacion,
                descripcion:    descripcion
            }, function(data){ 
                if(data > 0){
                    consultarListaInstituciones();
                    $('#mdl-admon-institucion').modal('hide');
                    toastr.success('Registrado exitosamente','Institución');
                    limpiarFormIns();
                }
                else
                    toastr.error('Hubo un problema al tratar de guardar el registro.');
            });
        }
    });

    $(document).on("click", ".btn-editar", function() {
        if($("#validaInstitucion").valid()){
            var pk          = $("#mdl-admon-institucion").attr("data-inst");
            var nombre      = $("#inNombre").val();
            var ubicacion   = $("#inUbicacion").val();
            var descripcion = $("#inDescripcion").val();
            $.post('<cfoutput>#event.buildLink("convenios.admonInstituciones.editarInstitucion")#</cfoutput>', {   
                pk:             pk,
                nombre:         nombre, 
                ubicacion:      ubicacion,
                descripcion:    descripcion
            }, function(data){ 
                if(data > 0){
                    consultarListaInstituciones();
                    $('#mdl-admon-institucion').modal('hide');
                    toastr.success('Actualizado exitosamente','Institución');
                    limpiarFormIns();
                }
                else
                    toastr.error('Hubo un problema al tratar de actualizar el registro.');
            });
        }
    });

    window.actionEvents = {        
        'click .eliminar-institucion': function (e, value, row, ubicacion, descripcion) {            
            modificarModal('Eliminar', row.id, row.nombre, row.ubicacion, row.descripcion)        
        },        
        'click .editar-institucion': function (e, value, row, index) {
            limpiarFormIns();
            validateForm.resetForm();
            $(".form-control").removeClass('error');
            $("#mdl-admon-institucion").attr("data-inst", row.id);             
            $("#mdl-admon-institucion .modal-title").text('Editar Institución');
            $("#btn-admon-institucion").switchClass("btn-agregar","btn-editar");
            $("#btn-admon-institucion").html('<span class="fa fa-check"></span> Actualizar');
            $.post('<cfoutput>#event.buildLink("convenios.admonInstituciones.consultarInstitucion")#</cfoutput>', { 
                pkIns: row.id
            }, function(data){
                if(data.ROWCOUNT > 0){
                    $('#inNombre').val(data.DATA.NOMBRE.toString());
                    $('#inUbicacion').val(data.DATA.DIRECCION.toString());
                    $('#inDescripcion').val(data.DATA.DESCRIPCION.toString());
                   }
                else
                    toastr.error('Hubo un problema al realizar la consulta de la Institución');
            });
        },     
    };


    $("#btn-estado-institucion").on("click", function() {
        if ($(this).attr('data-action') == 'eliminar')
            actualizarInstitucion(3, 'Eliminado', 'eliminar');
        else if ($(this).attr('data-action') == 'validar')
            actualizarInstitucion(2, 'Validado', 'validar');
        else if ($(this).attr('data-action') == 'cancelar')
            actualizarInstitucion(1, 'Cancelado', 'cancelar');
    });

});

function modificarModal(titulo, ins, nombre, ubicacion, descripcion) {
    var body = $('#mdl-estado-institucion .modal-body');            
    body.empty();
    $("#mdl-estado-institucion .modal-title").text(titulo + " Institución");
    $("#btn-estado-institucion").attr("data-action", titulo.toLowerCase());
    var conf = $('<p>').text("¿Confirma que desea " + titulo.toLowerCase() + " la institución seleccionada?");
    conf.attr("pkIns", ins);
    body.append(conf);
    var texto = $('<p>').append($('<strong>').text("Nombre: "));
    texto.append(nombre);
    texto.append('<br>');
    texto.append($('<strong>').text("Ubicación: "));
    texto.append(ubicacion);
    texto.append('<br>');
    texto.append($('<strong>').text("Descipción: "));
    texto.append(descripcion);
    body.append(texto);
}

function actualizarInstitucion(edo, successMsg, errorMsg) {
    var pk = $('#mdl-estado-institucion').find('p').attr('pkIns');
    $("#mdl-estado-institucion").modal('hide');
    $.post('<cfoutput>#event.buildLink("convenios.admonInstituciones.actualizarInstitucion")#</cfoutput>', {
            pk: pk, estado: edo
        }, function(data) {
        if(data > 0) {
            consultarListaInstituciones();
            toastr.success(successMsg + ' correctamente', 'Institución');
        } else
            toastr.error('Hubo un problema al tratar de ' + errorMsg + ' la institución.');
    });
}

function consultarListaInstituciones(){
    $.post('<cfoutput>#event.buildLink("convenios.admonInstituciones.getInstituciones")#</cfoutput>', function(data){
        $('#listaInstituciones').html( data );      
    });
}

function limpiarFormIns(){
    $("#validaInstitucion")[0].reset();
}



</script>