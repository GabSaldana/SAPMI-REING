<!---
========================================================================
* IPN - CSII
* Portal: Planeación 2018
* Modulo: Vista del menu principal.
* Sub modulo: -
* Fecha: Febrero 2018
* Descripcion: Vista para los roles
* Autor: GSA
=========================================================================
--->
<style type="text/css">
	/* PANTALLA MODAL */
	.load-screen{
	  display: none;
	}
	.load-screen>.load-back{
	  opacity: 1.07;
	  display: block;
	  background-color: rgba(0, 0, 0, 0.4);
	  position: fixed;
	  left: 0;
	  right: 0;
	  top: 0;
	  bottom: 0;
	  z-index: 10000;
	}
	.load-screen>.load-front{
	  background-color: white;
	  width: 500px;
	  padding: 15px;
	  border-radius: 5px;
	  border: 2px solid #6C1D45;
	  text-align: center;
	  position: fixed;
	  left: 50%;
	  top: 50%;
	  margin-left: -256px;
	  margin-top: -200px;
	  text-align: center;
	  z-index: 100000;
	}
	.btn-close{
	  border: none;
	  font-size: 18px;
	  padding: 0px 10px;
	  background-color: transparent;
	  text-shadow: 0px 2px #dee2e6;
	  color: #999;
	}
	
	#divCuadroFAQ{
		position:fixed;
		top:90px;
		right:20px;
		width:120px;
		margin:5px;
		border-radius: 9px 9px 9px 9px;
		-moz-border-radius: 9px 9px 9px 9px;
		-webkit-border-radius: 9px 9px 9px 9px;
		background-color:#EFEFEF;
		-webkit-box-shadow: 5px 5px 5px 5px rgba(0,0,0,0.75);
		-moz-box-shadow: 5px 5px 5px 5px rgba(0,0,0,0.75);
		box-shadow: 5px 5px 5px 5px rgba(0,0,0,0.75);
		z-index:500;
		cursor:pointer;
	}
</style>
<script>
	$(document).ready(function(){
		$("#cerrarFAQ").on('click', function(){
			$("#divFAQ").fadeOut(150);
		});
	});
	
	function visualizaFAQ(){
		$("#divFAQ").fadeIn(150);
	}
</script>
<div id="divCuadroFAQ" onclick="visualizaFAQ();">
	<h5 class="text-center" style="font-size:1.5em;">Preguntas frecuentes</h5>
</div>
<div class="">
	<h5 class="text-center" style="position:relative;font-size:55px;color:#666;top:90px;">&iexcl;Gracias por participar!</h5>
</div>
<div class="" style="width:70%;margin-left:auto;margin-right:auto;">
	<h5 align="justify" style="position:relative;font-size:25px;color:#000;top:115px;">La elaboraci&oacute;n del Programa Institucional de Mediano Plazo (PIMP) 2018-2020, se basa en los cinco Ejes Fundamentales y dos Transversales, que corresponden a la actualizaci&oacute;n del Programa de Desarrollo Institucional (PDI) 2018, que puedes consultar aqu&iacute;<a href="http://www.ipn.mx/Documents/2018/PDI-CONSEJO-23-03-18.pdf" target="_blank" title="PDI (2018)"><img src="/includes/images/pdf.png" /></a>.</h5>
</div>
<div class="" style="width:70%;margin-left:auto;margin-right:auto;">
	<h5 align="justify" style="position:relative;font-size:25px;color:#000;top:125px;">Cada Eje contiene Proyectos Especiales que se despliegan al seleccionarlos en la pesta&ntilde;a correspondiente.</h5>
</div>
<div class="" style="width:65%;margin-left:auto;margin-right:auto;">
	<h5 align="justify" style="position:relative;font-size:25px;color:#000;top:135px;">
		<ul style="line-height:1.2;">
			<li type="disc">La consulta se organiza por proyecto, mediante preguntas espec&iacute;ficas y/o aportaciones libres que podr&aacute;s escribir en un recuadro.</li>
			<li type="disc">Selecciona tu rol o papel en el Instituto: Alumno, Docente, Personal de Apoyo y Asistencia a la Educaci&oacute;n (PAAE), Directivo de Unidad Acad&eacute;mica, Egresado o Funcionario del &Aacute;rea Central.</li>
			<li type="disc">Participa en uno o m&aacute;s proyectos, puedes seleccionar s&oacute;lo las preguntas, hacer aportaciones libres o ambos.</li>
			<li type="disc">Si deseas agregar otros aspectos, ingresa a la plataforma y dir&iacute;gete al recuadro &quot;Aportaciones adicionales&quot;, ubicado en el lado inferior derecho del men&uacute; selector de ejes, donde podr&aacute;s a&ntilde;adir el archivo correspondiente.</li>
		</ul>
	</h5>
</div>
<div class="" style="width:65%;margin-left:auto;margin-right:auto;">
	<h5 class="text-center" style="position:relative;font-size:40px;color:#000;top:155px;font-weight:bold;"><a href="<cfoutput>#event.buildLink('roles/roles')#</cfoutput>">&iexcl;Inicia tu participaci&oacute;n!</a></h5>
</div>
<div id="divFAQ" class="load-screen" style="display: none;">
	<div class="load-back" tabindex="-1"></div>
	<div class="load-front">
		<table width="100%">
			<tr>
				<td align="left"><b>PREGUNTAS FRECUENTES</b></td>
				<td><button id="cerrarFAQ" class="btn btn-close pull-right">x</button></td>
			</tr>
		</table>
		<h3 align="left">&iquest;Qu&eacute; es el PDI?</h3>
		<p align="justify">El Programa lnstitucional de Desarrollo es el instrumento que contiene la planeación de largo plazo, constituyéndose en el instrumento básico para orientar el desarrollo institucional.</p>
		<br />
		<h3 align="left">&iquest;Qu&eacute; es el PIMP?</h3>
		<p align="justify">El Programa Institucional de Mediano Plazo (PIMP), es el instrumento de planeaci&oacute;n de mediano plazo, que tiende al desarrollo institucional y su contenido ser&aacute; congruente con el Programa de Desarrollo lnstitucional (PDI). En &eacute;l se indicar&aacute;n los objetivos, estrategias y metas para las diversas actividades que desempe&ntilde;an cada una de las Dependencias del Instituto, teniendo un alcance trienal.</p>
		<p align="justify">Los Programas de Mediano Plazo que formulen las Dependencias de la administraci&oacute;n central, contendr&aacute;n adicionalmente los lineamientos para normar, apoyar, dar seguimiento y evaluar el desempe&ntilde;o de las actividades institucionales que coordinan.</p>
	</div>
 </div>