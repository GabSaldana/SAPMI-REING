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
    
    <!--- Scripts ---> 
    <script type="text/javascript" src="/includes/js/jquery/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="/includes/bootstrap/3.3.4/js/bootstrap.min.js"></script>

    <cfinclude template="login_js.cfm">
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
		.imgAviso {
		    float:       left;
		    width:       100%;
		    height:      100%;
		}
		.fondoGrisClaro {
		    background-color: #E5E8EB;
		    height:70vh;
		}
		.cuadroHeader {
		    background-color: #00303F;
		    color:            #ffffff;
		}
		.cuadroFooter1 {
		    background-color: #2B5760;
		}
		.cuadroFooter2 {
		    background-color: #698C95;
		    color:            #ffffff;
		}
		.panelHeader {
		    background-color: #2B5760;
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
	</style>

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
                Sistema Institucional de Información<br>
                de Investigación y Posgrado
            </div>
            <div class="col-md-1">
                <img src="/includes/img/login/SIIIP_logo.png" class="imgBannerSIIIP">
            </div>

        </div>
        <div class="row">
            <div class="ibox-title cuadroHeader">
                <h5>SIIIP | Sistema Institucional de Información de Investigación y Posgrado</h5>
            </div>
        </div>
        <div class="row fondoGrisClaro" style="overflow:hidden;">
        
		
		   <img src="/includes/img/login/mantenimiento.jpg"  class="imgAviso" align="middle">
	
		
		
		
		
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





</body>
</html>

