<cfprocessingdirective pageEncoding="utf-8">
<table id="tabla-lista-modalidad" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true"  data-search-accent-neutralise="true">
    <thead>
        <tr>
            <th data-formatter="getIndex" class="text-center">#</th>
            <th data-field="nombre" data-sortable='true'>Nombre</th>
            <th data-field="id" data-sortable='true' >clave</th>
        	<th data-field="estado" class="text-center" data-field="accion" data-formatter="actionFormatter" data-events="actionEvents">Acciones</th> 
        </tr>
    </thead>
</table>

<script>
	var data = [];
    <cfif isDefined('prc.modalidades.recordCount')>
        <cfloop index='i' from='1' to='#prc.modalidades.recordCount#'>
            <cfoutput>
                data.push({
                    nombre: "#prc.modalidades.nombre[i]#",
                    id : "#prc.modalidades.pk[i]#",
              		estado: "<span class='badge badge-primary'>#prc.modalidades.EDO[i]#</span>" 
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
                
                '<button class="btn btn-info ml5 editar-modalidad" data-tooltip="tooltip" title="Editar" data-toggle="modal" href="#mdl-admon-modalidad"> <i class="fa fa-pencil"></i> </button>', //EDITAR REST
                '<button class="btn btn-warning ml5 eliminar-modalidad" data-tooltip="tooltip" title="Desactivar" data-toggle="modal" href="#mdl-estado-modalidad"> <i class="fa fa-times"></i> </button>' //DESACTIVAR
                
            ].join('');
        else
            return [
                '<button class="btn btn-success validar-usuario guiaPrivValidar" data-tooltip="tooltip" title="Validar" data-toggle="modal" href="#mdl-estado-usuario"> <i class="fa fa-thumbs-up"></i> </button>', //VALIDAR (habilitar)
            ].join('');
    }

    $(document).ready(function() {    
      	$("#tabla-lista-modalidad").bootstrapTable(); 
        $('#tabla-lista-modalidad').bootstrapTable('hideColumn', 'id');
        $('#tabla-lista-modalidad').bootstrapTable('load', data);
    });
</script>