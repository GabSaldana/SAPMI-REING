<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Explorar Tabla
* Fecha 23 de Marzo de 2017
* Descripcion:
* Vista  para el submodulo de exploracion de tablas
* Autor: Jonathan Martinez
* ================================
--->
 <cfprocessingdirective pageEncoding="utf-8">
 <cfinclude template="exploradorTablas_js.cfm">
 <cfoutput>
     <div class="row wrapper border-bottom white-bg page-heading" data-rep-id="#prc.tabla['tabla'].IDTAB#" data-con-id="#prc.conjunto.getId()#">
         <div class="col-lg-10">
             <h2>#prc.tabla['tabla'].NOMBRE#</h2>
             <ol class="breadcrumb encabezado">
                 <li>
                     <a href="/index.cfm">Inicio</a>
                 </li>
                 <li>
                     <a>Tablas Dinamicas</a>
                 </li>
                 <li>
                     <a href="#event.buildLink('tablasDinamicas/conjuntosDatos/index')#">Conjuntos de Datos</a>
                 </li>
                 <li>
                     <a href="#event.buildLink('tablasDinamicas/conjuntosDatos/cargarConjunto.idCon.#prc.conjunto.getId()#')#">#prc.conjunto.getNombre()#</a>
                 </li>
                 <li class="active">
                     <strong>#prc.tabla['tabla'].NOMBRE#</strong>
                 </li>
             </ol>
         </div>
     </div>
     <div class="wrapper wrapper-content animated fadeInRight" style="height:auto;">
         <div class="row">
             <div class="col-lg-12">
                 <div class="ibox float-e-margins configuraciones">
                     <div class="ibox-title">
                        <div class="ibox-tools">
                             <a class="collapse-link">
                                 <i class="fa fa-chevron-up"></i>
                             </a>
                         </div> 
                         <h3>Configuraciones</h3>
                     </div>
                     <div class="ibox-content no-padding" style="height: 130px; overflow:auto; ">
                         <div class="col-lg-3" style="margin-top: 5px" >
                             <div class="panel panel-primary"> 
                                 <div class="panel-heading" style="height: 30px;"> 
                                     <h5><i class="fa fa-arrows-h"></i> Columnas </h5>
                                 </div>
                                 <div class="chart-canvas-col" style="overflow:auto;"></div>
                             </div> 
                         </div>
                         <div class="col-lg-3" style="margin-top: 5px">
                             <div class="panel panel-success"> 
                                 <div class="panel-heading" style="height: 30px;"> 
                                     <h5><i class="fa fa-arrows-v"></i> Filas </h5>
                                 </div>
                                 <div class="chart-canvas-fil" style="overflow:auto;"></div>
                             </div> 
                         </div>
                         <div class="col-lg-3" style="margin-top: 5px">
                             <div class="panel panel-warning"> 
                                 <div class="panel-heading" style="height: 30px;"> 
                                     <h5><i class="glyphicon glyphicon-usd"></i> Valores </h5>
                                 </div>
                                 <div class="chart-canvas-val" style="overflow:auto;"></div>
                             </div> 
                         </div>
                         <div class="col-lg-3" style="margin-top: 5px">
                             <div class="panel panel-danger"> 
                                 <div class="panel-heading" style="height: 30px;"> 
                                     <h5><i class="fa fa-filter"></i> Filtros </h5>
                                 </div>
                                 <div class="btn-toolbar" style="overflow:auto;"></div>
                             </div> 
                         </div>
                     </div>
                 </div>  
             </div>
         </div>
         <div class="row">
             <div class="col-12">
                 <div class="ibox float-e-margins">
                     <div class="ibox-title titulo">
                         <h2>#prc.tabla['tabla'].NOMBRE#</h2> 
                     </div>
                      <div class="ibox-content descripcion">
                         <h5>#prc.tabla['tabla'].DESCRIPCION#</h5> 
                     </div>
                     <div class="ibox-content " style="height:auto;">
                         <div class="chart-table tabla_cont" id="chartTable"></div>
                     </div>
                 </div>  
             </div>
         </div>
     </div>
 </cfoutput>
 <!--- Modal Cargar --->
 <div class="modal inmodal fade" data-backdrop="static" data-keyboard="false" id="loading-modal" tabindex="-1" role="dialog"  aria-hidden="true">
     <div class="modal-dialog modal-lg">
         <div class="modal-content">
             <div class="modal-header">
                 <h6 class="modal-title title-save">Cargando...</h6>
                 <medium class="font-normal"></medium>
             </div>
             <div class="modal-body">
                 <div class="form-group" align="center">
                     <img src="/includes/img/tablasDinamicas/loading.gif">
                 </div>
             </div>
             <div class="modal-footer">
             </div>
         </div>
     </div>
 </div>
 <!---Guia de interfaz--->
 <ul id="tlyPageGuide" data-tourtitle="Como usar el editor de Visualizaciones">
     <li class="tlypageguide_right" data-tourtarget=".encabezado">
         <div>
             Cabecera de navegación.
         </div>
     </li>
     <li class="tlypageguide_left" data-tourtarget=".configuraciones">
         <div>
             Configuraciones de la tabla con respecto a sus columnas, filas, valores y filtros.
         </div>
     </li>
     <li class="tlypageguide_left" data-tourtarget=".titulo">
         <div>
             Titulo de la tabla.
         </div>
     </li>
     <li class="tlypageguide_left" data-tourtarget=".descripcion">
         <div>
             Descripción de la tabla.
         </div>
     </li>
     <li class="tlypageguide_left" data-tourtarget=".tabla_cont">
         <div>
             Aqui aparece la tabla construida a partir de las columnas,filas,valores y filtros.
         </div>
     </li>
 </ul>
