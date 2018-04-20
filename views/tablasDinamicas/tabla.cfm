<!---
* =========================================================================
* IPN - CSII
* Sistema: SII
* Modulo: Tabla Copiada
* Sub modulo: Administración de Tablas
* Fecha : 27 de Marzo de 2017
* Autores: Alejandro Rosales 
           Jonathan Martinez
* Descripcion: Vista para la Tabla Copiada.
* =========================================================================
--->
 <cfprocessingdirective pageEncoding="utf-8"> 
 <cfoutput>
     <div class="col-md-3 animated fadeInDown" >
         <div class="ibox" data-tab-id="#prc.tabla['tabla'].IDTAB#">
             <div class="ibox-content el-contenido">
                 <div class="el-vista-previa-rep">
                     <img src="/includes/img/tablasDinamicas/tabla.png">   
                 </div>
                 <span class="el-eliminar">
                     <i class="glyphicon glyphicon-remove"></i>
                 </span>
                 <span class="el-publicar">
                     <i class="glyphicon glyphicon-share"></i>
                 </span>
                 <span class="el-copiar-rep">
                     <i class="fa fa-copy"></i>
                 </span>
                 <span>
                     <br>
                 </span>
                 <div class="el-descripcion">          
                     <div  class="el-nombre">
                         #prc.tabla['tabla'].NOMBRE#
                     </div>
                     <div class="el-cont-desc small m-t-xs">
                         #prc.tabla['tabla'].DESCRIPCION#
                     </div>
                     <div class="m-t text-right"> 
                         <a class="btn btn-md btn-outline btn-primary" href="#event.buildLink('tablasDinamicas.administradorTablas.explorarTabla.idTab.#prc.tabla['tabla'].IDTAB#.idCon.#prc.conjunto.getId()#')#">Explorar
                         </a>        
                         <a class="btn btn-md btn-outline btn-primary" href="#event.buildLink('tablasDinamicas.administradorTablas.editarTabla.idTab.#prc.tabla['tabla'].IDTAB#.idCon.#prc.conjunto.getId()#')#">Editar
                         </a>
                    </div>
                </div>
            </div>
        </div>
    </div>   
</cfoutput>                