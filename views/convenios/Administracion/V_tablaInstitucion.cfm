<cfprocessingdirective pageEncoding="utf-8">
<table id="tabla-lista-institucion" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true"  data-search-accent-neutralise="true">
    <thead>
        <tr>
            <th data-formatter="getIndex" class="text-center">#</th>
            <th data-field="nombre">Nombre</th>
            <th data-field="ubicacion" data-sortable='true'>Ubicación</th>
            <th data-field="descripcion" data-sortable='true' >Descripción</th>
            <th data-field="id" data-sortable='true' >clave</th>
        	<th data-field="estado" class="text-center" data-field="accion" data-formatter="actionFormatter" data-events="actionEvents">Acciones</th> 
        </tr>
    </thead>
</table>

<script>
	var data = [];
    <cfif isDefined('prc.instituciones.recordCount')>
        <cfloop index='i' from='1' to='#prc.instituciones.recordCount#'>
            <cfoutput>
                data.push({
                    nombre: "#prc.instituciones.nombre[i]#",
                    ubicacion: "#prc.instituciones.direccion[i]#",
                    descripcion: "#prc.instituciones.descripcion[i]#",
                    id : "#prc.instituciones.pk[i]#",
              		estado: "<span class='badge badge-primary'>#prc.instituciones.EDO[i]#</span>" 
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
                
                '<button class="btn btn-info ml5 editar-institucion" data-tooltip="tooltip" title="Editar" data-toggle="modal" href="#mdl-admon-institucion"> <i class="fa fa-pencil"></i> </button>', //EDITAR REST
                '<button class="btn btn-warning ml5 eliminar-institucion" data-tooltip="tooltip" title="Desactivar" data-toggle="modal" href="#mdl-estado-institucion"> <i class="fa fa-times"></i> </button>' //DESACTIVAR
                
            ].join('');
        else
            return [
                '<button class="btn btn-success validar-usuario guiaPrivValidar" data-tooltip="tooltip" title="Validar" data-toggle="modal" href="#mdl-estado-usuario"> <i class="fa fa-thumbs-up"></i> </button>', //VALIDAR (habilitar)
            ].join('');
    }

    $(document).ready(function() {    
      	$("#tabla-lista-institucion").bootstrapTable(); 
        $('#tabla-lista-institucion').bootstrapTable('hideColumn', 'id');
        $('#tabla-lista-institucion').bootstrapTable('load', data);
    });
</script>