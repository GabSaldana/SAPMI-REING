<cfprocessingdirective pageEncoding="utf-8">
<table id="tabla-usuarios" class="table table-striped table-responsive" data-pagination="true" data-page-size="10" data-search="true" data-unique-id="id" data-search-accent-neutralise="true">
    <thead>
        <tr>
            <th class="text-center" data-formatter="getIndex">#</th>
            <th data-field="id">Cve</th>
            <th data-field="nombre" data-sortable="true">Nombre</th>
            <th data-field="rol" data-sortable="true">Rol</th>
            <th data-field="usuario" data-sortable="true">Usuario</th>
            <th data-field="vertiente" data-sortable="true">Vertiente</th>
            <th class="text-center" data-field="accion" data-formatter="actionFormatter" data-events="actionEvents">Acciones</th>
        </tr>
    </thead>
</table>

<script>
    <!---
        * Descripcion: llenar tabla con los usuarios de un sistema específico
        * Fecha: agosto/2016
        * @author Yareli Andrade
    --->
    var data = [];
    <cfif isDefined('prc.usuarios.recordCount')>
        <cfloop index='i' from='1' to='#prc.usuarios.recordCount#'>
            <cfoutput>
                data.push({
                    id: "#prc.usuarios.cveusr[i]#",
                    nombre: "#prc.usuarios.nombre[i]#",
                    rol: "#prc.usuarios.rol[i]#",
                    usuario: "#prc.usuarios.usrname[i]#",
                    vertiente: "#prc.usuarios.vert[i]#",      
                    correo: "#prc.usuarios.correo[i]#",                   
                    estado: "<span class='badge badge-primary'>#prc.usuarios.edo[i]#</span>"
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
                '<button class="btn btn-primary valid" data-tooltip="tooltip" title="Validado"> <i class="fa fa-lock"></i> </button>', //VALIDADO
                '<button class="btn btn-white ml5 enviar-pwd" data-tooltip="tooltip" title="Enviar contraseña"> <i class="fa fa-key"></i> </button>', //CONTRASEÑA
                '<button class="btn btn-info ml5 editar-usuario-validado" data-tooltip="tooltip" title="Editar" data-toggle="modal" href="#mdl-admon-usuario"> <i class="fa fa-pencil"></i> </button>', //EDITAR REST
                '<button class="btn btn-warning ml5 cancelar-usuario" data-tooltip="tooltip" title="Desactivar" data-toggle="modal" href="#mdl-estado-usuario"> <i class="fa fa-times"></i> </button>' //DESACTIVAR
                
            ].join('');
        else
            return [
                '<button class="btn btn-success validar-usuario" data-tooltip="tooltip" title="Validar" data-toggle="modal" href="#mdl-estado-usuario"> <i class="fa fa-unlock"></i> </button>', //VALIDAR
                '<button class="btn btn-info ml5 editar-usuario" data-tooltip="tooltip" title="Editar" data-toggle="modal" href="#mdl-admon-usuario"> <i class="fa fa-pencil"></i> </button>', //EDITAR
                '<button class="btn btn-danger ml5 eliminar-usuario" data-tooltip="tooltip" title="Eliminar" data-toggle="modal" href="#mdl-estado-usuario"> <i class="fa fa-trash"></i> </button>' //ELIMINAR
                
            ].join('');
    }

    $(document).ready(function() {    
        $('#tabla-usuarios').bootstrapTable(); 
        $('#tabla-usuarios').bootstrapTable('hideColumn', 'id');
        $('#tabla-usuarios').bootstrapTable('load', data);

        tl.pg.init({
             "pg_caption": "Gu&#237;a",
              "auto_refresh": true ,
              "default_zindex":9999,
              "custom_open_button":'#guiaPaginaActual'
        });
    });

</script>



<ul id="tlyPageGuide" data-tourtitle="Administración de usuarios.">

    <li class="tlypageguide_top" data-tourtarget=".btn-crear">
        <div>
            Crear un nuevo usuario.
        </div>
    </li>

    <li class="tlypageguide_top" data-tourtarget=".valid">
        <div>
            Indicador de usuario validado.
        </div>
    </li>

    <li class="tlypageguide_top" data-tourtarget=".enviar-pwd">
        <div>
            Enviar cuenta de usuario y contraseña al correo asociado a la cuenta.
        </div>
    </li>

    <li class="tlypageguide_top" data-tourtarget=".editar-usuario-validado">
        <div>
            Editar el registro del usuario validado.
        </div>
    </li>

    <li class="tlypageguide_top" data-tourtarget=".cancelar-usuario">
        <div>
            Desactivar la cuenta de usuario.
        </div>
    </li>

</ul>