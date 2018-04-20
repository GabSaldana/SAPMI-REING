<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla-accOpe" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-unique-id="id">
    <thead>
        <tr>
            <th class="text-center" data-formatter="getIndex">#</th>
            <th data-field="id">Cve</th>
            <th data-field="oper" data-sortable="true">Operación</th>
            <th data-field="tipo" data-sortable="true">Tipo</th>
            <th class="text-center" data-field="funcion" data-formatter="actionFormatter" data-events="actionEvents">Función</th>
        </tr>
    </thead>
</table>


<script>
    <!---
    * Descripcion: llenar tabla con las operaciones.
    * Fecha: Octubre de 2016
    * @author Alejandro Tovar
    --->
    var data = [];
    <cfif isDefined('prc.rel.recordCount')>
        <cfloop index='i' from='1' to='#prc.rel.recordCount#'>
            <cfoutput>
                data.push({
                    id: "#prc.rel.PK[i]#",
                    oper: "#prc.rel.OPERACION[i]#",
                    tipo: "#prc.rel.TIPO[i]#"
                });
            </cfoutput>
        </cfloop>
    </cfif>

    function getIndex(value, row, index) {
        return index+1;
    }

    function actionFormatter(value, row, index) {
        return [
            '<button class="btn btn-primary borraOper" data-tooltip="tooltip" title="Borrar"> <i class="fa fa-trash"></i> </button>'
        ].join('');
    }

    $(document).ready(function() {    
        $('#tabla-accOpe').bootstrapTable();
        $('#tabla-accOpe').bootstrapTable('hideColumn', 'id');
        $('#tabla-accOpe').bootstrapTable('load', data);
    });

</script>