<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla-rutas" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" data-unique-id="id" data-search-accent-neutralise="true">
    <thead>
        <tr>
            <th class="text-center" data-formatter="getIndex">#</th>
            <th data-field="id">Cve</th>
            <th data-field="nombre" data-sortable="true">Nombre</th>
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
                    nombre: "#prc.rutas.NOMBRE[i]#"
                });
            </cfoutput>
        </cfloop>
    </cfif>

    function getIndex(value, row, index) {
        return index+1;
    }

    function actionFormatter(value, row, index) {
        return [
            '<button class="btn btn-primary route ml5 guiaRutEstados" data-tooltip="tooltip" title="Estados"> <i class="fa fa-list-ol"></i> </button>', 
            '<button class="btn btn-primary relation ml5 guiaRutRelaciones" data-tooltip="tooltip" title="Relaciones"> <i class="fa fa-exchange"></i> </button>',  
            '<button class="btn btn-primary grafo ml5 guiaRutFlujos" data-tooltip="tooltip" title="Flujo de validación"> <i class="fa fa-area-chart"></i> </button>'
        ].join('');
    }

    $(document).ready(function() {    
        $('#tabla-rutas').bootstrapTable(); 
        $('#tabla-rutas').bootstrapTable('hideColumn', 'id');
        $('#tabla-rutas').bootstrapTable('load', data);
    });

</script>  
