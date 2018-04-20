<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla-ope" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-unique-id="id">
    <thead>
        <tr>
            <th class="text-center" data-formatter="getIndex">#</th>
            <th data-field="id">Cve</th>
            <th data-field="nombre" data-sortable="true">Nombre</th>
            <th data-field="descripcion" data-sortable="true">Descripción</th>
            <th class="text-center" data-field="estado" data-sortable="true">Estado</th>
            <th class="text-center" data-field="accion" data-formatter="actionFormatter" data-events="actionEvents">Acciones</th>
        </tr>
    </thead>
</table>

<script>
    <!---
    * Fecha: Noviembre de 2016
    * @author SGS
    * Descripcion: Llena tabla con las operaciones
    --->
    var data = [];
    <cfif isDefined('prc.oper.recordCount')>
        <cfloop index='i' from='1' to='#prc.oper.recordCount#'>
            <cfoutput>
                data.push({
                    id: "#prc.oper.PK[i]#",
                    nombre: "#prc.oper.NOMBRE[i]#",
                    descripcion: "#prc.oper.DESCRIPCION[i]#",
                    estado: "<span class='badge badge-primary'>#prc.oper.EDO[i]#</span>"
                });
            </cfoutput>
        </cfloop>
    </cfif>

    function getIndex(value, row, index) {
        return index+1;
    }

    function actionFormatter(value, row, index) {
        return [
            '<button class="btn btn-primary borrar guiaProNewElimina" data-tooltip="tooltip" title="Borrar"> <i class="fa fa-trash"></i> </button>'

        ].join('');
    }

    $(document).ready(function() {    
        $('#tabla-ope').bootstrapTable();
        $('#tabla-ope').bootstrapTable('hideColumn', 'id');
        $('#tabla-ope').bootstrapTable('load', data);
    });

</script>