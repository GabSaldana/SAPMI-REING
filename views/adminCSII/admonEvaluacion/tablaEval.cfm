<cfprocessingdirective pageEncoding="utf-8">

<div id="toolbar">
    
</div>

<div class="form-group">
    <div class="col-sm-3">
        <button  style="background-color: #cdcbcb" type="button" class="btn btn-default btn-outline dim btn-crear" data-toggle="modal" onclick="modalAgregarSeccion();"><span class="glyphicon glyphicon-plus"></span> AGREGAR SECCION A LA ENCUESTA </button>
    </div>
    <div class="col-sm-3">
        <button  style="background-color: #cdcbcb" type="button" class="btn btn-default btn-outline dim btn-crear" data-toggle="modal" onclick="modalCambiarOrden();"><span class="glyphicon glyphicon-refresh"></span> CAMBIAR ORDEN A LAS SECCIONES </button>
    </div>
</div>
<table id="tabla-eval" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" data-unique-id="id" data-search-accent-neutralise="true">
    <thead>
        <tr>
            <th data-field="numero">#</th>
            <th class="text-center" data-field="nombre" data-sortable="true">Nombre</th>
            <th data-field="pk">pk</th>
            <th class="text-center" data-field="orden" data-sortable="true">Num. Orden</th>
            <th class="text-center" data-field="botones" data-formatter="actionFormatter" data-events="actionEvents">Acciones</th>
        </tr>
    </thead>
</table>

<script>

    var data = [];

    <cfif isDefined('prc.secEval.recordCount')>
        <cfset i=0>
        <cfoutput query="prc.secEval">
            data.push({
                numero: #i#,
                nombre: "#NOMBRE#",
                orden: "#ORD#",
                pk: "#PKSEC#"
            });
            <cfset i++>
        </cfoutput>
    </cfif>

    function actionFormatter(value, row, index){
        return [
            '<button class="btn btn-primary editar-seccion" data-tooltip="tooltip" title="Editar Seccion" data-toggle="modal"> <i class="fa fa-pencil"></i> </button>',
             '<button class="btn btn-primary eliminar-seccion" data-tooltip="tooltip" title="Eliminar Seccion"> <i class="fa fa-trash"></i> </button>'
        ].join(' ');
    }

    $(document).ready(function(){
        $('#tabla-eval').bootstrapTable();
        $('#tabla-eval').bootstrapTable('hideColumn', 'pk');
        $('#tabla-eval').bootstrapTable('hideColumn', 'numero');
        $('#tabla-eval').bootstrapTable('load', data);
    });

</script>