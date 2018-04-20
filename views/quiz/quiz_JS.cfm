<cfprocessingdirective pageEncoding="utf-8"/>
<script type="text/javascript">

  var quiz= [];
  var numero = 0;//contador de preguntas
  var cp2=1;//contador para la barra de progreso
  var nombreEje = localStorage.getItem('NombreEje');
  var nombreAccion = localStorage.getItem('NombreAccion');
  var preguntasContestadas = 0; //contador de preguntas contestadas
  var totalPreguntas =0;
  console.log(nombreAccion);
  console.log(nombreEje);

  $(document).ready(function(){
    $('#eje').text(nombreEje);
    $('#accion').text(nombreAccion);
    //$('#divQuiz').hide();
    ocultarBtn(numero);
    /************************************Manejo de roles*********************************/
    if(localStorage.getItem('Rol')){
      //muestra div de preguntas si ha elegido un rol
      //$('#divQuiz').show();
      if(localStorage.getItem('Rol') == 'alumno'){
        $("#rol").append('<img src="/includes/images/icon-alumno.png" style="width:40px;"></img>');
      }else if(localStorage.getItem('Rol') == 'docente'){
        $("#rol").append('<img src="/includes/images/icon-docente.png" style="width:40px;"></img>');
      }else if(localStorage.getItem('Rol') == 'paae'){
        $("#rol").append('<img src="/includes/images/icon-paae.png" style="width: 40px;"></img>');
      }else if(localStorage.getItem('Rol') == 'egresado'){
        $("#rol").append('<img src="/includes/images/icon-egresado.png" style="width:40px;"></img>');
      }else if(localStorage.getItem('Rol') == 'directivo'){
        $("#rol").append('<img src="/includes/images/icon-directivo.png" style="width:40px;"></img>');
      }else{
        $("#rol").append('<img src="/includes/images/icon-funcionario.png" style="width:40px;"></img>');
      }
    }else{
      //$('#divQuiz').hide();
    }

    /**************OBTENEMOS LAS PREGUNTAS**************/
    obtenPreguntas();
    /************************************Escuchas de eventos*********************************/

    $('#anterior').click(function(){
      numero--;
      crearFilaNueva(quiz[numero].FORMATO,quiz[numero].REPORTE);//esta funcion carga el formulario para captura
      colocarImagen(quiz[numero].IMG);
      if(numero >= 0){
        limpiarRespuestas();
        cp2 -=1;
        ocultarBtn(numero);
        actualizaBarra();
      }
    });

    $('#siguiente').click(function(){
      numero++;      
      var progressbartext = 'Pregunta ' + (numero+1) + ' de ' + quiz.length;
      var porcentajeActual = 0;
      $('#prog').text(progressbartext);
      console.log(progressbartext);
      $('#btn-guardarDatos').trigger( "click" );
      
      if(numero < quiz.length){
        setTimeout(mostrarPregunta(numero), 1000);
        colocarImagen(quiz[numero].IMG);
        actualizaBarra();
      }
      if(numero >= 0){
          limpiarRespuestas();
          cp2 +=1;
          ocultarBtn(numero);
          actualizaBarra();
      }
    });

    $("#finalizar2").click(function (event) {
      $('#btn-guardarDatos').trigger( "click");
      setTimeout(gotoCarrousel, 1000);
    });
  });

  function mostrarPregunta(numero){
    crearFilaNueva(quiz[numero].FORMATO,quiz[numero].REPORTE);//esta funcion carga el formulario para captura
  }
  
  function gotoCarrousel() {
    location.assign('<cfoutput>#event.buildLink("carrousel/carrousel")#</cfoutput>');
  }

  function limpiarRespuestas(){
    $('#formularioCaptura').empty();
  }

  function limpiarRespuestas(){
    $('#respuestas').empty();
  }

  function actualizaBarra(){
      $('#barra').width(calculaPorciento(cp2,quiz.length) + '%');
  }

  function calculaPorciento(cp, total) {
    return ((cp) * 100 )/(total);
  }

  function ocultarBtn(numero){
    if((numero + 1) == quiz.length){
      $("#siguiente").hide();
      $("#anterior").show();
      $("#finalizar").show();
    }
    else if(numero == 0){
      $("#anterior").hide(); 
      $("#siguiente").show();
      $("#finalizar").hide();
    }else{
      $("#anterior").show();
      $("#siguiente").show();
      $("#finalizar").hide();
    }  
  }

  function colocarImagen(img){
    $("#imagen").attr("src",img);
  }

  function obtenPreguntas(){
    $.ajax({
        url: "<cfoutput>#event.buildLink("quiz.quiz.getPregunta")#</cfoutput>",
        method: 'POST',
        cache: false,
        data: { accion: localStorage.getItem('accion'),eje: localStorage.getItem('eje')}
    }).done(function(data){
      quiz = data;//asigna la respuesta(JSON) a la variable global
      totalPreguntas = quiz.length;
      if(0 == quiz.length){
        //alert('Lo sentimos, no se encontr\u00F3 ninguna pregunta para esta secci\u00F3n.');
		$('#divAvisoSinPreguntas').show();
        //gotoCarrousel();
      }else if(1 == quiz.length){
        $('#divQuiz').show();
		$('#prog').text('Pregunta 1 de' + quiz.length);
        $("#siguiente").hide();
        $("#finalizar").show();
        crearFilaNueva(quiz[0].FORMATO,quiz[0].REPORTE);//esta funcion carga el formulario para captura
        colocarImagen(quiz[0].IMG);  
        actualizaBarra();
      }else{
        $('#divQuiz').show();
		$('#prog').text('Pregunta 1 de ' + quiz.length);
        crearFilaNueva(quiz[0].FORMATO,quiz[0].REPORTE);//esta funcion carga el formulario para captura
        colocarImagen(quiz[0].IMG);  
        actualizaBarra();
      }
      console.log('ok');
    }).fail(function(xhr, errorType, exception) {
        console.log('problemas');
    });
  }

  <!---
  * Fecha      : Marzo 2018
  * Autor      :Marco Torres 
  * Descripcion: Crea una fila nueva en un formato (formato de producto(s))
  * --->
  function crearFilaNueva(formato,reporte){
    $.post('<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.getReporteLlenado")#</cfoutput>', {
      formato: formato,
      periodo: 1,
      reporte: reporte
    }, function(data){
      $('#formularioCaptura').html(data); 
    });
  } 
  
  <!---
  * Fecha      : Marzo 2018
  * Autor      :Marco Torres 
  * Descripcion: Funcion que se ejecuta como respuesta del guardado de del formulario
  * --->
  function cargarLlenado(){
  }
</script>