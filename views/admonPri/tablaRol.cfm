<cfprocessingdirective pageEncoding="utf-8">
<table id="tabla-lista" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true"  data-search-accent-neutralise="true">
    <thead>
        <tr>
            <th data-formatter="getIndex" class="text-center">#</th>
            <th data-field="nombre">Nombre</th>
            <th data-field="rol" data-sortable='true'>Prefijo</th>
            <th data-field="desc" data-sortable='true' >Descripción</th>
            <th data-field="modulo" data-sortable='true' >Modulo en que inicia la sesión</th>
            <th data-field="vertiente" data-sortable='true' >Vertiente</th>
            <th data-field="id" data-sortable='true' >clave</th>
            <th data-field="estado" class="text-center" data-field="accion" data-formatter="actionFormatter" data-events="actionEvents">Acciones</th>
        </tr>
    </thead>
</table>
<script>



     var data = [];
    <cfif isDefined('prc.roles.recordCount')>
        <cfloop index='i' from='1' to='#prc.roles.recordCount#'>
            <cfoutput>
                data.push({
                    nombre: "#prc.roles.nombre[i]#",
                    rol: "#prc.roles.usrname[i]#",
                    desc: "#prc.roles.descripcion[i]#",
                    id: "#prc.roles.cveusr[i]#",
                    modulo: "#prc.roles.modulo[i]#",
                    vertiente: "#prc.roles.vert[i]#",
                    estado: "<span class='badge badge-primary'>#prc.roles.EDO[i]#</span>"
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
                
                '<button class="btn btn-info ml5 editar-usuario-validado guiaPrivEditar" data-tooltip="tooltip" title="Editar" data-toggle="modal" href="#mdl-admon-usuario"> <i class="fa fa-pencil"></i> </button>', //EDITAR REST
                '<button class="btn btn-warning ml5 cancelar-usuario guiaPrivDesactivar" data-tooltip="tooltip" title="Desactivar" data-toggle="modal" href="#mdl-estado-usuario"> <i class="fa fa-thumbs-down"></i> </button>' //DESACTIVAR
                
            ].join('');
        else
            return [
                '<button class="btn btn-success validar-usuario guiaPrivValidar" data-tooltip="tooltip" title="Validar" data-toggle="modal" href="#mdl-estado-usuario"> <i class="fa fa-thumbs-up"></i> </button>', //VALIDAR (habilitar)
               
                
            ].join('');
    }

    $(document).ready(function() {    
      $("#tabla-lista").bootstrapTable(); 
        $('#tabla-lista').bootstrapTable('hideColumn', 'id');
        $('#tabla-lista').bootstrapTable('load', data);
    });

</script>



