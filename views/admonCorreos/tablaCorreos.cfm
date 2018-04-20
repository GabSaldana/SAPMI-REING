<cfprocessingdirective pageEncoding="utf-8">

<div id="toolbar">
    <button type="button" class="btn btn-primary btn-outline dim" id="btn-agregarCorreo" onclick="obtienePlantillas(0,0,0);"><span class="glyphicon glyphicon-plus"></span> AGREGAR CORREO</button>
    <button type="button" class="btn btn-primary btn-outline dim" data-toggle="modal" href="#mdl-plantillas" onclick="obtieneHeader();"><span class="glyphicon glyphicon-list-alt"></span> Cabeceras</button>
    <button type="button" class="btn btn-primary btn-outline dim" data-toggle="modal" href="#mdl-plantillas" onclick="obtieneFooter();"><span class="glyphicon glyphicon-list-alt"></span> Pies de pagina</button>
    <button type="button" class="btn btn-primary dim pull-right" id="btn-historial-correos"><span class="fa fa-list-ol"></span> Historial de correos</button>
</div>

<table id="tabla-correos" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-unique-id="id" data-search-accent-neutralise="true">
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
    * Descripcion: Llena la tabla con los correos registrados
    * Fecha: Noviembre de 2016
    * @author SGS
    --->
    var data = [];
    <cfif isDefined('prc.correo.recordCount')>
        <cfloop index='i' from='1' to='#prc.correo.recordCount#'>
            <cfoutput>
                data.push({
                    id: "#prc.correo.PK[i]#",
                    nombre: "#prc.correo.NOMBRE[i]#",                    
                    descripcion: "#prc.correo.DESCRIPCION[i]#",
                    estado: "<span class='badge badge-primary'>#prc.correo.EDO[i]#</span>"
                });
            </cfoutput>
        </cfloop>
    </cfif>

    function getIndex(value, row, index) {
        return index+1;
    }

    function actionFormatter(value, row, index) {
        return [
            '<button class="btn btn-primary editarcorreo" data-tooltip="tooltip" title="Editar"> <i class="fa fa-pencil"></i> </button>',
            '<button class="btn btn-primary ml5 vistaprecorreo" data-tooltip="tooltip" title="Vista previa"> <i class="fa fa-crosshairs"></i> </button>',
            '<button class="btn btn-primary ml5 eliminarcorreo" data-tooltip="tooltip" title="Eliminar"> <i class="fa fa-trash"></i> </button>'      
        ].join('');
    }

    $(document).ready(function() {    
        $('#tabla-correos').bootstrapTable(); 
        // $('#tabla-correos').bootstrapTable('hideColumn', 'id');
        $('#tabla-correos').bootstrapTable('load', data);

        $("#btn-agregarCorreo").click(function(){
            $('#pnl-ncorreo').slideDown(1000,'easeOutExpo');
            $('#cajaCorreos').slideUp(1000,'easeOutExpo');
        });
        
    });

</script>