<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="comparteReporte_js.cfm">


<!---Inicia Cuerpo de la vista--->
<div class="panel panel-danger"> 
    <div class="panel-heading"> 
        <i class="fa fa-info-circle"></i> Seleccione a los Usuarios con los que Desea Compartir el Reporte
    </div>

</div>

<table id="tabla_share_User"   class="table table-inverse table-responsive" data-pagination="true" data-maintain-selected="true" data-page-size="5" data-search="true" data-unique-id="id" >
    <thead >
        <tr class="success">
            <th class="text-center" data-field="id">#</th>
            <th class="text-center col-xs-1" data-field="nombre" data-sortable="true"><i class="fa fa-user"></i>Nombre</th>
            <th class="text-left col-xs-2" data-field="apPaterno" data-sortable="true"><i class="fa fa-user-o"></i>Apellido Paterno</th>
            <th class="text-left col-xs-2" data-field="apMaterno" data-sortable="true"><i class="fa fa-user-o"></i>Apellido Materno</th>
            <th class="text-center col-xs-1" data-field="rol" data-sortable="true"><i class="fa fa-mortar-board" ></i>Rol </th>
            <th class="text-center col-xs-4" data-field="dependencia" data-sortable="true"><i class="fa fa-mortar-board" ></i>Dependencia</th>
            <th class="text-center col-xs-4" data-field="data" data-sortable="true"><i class="fa fa-mortar-board" ></i>Data</th>
            <th class="text-center col-xs-1" data-field="Privilegio"  data-formatter="putDatos"  ><i class="glyphicon glyphicon-th" ></i>Privilegio<br>
            <input class="privilegioTodos" id="privilegioTodos" type="checkbox" onChange="privilegioCheck();"></th>
            <th class="text-center col-xs-4" data-field="relacion"  data-formatter="checkRelacion"><i class="fa fa-mortar-board" ></i>Relacion<br>
            <input class="compartirTodos" id="compartirTodos" type="checkbox" onChange="compartirCheck();"></th>
        </tr>
    </thead> 
</table>