<cfprocessingdirective pageEncoding="utf-8">

<input id="pkRegistroComentario" type="hidden" value="">

<script type="text/javascript">


	<!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene los comentarios dirigidos al usuario.
    --->  
    function escribirComentario(pkReg, edoDestino, nombReportes){
        $("#mdl-addComentario").modal();
        $("#inRegistro").val(pkReg);
        $("#edoDesti").val(edoDestino);
        $('#inAsunto').val(nombReportes);
        $('#inAsunto').focus();

        $.post('/index.cfm/comentarios/comentarios/getUsuComentario', {
        	pkRegistro: pkReg
        }, function(data) {
            if (data.ROWCOUNT > 0){
                var list = $(".destinatarios").append('<ol type="none"></ol>').find('ol');
                for (var i = 0; i < data.ROWCOUNT; i++){
                    list.append("<li><div class='checkbox'><label><input name='destinatarios' type='checkbox' value=" + data.DATA.USU_PK[i] + ">" + data.DATA.NOMBRE[i] + '  /  ' + data.DATA.NOMBREROL	[i] + "</label></div></li>");
                }
            }
        });
    }


	<!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene los comentarios dirigidos al usuario.
    --->  
    function registrarComentario(){
        var checkDestin = new Array();

        $("#mdl-addComentario").modal('hide');
        
        $('input[name="destinatarios"]:checked').each(function() {
           checkDestin.push($(this).val());
        });

        var prioridad = (!($("#check").children().hasClass('off'))) ? 1 : 0;

        var comentario = tinyMCE.activeEditor.getContent();
        comentario = comentario.substring(44, comentario.length -15).trim();

       	 $.post('/index.cfm/comentarios/comentarios/registraComentario', {
            pkRegistro:    $("#inRegistro").val(),
            asunto:        $("#inAsunto").val(),
            comentario:    comentario,
            prioridad:     prioridad,
            destinatarios: JSON.stringify(checkDestin),
            estado: $("#edoDesti").val()
        }, function(data) {
        	location.reload();
            limpiaModal();
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Limpia la modal de agregar comentario
    ---> 
    function limpiaModal(){
        $("#mdl-addComentario").modal('hide');
        $("#inRegistro").val('0');
        $("#inAccion").val('0');
        $("#inComent").val('');
        $('#inAsunto').val('');
        $("#inPrior").prop("checked",false);
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene los comentarios dirigidos al usuario.
    --->  
    function consultarComenReg(pkRegistro){
        $("#pkRegistroComentario").val(pkRegistro);
        $.post('/index.cfm/comentarios/comentarios/getComentariosReg', {
            pkRegistro: pkRegistro
        },
        function(data){
            $('#mdl-coments').modal('show');
            $('#mdl-coments .contnido').html(data);
            $("#mdl-coments .mail-comentarios").show();
            $("#mdl-coments .mail-contenido").hide();
        });
    }


    <!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene el contenido de un contenido en especifico
    --->  
    function contentComent(pkComent){
        $.post('/index.cfm/comentarios/comentarios/getContenidoComent', {
            pkComent: pkComent
        },
        function(data){
            $("#titulo").html(data.DATA.ASUNTO[0]);
            $(".mail-contnido").hide();
            $("#mdl-coments .mail-comentarios").hide();
            $("#mdl-coments .mail-contenido").show().html(data.DATA.COMENTARIO[0]);
            $('.atras').css("display", "block");
        });
    }

	<!---
    * Fecha : Noviembre de 2016
    * Autor : Alejandro Tovar
    * Comentario: Obtiene los comentarios dirigidos al usuario.
    --->
    function consultarComentario(){
        $.post('/index.cfm/comentarios/comentarios/getComentariosReg', {
            pkRegistro: $("#pkRegistroComentario").val()
        },
        function(data){
            $('#mdl-coments').modal('show');
            $('#mdl-coments .contnido').html(data);
            $("#mdl-coments .mail-comentarios").show();
            $("#mdl-coments .mail-contenido").hide();
        });
    } 


</script>