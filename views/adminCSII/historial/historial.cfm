<cfprocessingdirective pageEncoding="utf-8">

<div id="modal-historial" class="modal small inmodal modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" aria-hidden="true" onclick="cerrarModal();">×</button>
                <h4 class="modal-title">Historial de validación.</h4>
            </div>

            <div class="modal-body"> </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" onclick="cerrarModal();">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

	<!---
    * Fecha : Febrero de 2017
    * Autor : Alejandro Tovar
    * Comentario: Obtiene el historial de cambios de estado.
	* -------------------------------
    * Descripcion de la modificacion: Agregar un nuevo argumento. Este argumento es el pk del procedimiento.
    * Fecha de la modificacion: 22/05/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
	* -------------------------------
    --->
    function consultaHistorial(pkRegistro, pkProcedimiento){
        $("#pkRegistroComentario").val(pkRegistro);
        
        $.post('<cfoutput>#event.buildLink("adminCSII.historial.historial.getHistorial")#</cfoutput>', {	
            pkRegistro: pkRegistro,
            pkProcedimiento: pkProcedimiento
        },
        function(data){
            $('#modal-historial').modal('show');
            $('#modal-historial .modal-body').html(data);
        });
    }


    <!---
    * Fecha : Febrero de 2017
    * Autor : Alejandro Tovar
    * Comentario: Cierra la ventana modal del historial
    --->
    function cerrarModal(){
        $('#modal-historial').modal('hide');
        $('.skin-4').removeAttr('style');
    }


</script>