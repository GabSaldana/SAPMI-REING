<!---
========================================================================
* IPN - CSII
* Portal: Planeación 2018
* Modulo: Vista contenedora del ingreso como alumno o docente.
* Sub modulo: Contenedor de preguntas
* Fecha: Febrero 2018
* Descripcion: Vista
* Autor: GSA
=========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<cfoutput><cfinclude template="quiz_JS.cfm"></cfoutput>
<!-- Materialize -->
<link href="/includes/css/circulos/materialize.min.css" rel="stylesheet">
<style>
	#divAvisoSinPreguntas{
		position:relative;
		display:none;
		top:140px;
		width:600px;
		height:150px;
		font-size:1.9em;
		margin:5px;
		border-radius: 9px 9px 9px 9px;
		-moz-border-radius: 9px 9px 9px 9px;
		-webkit-border-radius: 9px 9px 9px 9px;
		background-color:#EFEFEF;
		-webkit-box-shadow: 5px 5px 5px 5px rgba(0,0,0,0.75);
		-moz-box-shadow: 5px 5px 5px 5px rgba(0,0,0,0.75);
		box-shadow: 5px 5px 5px 5px rgba(0,0,0,0.75);
	}
    @media only screen and (max-width: 992px) and (min-width: 601px){
        #toast-container { max-height: 50px !important; }
    }
    @media only screen and (max-width: 600px){
        #toast-container {max-height: 50px !important; }
    }
</style>
<div class="container">
    <div id="divAvisoSinPreguntas" style="margin-left:auto;margin-right:auto;">
        <p align="center">Lo sentimos, el eje seleccionado no tiene preguntas disponibles para el perfil ingresado.</p>
        <center>
            <cfoutput><a href="#event.buildLink("carrousel/carrousel")#" style="text-decoration: none;" title="Regresar"></cfoutput>
            <span class="fa-layers fa-fw" >
                <i class="fas fa-arrow-left fa-w-10 fa-1x"></i>
            </span>
            </a>
        </center>
    </div>
  <!--Card Regular-->
  <div class="row" id="divQuiz" style="margin-top: 30px;display: none;">
    <div class=" col-md-1 col-lg-1" >
    </div>
    <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10" >
        <div class="cardtitle" style="border:solid 1px;">
          <center>
            <div id="cardtitle" style="padding:1px;  border-radius: 5px 5px 0px 0px;">
              <h4 id="eje"></h4>
              <h5 id="accion"></h5>
            </div>
          </center>
        </div>
        <div class="card" style="border: none !important; -webkit-box-shadow: none;">
          <div class="card-image">
              <img id="imagen" class="img-responsive" src="" >
              <span id="rol" class="card-title" style=" margin-left: 20px; padding: 6px;">
                <!--icono-->
              </span>
          </div>
          <div class="card-content">
            <!---Aquis e renderiza la pregunta--->
			<div>
				<span id="leyenda-contestada"style="display:none;font-size:15px; color: #9e9e9e;font-weight:bold;" >Respuestas capturadas</span>
			</div>
            <div id="formularioCaptura"></div>
            <div class="progress" style=" height: 18px; color:white; font-size: 12px; word-wrap: normal !important;">
              <div id="barra" class="determinate indigo" style=" width: 0%; overflow:visible;" aria-valuenow="5" aria-valuemin="0" aria-valuemax="100">
              </div>
            </div>
            <p id="prog" style="text-align:right; width:auto; "></p>
          </div>
          <div class="card-footer text-muted" style="border: solid 1px;color: #7A003B !important; border-bottom: none;">
            <center style="margin-top: 10px;">
              <!---<a id="anterior" class="btn-floating btn-large waves-effect waves-light red"><i class="material-icons">navigate_before</i></a>--->
              <a id="siguiente" class="btn-floating btn-large waves-effect waves-light red"><i class="material-icons">navigate_next</i></a>
              <cfoutput>
                <a id="finalizar" style="display: none;" class="btn-floating btn-large waves-effect waves-light indigo"><i id="finalizar2" class="material-icons">check</i></a>
              </cfoutput>
            </center>
          </div>
        </div>
        <div class="ct" style="margin-top: 0px !important; border-radius: 0px 0px 5px 5px; border: solid 1px; border-top: none; ">
        <center>
          <cfoutput><a href="#event.buildLink("carrousel/carrousel")#" style="text-decoration: none; font-size: 2rem;"></cfoutput>
            Regresar
            <span class="fa-layers fa-fw" >
              <i class="fas fa-arrow-left fa-w-10 fa-1x"></i>
            </span>
          </a>
        </center>
      </div>
    </div>
    <div class="col-md-1 col-lg-1"></div>
  </div>
</div>