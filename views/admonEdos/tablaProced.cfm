<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla-proced" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" data-unique-id="id" data-search-accent-neutralise="true">
    <thead>
        <tr>
            <th class="text-center" data-formatter="getIndex">#</th>
            <th data-field="id">Cve</th>
            <th data-field="nombre" data-sortable="true">Nombre</th>
            <th class="text-center" data-field="vertiente" data-sortable="true">Vertiente</th>
            <th class="text-center" data-field="estado" data-sortable="true">Estado</th>
            <th class="text-center" data-field="accion" data-formatter="actionFormatter" data-events="actionEvents">Acciones</th>
        </tr>
    </thead>
</table>

<script>
    <!---
    * Descripcion: llenar tabla con las procedimientos registrados
    * Fecha: Octubre de 2016
    * @author Alejandro Tovar
    --->
    var data = [];
    <cfif isDefined('prc.proced.recordCount')>
        <cfloop index='i' from='1' to='#prc.proced.recordCount#'>
            <cfoutput>
                data.push({
                    id: "#prc.proced.PK[i]#",
                    nombre: "#prc.proced.NOMBRE[i]#",
                    vertiente: "#prc.proced.vert[i]#",
                    estado: "<span class='badge badge-primary'>#prc.proced.edo[i]#</span>"
                });
            </cfoutput>
        </cfloop>
    </cfif>

    function getIndex(value, row, index) {
        return index+1;
    }

    function actionFormatter(value, row, index) {
        return [
            '<button class="btn btn-primary route guiaProRutas" data-tooltip="tooltip" title="Rutas"> <i class="fa fa-road"></i> </button>',
            '<button class="btn btn-primary ml5 oper guiaProOperacion" data-tooltip="tooltip" title="Operaciones"> <i class="fa fa-plus"></i> </button>'      
        ].join('');
    }

    $(document).ready(function() {    
        $('#tabla-proced').bootstrapTable(); 
        $('#tabla-proced').bootstrapTable('hideColumn', 'id');
        $('#tabla-proced').bootstrapTable('load', data);
    });

</script>