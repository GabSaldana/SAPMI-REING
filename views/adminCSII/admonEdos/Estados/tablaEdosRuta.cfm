<cfprocessingdirective pageEncoding="utf-8">

<div id="toolbar">
    <button type="button" class="btn btn-primary btn-outline dim guiaEdoRutAgregarEstado" data-toggle="modal" href="#mdl-estado"><span class="glyphicon glyphicon-plus"></span> AGREGAR ESTADO</button>
</div>

<table id="tabla-rutas" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" data-unique-id="id" data-search-accent-neutralise="true" data-toolbar="#toolbar">
    <thead>
        <tr>
            <th class="text-center" data-formatter="getIndex">#</th>
            <th data-field="id">Cve</th>
            <th data-field="nombre" data-sortable="true">Nombre</th>
            <th data-field="desc" data-sortable="true">Descripción</th>
            <th data-field="area" data-sortable="true">Area</th>
            <th class="text-center" data-field="num" data-sortable="true">Estado - Número</th>
            <th class="text-center" data-field="accion" data-formatter="actionFormatter" data-events="actionEvents">Accion</th>
        </tr>
    </thead>
</table>

<script>
    <!---
    * Descripcion: llenar tabla con las rutas de un procedimiento en especifico
    * Fecha: Octubre de 2016
    * @author Alejandro Tovar
    --->
    var data = [];
    <cfif isDefined('prc.rutas.recordCount')>
        <cfloop index='i' from='1' to='#prc.rutas.recordCount#'>
            <cfoutput>
                data.push({
                    id: "#prc.rutas.PK[i]#",
                    nombre: "#prc.rutas.NOMBRE[i]#",
                    desc: "#prc.rutas.DESCR[i]#",
                    area: "#prc.rutas.AREA[i]#",
                    num: "#prc.rutas.EDONUM[i]#"
                });
            </cfoutput>
        </cfloop>
    </cfif>

    function getIndex(value, row, index) {
        return index+1;
    }

    function actionFormatter(value, row, index) {
        return [
            '<button class="btn btn-primary ml5 eliminar guiaEdoRutEliminar" data-tooltip="tooltip" title="Eliminar"> <i class="fa fa-trash"></i> </button>'
        ].join('');
    }

    $(document).ready(function() {
        $('#tabla-rutas').bootstrapTable();
        $('#tabla-rutas').bootstrapTable('hideColumn', 'id');
        $('#tabla-rutas').bootstrapTable('load', data);
    });

</script>