<cfprocessingdirective pageEncoding="utf-8">

<div id="modal_comentarios" class="modal-content">    
    <div class="modal-body">        
        <div class="row">    
            <div class="col-md-12">
                <div class="mail-box-header">
                        <div class="pull-right mail-search">
                        	<div class="input-group">
                            <input id="coment_convenio_buscar" type="text" class="form-control input-sm" name="search" placeholder="Buscar Comentario" onkeyup="busqueda();">
                        </div>
                      </div>
                    <form method="get" action="index.html" class="pull-right mail-search">
                    </form>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top:-25px; margin-right:-170px;">&times;</button>
                    <h2 id="coment_titulo">
                        Comentarios (<cfoutput>#prc.coment.recordCount#</cfoutput>)
                    </h2>
                    <div class="mail-tools tooltip-demo m-t-md clearfix">
                        <div class="btn-group pull-right">
                            <button id="coment_atras" class="btn btn-white btn-sm" onclick="consultarComentario()" style="display:none"><i class="fa fa-arrow-left"></i></button>
                        </div>                
                    </div>
                </div>

                <div id="coment_tabla" class="mail-box">
                    <table class="table table-hover table-mail">
                        <tbody>
                            <cfoutput>
                                <cfloop query="prc.coment">
                                    <tr class="comentario" style="cursor:pointer" onclick="contentComent(#COMENT_PK#)">                                                
                                        <td class="mail-ontact">
                                            <i class="fa fa-user"></i>&nbsp;&nbsp;#USUARIO_NOMBRE#                                    
                                            <cfif val(COMENT_PRIOR) eq 1>
                                                <span class="label label-danger pull-right"><i class="fa fa-exclamation"></i> Prioritario</span>
                                            </cfif>                                    
                                        </td>
                                        <td class="mail-subject"><i class="fa fa-envelope"></i>&nbsp;&nbsp;#COMENT_ASUNTO#</td>                                                                        
                                        <td class="text-right mail-date"><i class="fa fa-clock-o"></i>&nbsp;&nbsp;#dateTimeFormat(COMENT_FECHA,"dd/mm/yyyy")# <small>#dateTimeFormat(COMENT_FECHA,"hh:nn tt")#</small></td>
                                    </tr>                   
                                </cfloop>
                            </cfoutput>
                        </tbody>                                                   
                    </table>
                </div>
                
                <div style="padding:0px 20px;display:none;word-wrap:break-word" class="mail-box">
                    <blockquote style="display:none" id="coment_contenido"></blockquote>
                </div>

            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default btn-lg ml5" data-dismiss="modal">Cerrar</button>
    </div>
</div>

<script type="text/javascript">   

		<!---
    * Fecha : Octubre de 2017
    * Autor : Daniel Memije
    * Comentario: Busqueda de comentarios
    --->
		function busqueda(){					
      var tex = $('#coment_convenio_buscar').val().toUpperCase();
      var tex2 = $('#coment_convenio_buscar').val();
      /*oculta todos los reportes*/
      $('#coment_tabla .comentario').hide();
      /*muestra todos los que contengan el texto*/
      $('#coment_tabla .comentario').each(function(index,elem){
      		$(elem).find('td').each(function(index, el) {
      			if($(el).text().includes(tex) || $(el).text().includes(tex2)){
              $(el).parents().show();
          	}
      		});          
      });      
  	} 

    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene el contenido de un contenido en especifico
    --->  
    function contentComent(pkComent){        
        $.post('<cfoutput>#event.buildLink("adminCSII.comentarios.comentarios.getContenidoComent")#</cfoutput>', {
            pkComent: pkComent
        },
        function(data){
            $('#coment_atras').fadeIn();
            $("#coment_titulo").fadeOut(function() {                
                $(this).html(data.DATA.ASUNTO[0]).fadeIn();
            });
            $('#coment_contenido').closest('div').show(function(){
                $('#coment_tabla').slideUp(function(){
                    $('#coment_contenido').html(data.DATA.COMENTARIO[0]).slideDown(300);
                });
            });                                
        });
    }

    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene los comentarios dirigidos al usuario.
    --->
    function consultarComentario(){
        $('#coment_atras').fadeOut();
        $("#coment_titulo").fadeOut(function() {
            $(this).html("Comentarios (<cfoutput>#prc.coment.recordCount#</cfoutput>)").fadeIn();
        });
        $('#coment_contenido').slideUp(300,function(){
            $('#coment_tabla').slideDown(300, function(){                                
            }); 
        });
    }

</script>
