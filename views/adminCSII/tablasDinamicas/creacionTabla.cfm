<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Creador de Tablas
* Fecha 15 de marzo de 2016
* Descripcion:
* Vista correspondiente al submodulo de creacion de Tablas
* Autor:Jonathan Martinez
* ================================
--->
 <cfprocessingdirective pageEncoding="utf-8">
 <cfinclude template="creacionTabla_js.cfm">
 <cfoutput>
     <!---Seccion correspondiente a la barra de navegacion del modulo--->
     <div class="row wrapper border-bottom white-bg page-heading" data-con-id="#prc.conjunto.getId()#">
         <div class="col-lg-10">
             <h2>Conjunto de Datos</h2>
             <ol class="breadcrumb encabezado">
                 <li>
                     <a href="/index.cfm">Inicio</a>
                 </li>
                 <li>
                     <a>Tablas Dinamicas</a>
                 </li>
                 <li>
                     <a href="#event.buildLink('adminCSII.tablasDinamicas/conjuntosDatos/index')#">Conjuntos de Datos</a>
                 </li>
                 <li>
                     <a href="#event.buildLink('adminCSII.tablasDinamicas/conjuntosDatos/cargarConjunto.idCon.#prc.conjunto.getId()#')#">#prc.conjunto.getNombre()#</a>
                 </li>
                 <li class="active">
                     <strong><a>Creacion de Tabla</a></strong>
                 </li>
             </ol>
         </div>
         <div class="col-lg-2"></div>
     </div>
 </cfoutput>
 <div class="wrapper wrapper-content animated fadeInRight">
     <div class="row">
         <div class="col-12">
             <div class="ibox float-e-margins">
                 <div class="ibox-title tablaContenido">
                     <h5>Tabla Contenidos</h5> 
                 </div>
                 <div class="ibox-content tabla_cont" style="height:auto;">
                     <div class="chart-table" id="chartTable"></div>
                 </div>
             </div>  
         </div>
         <!---Seccion correspondiente al contenido del submodulo--->
         <cfoutput>
             <div class="row">
                 <div class="col-lg-6">
                     <div class="panel panel-primary">
                         <div class = "panel-body">
                             <div class="ibox  dimension ">
                                 <div class="ibox-title">
                                     <h5>Dimensiones</h5>
                                     <div class="ibox-tools">
                                         <a class="collapse-link">
                                             <i class="fa fa-chevron-up"></i>
                                         </a>
                                     </div>
                                 </div>
                                 <div class="ibox-content no-padding">
                                     <br>
                                     <center>
                                         <h5>Arrastra las dimensiones que desees a los contenedores de columnas y/o filas</h5>
                                     </center>
                                     <div class="list-group">
                                         <cfloop array="#prc.conjunto.getColumnas()#" index="columna" >
                                             <cfif columna.getTipo() eq 'D'>
                                                 <a data-col-id="#columna.getId()#" class="list-group-item ">
                                                     #columna.getNombre()#
                                                 </a>
                                             </cfif>
                                         </cfloop>
                                     </div>
                                 </div>
                             </div>
                             <div class="ibox float-e-margins metrica ">
                                 <div class="ibox-title">
                                     <h5>Métricas</h5>
                                     <div class="ibox-tools">
                                         <a class="collapse-link">
                                             <i class="fa fa-chevron-up"></i>
                                         </a>
                                     </div>
                                 </div>
                                 <div class="ibox-content no-padding" >
                                     <br>
                                     <center>
                                         <h5>Arrastra las métricas que desees al contenedor de valores</h5>
                                     </center>
                                     <div class="list-group">
                                         <cfloop array="#prc.conjunto.getColumnas()#" index="columna" >
                                             <cfif columna.getTipo() eq 'M'>
                                                 <a data-col-id="#columna.getId()#" class="list-group-item ">
                                                     #columna.getNombre()#
                                                 </a>
                                             </cfif>
                                         </cfloop>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
                 <div class="col-lg-3">
                     <div class="ibox columnas">
                         <div class="ibox-title">
                             <h5><i class="fa fa-arrows-h"></i> Columnas</h5>
                             <div class="ibox-tools">
                                 <a class="collapse-link">
                                     <i class="fa fa-chevron-up"></i>
                                 </a>
                             </div>
                         </div>
                         <div class="ibox-content">
                             <div class="chart-canvas-col" title="Arrastra aquí las columnas que desees agregar" style="height: 100px; overflow: auto;">
                             </div>
                         </div>
                     </div>
                 </div>
                 <div class="col-lg-3">
                     <div class="ibox filas">
                         <div class="ibox-title">
                             <h5><font color="##2E9AFE"><i class="fa fa-arrows-v"></i> Filas</font></h5>
                             <div class="ibox-tools">
                                 <a class="collapse-link">
                                     <i class="fa fa-chevron-up"></i>
                                 </a>
                             </div>
                         </div>
                         <div class="ibox-content">
                             <div class="chart-canvas-fil" style="height: 100px; overflow: auto;">
                             </div>
                         </div>
                     </div>
                 </div>
                 <div class="col-lg-3" >
                     <div class="ibox valores">
                         <div class="ibox-title">
                             <h5><font color="##FE9A2E"><i class="glyphicon glyphicon-usd"></i> Valores</font></h5>
                             <div class="ibox-tools">
                                 <a class="collapse-link">
                                     <i class="fa fa-chevron-up"></i>
                                 </a>
                             </div>
                         </div>
                         <div class="ibox-content">
                             <div class="chart-canvas-val" style="height: 100px; overflow: auto;">
                             </div>
                         </div>
                     </div>
                 </div>
                 <div class="col-lg-3">
                     <div class="ibox filtros">
                         <div class="ibox-title">
                             <h5><font color="##FA5858"><i class="fa fa-filter"></i> Filtros</h5></font>
                             <div class="ibox-tools">
                                 <a>
                                     <font color="##FA5858"> <i class="fa fa-plus fa-lg" data-toggle="modal" data-target="##filtrosModal"></i> </font>
                                 </a>
                                 <a class="collapse-link">
                                     <i class="fa fa-chevron-up"></i>
                                 </a>
                             </div>
                         </div>
                         <div class="ibox-content" style="height:138px;overflow: auto;">
                            <div class = "msj-filtro">Da click en el botón ( <font color="##FA5858"> <i class="fa fa-plus "></i></font> ) para agregar un filtro a la tabla </div>
                             <div class="btn-toolbar"></div>
                         </div>
                     </div>
                 </div>
             </div>
         </cfoutput>
     </div>
 </div>
 <cfoutput>
     <!--- Modal (guardar/actualizar) --->
     <div class="modal inmodal fade" id="saveConfirmation" tabindex="-1" role="dialog"  aria-hidden="true">
         <div class="modal-dialog modal-lg">
             <div class="modal-content">
                 <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                     <h4 class="modal-title title-save"></h4>
                     <medium class="font-normal"></medium>
                 </div>
                 <div class="modal-body">
                     <form id="formSave">
                         <div class="form-group">
                             <label>Nombre:</label>
                             <input type="text" class="form-control" name="name_usr" placeholder="" data-toggle="tooltip" data-placement="top" title="" data-original-title="Cambiar descripción" ></input> 
                         </div>  
                         <div class="form-group">
                             <label>Descripción:</label>
                             <textarea class="form-control" name="desc_usr" placeholder="" data-toggle="tooltip" data-placement="top" title="" data-original-title="Cambiar descripción" ></textarea> 
                         </div>    
                     </form>
                 </div>
                 <div class="modal-footer">
                     <button type="button" class="btn btn-primary save-sr" id="buttonConfig2">Guardar</button>
                      <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                 </div>
             </div>
         </div>
     </div>
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
     <!--- Modal de filtro--->
     <div class="row">
         <div id="filtrosModal" class="modal fade" role="dialog">
             <div class="modal-dialog">
                 <div class="modal-content">
                     <div class="modal-header">
                         <button type="button" class="close" data-dismiss="modal">&times;</button>
                         <h4 class="modal-title">Filtros</h4>
                     </div>
                     <div class="modal-body">
                         <div class="row">
                             <div class="btn-toolbar">
                                 <div id="comboColumnas" class="btn-group animated fadeInUp ">
                                     <button id="nombre-col"type="button" class="btn btn-primary nombre-combo btn-outline">Dimensiones</button>
                                     <button type="button" class="btn btn-primary btn-outline dropdown-toggle" data-toggle="dropdown">
                                         <span class="caret"></span>
                                     </button>
                                     <ul class="dropdown-menu menu-combo-filtro" role="menu">
                                         <cfloop array="#prc.conjunto.getColumnas()#" index="columna" >
                                             <cfif columna.getTipo() eq 'D'>
                                                 <li>
                                                     <a data-col-id="#columna.getId()#" >
                                                         #columna.getNombre()#
                                                     </a>
                                                 </li>
                                             </cfif>
                                         </cfloop>
                                     </ul>
                                 </div>
                             </div>
                         </div>
                     </div>
                     <div class="modal-footer">
                         <button id="agregarFiltro" type="button" class="btn btn-default btn-outline" >Agregar</button>
                     </div>
                 </div>
             </div>
         </div>
     </div>
     <!---Seccion de acciones del footer--->
     <div class="row">
         <div class="footerAcciones">
             <div class="col-sm-3"></div>
             <div class="col-sm-9">
                 <button class="button col-sm-2 btn btn-success btn-outline nextBtn dim btn-xs create-ct"  title="Generar Tabla" data-toggle="tooltip">
                     <i class="fa fa-refresh fa-2x"></i>
                 </button>
                 <button class="button col-sm-2 btn btn-success btn-outline nextBtn dim btn-xs save-sr" id="buttonConfig" title="Guardar Tabla" data-toggle="tooltip">
                     <i class="fa fa-floppy-o fa-2x"></i>Guardar
                 </button>
             </div>
         </div>
     </div> 
 </cfoutput>
 <!--- Guia de la Interfaz--->
 <ul id="tlyPageGuide" data-tourtitle="Como usar el editor de Visualizaciones">
     <li class="tlypageguide_right" data-tourtarget=".encabezado">
         <div>
             Cabecera de navegación.
         </div>
     </li>
     <li class="tlypageguide_top" data-tourtarget=".tabla_cont">
         <div>
             Aqui aparece la tabla construida a partir de las columnas,filas,valores y filtros.
         </div>
     </li>
     <li class="tlypageguide_top" data-tourtarget=".dimension">
         <div>
             Dimensiones disponibles para la construcción de tablas.
         </div>
     </li>
     <li class="tlypageguide_top" data-tourtarget=".metrica">
         <div>
             Metricas disponibles para la construcción de tablas.
         </div>
     </li>
     <li class="tlypageguide_top" data-tourtarget=".columnas">
         <div>
             Columnas seleccionadas para la tabla.
         </div>
     </li>
     <li class="tlypageguide_top" data-tourtarget=".filas">
         <div>
             Filas seleccionadas para la tabla.
         </div>
     </li>
     <li class="tlypageguide_top" data-tourtarget=".valores">
         <div>
             Valores seleccionadas para la tabla.
         </div>
     </li>
     <li class="tlypageguide_top" data-tourtarget=".filtros">
         <div>
             Filtros seleccionadas para la tabla.
         </div>
     </li>
 </ul>