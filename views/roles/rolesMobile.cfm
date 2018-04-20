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
  
  <link href="/includes/css/menu/PE_principalMobile.css" rel="stylesheet">
  <cfoutput><cfinclude template="roles_JS.cfm"></cfoutput>
	<!---<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12">
			<h5 class="text-center" style="position:relative;font-size:2.5em;color:#666;top:90px;">Miembros de la comunidad polit&eacute;cnica</h5>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12">
			<h5 align="justify" style="position:relative;font-size:1.2em;color:#000;top:115px;">Se les invita a participar en la &ldquo;Consulta para la Elaboraci&oacute;n del Programa Institucional de Mediano Plazo 2018-2020&rdquo;,para que se consideren sus ideas, proposiciones, inquietudes, necesidades y comentarios.</h5>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12">
			<h5 class="text-center" style="position:relative;font-size:1.2em;color:#000;top:125px;font-weight:bold;">&iexcl;T&uacute; participaci&oacute;n es muy importante!</h5>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12">
			<h5 align="justify" style="position:relative;font-size:1.2em;color:#000;top:145px;">Selecciona el perfil que mejor te describe en las actividades que desempe&ntilde;as dentro del Instituto:</h5>
		</div>
	</div>--->
    <div class="">
      <h5 class="text-center" style="position:relative;font-size:2.5em;color:#666;top:90px;">Bienvenido</h5>
    </div>
    <div class="">
        <h5 class="text-center" style="position:relative;font-size:1.5em;color:#000;top:105px;">Selecciona el perfil que mejor te describe en las actividades que desempe&ntilde;as dentro del Instituto:</h5>
    </div>
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12" style="margin-left:auto;margin-right:auto;">
            <nav id="hexNav">
            <div id="menuBtn">
              <div id="fondoElemento">
                <img src="/includes/images/menu_principal/IPN.png" />
              </div>
            </div>
            <ul id="hex">
              <li class="tr">
                <div class="clip">
                  <cfoutput><a id="alumno" href="#event.buildLink("login.registrarUsuario")#?rol=6" class="content" data-title="Alumnos">
                    <img src="/includes/images/menu_principal/alumnos.jpg" alt="" />
                    <h2 class="title">Alumnos</h2>
                  </a></cfoutput>
                </div>
              </li>
              <li class="tr">
                <div class="clip">
                  <cfoutput><a id="egresado" href="#event.buildLink("login.registrarUsuario")#?rol=122" class="content" data-title="Egresados">
                    <img src="/includes/images/menu_principal/egresados.jpg" alt="" />
                    <h2 class="title">Egresados</h2>
                  </a></cfoutput>
                </div>
              </li>
              <li class="tr">
                <div class="clip">
                  <cfoutput><a id="docente" href="#event.buildLink("login.registrarUsuario")#?rol=5" class="content" data-title="Docentes">
                    <img src="/includes/images/menu_principal/docente.jpg" alt="" />
                    <h2 class="title">Docentes</h2>
                  </a></cfoutput>
                </div>
              </li>
              <li class="tr">
                <div class="clip">
                  <cfoutput><a id="paae" href="#event.buildLink("login.registrarUsuario")#?rol=8" class="content" data-title="Personal de Apoyo y Asistencia a la Educaci&oacute;n">
                    <img src="/includes/images/menu_principal/paae.jpg" alt="" />
                    <h2 class="title">Personal de apoyo</h2>
                  </a></cfoutput>
                </div>
              </li>
              <li class="tr">
                <div class="clip">
                  <cfoutput><a id="directivo" href="#event.buildLink("login.registrarUsuario")#?rol=126" class="content" data-title="Directivos">
                    <img src="/includes/images/menu_principal/directivos.jpg" alt="" />
                    <h2 class="title">Directivos</h2>
                  </a></cfoutput>
                </div>
              </li>
              <li class="tr">
                <div class="clip">
                  <cfoutput><a id="funcionario" href="#event.buildLink("login.registrarUsuario")#?rol=7" class="content" data-title="Funcionarios">
                    <img src="/includes/images/menu_principal/funcionarios.jpg" alt="" />
                    <h2 class="title">Funcionarios</h2>
                    <!---<p>&nbsp;</p>--->
                  </a></cfoutput>
                </div>
              </li>
            </ul>
          </nav>
      </div>
  </div>
  <div id="IDPerfilAcceso" style="position:absolute; left:70%; top:60%;">
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
          jQuery('#IDPerfilAcceso').html("");
          jQuery('#IDPerfilAcceso').css("display","none");
        }
      )
    });
  </script>