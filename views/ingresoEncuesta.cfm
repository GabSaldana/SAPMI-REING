<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>PDI | IPN</title>
<link rel="stylesheet" href="/includes/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet" href="/includes/login/css/flexslider.css">
<link rel="stylesheet" href="/includes/login/css/jquery.fancybox.css">
<link rel="stylesheet" href="/includes/login/css/main.css">
<link rel="stylesheet" href="/includes/login/css/responsive.css">
<link rel="stylesheet" href="/includes/login/css/font-icon.css">
<link rel="stylesheet" href="/includes/login/css/animate.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"> 
<link rel="stylesheet" href="/includes/login/css/style.css">
<link rel="stylesheet" href="/includes/css/plugins/toastr/toastr.min.css">
<link rel="stylesheet" href="/includes/css/plugins/datapicker/datepicker3.css">

<script type="text/javascript" src="/includes/login/js/jquery-2.1.4.min.js"></script>
<!---<script type="text/javascript" src="/includes/js/jquery/jquery-2.1.4.min.js"></script>--->
<script type="text/javascript" src="/includes/js/plugins/toastr/toastr.min.js"></script>
<script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.15.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.15.0/localization/messages_es.min.js"></script>
<script type="text/javascript" src="/includes/js/plugins/datepicker/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="/includes/bootstrap/3.3.4/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="/includes/login/js/jquery.flexslider-min.js"></script> 
<script type="text/javascript" src="/includes/login/js/jquery.fancybox.pack.js"></script>  
<script type="text/javascript" src="/includes/login/js/modernizr.js"></script> 
<script type="text/javascript" src="/includes/login/js/jquery.contact.js"></script> 
<script type="text/javascript" src="/includes/login/js/jquery.devrama.slider.min-0.9.4.js"></script>
<script type="text/javascript" src="/includes/login/js/jquery.stellar.min.js"></script>
<script type="text/javascript" src="/includes/login/js/main.js"></script>

<cfinclude template="login_js.cfm">

<style type="text/css">
    .embed-container {
    position: relative;
    padding-bottom: 56.25%;
    height: 0;
    overflow: hidden;
}
.embed-container iframe {
    position: absolute;
    top:0;
    left: 0;
    width: 100%;
    height: 100%;
}
</style>

 </head>
 <body>
     <section id="PDI" class="hero overlay" data-stellar-background-ratio="0.3">
         <header id="header">
             <div class="col-lg-2 h_img1">
                 <img class="pull-right" style="width:220px; margin-top: 5%;" src="/includes/img/login/PPI2018Logo.png">
             </div>
             <div class="header-content clearfix"> <a class="logo" href="index.html">PDI | IPN</a>
                 <nav class="navigation" role="navigation">
                     <ul class="primary-nav">
                         <li><a href="#PDI">Inicio</a></li>
                         <li><a href="#obj">Objetivo</a></li> 
                         <li><a href="#mivi">Misión y Visión</a></li>
                         <li><a href="#docP">Instrumentos de planeación</a></li>
                         <li><a href="#fechas">Fechas importantes</a></li>
                         <li><a href="#contacto">Contacto</a></li>
                         <li><a href="#pricing5" data-toggle="tooltip" title="Coordinación del Sistema Institucional de Información">CSII</a></li>
                     </ul>
                 </nav>
                 <a href="#" class="nav-toggle">Menu<span></span></a> 
             </div>
         </header>
         <div style="margin-top: 10%">
             <div class="col-lg-4"> </div>
             <div class="col-lg-5 text-justify">
	     </br></br>
                 <h2 id="textoLargo" style="color:white;"> Consulta para la Planeación 2018 </h2>
                 <h4 id="textoLargo" style="color:white;"> Bienvenido al portal de Consulta para la Planeación 2018, que tiene por objeto actualizar el Programa de Desarrollo Institucional (PDI) para el 2018 e integrar el Programa Institucional de Mediano Plazo (PIMP) 2018-2020 y los Programas Estratégicos de Desarrollo de Mediano Plazo (PEDMP) 2018-2020 de las dependencias politécnicas, lo que retroalimentará la propuesta de Programa de Trabajo 2017-2020. Podrá realizar sus aportaciones de manera anónima o a través de un registro personalizado ingresando directamente en INICIAR SESIÓN</h4>
             </div>
             <div class="col-lg-3"> </div>
         </div>
         <div style="margin-top: 24%">
             <div class="col-lg-5"> </div>
             <div class="col-lg-4">
                 <cfoutput>
                     <form class="m-t" action="#event.buildLink('login.autenticacionEncuesta')#" method="post">
                         <div class="input-group col-lg-7">
                             <span class="input-group-addon" onclick="location.reload();">
                                 <span class="glyphicon glyphicon-refresh"></span>
                             </span>
                             <div id="idCaptcha">
                                 <cfoutput>
                                     <cfset result="">
                                     <cfset i=0>
                                     <cfloop index="i" from="1" to="5">
                                         <cfset result=result&Chr(RandRange(65, 81))>
                                     </cfloop>
                                     <cfset funcimg1 = ImageCreateCaptcha(35,400,result,"low")> 
                                     <cfimage action="writetoBrowser" source="#funcimg1#" class="img-responsive">
                                     <input id="ip_usr" name="ip_usr" type="hidden"  class="form-control" style="width: 85%;" value="#Hash(result&'holaMundo')#"/>
                                 </cfoutput>
                             </div>
                         </div>         <br>
                         <div class="input-group col-lg-7">
                             <span class="input-group-addon">
                                 <span class="glyphicon glyphicon-font"></span>
                             </span>
                             <input id="inCaptcha" name="inCaptcha" type="text" class="form-control" style="width: 95%;" placeholder="Escriba el texto que aparece en la imagen" Maxlength="6" />
                         </div><br>
                         <div class="input-group col-lg-7">
                             <center>
                                <button class="btn" style="color:white;background-color: ##B1075E;" type="submit" >Iniciar sesión</button>
                           </center>
                         </div>
                         <div class="col-lg-7">
                            #getPlugin("MessageBox").renderIt()#
                         </div>
                     </form>
                 </cfoutput>
             </div>
             <div class="col-lg-3 col-md-offset-5" > 
                 <h5 style="cursor: pointer; font-size: 15px; margin-left: 10px;"><span class="fa fa-user" style="color: white;"></span><a onclick="inicioRegistrado();"><font color="white"> Inicio de sesión como usuario registrado</font></a></h5>
             </div>   
             <div class="col-lg-4" align="right"> 
                 <h5 style="cursor: pointer"><span class="fa fa-book" style="color: white;"></span><a onclick="modalPdf();"> <font color="white">Diagnóstico Institucional</font></a></h5>
		 <h5 style="cursor: pointer"><span class="fa fa-book" style="color: white;"></span><a href="https://goo.gl/cAGvgf" target="_blank"> <font color="white">Presentación</font></a></h5>
                 <h5 style="cursor: pointer"><span class="fa fa-book" style="color: white;"></span><a onclick="modalDocumentos();"> <font color="white">Documentos de consulta</font></a></h5>
             </div>    
         </div>
         <div style="margin-top: 35%">
         </div>
     </section>
     <section id="intro" class="section intro">
         <div class="container" >
             <div class="col-md-4 col-md-offset-2 text-center" >
                 <span style="color: white;" class="fa fa-tachometer fa-3x"></span><h3 style="color: white;" class="wow fadeInDown animated">Número de visitas</h3>
                 <div id="visitas">
                 </div>
             </div>
             <div class="col-md-4 col-md-offset-1 text-center" >
                 <span style="color: white;" class="fa fa-tachometer fa-3x"></span><h3 style="color: white;" class="wow fadeInDown animated">Número de aportaciones</h3>
                 <div id="aportaciones">
                 </div>
             </div>
         </div>
     </section>

     <section id="obj" class="section teams">
         <div class="container">
             <div class="section-header">
                 <span style="color: black;" class="fa fa-dot-circle-o fa-3x"></span><h2 class="wow fadeInDown animated">Objetivo</h2>
             </div>
             <div class="col-md-6 col-md-offset-3 text-justify">
                 <h4>  Actualizar el Programa de Desarrollo Institucional (PDI) para el 2018 e integrar el Programa Institucional de Mediano Plazo (PIMP) 2018 - 2020 y los Programas Estratégicos de Desarrollo de Mediano Plazo (PEDMP) 2018 - 2020 de las dependencias politécnicas, lo que retroalimentará la propuesta de Programa de Trabajo 2017-2020.</h4>
             </div>
         </div>
     </section>
     <!--About-->
     <section id="mivi" class="content-block data-section nopad content-3-10">
         <div class="image-container col-sm-6 col-xs-12 pull-left">
             <div class="background-image-holder">
                 <img class="pull-left" style="width:100%; height: 110%;" src="/includes/img/login/planeacion-institucional.jpg">
             </div>
         </div>
         <div class="container-fluid">
             <div class="row">
                 <div class="col-sm-6 col-sm-offset-6 col-xs-12 content">
                     
                     <div class="editContent">
                         <h3><span class="  fa fa-check-square-o"></span> Misión actual</h3>
                     </div>
                     <div class="editContent text-justify">
                         <p>El Instituto Politécnico Nacional contribuye al desarrollo económico y social de la nación, a través de la formación integral de personas competentes; de la investigación, el desarrollo tecnológico y la innovación. Además tiene reconocimiento internacional por su calidad e impacto social.</p>
                     </div>
                     <div class="editContent">
                         <h3><span class="fa fa-check-square-o"></span> Visión actual</h3>
                     </div>
                     <div class="editContent text-justify">
                         <p>Institución educativa incluyente de prestigio internacional, que con su comunidad contribuye al desarrollo científico, tecnológico e innovación con impacto social en el país.</p>
                     </div>
                 </div>
             </div><!-- /.row-->
         </div><!-- /.container -->
     </section>

     <section id="docP" class="section teams">
         <div class="container">
             <div class="section-header">
                 <span style="color: black;"  class=" fa fa-newspaper-o fa-3x"></span><h2 class="wow fadeInDown animated">Instrumentos de planeación</h2>
             </div>
             <div class="row">
                 <div class="col-md-4"> 
                     <div class="services-content text-justify" style="height:440px;">
                         <center><img class="pull-center" style="width:50%; height: 60%;" src="/includes/img/login/PDI.PNG"></center>
                         
                         <h5>PDI</h5>
                         <h6>Instrumento básico de planeación que en congruencia con el Plan Nacional Desarrollo (PND) y los programas sectoriales correspondientes, orienta el desarrollo del IPN, tiene un alcance de seis años, en paralelo con el encargo del Ejecutivo Federal, pudiendo actualizar su contenido en los años subsiguientes considerando el resultado que arroje el diagnóstico institucional, publicándose la adecuación, en su caso, a más tardar en el mes de abril.</h6>
                     </div>
                 </div>
                 <div class="col-md-4 col-sm-6 "> 
                     <div class="services-content text-justify" style="height:440px;">
                          <center><img class="pull-center" style="width:50%; height: 60%;" src="/includes/img/login/PIMP.PNG"></center>
                         <h5>PIMP</h5>
                         <h6>Instrumento que contiene los lineamientos para normar, apoyar, dar seguimiento y evaluar el desempeño de las actividades institucionales en congruencia con el PDI.En él se indicarán los objetivos, estrategias y metas para las diversas actividades que se desempeñan en el Instituto, teniendo un alcance trienal.</h6>
                     </div>
                 </div>
                 <div class="col-md-4 col-sm-6" > 
                     <div class="services-content text-justify" style="height:440px;">
                         <center><img class="pull-center" style="width:50%; height: 60%;" src="/includes/img/login/PEDMP.PNG"></center>
                         <bR>
                         <h5>PEDMP</h5>
                         <h6>Instrumento que elaboran las dependencias politécnicas en el que establecen sus objetivos, estrategias y metas a desarrollar en un periodo de tres años, en congruencia con el PIMP.</h6>
                     </div>
                 </div>
             </div>
         </div>
     </section>

     <!--About-->
     <section id="fechas" class="content-block data-section nopad content-3-10">
         <div class="image-container col-sm-9 col-xs-12 pull-center">
             <div class="background-image-holder">
                 <img class="pull-center" style="width:70%; height: 100%; margin-left: 15%; " src="/includes/img/login/calender.png">
             </div>
         </div>
         <div class="container-fluid">
             <div class="row">
                 <div class="col-sm-3 col-sm-offset-9 col-xs-12 content">
                     <div class="editContent" style=" height: 180px;  " >
                         <center>
                         <h3 style="margin-top: 30%;"><span class="fa fa-calendar"></span> Fechas de importantes</h3>
                         <center>
                     </div>
                 </div>
             </div><!-- /.row-->
         </div><!-- /.container -->
     </section>

     <section id="contacto" class="section teams" >
         <div class="container">
             <div class="section-header">
                 <span style="color: gray;" class="fa fa-book fa-3x"></span><h2 class="wow fadeInDown animated">Contacto</h2>
                 <p class="wow fadeInDown animated">Dirección de planeación</p>
             </div>
             <div class="row">
                 <div class="col-md-3 col-sm-6">
                     <div class="person"><img src="/includes/img/login/user.png" alt="" class="img-responsive">
                         <div class="person-content">
                             <h5  ><b>Dr. José Nicolás Fernández García</b></h5>
                             <h5  class="role"><i class="fa fa-graduation-cap"></i> Director</h5>
                             <h5  class="role"><i class="fa fa-envelope-o"></i> <font style="text-transform: lowercase;">jfernandezg@ipn.mx</font></h5>
                             <h5  class="role"><i class="fa fa-phone"></i> 51821</h5>
                         </div>
                     </div>
                 </div>
                 <div class="col-md-3 col-sm-6">
                     <div class="person"><img src="/includes/img/login/user.png" alt="" class="img-responsive">
                         <div class="person-content">
                             <h5  ><b>M. en C. Marissa Alonso Marbán</b></h5>
                             <h5  class="role"><i class="fa fa-graduation-cap"></i> Jefa de División de Planeación y Prospectiva</h5>
                             <h5  class="role"><i class="fa fa-envelope-o"></i><font style="text-transform: lowercase;"> malonso@ipn.mx</font></h5>
                             <h5  class="role"><i class="fa fa-phone"></i> 46049</h5>
                         </div>
                     </div>
                 </div>
                   <div class="col-md-3 col-sm-6">
                     <div class="person"><img src="/includes/img/login/user.png" alt="" class="img-responsive">
                         <div class="person-content">
                             <h5  ><b>M. en DCD. Cristina Méndez Ravina</b></h5>
                             <h5  class="role"><i class="fa fa-graduation-cap"></i> Jefa del Departamento de Planeación</h5>
                             <h5  class="role"><i class="fa fa-envelope-o"></i><font style="text-transform: lowercase;"> cmendezr@ipn.mx</font></h5>
                             <h5  class="role"><i class="fa fa-phone"></i> 51812</h5>
                         </div>
                     </div>
                 </div>
                   <div class="col-md-3 col-sm-6">
                     <div class="person"><img src="/includes/img/login/user.png" alt="" class="img-responsive">
                         <div class="person-content">
                             <h5  ><b>C. P. Joel Juárez Sánchez</b></h5>
                             <h5  class="role"><i class="fa fa-envelope-o"></i><font style="text-transform: lowercase;"> jjuarezs@ipn.mx</font></h5>
                             <h5  class="role"><i class="fa fa-phone"></i> 51806</h5>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </section>
     <!-- our team section --> 
     <section id="pricing5"  class="section intro">
         <div class="container">
             <div class="section-header" style="color:white;">
                  <span class="fa fa-institution fa-3x"></span><br>
                  <small>Aplicación desarrollada por la</small>
                  <p style="color:white; font-size: 20px;" class="wow fadeInDown animated">Coordinación del Sistema Institucional de Información (CSII)</p>
             </div>
             <div class="row">
	     
                 <div class="col-md-4">
                     <div class="table" style="height: 400px; border-radius: 30px; background: white;">
                         <center><img src="/includes/img/login/adm.png" class="img-responsive" ></center>
                         <h3 style="color:black;" class="editContent">Israel Aguirre Martínez</h3>
                         <p style="color:black;" class="editContent">Coordinador del Sistema Institucional de Información</p>
                         <ul class="table-content">
                             <li style="color:black;" class="editContent"><i class="fa fa-envelope-o"></i> iaguirrem@ipn.mx</li>
                             <li style="color:black;" class="editContent"><i class="fa fa-phone"></i> 57300</li>
                         </ul>
                     </div>
                 </div>
                 <div class="col-md-4">
                     <div class="table" style="height: 400px; border-radius: 30px; background: white;">
                         <center><img src="/includes/img/login/adm.png" class="img-responsive" ></center>
                         <h3 style="color:black;" class="editContent">Edgar Eduardo Anaya Gómez</h3>
                         <p style="color:black;" class="editContent">Jefe de División de Sistemas Informáticos</p>
                         <ul class="table-content">
                             <li style="color:black;" class="editContent"><i class="fa fa-envelope-o"></i> eanaya@ipn.mx</li>
                             <li style="color:black;" class="editContent"><i class="fa fa-phone"></i> 57303</li>
                         </ul>
                     </div>
                 </div>
                 <div class="col-md-4">
                     <div class="table" style="height: 400px; border-radius: 30px; background: white;">
                         <center><img src="/includes/img/login/adm.png" class="img-responsive" ></center>
                         <h3 style="color:black;" class="editContent">Marco Antonio Torres Hernández</h3>
                         <p style="color:black;" class="editContent">Coordinador Técnico de Desarrollo</p>
                         <ul class="table-content">
                             <li style="color:black;" class="editContent"><i class="fa fa-envelope-o"></i> mtorreshe@ipn.mx</li>
                             <li style="color:black;" class="editContent"><i class="fa fa-phone"></i> 57335</li>
                         </ul>
                     </div>
                 </div>
             </div>
         </div>
     </section>
     <script type="text/javascript">
        $(document).ready(function(){
            $('.slider-banner').DrSlider({
                'transition': 'fade',
                showNavigation: false,
                progressColor: "#9b9899"
            });

        });

        $.stellar();
    </script>
     <div class="row">
         <div id="documentos_consulta" class="modal fade" role="dialog">
             <div class="modal-dialog" style="width:80%;" >
                 <div class="modal-content">
                     <div class="modal-header" style=" background-color: #B1075E;" >
                         <button type="button" class="close" data-dismiss="modal">&times;</button>
                         <h4 style="color:white;" class="modal-title"><center>Documentos de consulta</center></h4>
                     </div>
                     <div class="modal-body" >
                        <div class="row">
                             <div class="col-md-5">
                                 <center><img src="/includes/img/logo/logoIPN_PDI.png" style="width: 70%; margin-top: 20%;" class="img-responsive" ></center>
                             </div>
                             <div class="col-md-7">
                                <div class="bg-default p-xs b-r-xl" style=" width: 85%; border-radius: 5%;"> <a  target="blank_" href="http://www.repositoriodigital.ipn.mx/retrieve/49935/GuiaActualizacionPDI2018.pdf">1.Guía para la actualización del Programa de Desarrollo Institucional (PDI) 2018</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 60%; border-radius: 5%;"> <a  target="blank_" href="http://www.repositoriodigital.ipn.mx/retrieve/48873/PDI%202015%20-%202018.pdf">2.Programa de Desarrollo Institucional 2015-2018</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 60%; border-radius: 5%;">  <a target="blank_" href="http://www.repositoriodigital.ipn.mx/retrieve/48871/PDI%202013%20-%202018.pdf">3.Programa de Desarrollo Institucional 2013-2018</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 60%; border-radius: 5%;"> <a target="blank_" href="http://www.repositoriodigital.ipn.mx/retrieve/48879/PIMP%202016%20-%202018.pdf">4.Programa Institucional a Mediano Plazo 2016-2018</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 60%; border-radius: 5%;">  <a target="blank_" href="http://www.repositoriodigital.ipn.mx/retrieve/48877/PIMP%202013%20-%202015.pdf">5.Programa Institucional a Mediano Plazo 2013-2015</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 60%; border-radius: 5%;"><a target="blank_" href="http://www.repositoriodigital.ipn.mx/retrieve/48869/LEY%20DE%20PLANEACION.pdf">6.Ley de Planeación</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 60%; border-radius: 5%;"> <a target="blank_" href="http://www.aplicaciones.abogadogeneral.ipn.mx/leyes/leyorganicadelipn.pdf">7.Ley Orgánica del Instituto Politécnico Nacional</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 60%; border-radius: 5%;">  <a target="blank_" href="http://www.repositoriodigital.ipn.mx/retrieve/48881/PND_2013-2018.pdf">8. Plan Nacional de Desarrollo 2013-2018</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 60%; border-radius: 5%;"> <a target="blank_" href="http://www.repositoriodigital.ipn.mx/retrieve/48883/PROGRAMA%20SECTORIAL%20DE%20EDUCACION%202013%20-%202018.pdf">9.Programa Sectorial de Educación 2013-2018</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 90%; border-radius: 5%;"> <a target="blank_" href="http://www.repositoriodigital.ipn.mx/retrieve/48875/PECiTI%202014%20-%202018.pdf">10.Programa Especial de Ciencia, y Tecnología e Innovación 2014-2018</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 80%; border-radius: 5%;"> <a target="blank_" href="http://www.aplicaciones.abogadogeneral.ipn.mx/reglamentos/reglamento-interno.pdf">11.Reglamento Interno del Instituto Politécnico Nacional</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 90%; border-radius: 5%;"> <a target="blank_" href="http://www.aplicaciones.abogadogeneral.ipn.mx/reglamentos/Reglamento-Organico-IPN.pdf">12.Reglamento Orgánico del Instituto Politécnico Nacional</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 90%; border-radius: 5%;"> <a target="blank_" href="http://repositoriodigital.ipn.mx/bitstream/123456789/23282/1/REGLAMENTO%20DE%20PLANEACION%20DEL%20IPN.pdf">13.Reglamento de Planeación del Instituto Politécnico Nacional</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 90%; border-radius: 5%;"> <a target="blank_" href="http://www.aplicaciones.abogadogeneral.ipn.mx/PDFS/Normatividad/RGE_13_06_2011.pdf">14.Reglamento General de Estudios del Instituto Politécnico Nacional</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 90%; border-radius: 5%;"> <a target="blank_" href="http://www.aplicaciones.abogadogeneral.ipn.mx/reglamentos/Reglamento%20Integracion%20Social.pdf">15.Reglamento de Integración Social del Instituto Politécnico Nacional</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 100%; border-radius: 5%;"> <a target="blank_" href="http://www.repositoriodigital.ipn.mx/retrieve/48867/GUIA%20TECNICA%20ELABORACION%20PEDMP.pdf">16.Guía para la elaboración del Programa Estratégico de Desarrollo a Mediano Plazo 2016-2018</a></div><br>
                                <div class="bg-default p-xs b-r-xl" style=" width: 60%; border-radius: 5%;"> <a target="blank_" href="http://www.repositoriodigital.ipn.mx/retrieve/49033/DIAGNOSTICO%20DEL%20PERSONAL%20DOCENTE%20DE%20BASE%20E%20INTERINO.pdf">17. Diagnóstico del Personal Docente de Base e Interino</a></div><br>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </div>
     <div class="row">
         <div id="login_registrado" class="modal fade" role="dialog">
             <div class="modal-dialog" role="document">
                 <div class="modal-content">
                     <div class="modal-header" style=" background-color: #B1075E;" >
                         <button type="button" class="close" data-dismiss="modal">&times;</button>
                         <h4 style="color:white;" class="modal-title"><center>Usuario registrado</center></h4>
                     </div>
                     <div class="modal-body" >
                         <div class="middle-box text-center loginscreen animated fadeInDown">
                             <div class="middle-box text-center">
                             <center> 
                                <cfoutput>
                                    <form class="m-t" action="#event.buildLink('login.autenticacion')#" method="post">
                                         <div class="form-group" style="width: 30%;">
                                             <img class="pull-center" style="width:100%; margin-top: 20%;" src="/includes/img/login/PPI2018Logo.png">    
                                        </div>  
                                        #getPlugin("MessageBox").renderIt()#
                                        <div class="form-group" style="width: 30%; margin-top: 5%">
                                            <input type="text" name="user" class="form-control usuario" placeholder="Usuario">
                                        </div>
                                        <div class="form-group" style="width: 30%;">
                                            <input type="password" name="password" class="form-control pass" placeholder="Contraseña">
                                        </div>
                                        <button type="submit" class="btn" style="color:white;background-color: ##B1075E;">Entrar</button>
                                    </form>
                                </cfoutput>   
                             </center>          
                             </div>
                             <div align="center">
                                 <a style="cursor: pointer" onclick="modalRecuperar();">Recuperar Contraseña</a>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </div>
     <div id="mdl-recuperar-pwd" class="modal fade" tabindex="-1" role="dialog">
         <div class="modal-dialog" role="document">
             <div class="modal-content">
                 <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                     <h4>Recuperar contraseña</h4>
                 </div>
                 <div class="modal-body">
                     <div class="form-group">
                         <p class="continuar">¿Este es su correo?</p>
                         <div class="col-sm-10">
                             <form id="userName" role="form" onsubmit="return false;">
                                 <input name="nomUser" id="nomUser" type="text" class="form-control" maxlength="35" placeholder="Ingrese su nombre de usuario"/>
                                 <input name="email" id="email" type="text" class="form-control"/>
                             </form>
                         </div>
                     </div>
                 </div>
                 <br>
                 <div class="modal-footer">
                     <div class="enviar">
                         <button class="btn btn-primary btn-lg btn-block" onclick="consultarEmail();">Enviar</button>
                     </div>
                     <div class="continuar">
                        <button type="button" class="btn btn-primary btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cancelar</button>
                        <button type="button" class="btn btn-default btn-lg pull-right" onclick="recuperar()"><span class="fa fa-arrow-right"></span> Continuar</button>
                     </div>
                 </div>
             </div>
         </div>
     </div>
     <div class="row">
         <div id="mdl-diagnostico" class="modal fade" style="align-content: center">
             <div class="modal-dialog" style="width:60%;">
                 <div class="modal-content">
                     <div class="modal-header" style=" background-color: #B1075E;" >
                         <button type="button" class="close" data-dismiss="modal">&times;</button>
                         <h4 style="color:white;" class="modal-title"><center>Diagnóstico Institucional</center></h4>
                     </div>
                     <div class="modal-body" >
                         <div class="embed-container">
                       
                          <iframe width="85%" height="560" src="/includes/pdf/Diagnostico.pdf#zoom=80" frameborder="0" allowfullscreen></iframe>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     <div class="modal fade" id="mdlAviso">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Aviso</h4>
                </div>
                <div class="modal-body">
                    <object type="application/pdf" data="/includes/img/login/avisoPDI.pdf" width="100%" height="600">Aviso</object>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
     </body>
      
</html>