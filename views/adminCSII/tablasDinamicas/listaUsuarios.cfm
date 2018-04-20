<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Tablas de Usuarios
* Fecha 28 de Marzo de 2017
* Descripcion:
* Vista  para el submodulo de Tablas de Usuarios
* Autor: Jonathan Martinez
* ================================
--->
 <cfprocessingdirective pageEncoding="utf-8">
 <cfinclude template="listaUsuarios_js.cfm">
 <!---Inicia Cuerpo de la vista--->
 <div class="panel panel-info"> 
     <div class="panel-heading"> 
         <i class="fa fa-child"></i><cfoutput> Tabla Compartida </cfoutput>
     </div>
     <p align="center">Seleccione a los usuarios con los que desea compartir la tabla</p>
 </div>
 <table id="tabla_share_User"  class="table table-inverse table-responsive" data-pagination="true" data-maintain-selected="true" data-page-size="5" data-search="true" data-unique-id="id" >
     <thead >
         <tr class="info">
             <th class="text-center" data-field="id">#</th>
             <th class="text-left col-xs-2" data-field="apPaterno" data-sortable="true"><i class="fa fa-user-o"></i>Apellido Paterno</th>
             <th class="text-left col-xs-2" data-field="apMaterno" data-sortable="true"><i class="fa fa-user-o"></i>Apellido Materno</th>
             <th class="text-center col-xs-2" data-field="nombre" data-sortable="true"><i class="fa fa-user"></i> Nombre</th>
             <th class="text-center col-xs-3" data-field="rol" data-sortable="true"><i class="fa fa-mortar-board" ></i> Rol</th>
             <th class="text-center col-xs-2" data-field="share" data-sortable="true"><i class="fa fa-refresh"></i> Último Compartir</th>
             <th class="text-center col-xs-1" data-field="compartir" data-checkbox="true" ></th>
         </tr>
     </thead>
 </table>