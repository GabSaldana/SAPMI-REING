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
             <li class="active"> 
                 <strong>Menú de aportaciones</strong>
             </li>
             
         </ol>
     </div>
     <div class="col-lg-2"></div>
 </div>
 <div class="wrapper wrapper-content animated fadeInRight" >
 <!---Seccion correspondiente al contenido del submodulo--->
     <div class="row">
        <cfoutput>
            
            <!---- NOTIFICACION ---->
             <div class="widget style1 white-bg animated fadeInLeft" style="border: 1px solid;  border-color:##A4A4A4; border-radius: 8px;">
                 <div class="row">              
                     <div class="col-xs-8 text-left">
                         <span><h2><b>Bienvenid@</b></h2> </span>
                         <span> Selecciona una opción para realizar tu aportación. </span>    
                     </div>
                     <div class="col-xs-4 text-right">
                         <i class="fa fa-book fa-5x"></i>
                     </div>
                 </div>
             </div>
            <!--- FIN DE NOTIFICACION ---->


             <!---
                 MISIÓN
             --->

            <div class="conjunto" >
                <div class="col-lg-4 info col-md-offset-2" >
                    <div class="widget-head-color-box navy-bg p-lg text-center">
                        <div class="m-b-md">
                            <i class="fa fa-pencil-square-o fa-4x"></i>
                            <h1 class="font-bold no-margins">  MISIÓN Y VISIÓN   </h1>
                        </div>
                    </div>
                    <div class="widget-text-box desc-cont">
                        <!--- <h4 class="media-heading">Descripción</h4>
                         ---><!--- <p class="desc-text">La Misión es una descripción de la razón de ser de la organización, establece su quehacer institucional, los bienes y servicios que entrega, las funciones principales que la distinguen y la hacen diferente de otras instituciones y justifican su existencia.  </p> --->
                        <div class="text-right">
                                 
                            <a class="btn  btn-outline btn-primary" href="/index.cfm/formatosTrimestrales/capturaFT?idCon=1">
                                <i class="fa fa-file-text"></i>
                                Aportar
                            </a>
                        </div>
                    </div>
                </div>     
            </div>
            <!---
                 FODA
             --->

            <div class="conjunto" >
                <div class="col-lg-4 info" >
                    <div class="widget-head-color-box navy-bg p-lg text-center">
                        <div class="m-b-md">
                            <i class="fa fa-pencil-square-o fa-4x"></i>
                            <h1 class="font-bold no-margins">  FODA   </h1>
                        </div>
                    </div>
                    <div class="widget-text-box desc-cont">
                        <!--- <h4 class="media-heading">Descripción</h4>
                         ---><!--- <p class="desc-text">El Análisis FODA es la técnica que permite conformar un cuadro de la situación actual de la institución; y de esta manera obtener datos precisos para la toma de decisiones acordes con los objetivos y políticas establecidos por la misma.  </p> --->
                        <div class="text-right">
                                 
                            <a class="btn  btn-outline btn-primary" href="/index.cfm/formatosTrimestrales/capturaFT?idCon=3">
                                 <i class="fa fa-file-text"></i>
                                Aportar
                            </a>
                        </div>
                    </div>
                </div>     
            </div>
            <!---
                 VISIÓN
             --->

            <div class="conjunto" >
                <div class="col-lg-4 col-md-offset-2 info" style="margin-top: 2%;">
                    <div class="widget-head-color-box navy-bg p-lg text-center">
                        <div class="m-b-md">
                            <i class="fa fa-pencil-square-o fa-4x"></i>
                            <h1 class="font-bold no-margins">  APORTACIÓN A EJES FUNDAMENTALES</h1>
                        </div>
                    </div>
                    <div class="widget-text-box desc-cont">
                        <!--- <h4 class="media-heading">Descripción</h4>
                         ---><!--- <p class="desc-text">La Visión corresponde al futuro deseado de la Institución, se refiere a cómo quiere ser reconocida y representa los valores con los cuales se fundamentará su accionar público.  </p> --->
                        <div class="text-right">
                                 
                            <a class="btn  btn-outline btn-primary" href="/index.cfm/formatosTrimestrales/capturaFT/getEjes?tipo=1">
                                 <i class="fa fa-file-text"></i>
                                Aportar
                            </a>
                        </div>
                    </div>
                </div>     
            </div>

             <div class="conjunto" >
                <div class="col-lg-4 info" style="margin-top: 2%;"" >
                    <div class="widget-head-color-box navy-bg p-lg text-center">
                        <div class="m-b-md">
                            <i class="fa fa-pencil-square-o fa-4x"></i>
                            <h1 class="font-bold no-margins">  APORTACIÓN A EJES TRANSVERSALES</h1>
                        </div>
                    </div>
                    <div class="widget-text-box desc-cont">
                        <!--- <h4 class="media-heading">Descripción</h4>
                         ---><!--- <p class="desc-text">La Visión corresponde al futuro deseado de la Institución, se refiere a cómo quiere ser reconocida y representa los valores con los cuales se fundamentará su accionar público.  </p> --->
                        <div class="text-right">
                                 
                            <a class="btn  btn-outline btn-primary" href="/index.cfm/formatosTrimestrales/capturaFT/getEjes?tipo=2">
                                 <i class="fa fa-file-text"></i>
                                Aportar
                            </a>
                        </div>
                    </div>
                </div>     
             </div>
            

            
        </cfoutput>
    </div>
</div>

