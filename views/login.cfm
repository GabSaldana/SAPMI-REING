<!DOCTYPE html>
<cfprocessingdirective pageEncoding="utf-8">    
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IPN | SIIIP</title>

    <!--- Hojas de estilo ---> 
    <link rel="stylesheet" href="/includes/css/plugins/toastr/toastr.min.css">
    <link rel="stylesheet" href="/includes/bootstrap/3.3.4/css/bootstrap.min.css">
    <link rel="stylesheet" href="/includes/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="/includes/css/inspinia/animate.css">
    <link rel="stylesheet" href="/includes/css/inspinia/style.css">
    <link rel="stylesheet" href="/includes/js/slick/slick.css"/>
	<link rel="stylesheet" href="/includes/js/slick/slick-theme.css"/>
    
    <!--- Scripts ---> 
    <script type="text/javascript" src="/includes/js/jquery/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="/includes/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/includes/js/plugins/toastr/toastr.min.js"></script>
    <script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.15.0/jquery.validate.min.js"></script>
    <script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.15.0/localization/messages_es.min.js"></script>
    <script type="text/javascript" src="/includes/js/slick/slick.min.js"></script>
    <script type="text/javascript" src="/includes/js/slick/slick.js"></script>
    <cfinclude template="login_js.cfm">

    <!---SAPMI CIRCULO--->

</head>
<body class="white-bg">

	<style>
		.imgCarrusel {
		    width:  100%;
		    height: auto;
		}
		.imgBannerIPN {
		    float:       right;
		    width:       88%;
		    height:      88%;
		    padding-top: 5px;
		}
		.imgBannerSIIIP {
		     float:       right;
		     width:       100%;
		     height:      100%;
		     padding-top: 15px;
		}
		.imgBannerCSII {
		     width:       30%;
		     height:      30%;
		}
		.fondoGrisClaro {
		    background-color: #E5E8EB;
		}
		.cuadroHeader {
		    background-color: #333F50;
		    color:            #ffffff;
		}
		.cuadroFooter1 {
		    background-color: #333F50;
		}
		.cuadroFooter2 {
		    background-color: #5B9BD5;
		    color:            #ffffff;
		}
		.panelHeader {
		    background-color: #5B9BD5;
		    color:            #ffffff;
		}
		.tituloIPN {
		    font-size:   13px;
		    font-weight: bold;
		    padding-top: 20px;
		}
		.tituloSIIIP {
		    font-size:   13px;
		    font-weight: bold;
		    padding-top: 30px;
		}
		.pt15 {
		    padding-top: 15px;
		}
		.pt13 {
		    padding-top: 13px;
		}
		.pt10 {
		    padding-top: 10px;
		}
		.formTxt {
		    padding-left:  15px; 
		    padding-right: 15px;
		}
		.ligaBlanca .ligaBlanca, .ligaBlanca:hover, .ligaBlanca:link, .ligaBlanca:visited, .ligaBlanca:focus, .ligaBlanca:hover {
		    color:           white;
		    text-decoration: underline;
		}
		.tituloTab {
		    font-family: "Century Gothic", CenturyGothic, AppleGothic, sans-serif;
		    color:       #2B5760;
		    font-size:   16px;
		    font-weight: bold;
		}
		.parrafo {
		    font-family: "Century Gothic", CenturyGothic, AppleGothic, sans-serif;
		    color:       #00303F;
		    font-size:   14px;
		    font-weight: normal;
		}

		.ligaSIIIP, .ligaSIIIP:hover, .ligaSIIIP:link, .ligaSIIIP:visited, .ligaSIIIP:focus {
		    font-family: "Century Gothic", CenturyGothic, AppleGothic, sans-serif;
		    color:       #00303F;
		    font-size:   13px;
		    font-weight: normal;
		}
		.ligaSIIIP:hover {
		    color:       #2B5760;
		}
		body {
		    font-size:   14px;
		}
		.form-control-feedback {
		  pointer-events: initial;
		}

        <!---SAPMI CIRCULOS--->
        .vcenter {
            display: inline-block;
            vertical-align: middle;
            float: left;
        }
        .center {
            margin: 0 auto;
            width: 80%;
        }
        .subTitulo {
            font-size: 15px;
            font-family: Helvetica, sans-serif;
            color:white;
        }

	</style>
    <!---SAPMI CIRCULO--->
    <script>    
        $(document).ready(function(){
            $(".areaMenu").hover(function(){
                    $('#txtModulo').html($(this).attr("data-titulo"));
                    $('#txtModulo').css('background-color',$(this).attr("data-color"));
                }, function(){
                    $('#txtModulo').hide();
                    $('#txtModulo').html("PROCESOS T&Eacute;CNICOS <BR>INSTITUCIONALES");
                    $('#txtModulo').show();
            });

            $(".areaMenu").click(function(){
                $( "#user" ).focus();
            });
            
        });
    </script>

    <div class="container">
        <div class="row hidden-xs hidden-sm">
            <div class="col-md-1">
                <img src="/includes/img/login/IPN-guinda-lg.png" class="imgBannerIPN">
            </div>
            <div class="col-md-4 tituloIPN">
                Instituto Politécnico Nacional<br>
                "La Técnica al Servicio de la Patria"<br>
                Secretaría de Investigación y Posgrado
            </div>
            <div class="col-md-5 col-md-offset-1 tituloSIIIP text-right">
                Sistema de Administracion para <br>
                los Programas de Mejora Institucional
            </div>
            <div class="col-md-1">
                <img src="/includes/img/login/sapmi-logo.png" class="imgBannerSIIIP">
            </div>
        </div>
        <div class="row">
            <div class="ibox-title cuadroHeader">
                <h5>SAPMI | PROCESOS T&Eacute;CNICOS INSTITUCIONALES</h5>
            </div>
        </div>
        <div class="row fondoGrisClaro">
            <div class="col-md-8">
                <div class="pt15">
                    <div class="divCarrusel">
                        <div><img src="/includes/img/login/SAPMI.png"      	class="imgCarrusel"></div>
                        <div><img src="/includes/img/login/AVISOS.jpg" class="imgCarrusel"></div>
                    </div>
                </div>
                <div class="container text-center" style="margin-top:50px">
                    <div class="row">
                        <div class="col-xs-12 col-md-2 col-lg-2 vcenter subTitulo" id="txtModulo" 
                        style="height:400px; padding-top: 10px; padding-bottom: 10px; background-color: red; margin-left: 70px;">
                            PROCESOS T&Eacute;CNICOS <BR>INSTITUCIONALES
                        </div>
                        <div class="col-xs-10 col-md-10 col-lg-10 vcenter" style="width:450px; height:430px; border:none; margin-left: 30px;">
                            <img src="/includes/img/login/menuPrincipal/1verde.png"      id="btnVerdeClaro"  border="0" 
                                style="z-index:11px; position:relative;top:3px;left:4px;"/>
                            <img src="/includes/img/login/menuPrincipal/2verdeClaro.png" id="btnVerde"       border="0" 
                                style="z-index:10px; position:relative; top:3px;left:-3px;"/>
                            <img src="/includes/img/login/menuPrincipal/3amarillo.png"    id ="btnAmarillo"   border="0" 
                                style="z-index:9px; position:relative; top:-95px;left:211px;"/>
                            <img src="/includes/img/login/menuPrincipal/4anaranjado.png"  id ="btnNaranja"    border="0" 
                                style="z-index:8px; position:relative;top:36px;left:56px;"/>
                            <img src="/includes/img/login/menuPrincipal/6guinda.png"      id="btnGuinda"      border="0" 
                                style="z-index:7px; position:relative; top:-67px;left:1px;"/>
                            <img src="/includes/img/login/menuPrincipal/5rojo.png"        id ="btnRojo"       border="0" 
                                style="z-index:7px; position:relative; top:-67px;left:-6px;"/>
                            <img src="/includes/img/login/menuPrincipal/7violeta.png"     id="btnVioleta"     border="0" 
                                style="z-index:10px; position:relative; top:-270px;left:-58px;"/>
                            <img src="/includes/img/login/menuPrincipal/8marino.png"      id="btnMarino"      border="0" 
                                style="z-index:10px; position:relative; top:-400px;left:-213px;"/>
                            <img src="/includes/img/login/menuPrincipal/centro.png"       border="0" 
                                style="z-index:20px; position:relative; top:-491px;left:0px;"/>
                            <img src="/includes/img/login/menuPrincipal/mascara.png" border="0" usemap="#Map" 
                                style="z-index:100px; position:relative; top:-794px;left:-15px;"/>
                            <map name="Map">
                                <area class="areaMenu" shape="POLY" coords="212,4,369,74,277,160,210,136"    onClick="javascript:openVerde();"    href="#"     data-titulo="&Aacute;rea encargada de coordinar los procesos de planeaci&oacute;n estrat&eacute;gica de mediano y largo plazo." data-boton="btnVerde" 
                                data-color="#8bbd1a"/>
                                <area class="areaMenu" shape="POLY" coords="371,78,418,226,301,227,279,162"  onClick="openAmarillo();"            href="#" 
                                data-titulo="&Aacute;rea encargada de coordinar la integraci&oacute;n de los programas anuales de trabajo y el programa operativo anual institucional para apoyar el cumplimiento de los objetivos institucionales." 
                                data-boton="btnAmarillo" 
                                data-color="#ab9e2c"/>
                                <area class="areaMenu" shape="POLY" coords="415,230,345,351,274,283,302,229"  onClick="javascript:openNaranja();"  href="#" data-titulo="&Aacute;rea encargada de realizar la asignaci&oacute;n de recursos federales y autogenerados de las unidades responsables para apoyar el cumplimiento de los objetivos institucionales." 
                                data-boton="btnNaranja" 
                                data-color="#db972a"/>
                                <area class="areaMenu" shape="POLY" coords="342,354,210,399,210,310,269,287"  onClick="javascript:openRojo();"     href="#" data-titulo="SEGUIMIENTO A LOS PROCESOS DE GESTI&Oacute;N INSTITUCIONAL" 
                                data-boton="btnRojo" 
                                data-color="#ca4b3f"/>
                                <area class="areaMenu" shape="POLY" coords="204,398,74,353,145,285,206,308"   onClick="javascript:openLila();"     href="#" data-titulo="&Aacute;rea encargada de planear, diseñar, dirigir y operar los Sistemas de Evaluaci&oacute;n e Informaci&oacute;n Institucionales a trav&eacute;s de la realizaci&oacute;n de estudios sobre el funcionamiento integral del Instituto." 
                                data-boton="btnGuinda" 
                                data-color="#72142e"/>
                                <area class="areaMenu" shape="POLY" coords="69,350,143,283,118,224,1,224"     onClick="javascript:openMorado();"   href="#" data-titulo="CAT&Aacute;LOGO DE REPORTES" 
                                data-boton="btnVioleta" 
                                data-color="#733181"/>
                                <area class="areaMenu" shape="POLY" coords="3,220,53,76,142,160,118,221"      onClick="javascript:openAzulMarino();" href="#" data-titulo="INFORMES DE LOS<BR>PROCESOS DE <BR>GESTI&Oacute;N INSTITUCIONAL" 
                                data-boton="btnMarino" 
                                data-color="#4247a9"/>
                                <area class="areaMenu" shape="POLY" coords="52,73,208,6,207,133,143,158"      onClick="javascript:openAzulClaro();"   href="#" data-titulo="DATOS DE LOS<BR>RESPONSABLES<BR>DE LA DEPENDENCIA" 
                                data-boton="btnVerdeClaro" 
                                data-color="#93a524"/>
                            </map>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="ibox pt13">
                    <div class="ibox-title panelHeader">
                        <h5>Acceso al sistema</h5>
                    </div>
                    <div class="ibox-content">
                        <cfoutput>
                            <form class="form-horizontal" action="#event.buildLink('login.autenticacion')#" method="post">
                            	#getPlugin("MessageBox").renderIt()#
                                <div class="form-group has-feedback formTxt">
                                    <input id="user" name="user" maxlength="30" type="text" class="form-control" placeholder="Usuario">
                                    <i class="fa fa-user fa-lg form-control-feedback pt10" aria-hidden="true"></i>
                                </div>
                                <div class="form-group has-feedback formTxt">
                                    <input name="password" id="password" maxlength="25" type="password" class="form-control" placeholder="Contraseña">
                                    <span class="form-control-feedback" style="cursor: pointer;" onclick="muestraPass();">
                                        <i id="eyePass" class="fa fa-eye fa-lg pt10" aria-hidden="true"></i>    
                                    </span>
                                </div>
                                <div class="form-group row">
                                	<div class="col-md-1"></div>
                                    <a onclick="modalRecuperar();" class="col-md-6">Recuperar Contraseña</a>
                                    <button type="submit" class="btn btn-primary col-md-4">Entrar</button>
                                </div>
                            </form>
                        </cfoutput>

                        <div>
                        	<p class="text-justify">
                        		Algun texto de ayuda <a href="<cfoutput>#event.buildLink("CVU.registro.investigadorNumEmpleado")#</cfoutput>">este enlace.</a>
                        	</p>
							<p class="text-justify">
								Algun link a <a>este enlace.</a>
							</p>
							<p class="text-justify">
								Usted esta accesando al sistema de forma segura.<a href="<cfoutput>#event.buildLink("CVU.registro.investigadorSinNumEmpleado")#</cfoutput>">este enlace.</a>
							</p>
						</div> 

                    </div>
                </div>

                <div class="ibox">
                    <div class="ibox-content text-center">
                        <strong>Coordinación del Sistema Institucional de Información</strong>
                        <div>
                        	<img src="/includes/img/login/CSII_logo.png" class="imgBannerCSII">
                        </div>
                        <div>
                        	<small>SAPMI 2017</small>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="row">
            <div class="col-md-12 cuadroFooter1" style="height: 20px"></div>
        </div>
        <div class="row">
            <div class="col-md-12 cuadroFooter2 text-center">
                <small>
	                <p>
	                    <strong><a href="http://www.csii.ipn.mx" target="_blank" class="ligaBlanca">Coordinación del Sistema Institucional de Información</a></strong><br>
	                    D.R. <strong><a href="http://www.ipn.mx" target="_blank" class="ligaBlanca">Instituto Politécnico Nacional (IPN)</a></strong>, Planta Baja del Edificio "Adolfo Ruíz Cortines" de la Unidad Profesional "Adolfo López Mateos",<br>Zacatenco Av. Wilfrido Massieu S/N esquina Luis Enrique Erro C.P. 07738 ​Delegación Gustavo A. Madero, México, Ciudad de México.
	                </p>
	                <p>
	                    Tel. <a href="callto://57296000" class="ligaBlanca">57-29-6000</a> Ext. 57301, 57302, Fax 57327.<br>
	                    Correo Institucional : <strong><a href="mailto:csii@ipn.mx" class="ligaBlanca">csii@ipn.mx</a></strong>
	                </p>
            	</small>
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
	          </div><br>
	          <div class="modal-footer">
	          	<div class="enviar">
	            	<button class="btn btn-primary btn-lg btn-block" onclick="consultarEmail();">Enviar</button>
	        	</div>
	            <div class="continuar">
	            	<button type="button" class="btn btn-primary btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cancelar</button>
	                <button type="button" class="btn btn-default btn-lg pull-right" onclick="recuperar();"><span class="fa fa-arrow-right"></span> Continuar</button>
	        	</div>
	          </div>
	        </div>
	    </div>
	</div>
</body>
</html>

