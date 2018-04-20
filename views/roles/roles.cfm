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
  <link href="/includes/css/menu/PE_principal.css" rel="stylesheet">
  <cfoutput><cfinclude template="roles_JS.cfm"></cfoutput>
    <!---<div class="">
        <h5 class="text-center" style="position:relative;font-size:40px;color:#666;top:90px;">&iexcl;Gracias por participar!</h5>
    </div>
    <div class="" style="width:90%;margin-left:auto;margin-right:auto;">
        <h5 align="justify" style="position:relative;font-size:20px;color:#000;top:115px;">La elaboraci&oacute;n del Programa Institucional de Mediano Plazo (PIMP) 2018-2020, se basa en los cinco Ejes Fundamentales y dos Transversales, que corresponden a la actualizaci&oacute;n del Programa de Desarrollo Institucional (PDI) 2018, que puedes consultar <a href="http://www.ipn.mx/Documents/2018/PDI-CONSEJO-23-03-18.pdf" target="_blank">aqu&iacute;</a>.</h5>
    </div>
    <div class="" style="width:90%;margin-left:auto;margin-right:auto;">
        <h5 align="justify" style="position:relative;font-size:20px;color:#000;top:125px;">Cada Eje contiene Proyectos Especiales que se despliegan al seleccionarlos en la pesta&ntilde;a correspondiente.</h5>
    </div>
    <div class="" style="width:90%;margin-left:auto;margin-right:auto;">
        <h5 align="justify" style="position:relative;font-size:20px;color:#000;top:125px;">La consulta se organiza por proyecto, mediante preguntas espec&iacute;ficas y/o aportaciones libres que podr&aacute;s escribir en un recuadro.</h5>
    </div>
    <div class="" style="width:85%;margin-left:auto;margin-right:auto;">
        <h5 align="justify" style="position:relative;font-size:20px;color:#000;top:125px;">
        	<ol>
            	<li>Selecciona tu rol o papel en el Instituto: Alumno, Docente, Personal de Apoyo y Asistencia a la Educaci&oacute;n (PAAE), Directivo de Unidad Acad&eacute;mica, Egresado y Funcionario del &Aacute;rea Central.</li>
                <li>Participa en uno o m&aacute;s proyectos, puedes seleccionar s&oacute;lo las preguntas, hacer aportaciones libres o ambos.</li>
                <li>Si deseas agregar otros aspectos, a&ntilde;ade un PDF o escribe tu aportaci&oacute;n.</li>
            </ol>
        </h5>
    </div>
    <div class="">
        <h5 class="text-center" style="position:relative;font-size:20px;color:#000;top:145px;font-weight:bold;">&iexcl;Inicia tu participaci&oacute;n!</h5>
    </div>--->
    <div class="">
      <h5 class="text-center" style="position:relative;font-size:55px;color:#666;top:90px;">Bienvenido</h5>
    </div>
    <div class="">
        <h5 class="text-center" style="position:relative;font-size:21px;color:#000;top:105px;">Selecciona el perfil que mejor te describe en las actividades que desempe&ntilde;as dentro del Instituto:</h5>
    </div>
    <nav id="hexNav">
    <div id="menuBtn">
      <div id="fondoElemento">
        <img src="/includes/images/menu_principal/IPN.png" />
      </div>
      
      <!--
      <svg viewbox="0 0 100 100">
        <polygon points="50 2 7 26 7 74 50 98 93 74 93 26" fill="transparent" stroke-width="4" stroke="#585247" stroke-dasharray="0,0,300"/>
      </svg>
      <span></span>
      -->
    </div>
    <ul id="hex">
      <li class="tr">
        <div class="clip">
          <cfoutput><a id="alumno" href="#event.buildLink("login.registrarUsuario")#?rol=6" class="content" data-title="Alumnos">
            <img src="/includes/images/menu_principal/alumnos.jpg" alt="" />
          </a></cfoutput>
        </div>
      </li>
      <li class="tr">
        <div class="clip">
          <cfoutput><a id="egresado" href="#event.buildLink("login.registrarUsuario")#?rol=122" class="content" data-title="Egresados">
            <img src="/includes/images/menu_principal/egresados.jpg" alt="" />
            <!--<h2 class="title">Egresados</h2>
            <p>&nbsp;</p>-->
          </a></cfoutput>
        </div>
      </li>
      <li class="tr">
        <div class="clip">
          <cfoutput><a id="docente" href="#event.buildLink("login.registrarUsuario")#?rol=5" class="content" data-title="Docentes">
            <img src="/includes/images/menu_principal/docente.jpg" alt="" />
            <!--<h2 class="title">Docentes</h2>
            <p>&nbsp;</p>-->
          </a></cfoutput>
        </div>
      </li>
      <li class="tr">
        <div class="clip">
          <cfoutput><a id="paae" href="#event.buildLink("login.registrarUsuario")#?rol=8" class="content" data-title="Personal de Apoyo y Asistencia a la Educaci&oacute;n">
            <img src="/includes/images/menu_principal/paae.jpg" alt="" />
            <!--<h2 class="title">PAAE</h2>
            <p>&nbsp;</p>-->
          </a></cfoutput>
        </div>
      </li>
      <li class="tr">
        <div class="clip">
          <cfoutput><a id="directivo" href="#event.buildLink("login.registrarUsuario")#?rol=126" class="content" data-title="Directivos de Unidad Acad&eacute;mica">
            <img src="/includes/images/menu_principal/directivos.jpg" alt="" />
            <!--<h2 class="title">Directivos</h2>
            <p>&nbsp;</p>-->
          </a></cfoutput>
        </div>
      </li>
      <li class="tr">
        <div class="clip">
          <cfoutput><a id="funcionario" href="#event.buildLink("login.registrarUsuario")#?rol=7" class="content" data-title="Funcionarios del &Aacute;rea Central">
            <img src="/includes/images/menu_principal/funcionarios.jpg" alt="" />
            <!--<h2 class="title">Funcionarios</h2>
            <p>&nbsp;</p>-->
          </a></cfoutput>
        </div>
      </li>
    </ul>
  </nav>
  <div id="IDPerfilAcceso" style="position:absolute; left:70%; top:52%;">
    <div id="nombrePerfil"></div>
  </div>
    <script type="text/javascript" language="javascript">
    var hexNav = document.getElementById('hexNav');
    
    document.getElementById('menuBtn').onclick = function() {
      var className = ' ' + hexNav.className + ' ';
      if ( ~className.indexOf(' active ') ) {
        hexNav.className = className.replace(' active ', ' ');
      } else {
        hexNav.className += ' active';
      }
    }
    
    jQuery(document).ready(function(e) {
      document.getElementById("menuBtn").click();
      jQuery("div.clip>a.content").hover(
        function(){
          var txtAcceso = jQuery(this).attr("data-title");
          jQuery("#IDPerfilAcceso").css("display","inline");
          jQuery('#IDPerfilAcceso').html("");
          jQuery('#IDPerfilAcceso').html('<div id="nombrePerfil" align="center" class="mostrarTituloProcesoNuevo"></div>');
          jQuery('#nombrePerfil').css("display","inline");
          jQuery('#nombrePerfil').html(txtAcceso);
        },
        function(){
          jQuery('#IDPerfilAcceso').html("");
          jQuery('#IDPerfilAcceso').css("display","none");
        }
      )
    });
  </script>