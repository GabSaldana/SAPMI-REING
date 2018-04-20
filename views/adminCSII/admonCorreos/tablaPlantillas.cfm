<cfprocessingdirective pageEncoding="utf-8">

<table id="tabla-plantilla" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-unique-id="id" data-search-accent-neutralise="true">
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
    * Descripcion: Llena la tabla con las plantillas de cabecera o pie de pagina
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
    var data = [];
    <cfif isDefined('prc.plantilla.recordCount')>
        <cfloop index='i' from='1' to='#prc.plantilla.recordCount#'>
            <cfoutput>
                data.push({
                    id: '#prc.plantilla.PK[i]#',
                    nombre: '#prc.plantilla.NOMBRE[i]#',                    
                    descripcion: '#prc.plantilla.DESCRIPCION[i]#',
                    estado: '<span class="badge badge-primary">#prc.plantilla.EDO[i]#</span>'
                });
            </cfoutput>
        </cfloop>
    </cfif>

    function getIndex(value, row, index) {
        return index+1;
    }

    function actionFormatter(value, row, index) {
        return [
            '<button class="btn btn-primary editarplant" data-tooltip="tooltip" title="Editar"> <i class="fa fa-pencil"></i> </button>',
            '<button class="btn btn-primary ml5 vistapreplant" data-tooltip="tooltip" title="Vista previa"> <i class="fa fa-crosshairs"></i> </button>',
            '<button class="btn btn-primary ml5 eliminarplant" data-tooltip="tooltip" title="Eliminar"> <i class="fa fa-trash"></i> </button>'      
        ].join('');
    }

    $(document).ready(function() {    
        $('#tabla-plantilla').bootstrapTable(); 
        $('#tabla-plantilla').bootstrapTable('hideColumn', 'id');
        $('#tabla-plantilla').bootstrapTable('load', data);
    });

</script>