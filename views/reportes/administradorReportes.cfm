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
 <cfinclude template="administradorReportes_js.cfm">
 <div class="row wrapper border-bottom white-bg page-heading">
     <cfoutput>
         <div class="col-lg-10" <!---data-con-id="#prc.conjunto.getId()#"---->>
             <h2>Reportes</h2>
             <ol class="breadcrumb encabezado">
                 <li>
                     <a <!--- href="/index.cfm" --->>Inicio</a>
                 </li>
                 <li class="active">
                     <strong>Reportes</strong>
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
                         <div class="col-lg-8">
                             <h1>
                                 Reportes
                             </h1>
                         </div>
                         <div class="input-group col-lg-3 buscador">
                             <span class="input-group-addon" id="basic-addon1"><i class="glyphicon glyphicon-search"></i></span>
                             <input type="text" class="form-control col-xs-1" placeholder="Buscar" id="BuscarTablas">
                         </div>
                         <div class="input-group col-lg-1 ">
                        </div> 
                     </div>
                 </div>
                 <div class="ibox-content">
                    <br>
                    <div class="row">
                    <cfloop array="#prc.reportes#" index="rep">
                        <div class="col-md-3 border-reporte animated fadeInDown reporteConsulta" id="#rep['tabla'].IDTAB#" data-tab-id="#rep['tabla'].IDTAB#" data-tab-con="#rep['tabla'].IDCON#" style="display:block;">
                            <div class="ibox"  >
                                <div class="ibox-content el-contenido">
                                    <div class="el-vista-previa-reporte">
                                        <br>
                                        <img src="/includes/img/reportes/reporte.png">
                                    </div>
                                    
                                    <div class="el-descripcion-reporte">
                                        <div class="el-nombre-rep font-bold"><p>#rep['tabla'].NOMBRE#</p></div>
                                        <div class="el-cont-desc-reporte small m-t-xs">
                                            <p>#rep['tabla'].DESCRIPCION#</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </cfloop>
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
     