<!---
* ================================
* IPN – CSII
* Sistema: SIE
* Fecha Diciembre de 2017
* Descripcion:
* Vista 
* Autor:
* ================================
--->
 <cfprocessingdirective pageEncoding="utf-8">
 <!--- <cfinclude template="conjuntosDatos_js.cfm">
  ---><!---Seccion correspondiente a la barra de navegacion del modulo--->
 <div class="row wrapper border-bottom white-bg page-heading">
     <div class="col-lg-10">
         <h2>Realiza tus aportaciones</h2>
         <ol class="breadcrumb">
             <li>
                 <a href="/index.cfm/inicio">Inicio</a>
             </li>
             <li class="breadcrumb"> 
                 <a href="/index.cfm/formatosTrimestrales/capturaFT/conjuntosFormatos">Menú de aportaciones</a>
             </li>
             <li class="active"> 
                 <strong>Ejes</strong>
             </li>
             
         </ol>
     </div>
     <div class="col-lg-2"></div>
 </div>
 <div class="wrapper wrapper-content animated fadeInRight" >
 <!---Seccion correspondiente al contenido del submodulo--->
     <div class="row">
        <cfoutput>
         <cfif #prc.tipo# EQ 1>
            <!---- FUNDAMENTALES ---->
             <div class="widget style1 white-bg animated fadeInLeft" style="border: 1px solid;  border-color:##A4A4A4; border-radius: 8px;">
                 <div class="row">              
                     <div class="col-xs-8 text-left">
                         <span><h2><b>Ejes Fundamentales</b></h2> </span>
                         <span> Elije un eje para aportar </span>    
                     </div>
                     <div class="col-xs-4 text-right">
                         <i class=" fa fa-thumb-tack fa-4x"></i>
                     </div>
                 </div>
             </div>
             <div class="contact-box center-version col-md-3" style="  border-radius: 15px; border: solid 1px; border-color: ##A4A4A4; margin-left: 8%;">
                 <a href="/index.cfm/formatosTrimestrales/capturaFT?idCon=4">
                     <center>
                         <img alt="image" style="width: 80px;" class="img-circle" src="/includes/img/aportaciones/eje.png">
                         <h3 class="m-b-xs" style="font-size: 15px;"><strong> <span class="badge badge-primary" style="font-size: 12px;">1</span> Calidad y Pertinencia Educativa</strong></h3>
                         <strong>Acciones</strong><br>
                     </center>
                     <address class="m-t-md" style="height: 85px;  overflow-y: auto;  font-size: 10px;">
                         <span class="badge" style="font-size: 10px;">1.1</span> Modelo Educativo Institucional<br>
                         <span class="badge" style="font-size: 10px;">1.2</span> Pertinencia de los programas académicos<br>
                         <span class="badge" style="font-size: 10px;">1.3</span> Aseguramiento de la calidad educativa<br>
                         <span class="badge" style="font-size: 10px;">1.4</span> Cultura y deporte<br>
                         <span class="badge" style="font-size: 10px;">1.5</span> Personal docente, de apoyo a la educación y directivo<br>
                     </address>
                 </a>
             </div>

             
             <div class="contact-box center-version col-md-3" style="border-radius: 15px; border: solid 1px; border-color: ##A4A4A4; margin-left: 3%">
                 <a href="/index.cfm/formatosTrimestrales/capturaFT?idCon=5">
                     <center>
                         <img alt="image" style="width: 80px;" class="img-circle" src="/includes/img/aportaciones/eje.png">
                         <h3 class="m-b-xs" style="font-size: 15px;"><strong><span class="badge badge-primary" style="font-size: 12px;">2</span> Cobertura</strong></h3>
                         <strong>Acciones</strong><br>
                     </center>
                     <address class="m-t-md" style="height: 85px; width: 100%; overflow-y: auto; font-size: 10px;">
                         <span class="badge" style="font-size: 10px;">2.1</span> Consolidación de espacios educativos<br>
                         <span class="badge" style="font-size: 10px;">2.2</span> Nuevos programas académicos<br>
                         <span class="badge" style="font-size: 10px;">2.3</span> Articulación entre tipos y niveles educativos<br>
                         <span class="badge" style="font-size: 10px;">2.4</span> Educación virtual y a distancia <br>
                         <span class="badge" style="font-size: 10px;">2.5</span> Equidad en el acceso y trayectoria escolar <br>
                     </address>
                 </a>
             </div>
              <div class="contact-box center-version col-md-3 " style="border-radius: 15px; border: solid 1px; border-color: ##A4A4A4; margin-left: 3%">
                 <a href="/index.cfm/formatosTrimestrales/capturaFT?idCon=6">
                     <center>
                         <img alt="image" style="width: 90px;" class="img-circle" src="/includes/img/aportaciones/eje.png">
                         <h4 class="m-b-xs" style="font-size: 12px;"><strong><span class="badge badge-primary" style="font-size: 12px;">3</span> Conocimiento para la Solución de Problemas Nacionales</strong></h4>
                         <strong>Acciones</strong><br>
                     </center>
                     <address class="m-t-md" style="height: 80px;  overflow-y: auto; font-size: 10px;">
                         <span class="badge" style="font-size: 10px;">3.1</span> Investigación y Desarrollo Tecnológico<br>
                         <span class="badge" style="font-size: 10px;">3.3</span> Innovación Tecnológicas<br>
                         <span class="badge" style="font-size: 10px;">3.3</span> Incubación de Empresas de base Tecnológica<br>
                         <span class="badge" style="font-size: 10px;">3.4</span> Observatorio Tecnológico <br>
                     </address>
                 </a>
             </div>

              <div class="contact-box center-version col-md-3" style="border-radius: 15px; border: solid 1px; border-color: ##A4A4A4; margin-left: 8%;">
                  <a href="/index.cfm/formatosTrimestrales/capturaFT?idCon=7">
                      <center>
                         <img alt="image" style="width: 80px;" class="img-circle" src="/includes/img/aportaciones/eje.png">
                         <h3 class="m-b-xs" style="font-size: 15px;"><strong><span class="badge badge-primary" style="font-size: 12px;">4</span> Cumplimiento del Compromiso Social</strong></h3>
                         <strong>Acciones</strong><br>
                     </center>
                     <address class="m-t-md" style="height: 85px; overflow-y: auto; font-size: 10px;">
                         <span class="badge" style="font-size: 10px;">4.1</span> Relación con el sector productivo y social<br>
                         <span class="badge" style="font-size: 10px;">4.2</span> Institución con impacto social<br>
                         <span class="badge" style="font-size: 10px;">4.3</span> Movilidad e Internacionalización <br>
                         <span class="badge" style="font-size: 10px;">4.4</span> Difusión de la actividad politécnica a través de Canal Once y Radio IPN <br>
                     </address>
                 </a>
             </div>
             

             <div class="contact-box center-version col-md-3" style="border-radius: 15px; border: solid 1px; border-color: ##A4A4A4; margin-left: 3%">
                 <a href="/index.cfm/formatosTrimestrales/capturaFT?idCon=8">
                     <center>
                         <img alt="image" style="width: 80px;" class="img-circle" src="/includes/img/aportaciones/eje.png">
                         <h3 class="m-b-xs" style="font-size: 15px;"><strong><span class="badge badge-primary" style="font-size: 12px;">5</span> Gobernanza y Gestión Institucional</strong></h3>
                         <strong>Acciones</strong><br>
                     </center>
                     <address class="m-t-md" style="height: 85px; overflow-y: auto; font-size: 10px;">
                         <span class="badge" style="font-size: 10px;">5.1</span> Planeación estratégica a corto, mediano y largo plazo<br>
                         <span class="badge" style="font-size: 10px;">5.2</span> Análisis estadísticos, transparencia y rendición de cuentas<br>
                         <span class="badge" style="font-size: 10px;">5.3</span> Simplificación e interoperabilidad de procesos<br>
                         <span class="badge" style="font-size: 10px;">5.4</span> Implantación de estrategias para seguridad de la comunidad politécnica <br>
                     </address>
                 </a>
             </div>
             

             
         <cfelse>
             <!---- TRANSVERSALES ---->
             <div class="widget style1 white-bg animated fadeInLeft" style="border: 1px solid;  border-color:##A4A4A4; border-radius: 8px;">
                 <div class="row">              
                     <div class="col-xs-8 text-left">
                         <span><h2><b>Ejes Transversales</b></h2> </span>
                         <span> Elije un eje para aportar </span>    
                     </div>
                     <div class="col-xs-4 text-right">
                         <i class=" fa fa-thumb-tack fa-4x"></i>
                     </div>
                 </div>
             </div>
             <div class="contact-box center-version col-md-3 " style="border-radius: 15px; border: solid 1px; border-color: ##A4A4A4; margin-left: 8%">
                 <a href="/index.cfm/formatosTrimestrales/capturaFT?idCon=9">
                     <center>
                         <img alt="image" style="width: 80px;" class="img-circle" src="/includes/img/aportaciones/eje.png">
                         <h3 class="m-b-xs" style="font-size: 15px;"><strong><span class="badge badge-primary" style="font-size: 12px;">1</span> Sustentabilidad</strong></h3>
                         <strong>Acciones</strong><br>
                     </center>
                     <address class="m-t-md" style="height: 35px; overflow-y: auto;font-size: 13px;">
                         <span class="badge" style="font-size: 10px;">1.1</span>  Modelo de Sustentabilidad<br>
                     </address>
                 </a>
             </div>

             
             <div class="contact-box center-version col-md-3" style="border-radius: 15px; border: solid 1px; border-color: ##A4A4A4; margin-left: 3%">
                 <a href="/index.cfm/formatosTrimestrales/capturaFT?idCon=10">
                     <center>
                         <img alt="image" style="width: 80px;" class="img-circle" src="/includes/img/aportaciones/eje.png">
                         <h3 class="m-b-xs" style="font-size: 15px;"><strong><span class="badge badge-primary" style="font-size: 12px;">2</span> Perspectiva de Género</strong></h3>
                         <strong>Acciones</strong><br>
                     </center>
                     <address class="m-t-md" style="height: 35px; overflow-y: auto; font-size: 11px;">
                         <span class="badge" style="font-size: 10px;">2.1</span> Acciones afirmativas<br>
                         <span class="badge" style="font-size: 10px;">2.2</span> Fortalecimiento de la divulgación<br>
                     </address>
                 </a>
             </div>
         </cfif>
         </cfoutput>
     </div>
 </div>

