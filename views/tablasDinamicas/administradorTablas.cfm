<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Administrador de Tablas
* Fecha 23 de Marzo de 2017
* Descripcion:
* Vista correspondiente al administrador de Tablas asociadas a un conjunto
* Autor:Jonathan Martinez
* ================================
--->
 <cfprocessingdirective pageEncoding="utf-8">
 <cfinclude template="administradorTablas_js.cfm">
 <div class="row wrapper border-bottom white-bg page-heading">
     <cfoutput>
         <div class="col-lg-10" data-con-id="#prc.conjunto.getId()#">
             <h2>#prc.conjunto.getNombre()#</h2>
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
                 <li class="active ">
                     <strong>#prc.conjunto.getNombre()#</strong>
                 </li>
             </ol>
         </div>
     </cfoutput>
     <div class="col-lg-2"></div>
 </div>
 <div class="wrapper wrapper-content animated fadeInRight" >
     <cfoutput>
         <div  id="contenido" class="row">
             <div id="tablas" class="ibox float-e-margins">
                 <div class="ibox-title">
                     <div class="row">
                         <div class="col-lg-9">
                             <h1>
                                 Tablas 
                             </h1>
                             <button class="col-lg-2  btn btn-primary nextBtn btn-outline dim btn-xs crearTab " title="Mostrar Reportes Guardados" data-toggle="tooltip" onclick="location.href='#event.buildLink('tablasDinamicas.administradorTablas.crearTabla.idCon.#prc.conjunto.getId()#')#'">
                                 <i class="glyphicon glyphicon-calendar">
                                 </i> Crear Tabla
                             </button>
                         </div>
                         <div class="input-group col-lg-3 buscador">
                             <span class="input-group-addon" id="basic-addon1"><i class="glyphicon glyphicon-search"></i></span>
                             <input type="text" class="form-control col-xs-1" placeholder="Buscar" id="BuscarTablas">
                         </div>
                     </div>
                 </div>
             </div>
             <cfloop array="#prc.tablas#" index="rep">
                 <div class="col-md-3 animated fadeInDown" id="#rep['tabla'].IDTAB#" style="display:block;">
                     <div class="ibox" data-tab-id="#rep['tabla'].IDTAB#">
                         <div class="ibox-content el-contenido">
                             <div class="el-vista-previa-rep">
                                 <img src="/includes/img/tablasDinamicas/tabla.png">
                             </div>
                             <span class="el-eliminar">
                                 <i class="glyphicon glyphicon-remove"></i>
                             </span>
                             <span class="el-publicar">
                                 <i class="fa fa-users"></i>
                             </span>
                             <span class="el-copiar-rep">
                                 <i class="fa fa-copy"></i>
                             </span>
                             <span>
                                 <br>
                             </span>
                             <div class="el-descripcion">
                                 <div class="el-nombre"><p>#rep['tabla'].NOMBRE#</p></div>
                                 <div class="el-cont-desc small m-t-xs">
                                     <p>#rep['tabla'].DESCRIPCION#</p>
                                 </div>
                                 <div style="position: absolute; right:    10px; bottom: 10px;">
                                     <a class="btn btn-md btn-outline btn-primary explorar" href="#event.buildLink('tablasDinamicas.administradorTablas.explorarTabla.idTab.#rep['tabla'].IDTAB#.idCon.#prc.conjunto.getId()#')#">
                                        Explorar
                                     </a>
                                     <a  class="btn btn-md btn-outline btn-primary editar" href="#event.buildLink('tablasDinamicas.administradorTablas.editarTabla.idTab.#rep['tabla'].IDTAB#.idCon.#prc.conjunto.getId()#')#">
                                        Editar
                                     </a>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
             </cfloop>
             <div id="tablasC" class="ibox float-e-margins">
                 <div class="ibox-title">
                     <div class="row">
                         <div class="col-lg-9 col-sm-5 col-xs-5">
                             <h1>
                                 Tablas Compartidas
                             </h1>
                         </div>
                         <div class="input-group col-xs-2 col-sm-3 col-xs-2">
                             <span class="input-group-addon" id="basic-addon1"><i class="glyphicon glyphicon-search"></i></span>
                             <input type="text" class="form-control col-xs-1" placeholder="Buscar" id="BuscarTablasC">
                         </div>
                     </div>
                 </div>
             </div>
             <cfloop array="#prc.tablasC#" index="rep">
                 <div class="col-md-3 animated fadeInDown" id="#rep['tabla'].IDTAB#" style="display:block;">
                     <div class="ibox" data-tab-id="#rep['tabla'].IDTAB#">
                         <div class="ibox-content el-contenido">
                             <div class="el-vista-previa-rep">
                                 <img src="/includes/img/tablasDinamicas/tabla2.png">
                             </div>
                             <span class="el-eliminar-compartido">
                                 <i class="glyphicon glyphicon-remove"></i>
                             </span>
                             <span class="el-publicar">
                                 <i class="fa fa-users"></i>
                             </span>
                             <span>
                                 <i class="glyphicon glyphicon-user" style="color:grey"></i>#rep['tabla'].CREADOR#
                             </span>
                             <div class="el-descripcion">
                                 <div class="el-nombre">#rep['tabla'].NOMBRE#</div>
                                 <div class="el-cont-desc small m-t-xs">
                                     #rep['tabla'].DESCRIPCION#
                                 </div>
                                 <div class="m-t text-right">
                                     <a class="btn btn-md btn-outline btn-primary" href="#event.buildLink('tablasDinamicas.administradorTablas.explorarTabla.idTab.#rep['tabla'].IDTAB#.idCon.#prc.conjunto.getId()#')#">
                                        Explorar
                                     </a>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
             </cfloop>
             <div class="row">
                 <div id="listaUsuarios" class="modal fade" role="dialog">
                     <div class="modal-dialog" style="width:70%;">
                         <div class="modal-content">
                             <div class="modal-header">
                                 <button type="button" class="close" data-dismiss="modal">&times;</button>
                                 <h4 class="modal-title">Usuarios autorizados</h4>
                             </div>
                             <div class="modal-body"></div>
                             <div class="modal-footer">
                                 <button id="btnCompartir" type="button" class="btn btn-default btn-outline" >Aceptar</button>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </cfoutput>
 </div>
 <!--- Guia de la Interfaz--->
 <ul id="tlyPageGuide" data-tourtitle="Como usar el editor de Visualizaciones">
     <li class="tlypageguide_right" data-tourtarget=".encabezado">
         <div>
             Cabecera de navegación.
         </div>
     </li>
     <li class="tlypageguide_left" data-tourtarget=".buscador">
         <div>
             Teclea el nombre de la tabla que deseas buscar.
         </div>
     </li>
     <li class="tlypageguide_left" data-tourtarget=".crearTab">
         <div>
             Redirecciona a la interfaz de creación de tablas dinámicas.
         </div>
     </li>
     <li class="tlypageguide_bottom" data-tourtarget=".el-copiar-rep">
         <div>
             Crea una copia exacta de la tabla correspondiente.
         </div>
     </li>
     <li class="tlypageguide_top" data-tourtarget=".el-publicar">
         <div>
             Comparte la tabla con los usuarios autorizados.
         </div>
     </li>
     <li class="tlypageguide_bottom" data-tourtarget=".el-eliminar">
         <div>
             Elimina la tabla corrrespondiente.
         </div>
     </li>
     <li class="tlypageguide_top" data-tourtarget=".explorar">
         <div>
             Redirecciona a la interfaz de exploración de tablas dinámicas.
         </div>
     </li>
     <li class="tlypageguide_top" data-tourtarget=".editar">
         <div>
             Redirecciona a la interfaz de edición de tablas dinámicas.
         </div>
     </li>
 </ul>
     