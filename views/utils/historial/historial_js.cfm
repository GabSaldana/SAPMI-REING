<cfprocessingdirective pageEncoding="utf-8">

<div id="modal-historial" class="modal small inmodal modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Historial de validación.</h4>
            </div>

            <div class="modal-body"> </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

	<!---
    * Fecha : Febrero de 2017
    * Autor : Alejandro Tovar
    * Comentario: Obtiene el historial de cambios de estado.
    --->
    function consultaHistorial(pkRegistro, pkProcedimiento){
        $("#pkRegistroComentario").val(pkRegistro);
        
        $.post('/index.cfm/historial/historial/getHistorial', {	
            pkRegistro: pkRegistro,
            pkProcedimiento: pkProcedimiento
        },
        function(data){
            $('#modal-historial').modal('show');
            $('#modal-historial .modal-body').html(data);
        });
    }


</script>