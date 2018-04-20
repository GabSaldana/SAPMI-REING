 <!---
* =========================================================================
* IPN - CSII
* Sistema:SII
* Modulo:Administrador Procesos
* Fecha:06-07-2017
* Descripcion:
* Autor: Alejandro Rosales
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<button class="btn btn-primary   dim btn-dim btn-outline" id="agregar" type="button">Agregar proceso  <i class="fa fa-plus"></i></button>
<br>
<table id="tablaFormatoCap" class="table table-striped table-responsive" data-pagination="true" data-page-size="5" data-search="true" data-unique-id="id">
    <thead>
        <tr>
            <th class="text-left col-xs-4"  data-field="id"><center>ID</center></th>
            <th class="text-left col-xs-4"  data-field="proceso"><center>PROCESO</center></th>
            <th class="text-left col-xs-4"  data-field="desc"><center>DESCRIPCIÓN</center></th>
            <th class="text-left col-xs-4"  data-field="acciones" data-events="actionEvents"><center>ACCIONES</center></th>
        </tr>
    </thead>
    <cfif isDefined('prc.procesos.recordCount')>
        <tbody>
          <cfloop index='i' from='1' to='#prc.procesos.recordCount#'>
          <tr>
            <cfoutput>
            <td>#prc.procesos.PK[i]#</td>
            <td>#prc.procesos.NOMBRE[i]#</td>
            <td>#prc.procesos.DESCRIPCION[i]#</td>
            <td><center><button class="btn btn-warning btn-sm  edit-pr " data-tooltip="tooltip" title="Editar"><span class="glyphicon glyphicon-pencil"></span></button> 
            <button class=" btn btn-sm btn-info init-pr"  data-tooltip="tooltip" title="Inicializar" data-original-title="Inicializar chat"><i class="fa fa-refresh"></i></button> 
             <button class=" btn btn-sm btn-danger delete-pr"  data-tooltip="tooltip" title="Eliminar" data-original-title="Eliminar proceso"><i class="fa fa-trash"></i></button></center></td>
            </cfoutput>
          </tr>
        </cfloop>
        </tbody>
    </cfif>
</table>
<br>
         
 
<div id="createProcess" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Agregar proceso nuevo</h3>
            </div>
            <div class="modal-body">   
              <div class="form-group">
                <h4 >Ingrese el nombre del nuevo proceso</h4>     
                <input id="nombreP" type="text" placeholder="Nombre" class="form-control">
              </div>
              <div class="form-group">
                <h4 >Ingrese una descripción para el proceso</h4>
                <input id="descP" type="text" placeholder="Descripción" class="form-control">
              </div>                   
            </div>
            <div class="modal-footer">
                <button type="button" id="addProc" class="btn btn-primary confirm-copy-sr">Agregar</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</div>



<div id="deleteProcess" class="modal small inmodal fade modaltext" tabindex="-1" proc = "-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Eliminar proceso</h3>
            </div>
            <div class="modal-body">   
              <div class="form-group">
                <h3 >¿Esta seguro de que desea eliminar el proceso?</h3>     
              </div>                  
            </div>
            <div class="modal-footer">
                <button type="button" id="deleteProc" class="btn btn-primary">SI</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">NO</button>
         
            </div>
        </div>
    </div>
</div>

<div id="initProcess" class="modal small inmodal fade modaltext" tabindex="-1" proc = "-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Inicializar chat</h3>
            </div>
            <div class="modal-body">   
              <div class="form-group">
                <h3 >¿Esta seguro de que desea inicializar el chat de este proceso?</h3>     
              </div>                  
            </div>
            <div class="modal-footer">
                <button type="button" id="initProc" class="btn btn-primary">SI</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">NO</button>
         
            </div>
        </div>
    </div>
</div>

<div id="editProcess" class="modal small inmodal fade modaltext" tabindex="-1" proc = "-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title">Editar proceso</h3>
            </div>
            <div class="modal-body">   
               <div class="form-group">
                <h4 >Nombre del proceso</h4>     
                <input id="nombrePE" type="text" placeholder="Nombre" class="form-control">
              </div>
              <div class="form-group">
                <h4 >Descripción</h4>
                <input id="descPE" type="text" placeholder="Descripción" class="form-control">
              </div>                         
            </div>
            <div class="modal-footer">
                <button type="button" id="editProc" class="btn btn-primary">Actualizar</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
         
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
	var data = [];
  //addProc
  
    window.actionEvents = {
    'click .edit-pr': function (e, value, row, index) {
            
        $('#editProcess').attr("proc",row.id);
        $('#nombrePE').attr("value",row.proceso);
        $('#descPE').attr("value",row.desc);
        
        $('#editProcess').modal('toggle');
        },
    'click .delete-pr': function (e, value, row, index) {
        $('#deleteProcess').attr("proc",row.id);
        $('#deleteProcess').modal('toggle');
        },
    'click .init-pr': function (e, value, row, index) {
        $('#initProcess').attr("proc",row.id);
        $('#initProcess').modal('toggle');
        }


   };
   
	$(document).ready(function() {    
    $('#tablaFormatoCap').bootstrapTable(); 
    $('#tablaFormatoCap').bootstrapTable("hideColumn","id"); 
    $("#agregar").on('click',
      function (){
        $('#createProcess').modal('toggle');
      });

    $("#deleteProc").on('click',
      function (){
        $.post('admonChat/eliminarProceso', {
          pk:$("#deleteProcess").attr("proc")  }, function(data){
                if(data > 0){
                location.reload();
              }          
            });
      });
     $("#initProc").on('click',
      function (){
        $.post('admonChat/inicializarProceso', {
          pk:$("#initProcess").attr("proc")  }, function(data){
                if(data > 0){
                location.reload();
              }          
            });
      });
    $("#editProc").on('click',
      function (){
        var pk = $("#editProcess").attr("proc");
        var name = $("#nombrePE").val();
        var desc = $("#descPE").val();
        $.post('/index.cfm/admonChat/admonChat/editarProceso', {
          pk:pk, name:name, desc:desc  }, function(data){
                if(data > 0){
                location.reload();
              }          
            });
      });
    $("#addProc").on('click',
       function (){
         if($("#nombreP").val() != "" && $("#descP").val() ){

         $.post('admonChat/agregarProceso', {
           name:$("#nombreP").val() , desc:$("#descP").val() }, function(data){
             if(data > 0){
              location.reload();
             }
             else{
              alert("El nombre del proceso ya existe");
             }
           });
         }
         else{
           alert("Llene los campos.");
         }
       });

  });
</script>