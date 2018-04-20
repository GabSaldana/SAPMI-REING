<cfprocessingdirective pageEncoding="utf-8">
<table id="tabla-accion" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true"  data-search-accent-neutralise="true">
    <thead>
        <tr>
            <th data-formatter="getIndex" class="text-center">#</th>
            <th data-field="nombre">Nombre</th>
            <th data-field="rol" data-sortable='true'>Prefijo</th>
            <th data-field="desc" data-sortable='true' >Descripción</th>
            <th data-field="edo" data-sortable='true' >Estado</th>
            <th data-field="id" data-sortable='true' >PK</th>
            <th data-field="xx" class="text-center" data-field="accion" data-formatter="actionFormatter" data-events="actionEvents">Acciones</th>
        </tr>
    </thead>
</table>
<script>

     var data = [];
    <cfif isDefined('prc.modulos.recordCount')>
        <cfloop index='i' from='1' to='#prc.modulos.recordCount#'>
            <cfoutput>
                data.push({
                    nombre: "#prc.modulos.nombre[i]#",
                    rol: "#prc.modulos.CVE[i]#",
                    desc: "#prc.modulos.descripcion[i]#",
                    edo: "#prc.modulos.EDO[i]#",
                    id: "#prc.modulos.ID[i]#",
                    xx: "#prc.modulos.EDO[i]#",                    
                    estado: "<span class='badge badge-primary'>#prc.modulos.EDO[i]#</span>"
                });
            </cfoutput>
        </cfloop>
    </cfif>

    function getIndex(value, row, index) {
        return index+1;
    }

    function actionFormatter(value, row, index) {
        if($(row.estado).text() == "2")
            return [
                
                '<button class="btn btn-info ml5 editar-usuario-validado guiaPrivEditar" data-tooltip="tooltip" title="Editar" data-toggle="modal" href="#mdl-admon-accion"> <i class="fa fa-pencil"></i> </button>', //EDITAR REST
                '<button class="btn btn-warning ml5 cancelar-usuario guiaPrivDesactivar" data-tooltip="tooltip" title="Desactivar" data-toggle="modal" href="#mdl-estado-accion"> <i class="fa fa-thumbs-down"></i> </button>' //DESACTIVAR
                
            ].join('');
        else
            return [
                '<button class="btn btn-success validar-usuario guiaPrivValidar" data-tooltip="tooltip" title="Validar" data-toggle="modal" href="#mdl-estado-accion"> <i class="fa fa-thumbs-up"></i> </button>', //VALIDAR (habilitar)
               
                
            ].join('');
    }

    $(document).ready(function() {    
      $("#tabla-accion").bootstrapTable(); 
        $('#tabla-accion').bootstrapTable('hideColumn', 'id');
        $('#tabla-accion').bootstrapTable('hideColumn', 'edo');
        $('#tabla-accion').bootstrapTable('load', data);
    });

</script>
    