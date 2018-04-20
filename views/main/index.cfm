<!---
========================================================================
* IPN - CSII
* Portal: Planeación 2018
* Modulo: Vista del menu principal.
* Sub modulo: -
* Fecha: Febrero 2018
* Descripcion: Vista 
* Autor: GSA
=========================================================================
--->
<link href="/includes/css/circulos/style.css" rel="stylesheet">
<style>
	#divPerfilIngresado{
		position:relative;
		top:85px;
		left:25px;
		font-size:1.3em;
		text-shadow:2px 2px 2px #000;
	}
</style>
<cfoutput>
	<cfinclude template="index_JS.cfm">
	<cfinclude template="login_js.cfm">
	<cfinclude template="circle-element_JS.cfm">
</cfoutput>
<div id="divPerfilIngresado">Bienvenido: <cfoutput>#Ucase(Session.cbstorage.usuario.ROL_NOMBRE)#</cfoutput></div>
<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12" style="margin-left:auto;margin-right:auto;">
		<h5 class="text-center" style="position:relative;font-size:1.5em;color:#000;top:85px;">Por favor selecciona los ejes en los cuales deseas realizar tu aportaci&oacute;n:
	</div>
</div>
<div class="row">
    <div class="menu" style="margin-left:800px;margin-top:455px;">
        <div id="center">
            <img class="circle-center menu-open-button" src="/includes/images/icono-09.png"  >
        </div>
        <!--Eje 3-->
        <!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[3] GT 0>--->
            <cfoutput><a id="E3" href="#event.buildLink("carrousel/carrousel")#" data-toggle="tooltip" title="Eje 3: Conocimiento para la soluci&oacute;n de problemas nacionales" data-placement="right" class="field circle menu-item figure conocimiento white-tooltip"></cfoutput>
            <img src="/includes/images/menu_principal/icono-04.png"></a>
        <!---</cfif>--->
        <!--Eje 4-->
        <!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[4] GT 0>--->
            <cfoutput><a id="E4" href="#event.buildLink("carrousel/carrousel")#" data-toggle="tooltip" title="Eje 4: Cumplimiento del compromiso social" data-placement="right" class="field circle menu-item figure social white-tooltip"></cfoutput>
            <img src="/includes/images/menu_principal/icono-05.png"></a>
        <!---</cfif>--->
        <!--Eje 5-->
        <!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[5] GT 0>--->
            <cfoutput><a id="E5" href="#event.buildLink("carrousel/carrousel")#" data-toggle="tooltip" title="Eje 5: Gobernanza y gesti&oacute;n institucional" data-placement="left" class="field circle menu-item figure gobernanza white-tooltip"></cfoutput>
            <img src="/includes/images/menu_principal/icono-06.png"></a>
        <!---</cfif>--->
        <!--Eje 1T-->
        <!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[6] GT 0>--->
            <cfoutput><a id="ET1" href="#event.buildLink("carrousel/carrousel")#" data-toggle="tooltip" title="Eje T 1: Sustentabilidad" data-placement="left" class="field circle menu-item figure sustentabilidad white-tooltip"></cfoutput>
            <img src="/includes/images/menu_principal/icono-07.png"></a>
        <!---</cfif>--->
        <!--Eje 2T-->
        <!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[7] GT 0>--->
            <cfoutput><a id="ET2" href="#event.buildLink("carrousel/carrousel")#" data-toggle="tooltip" title="Eje T 2: Perspectiva de g&eacute;nero" data-placement="left" class="field circle menu-item figure perspectiva white-tooltip"></cfoutput>
            <img src="/includes/images/menu_principal/icono-08.png"></a> 
        <!---</cfif>--->
        <!--Eje 1-->
        <!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[1] GT 0>--->
            <cfoutput><a id="E1" href="#event.buildLink("carrousel/carrousel")#" data-toggle="tooltip" data-placement="left" title="Eje 1: Calidad y pertinencia educativa" class="field circle menu-item figure calidad  white-tooltip"></cfoutput>
            <img src="/includes/images/menu_principal/icono-02.png"></a>
        <!---</cfif>--->
        <!--Eje 2-->
        <!---<cfif Request.accionesEjes.CANTIDAD_ACCIONES[2] GT 0>--->
            <cfoutput><a id="E2" href="#event.buildLink("carrousel/carrousel")#" data-toggle="tooltip" title="Eje 2: Cobertura y atenci&oacute;n estudiantil" data-placement="right" class="field circle menu-item figure cobertura white-tooltip" ></cfoutput>
            <img src="/includes/images/menu_principal/icono-03.png"></a>
        <!---</cfif>--->
    </div>
</div>
<div>
    <button class="card-title" style="position:fixed;width:250px;top:95px; right:20px; background: white; padding-bottom: 5px; padding: 10px; border-radius: 5px; border: solid 1px #7A003B; color: #337ab7; font-size:1.4em; text-decoration: none;" id="abrirComplementarConDocumento">
        Aportaciones adicionales
    </button>
</div>
<div>
    <span id="roli" class="card-title" style="position:fixed;width:250px;text-align:center;bottom:20px;right:20px; background: white;padding-bottom: 5px; padding: 10px; border-radius: 5px; border: solid 1px #7A003B; color: #AD1457; ">
        <!--icono-->
        <cfoutput>
            <a href="#event.buildLink('login.cerrarSesion')#" style=" font-size:1.4em;text-decoration: none;">
                Terminar consulta
            </a>
        </cfoutput>
    </span>
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
<div id="complementarConDocumento" class="load-screen" style="display: none;">
    <div class="load-back" tabindex="-1"></div>
    <div class="load-front">
        <table width="100%">
			<tr>
				<td align="left"><b>APORTACIONES ADICIONALES</b></td>
				<td><button id="cerrarComplementarConDocumento" class="btn btn-close pull-right">x</button></td>
			</tr>
		</table>
        <br />
        <p>Si deseas realizar alguna aportaci&oacute;n adicional, adjunta un archivo en formato PDF que no exceda 1 Mb.</p>
        <div id="cargarDoc" style="width: 100%; height: 100%; margin: 50px 0 50px 0;">
            <input id="documentoComplementario" name="upload_files" type="file" data-show-preview="false">
        </div>
        <div id="docYaCargado" style="display: none; width: 100%; height: 100%; margin: 20px 0 50px 0;">
            <div class="alert alert-info">Ya has cargado un documento</div>
            <div id="previewDoc"></div>
        </div>
	<div id="formularioCaptura" style="overflow:visible"></div>
        <div id="errorDocumento" class="help-block"></div>
    </div>
    <script type="text/javascript">
        function consultarArchivoCargado(){
            $.post('<cfoutput>#event.buildLink('cargaArchivos.cargaArchivos.consultarArchivoExistente')#</cfoutput>',{
                pkCatalogo: 3,  // pk del Documento complementario de encuesta
                pkRegistro: <cfoutput>#Session.cbstorage.usuario.PK#</cfoutput>
            }, function(data){
                if (data.DATA.PK[0] > 0){
                    obtenerDocumentoCargado(data.DATA.PK[0]);
                    $("#cargarDoc").hide(); $("#docYaCargado").show();
                } else {
                    $("#cargarDoc").show(); $("#docYaCargado").hide();
                }
            });
        }
        function obtenerDocumentoCargado(pkDoc){
            $.post('<cfoutput>#event.buildLink("cargaArchivos.cargaArchivos.obtenerDocumento")#</cfoutput>',{
                pkDoc: pkDoc
            }, function(data){
                var base64 = /^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$/;
                if (data.match(base64)){
                    var str = '<object data="data:application/pdf;base64,'+data+'" type="application/pdf" width="100%" height="100%"></object>';        
                } else {
                    var str = '<div class="alert alert-danger" style="margin: auto;">Error al cargar documento</div>';
                }
                $("#previewDoc").html(str);
            });
        }
        function validarExtension(ext, extensiones){
            var cont = 0;
            for (var i = 0; i < extensiones.length; i++){
                if (ext == extensiones[i]){ cont = cont + 1; }
            }
            if (cont == 0)return false;
            else return true;
        }
        function caracteresEspeciales(cadena){
            var specialChars = " ^<>@!#$%^&*()+[]{}?:;|ñÑáéíóúÁÉÍÓÚ'\"\\,/~`-=";
            for(i = 0; i < specialChars.length;i++){
                if(cadena.indexOf(specialChars[i]) > -1){ return true }
            } return false;
        }
        $(document).ready(function(){
            $("#abrirComplementarConDocumento").on('click', function(){
                $("#complementarConDocumento").fadeIn(150);
                consultarArchivoCargado();
                cargacomplemento();
            });
            $("#cerrarComplementarConDocumento").on('click', function(){
                $("#complementarConDocumento").fadeOut(150);
                $('#documentoComplementario').fileinput('clear');
                $('#documentoComplementario').fileinput('unlock');
            });
            $("#documentoComplementario").fileinput({
                uploadUrl: '<cfoutput>#event.buildLink('cargaArchivos.cargaArchivos.subirArchivo')#</cfoutput>',
                maxFileCount: 1,
                maxFileSize: 1000,
                msgSizeTooLarge: '"{name}" excede el tamaño máximo, <b>1 MB</b> permitidos!',
                uploadAsync: true,
                showRemove: true,
                showUpload: true,
                elErrorContainer: "#errorDocumento",
                uploadExtraData: function (previewId, index){
                    var extraData = {
                        pkCatalogo: 3, // pk del Documento complementario de encuesta
                        pkRegistro: <cfoutput>#Session.cbstorage.usuario.PK#</cfoutput>
                    };
                    return extraData;
                },
                slugCallback: function(filename) {
                    return filename;
                }
            })
            .on('filebatchpreupload', function(event, data) {
                var ext         = (data.filenames[0]).substring((data.filenames[0]).lastIndexOf(".")+1).toString();
                var puntos      = (data.filenames[0]).split('.').length;
                var extensiones = JSON.parse('["pdf"]');

                /*Verifica que la extension del documento sea la permitida*/
                if(!validarExtension(ext, extensiones)){
                    return { message: "Extension del documento no permitida, solo se aceptan las siguientes extensiones ["+JSON.parse('["pdf"]') +"]" };
                }

                /*Verifica que el nombre del documento no tenga caracteres especiales*/
                if (caracteresEspeciales(data.filenames[0])) {
                    return {message: "El nombre del documento no debe contener espacios ni los siguientes caracteres ^<>@!\#$%^&*()+[]{}?:;|ñÑáéíóúÁÉÍÓÚ'\"\\,/~`-=!"};
                }

                /*Verifica que el nombre del documento no tenga dos puntos*/
                if (puntos > 2){
                    return {message: "El nombre del documento no puede tener dos puntos."};
                }

                /*Verifica la longitud del nombre del documento*/
                if (data.filenames[0].length > 24) {
                    return {message: "El nombre del documento no debe exceder 20 caracteres!"};
                }
            })
            .on('fileuploaded', function(event, files) {
                $("#cerrarComplementarConDocumento").trigger('click');
            });
        });
        
          function cargacomplemento(){
		    $.post('<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.getReporteLlenado")#</cfoutput>', {
		      formato: 2434,
		      periodo: 1,
		      reporte: 75704
		    }, function(data){
		      $('#formularioCaptura').html(data); 
		      $('#btn-guardarDatos').show();
		       setTimeout(desbloqueoCampos,500); 
		      
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
    <style type="text/css">
        /* PANTALLA DE CARGA */
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
         /* max-width: 900px;*/
          /*height: 365px;*/
          padding: 15px;
          border-radius: 5px;
          border: 2px solid #6C1D45;
          text-align: center;
          position: fixed;
          left: 20%;
          right: 20%;
          top: 30%;
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
    </style>
</div>