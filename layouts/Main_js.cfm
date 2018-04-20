<cfprocessingdirective pageEncoding="utf-8"> 
<script type="text/javascript">
	var totalTiempo = 120;
	function atencion(){
		 $('#guiaPaginaActual').removeClass('animated rubberBand').delay(1000).queue(function(next) {
      $(this).addClass('animated rubberBand');
      next();
    });
	}

    function cargarModalComentarios(pkRegistro,tipo){//0 - Documento, 1 - Convenio
        $("#pkRegistroComentario").val(pkRegistro);
        var tipoComentario = tipo ? '<cfoutput>#application.SIIIP_CTES.TIPOCOMENTARIO.CONVENIO#</cfoutput>' : '<cfoutput>#application.SIIIP_CTES.TIPOCOMENTARIO.DOCUMENTO#</cfoutput>';
        $("#pkTipoComentario").val(tipoComentario);

        $.post('<cfoutput>#event.buildLink("adminCSII.comentarios.comentarios.getComentariosReg")#</cfoutput>', {
            pkRegistro: pkRegistro,
            pkTipoComent: tipoComentario
        },
        function(data){     
            if ($('body > #modal_comentarios_container').length) {        
                $('#modal_comentarios_container').modal('show');
            }else {        
                $('#modal_comentarios_container').appendTo("body").modal('show');
            }   
            $('#modal_comentarios_container .contnido').html(data);
            $("#modal_comentarios_container .mail-comentarios").show();
            $("#modal_comentarios_container .mail-contenido").hide();
        });
    }

    function cargarDocumento(data){
        var liga = window.location.href;
        var tamano = liga.length;
        var param = liga.substring(tamano - 4, tamano - 1);


        var str;
        var patt = /^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$/; //Patron para comprobar que la cadena sea base64
        $('#agregarDocto').html('');
        if(data.match(patt)){ //Si la cadena es base64 insertarla en un objeto 

            var decod = window.atob(data);
            if(decod.includes('%PDF')){
                str = "<div>" +
                  "  <div>" +
                  "     <object data='data:application/pdf;base64," + data + "' type='application/pdf' width='100%' height='100%'></object>" +
                  "  </div>" +
                  "</div>";
            }else{
                str = "<div>" +
                  "  <div>" +
                  "     <img src='data:image/jpg;base64," + data + "' width='100%' height='100%'></object>" +
                  "  </div>" +
                  "</div>";
            }


        }else{ //Si no, mostrar el error
          str = '<div style="display: table; background:#eee; width:100%; height: 100%; overflow: hidden;"><div style="display: table-cell; text-align: center; vertical-align: middle;"><div><span class="fa-stack fa-5x" style=""><i class="fa fa-file-o fa-stack-2x"></i><span class="fa-stack" style="top: 35px;left: -35px;"><i class="fa fa-circle fa-stack-2x text-danger"></i><i class="fa fa-exclamation fa-stack-1x" style="color: #fff;"></i></span></span><h1 style="font-size: 20px;padding-top:20px;">No se ha podido cargar el documento</h1></div></div></div>';
        }
        $("#agregarDocto").html(str);      

        // <cfoutput>#Session.cbstorage.usuario.ROL#</cfoutput> != <cfoutput>#application.SIIIP_CTES.ROLES.ANALISTADINV#</cfoutput>
        if( param != "tc=" ){
            mostrarVisor();
        }
    }

    function mostrarVisor(){
        $('.visorDocumentos').remove();
        $("#contenedorVisorDocumentos").dialog({
          height: $(window).height()*0.85,
          width : $(window).width()*0.50,
          classes:{
            "ui-dialog": "visorDocumentos"
          },          
          show: true,
          hide: true,
          minHeight: $(window).height()*0.55,
          minWidth: $(window).width()*0.20,
          close: function(){
            $("#contenedorVisorDocumentos").dialog('option','position',{
              my: "center", 
              at: "center", 
              of: window
            });
            $('#contenedorVisorDocumentos').dialog('destroy');
          }
        });

        var draggableArguments={      
          appendTo: 'body',
          containment:'window',
          scroll: false                   
        };

        $('.ui-dialog').draggable(draggableArguments);

        var html =  '<div class="btn-group pull-right">'+                                                                               
        '<span id="visorDocumentos-size" class="btn btn-success btn-sm">'+
        '<span class="fa fa-window-maximize"></span>'+
        '</span>'+
        '<span class="btn btn-danger btn-sm" onclick="cerrarVisor();">'+
        '<span class="fa fa-times"></span>'+
        '</span>'+
        '</div>';

        $('.visorDocumentos .ui-dialog-titlebar').html(html);       

        $('#visorDocumentos-size').one('click', maximizarVisor);
    }

    function cerrarVisor(){
        $("#contenedorVisorDocumentos").dialog('close');        
    }

    function maximizarVisor(){
        $("#contenedorVisorDocumentos").dialog('option','position',{
            my: "center", 
            at: "center", 
            of: window
        });

        $("#contenedorVisorDocumentos").dialog("option","height",$(window).height());
        $("#contenedorVisorDocumentos").dialog("option","width",$(window).width());
        $('#visorDocumentos-size').html('<span class="fa fa-window-restore"></span>');      
        $('#visorDocumentos-size').one('click', restaurarVisor);
    }

    function restaurarVisor(){
        $("#contenedorVisorDocumentos").dialog('option','position',{
            my: "center", 
            at: "center", 
            of: window
        });
        $("#contenedorVisorDocumentos").dialog("option","height",$(window).height()*0.85);
        $("#contenedorVisorDocumentos").dialog("option","width",$(window).width()*0.50);                
        $('#visorDocumentos-size').html('<span class="fa fa-window-maximize"></span>');     
        $('#visorDocumentos-size').one('click', maximizarVisor);
    }

  	//Variables relacionadas con el chat
	var bandeja=0;
	var idanimacion=0;
	var idcanal=0;
	var buzon=[];
	var chatactual="";

	$(document).ready(function(){

		window.setInterval(atencion,15000);
		updateReloj();
		//Carga los procesos registrados
     	CargarProcesos();
     	$('.bandeja').html(bandeja);

		ComentariosNoVistos();

		toastr.options = {
		  "closeButton": true,
		  "debug": false,
		  "progressBar": true,
		  "preventDuplicates": false,
		  "newestOnTop": true,
		  "positionClass": "toast-top-right",
		  "onclick": null,
		  "showDuration": "400",
		  "hideDuration": "1000",
		  "timeOut": "4000",
		  "extendedTimeOut": "2000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
		};

		$("ul.nav li.active").parents("li").addClass("active");
		$("ul.nav li.active").parents("ul").addClass("in");

		$(document).tooltip({
		  selector: '[data-toggle="tooltip"]'
		});

		tl.pg.init({
		 "pg_caption": "Gu&#237;a",
		 "auto_refresh": true ,
		 "default_zindex":9999,
		 "custom_open_button":'#guiaPaginaActual'    
		});

		$("#btn-desactivar").on("click", function() {
    		$.post('<cfoutput>#event.buildLink("adminCSII.administracion.usuarios.desactivarCuenta")#</cfoutput>', function(data) {
    		    if (data > 0) {
    		      $("#mdl-desactivar").modal('toggle');
    		      $('#endSession').submit();
    		    }else {
    		      toastr.error('Hubo un problema al tratar de desactivar la cuenta.');
    		    }
    		});
		});

     	//Codigo para enviar el Mensaje
	    $("#msg").on('keyup', function (e) { 
	        if (e.keyCode == 13) { 
	            var text = $("#msg").val();
	            if (text=="")
	                return;
	            var msg={user:$('#username').val(),texto:text,canal:chatactual, nombre:$('.tituloChat').text()};
	            myWS.publish(chatactual, msg);
	            $("#msg").val("");
	        } 
	    });
	    $(".enviar").on("click", function() {
	        var text = $("#msg").val();
	        if (text=="")
	           return;
	        var msg={user:$('#username').val(),texto:text,canal:chatactual, nombre:$('.tituloChat').text()};
	        myWS.publish(chatactual, msg);
	        $("#msg").val("");
	    });
     	//Boton para abrir el chat
	    $('.open-chat').click(function(){
	        $(this).children().toggleClass('fa-minus').toggleClass('fa-comments');
	        $('.small-chat-box').toggleClass('active');
	        $(".content").animate({ scrollTop: $('.content')[0].scrollHeight},0); 
	        clearInterval(idanimacion);
	        bandeja=0;
	        $('.bandeja').html(bandeja);
	    });
     	//Boton para minimizar el chat
	    $('.minimizar').click(function(){
	        $('.open-chat').children().toggleClass('fa-minus').toggleClass('fa-comments');
	        $('.small-chat-box').toggleClass('active');
	    });
	    $('body').on('click', '.group', function () {
	        //Carga el chat seleccionado y vacia el buzon de pendientes
	        $('.content').empty();
	        chatactual=$(this).attr("title");
	        CargarChat(chatactual);
	        $('.tituloChat').html($(this).attr("id"));
	        $(this).html("<i class=' fa fa-comment-o' style='font-size:25px; color:#BDBDBD'></i> "+$('.tituloChat').text()+"</div>");
	        $(".content").animate({ scrollTop: $('.content')[0].scrollHeight+500000});
	        $.post('<cfoutput>#event.buildLink("adminCSII.chat.administradorChat.eliminarBuzon")#</cfoutput>',{
	            username: $('#username').val(), nombre: $(this).attr("id")
	        },
	        function(data){
	        });
	    });

	});	


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene los comentarios dirigidos al usuario.
    --->  
    function consultarComentarios(tipoComentario){

        if(tipoComentario != undefined){
          $("#inpkTipoComentario").val(tipoComentario);
        }

        var filtroVal = $('input:radio[name=filtro]:checked').val();

        if(filtroVal == undefined){
          filtroVal = 2;
        }

        $.post('<cfoutput>#event.buildLink("adminCSII.comentarios.comentarios.getComentariosByUsuario")#</cfoutput>', {
            pkUsuario: <cfoutput>#session.cbStorage.usuario.pk#</cfoutput>,
            filtro: filtroVal,
            pkTipoComent: $("#inpkTipoComentario").val()
        }, ///
          function(data){

            if ($('input:radio[name=filtro]:checked').val() == undefined){
              $("#inTodos").parent().addClass('active');
              $("#inTodos").attr('checked', 'checked');
            }

            $('#mdl-msjs').modal('show');
            $('#mdl-msjs .comentarios').html(data);

            $("#mdl-msjs .mail-box").show();
            $("#mdl-msjs .mail-box-header").show();
            $('#mdl-msjs .mail-content').hide();
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene el contenido de un contenido en especifico que no ha sido visto.
    --->  
    function comentByUsuarioUnread(pkComent, pkRel){
        $.post('<cfoutput>#event.buildLink("adminCSII.comentarios.comentarios.getContenidoComent")#</cfoutput>', {
          pkComent: pkComent
        },
        function(data){
            $("#mdl-msjs .mail-box").hide();
            $("#mdl-msjs .mail-box-header").hide();
            $('#mdl-msjs .mail-content').show().html(data.DATA.COMENTARIO[0]);
            $("#subject").removeClass('hide');
            $('#mdl-msjs #subject h2').html(data.DATA.ASUNTO[0]);
            var mensaje = Number($("#noVistos").text());
            mensaje -= 1;
            $("#noVistos").text(mensaje);  
            comentarioVisto(pkRel);
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene el contenido de un contenido en especifico que ya fue visto.
    --->  
    function comentByUsuarioRead(pkComent){
        $.post('<cfoutput>#event.buildLink("adminCSII.comentarios.comentarios.getContenidoComent")#</cfoutput>', {
          pkComent: pkComent
        },
        function(data){
          $("#mdl-msjs .mail-box").hide();
          $("#mdl-msjs .mail-box-header").hide();
          $('#mdl-msjs .mail-content').show().html(data.DATA.COMENTARIO[0]);
          $("#subject").removeClass('hide');
          $('#mdl-msjs #subject h2').html(data.DATA.ASUNTO[0]);
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Registra que el comentario fue visto.
    --->
    function comentarioVisto(pkRelacion){
        $.post('<cfoutput>#event.buildLink("adminCSII.comentarios.comentarios.setVisto")#</cfoutput>', {
            pkComentRel: pkRelacion
        },
        function(data){
            ComentariosNoVistos();
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Funcion que muestra solo los comentarios importantes.
    --->
    function soloImportantes(){
        if ($("#filtImportant").prop('checked')) {
          $(".normal").parent().parent().hide();
        }else {
          $(".normal").parent().parent().show();
        }
    }


    <!---
    * Fecha : Febrero de 2017
    * Autor : Alejandro Tovar
    * Comentario: Funcion que muestra los comentarios no vistos.
    --->
    function ComentariosNoVistos(){
        $.post('<cfoutput>#event.buildLink("adminCSII.comentarios.comentarios.getComentariosNoVistos")#</cfoutput>',{
          pkUsuario: <cfoutput>#Session.cbstorage.usuario.PK#</cfoutput>
        },///
        function(data) {
          $("#noVistos").text(data.DATA.REL_NOVISTO[0]);
        });
    } 

    //Manejadores de eventos para el chat
    function errorHandler(e) {
        console.log("Error");
        console.dir(e);
    }

    function messageHandler(msg) {
        //console.log("messageHandler Run");
        console.dir(msg);
        var f=new Date();
        if (msg.reqType == "welcome")
             idcanal=msg.clientid;
        if (msg.type == "data") {
            if(msg.data.canal==chatactual){
                 $(".content").animate({ scrollTop: $('.content')[0].scrollHeight},500);
                if (msg.publisherid == idcanal){
                     $('.content').append("<div class='left'><div class='author-name'>"+msg.data.user+" <small class='chat-date'>"+f.getHours()+":"+f.getMinutes()+"</small></div><div class='chat-message active' style='word-wrap: break-word;'>"+msg.data.texto+"</div></div>");
                    $.post('<cfoutput>#event.buildLink("adminCSII.chat.administradorChat.guardarChat")#</cfoutput>',{
                        user: msg.data.user, texto:msg.data.texto, hora:f.getHours()+":"+f.getMinutes(), proceso:chatactual
                    },
                    function(data) {
                    })
                }else {
                    $('.content').append("<div class='right'><div class='author-name'>"+msg.data.user+" <small class='chat-date'>"+f.getHours()+":"+f.getMinutes()+"</small></div><div class='chat-message' style='word-wrap: break-word;'>"+msg.data.texto+"</div></div>");  
                }
            }else {
                //Efecto de animacion al recibir mensajes
                $('#'+msg.data.nombre).effect( "highlight", {color:"#CEE3F6"}, 3000 );
                $('#'+msg.data.nombre).html("<i class=' fa fa-comment-o' style='font-size:25px; color:#2E9AFE'></i> "+msg.data.nombre+" ");
                //Guarda menssje en el buzon de pendientes
                $.post('<cfoutput>#event.buildLink("adminCSII.chat.administradorChat.guardarBuzon")#</cfoutput>',{
                     username: $('#username').val(), nombre: msg.data.nombre
                },
                function(data){
                });
            }
             //Verifica si burbuja de mensajes está abierta o no
            if ($('.open-chat').children().hasClass("fa-comments")){
                if(bandeja==0)
                    idanimacion=setInterval(animacion, 2000);
                bandeja++;     
            }else {
                clearInterval(idanimacion);
                bandeja=0;
            }
            $('.bandeja').html(bandeja);
        }
    }

    //Animacion de entrada de mensaje
    animacion = function(){
        $(".bandeja").fadeTo(500, .1).fadeTo(500, 1);
    }


    <!---
    * Fecha : Junio de 2017
    * Autor : Jonathan Martinez
    * Comentario: Funcion para cargar las conversaciones guardadas en Cache.
    --->  
    function CargarChat(canal){
        $.post('<cfoutput>#event.buildLink("adminCSII.chat.administradorChat.obtenerChat")#</cfoutput>',{
            canal: canal
        },
        function(data){
            if(data != 0){
                for(var i=0; i < data.length; i++){
                    if (data[i]['username'] == $('#username').val()){
                         $('.content').append("<div class='left'><div class='author-name'>"+data[i]['username']+" <small class='chat-date'>"+data[i]['hour']+"</small></div><div class='chat-message active' style='word-wrap: break-word;'>"+data[i]['msg']+"</div></div>");  
        
                    }
                    else
                        $('.content').append("<div class='right'><div class='author-name'>"+data[i]['username']+"<small class='chat-date'>"+data[i]['hour']+"</small></div><div class='chat-message' style='word-wrap: break-word;'>"+data[i]['msg']+"</div></div>");  
                }
            }
        });
    }

    <!---
    * Fecha : Junio de 2017
    * Autor : Jonathan Martinez
    * Comentario: Funcion para cargar los procesos asignados.
    --->  
    function CargarProcesos(){
        $.post('<cfoutput>#event.buildLink("adminCSII.chat.administradorChat.obtenerProcesos")#</cfoutput>',{
            rol:$('#userrol').val()
        },
        function(data){
            if (data != 0){
                for(var i=0; i < data.length ;i++){
                    if (data[i].entrada.indexOf($('#username').val())>=0)
                         $('.process').append("<div class='group' id='"+data[i].nombre+"' title='"+data[i].subcanal+"'><i class=' fa fa-comment-o' style='font-size:25px; color:#2E9AFE'></i> "+data[i].nombre+"");
                    else
                        $('.process').append("<div class='group' id='"+data[i].nombre+"' title='"+data[i].subcanal+"'><i class=' fa fa-comment-o' style='font-size:25px; color:#BDBDBD'></i> "+data[i].nombre+"</div>");
                }
                CargarChat(data[0].subcanal);
                chatactual=data[0].subcanal;
                $('.tituloChat').text(data[0].nombre);                  

            }else {
                $('#small-chat').hide();
            }
        });

    }

    <!---
    * Descripcion:  Función mostrar los datos del Usuario". 
    * Fecha:    5 abril 2017.
    * Autor:    Roberto Cadena.
    ---> 
    function getUsuariosMain() {
        $.post('<cfoutput>#event.buildLink("adminCSII.usuarios.usuarios.getUsuariosMain")#</cfoutput>', {},
        function(data){
            $('#mdl-admon-usuario-main').modal('show');
            $('#admonUsuarios').html(data);
        });
    }


    /************Guarda Archivo ********************************************/
    function saveFile(input) {
        if ($(input).val() != ""){
            var formData = new FormData();
            formData.append('image',$('input[type=file]')[0].files[0]);
            jQuery.ajax({
                url: '<cfoutput>#event.buildLink("adminCSII.chat.administradorChat.saveFile")#</cfoutput>',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                type: 'POST'
            }).done(function(data) {
                param = data.split(";");
                console.log(param);
                if (param[0]=="IMG"){
                    var text="<a id='linkImg' href='"+param[1]+"' download><img id='blah' src='"+param[1]+"' width=100% height=100%/></a>"
                }else {
                    var text="<div id='fileIn'><i class='fa fa-file-word-o'></i> <a id='linkFile' href='"+param[1]+"' style='color=white;' download>"+param[2]+"</a></div>"
                }
                var msg={user:$('#username').val(),texto:text, canal:chatactual, nombre:$('.tituloChat').text()};
                myWS.publish(chatactual, msg);
          });
        }
    }    


    $.blockUI.defaults.baseZ = 999999; 
    $.blockUI.defaults.fadeIn = 100; 
		$.blockUI.defaults.fadeOut = 400;
		$.blockUI.defaults.css.border = 0;				

    $(document)
    .ajaxStart(function(){
     totalTiempo = 120;
    	var mdl = '<div class="modal inmodal modaltext"><div class="modal-dialog"><div class="modal-content"><div id="blockUI_close" class="modal-header"></div><div class="modal-body"><div class="text-center"><img alt="" width="128" height="128" src="/includes/img/main/loading.gif"/><h4>Procesando... </h4></div></div></div></div></div>';
			$.blockUI({message: $(mdl)});    		    				
    })
    .ajaxComplete(function(){
    	var active = $.active;
    	if(active <= 1){    		    		
  			$.unblockUI();    	  			
    	}
        totalTiempo = 120;			
    });    

    function updateReloj()
    {
        document.getElementById('CuentaAtras').innerHTML = " "+totalTiempo+" ";
        if(totalTiempo==0)
        {
            location.assign("<cfoutput>#event.buildLink('login.cerrarSesion')#</cfoutput>"); 
        }else{

            /* Restamos un segundo al tiempo restante */
            totalTiempo-=1;
            /* Ejecutamos nuevamente la función al pasar 1000 milisegundos (1 segundo) */
            setTimeout("updateReloj()",60000);
        }
    }

    <!---
    * Descripcion: Desbloquea manualmente el UI si el JS tiene un error
    * Fecha:    Enero 2018.
    * Autor:    Daniel Memije
    ---> 
    window.onerror = function(error, url, line) {    	  			
    		$('#blockUI_close').html('<button onclick="$.unblockUI();" class="close"><span aria-hidden="true">X</span><span class="sr-only">Close</span></button>');	    	
		};

    window.onload=updateReloj;


    <!---
    * Descripcion: Valida si una cadena tiene caracteres especiales. 
    * Fecha:    11 enero 2018.
    * Autor:    Alejandro tovar
    ---> 
    function caracteresEspeciales(cadena){
       var specialChars = " ^<>@!#$%^&*()+[]{}?:;|ñÑáéíóúÁÉÍÓÚ'\"\\,/~`-=";
        for(i = 0; i < specialChars.length;i++){
            if(cadena.indexOf(specialChars[i]) > -1){
                return true
            }
        }       
        return false;
    }

    <!---
    * Descripcion: Valida que la extension de un archivo sea aceptada en ese apartado. 
    * Fecha:    12 enero 2018.
    * Autor:    Alejandro tovar
    ---> 
    function validarExtension(ext, extensiones){

        var cont = 0;

        for (var i = 0; i < extensiones.length; i++){
            if (ext == extensiones[i]){
                cont = cont + 1;
            }
        }

        if (cont == 0){
            return false;
        }else {
            return true;
        }
    }

    function agregaRuta(nombreURL){
        window.location.href = nombreURL;
    }

</script>
