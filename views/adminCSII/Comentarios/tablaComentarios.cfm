<cfprocessingdirective pageEncoding="utf-8">

    <div class="col-lg-10 animated fadeInRight"> 
        <div class="mail-box-header">
            <div class="input-group pull-right mail-search">
                <input id="coment_usuario_buscar" class="form-control input-sm" name="search" placeholder="Buscar comentario" type="text" onkeyup="busqueda()">                
            </div>
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top:-25px; margin-right:-170px;">&times;</button>
            <h2> Comentarios (<cfoutput>#prc.noVistos.REL_NOVISTO#</cfoutput>) </h2>            

            <div class="mail-tools tooltip-demo m-t-md">
							
							<!--- OVERRIDE A ESTILO DE tablasDinamicas.css --->
            	<style type="text/css">
            		.btn-group>.btn:not(:first-child):not(:last-child):not(.dropdown-toggle){
            			border-top-right-radius: 0px;
  								border-bottom-right-radius: 0px;			
            		}
            	</style>
	            
	            <div class="btn-group" data-toggle="buttons">
	            	<div class="btn btn-primary" data-toggle="tooltip" data-placement="top" title="" data-original-title="Todos los comentarios">
	            		<input type="radio" name="filtro" value="2" onchange="consultarComentarios();" id="inTodos"><span class="fa fa-bullseye"></span>
	            	</div>
	            	<div class="btn btn-primary" data-toggle="tooltip" data-placement="top" title="" data-original-title="Comentarios no vistos">
	            		<input type="radio" name="filtro" value="0" onchange="consultarComentarios();"><span class="fa fa-eye-slash"></span>
	            	</div>
	            	<div class="btn btn-primary" data-toggle="tooltip" data-placement="top" title="" data-original-title="Comentarios vistos">
	            		<input type="radio" name="filtro" value="1" onchange="consultarComentarios();"><span class="fa fa-eye ml5"></span>
	            	</div>
	            	<div class="btn btn-primary" data-toggle="tooltip" data-placement="top" title="" data-original-title="Comentarios prioritarios">
	            		<input type="checkbox" id="filtImportant" onchange="soloImportantes();"> <span class="fa fa-exclamation ml5">
	            	</div>	              
							</div>     

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-lg ml5" data-dismiss="modal">Cerrar</button>
        </div>
        <div id="tabla_comentarios" class="mail-box">
            <table class="table table-hover table-mail">
                <tbody>
                    <cfoutput>
                        <cfloop query="prc.comentUsu">
                        	<cfif #REL_VISTO# EQ 0>
                            <tr class="unread nombre" style="cursor:pointer" onclick="comentByUsuarioUnread(#COMENT_PK#, #REL_PK#);">
                        	<cfelse>
                            <tr class="read nombre" style="cursor:pointer" onclick="comentByUsuarioRead(#COMENT_PK#);">
                        	</cfif>

	                					<td class="mail-ontact">
	                            <i class="fa fa-user"></i>&nbsp;&nbsp;#USUARIO_NOMBRE#                                    
	                            <cfif val(COMENT_PRIOR) eq 1>
	                                <span class="label label-danger pull-right importante"><i class="fa fa-exclamation"></i> Prioritario</span>
                              <cfelse>
                                  <span class="pull-right normal"></span>
	                            </cfif>                     	                            
	                          </td>
	                          <td class="mail-subject"><i class="fa fa-envelope"></i>&nbsp;&nbsp;#EDO_NOMBRE#</td>
	                          <td class="text-right mail-date"><i class="fa fa-clock-o"></i>&nbsp;&nbsp;#dateTimeFormat(COMENT_FECHA,"dd/mm/yyyy")# <small>#dateTimeFormat(COMENT_FECHA,"hh:nn tt")#</small></td>                                             
                        </cfloop>
                    </cfoutput>
                </tbody>                                                   
            </table>
        </div>                
        <div id="subject" class="hide"><h2> Comentarios </h2></div>
        <div class="mail-content" style="margin-left: 40px; margin-right: 40px; margin-top: 50px; word-wrap: break-word;"> </div>
    </div>


<script type="text/javascript">

		function busqueda(){					

      var tex = $('#coment_usuario_buscar').val().toUpperCase();
      var tex2 = $('#coment_usuario_buscar').val();
      /*oculta todos los reportes*/
      $('#tabla_comentarios .nombre').hide();
      /*muestra todos los que contengan el texto*/
      $('#tabla_comentarios .nombre').each(function(index,elem){
      		$(elem).find('td').each(function(index, el) {
      			if($(el).text().includes(tex) || $(el).text().includes(tex2)){
              $(el).parents().show();
          	}
      		});          
      });      
  	}

    $(document).ready(function(){

    });

</script>
