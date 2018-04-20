<cfprocessingdirective pageEncoding="utf-8">

<div id="toolbar">
    <button type="button" class="btn btn-primary btn-outline dim" data-toggle="modal" href="#mdl-relacion"><span class="glyphicon glyphicon-plus"></span> AGREGAR RELACIÓN</button>
</div>

<table id="tabla-rutas" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" data-unique-id="id" data-search-accent-neutralise="true" data-toolbar="#toolbar">
    <thead>
        <tr>
            <th class="text-center" data-formatter="getIndex">#</th>
            <th data-field="id">Cve</th>
            <th data-field="rol" data-sortable="true">Rol</th>
            <th data-field="accion" data-sortable="true">Acción</th>
            <th data-field="edUno" data-sortable="true">Estado actual</th>
            <th data-field="edDos" data-sortable="true">Estado siguiente</th>
            <th class="text-center" data-field="funcion" data-formatter="actionFormatter" data-events="actionEvents">Función</th>
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
    <cfif isDefined('prc.rel.recordCount')>
        <cfloop index='i' from='1' to='#prc.rel.recordCount#'>
            <cfoutput>
                data.push({
                    id: "#prc.rel.PK[i]#",
                    rol: "#prc.rel.NOMROL[i]#",
                    accion: "#prc.rel.NOMACCION[i]#",
                    edUno: "#prc.rel.EDOUNO[i]# -- ( #prc.rel.NUMUNO[i]# )",
                    edDos: "#prc.rel.EDODOS[i]# -- ( #prc.rel.NUMDOS[i]# )"
                });
            </cfoutput>
        </cfloop>
    </cfif>

    function getIndex(value, row, index) {
        return index+1;
    }

    function actionFormatter(value, row, index) {
        return [
            '<button class="btn btn-primary borrar" data-tooltip="tooltip" title="Borrar"> <i class="fa fa-trash"></i> </button>',
            '<button class="btn btn-primary ml5 accionOper" data-tooltip="tooltip" title="Operaciones" data-toggle="modal"> <i class="fa fa-plus"></i> </button>'
        ].join('');
    }

    $(document).ready(function() {    
        $('#tabla-rutas').bootstrapTable();
        $('#tabla-rutas').bootstrapTable('hideColumn', 'id');
        $('#tabla-rutas').bootstrapTable('load', data);
    });

</script>