<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Explorador de conjuntos de datos
* Fecha 23 de Marzo de 2017
* Descripcion:
* Vista correspondiente al submodulo del explorador de conjuntos de datos
* Autor:Jonathan Martinez
* ================================
--->
 <cfprocessingdirective pageEncoding="utf-8">
 <cfinclude template="conjuntosDatos_js.cfm">
 <!---Seccion correspondiente a la barra de navegacion del modulo--->
 <div class="row wrapper border-bottom white-bg page-heading">
     <div class="col-lg-10">
         <h2>Conjunto de Datos</h2>
         <ol class="breadcrumb">
             <li>
                 <cfoutput><a href="#event.buildLink('inicio')#">Inicio</a></cfoutput>
             </li>
             <li>
                 <a>Tablas Dinamicas</a>
             </li>
             <li class="active">
                 <strong>Conjuntos de Datos</strong>
             </li>
         </ol>
     </div>
     <div class="col-lg-2"></div>
 </div>
 <div class="wrapper wrapper-content animated fadeInRight" >
 <!---Seccion correspondiente al contenido del submodulo--->
     <div class="row">
         <cfoutput>
             <!---
                 Bucle que crea la estructura de los conjuntos de datos cada uno encapsulado en un div que pertenece a la clase "conjunto" y que a su vez se divide en dos secciones delimitadas por divs uno con clase "info" y otro "datos" que contienen la descripcion del conjunto y la tabla de datos respectivamente.
             --->
             <cfloop array="#prc.conjuntos#" index="conjuntodatos">
                 <div class="conjunto" id="conjunto_#conjuntodatos.getId()#">
                     <div class="col-lg-4 info" id="info_#conjuntodatos.getId()#">
                         <div class="widget-head-color-box navy-bg p-lg text-center">
                             <div class="m-b-md">
                                 <i class="fa fa-database fa-4x"></i>
                                 <h1 class="font-bold no-margins">
                                     #conjuntodatos.getNombre()#
                                 </h1>
                             </div>
                         </div>
                         <div class="widget-text-box desc-cont">
                             <h4 class="media-heading">Descripción</h4>
                                 <p class="desc-text">
                                     #conjuntodatos.getDescripcion()#
                                 </p>
                             <div class="text-right">
                                 <a class="btn   btn-outline btn-default ver-datos">
                                     <i class="fa fa-list-alt"></i>
                                     Ver Datos
                                 </a>
                                 <a class="btn  btn-outline btn-primary" href="#event.buildLink('adminCSII.tablasDinamicas.conjuntosDatos.cargarConjunto.idCon.#conjuntodatos.getId()#')#">
                                     <i class="fa fa-cloud-download"></i>
                                     Cargar
                                 </a>
                             </div>
                         </div>
                     </div>
                     <div class="col-lg-8 datos"id="datos_#conjuntodatos.getId()#" hidden>
                         <div class="ibox datos">
                             <div class="ibox-title">
                                 <div class="ibox-tools">
                                     <a class="close-data">
                                         <i class="fa fa-times"></i>
                                     </a>
                                 </div>
                             </div>
                             <div class="ibox-content large-data" >
                                 <table class="table table-hover">
                                     <thead>
                                         <tr>
                                             <cfloop array="#conjuntodatos.getColumnas()#" index="columna">
                                                 <th>#columna.getNombre()#</th>
                                             </cfloop>
                                         </tr>
                                     </thead>
                                     <tbody>
                                         <cfloop query="#conjuntodatos.getDatos()#" endRow = "50">
                                             <tr>
                                                 <cfloop array="#conjuntodatos.getColumnas()#" index="columna">
                                                     <td>
                                                         #conjuntodatos.getDatos()["COL_"&columna.getId()][currentRow]#
                                                     </td>
                                                 </cfloop>
                                             </tr>
                                         </cfloop>
                                     </tbody>
                                 </table>
                             </div>
                         </div>
                     </div>
                 </div>
             </cfloop>
         </cfoutput>
     </div>
 </div>
