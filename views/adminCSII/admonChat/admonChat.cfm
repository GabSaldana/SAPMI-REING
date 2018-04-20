<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Administración Chat
* Sub modulo: Creador de Tablas
* Fecha 6 de Julio de 2017
* Descripcion:
* Vista correspondiente al modulo de administrador de Chat
* Autor:Alejandro Rosales
* ================================
--->
 <cfprocessingdirective pageEncoding="utf-8">
 <cfinclude template="admonChat_js.cfm">
 <head>
 	<link rel="stylesheet" type="text/css" href="/includes/css/plugins/clockpicker/bootstrap-clockpicker.min.css">
 </head>
 <cfoutput>
    <!---Seccion correspondiente a la barra de navegacion del modulo--->
     <div class="row wrapper border-bottom white-bg page-heading" >
         <div class="col-lg-10">
             <h2>Administración Chat</h2>
             <ol class="breadcrumb encabezado">
                 <li>
                     <a href="/index.cfm">Inicio</a>
                 </li>
                 
                 <li class="active">
                     <strong><a>Administración Chat</a></strong>
                 </li>
             </ol>
         </div>
         <div class="col-lg-2"></div>
     </div>
 </cfoutput>

<!--- <cfdump var="#session.cbstorage.usuario.ROL#" abort="true"> --->

 <div class="wrapper wrapper-content animated fadeInRight">
   	<div class="row">
   <!--- Seccion correspondiente a los proceso asociacion --->
         <div class="col-sm-12">
             <div class="ibox float-e-margins">
                 <div class="ibox-title tablaContenido">
                     <h5>Procesos</h5> 
                 </div>
                 <div class="ibox-content " style="height:auto;">
                 	<cfinclude template="tablaProcesos.cfm">
                 </div>
             </div>  
         </div>
    </div>
    <!--- Seccion corresponeitne a la asociacion --->
     <div class="row">
         <div class="col-sm-12">
             <div class="ibox float-e-margins">
                 <div class="ibox-title tablaContenido">
                     <h5>Relacion Proceso/Rol</h5> 
                 </div>
                 <div class="ibox-content tabla_cont" >
                 	<div class="row">
         			<div class="col-sm-12">
  					     <div id="tablaR"> </div>
         			</div>
                 </div>
             </div>  
         </div>
    </div>
</div>



