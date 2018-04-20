<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="procedimientos_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Administración de estados</h2>
        <ol class="breadcrumb">
            <cfoutput>
            <li>
                <a href="#event.buildLink('inicio')#">Inicio</a>
            </li>
            <li class="active">
                <strong>Control de estados</strong>
            </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    
    <div class="ibox float-e-margins">
        <div class="ibox-title guiaProRegistrados">
            <h5>PROCEDIMIENTOS REGISTRADOS</h5>
            <div class="ibox-tools">
            </div>
        </div>
        <div class="ibox-content">
            <div id="procedimientos"></div>
        </div>
    </div>

</div>

<div id="mdl-operaciones" class="modal inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="limpiaModal();">×</button>
                <h4 class="modal-title">Operaciones</h4>
            </div>
            <div class="modal-body">
                <input id="inProced" type="hidden">
                <form id="nuevaOperacion" class="form-horizontal" role="form" onsubmit="return false;">
                    <div class="form-group">
                        <div class="form-group">                    
                            <label class="control-label col-sm-2">Nombre</label>
                            <div class="col-sm-10">                    
                                <input id="inOperacion" name="inOperacion" type="text" class="form-control guiaProNewNombre"/>
                            </div>                    
                        </div>
                        <div class="form-group">                    
                            <label class="control-label col-sm-2">Descripción:</label>
                            <div class="col-sm-10">                     
                                <input class="form-control guiaProNewDesc" id="inDescripcion" name="inDescripcion" rows="3"></input>
                            </div>                    
                        </div>
                    </div>
                </form>
                <button type="button" class="btn btn-success btn-lg btn-block guiaProNewBtnGuarda" onclick="addOperacion();">Guardar operación</button>
                <br><br><br><br>

                <div id="tablaOpe"></div>
                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg guiaProNewBtnCancela" data-dismiss="modal" onclick="limpiaModal();"><span class="fa fa-times"></span> Cancelar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade modaltext" id="mdl-confirma" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="position: absolute; z-index: 9999 !important">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="limpiaOpacidadModal();">×</button>
                <h4 class="modal-title">Eliminar operación</h4>
            </div>

            <input id="inPkOper" type="hidden" value="">
            <div class="modal-body"></div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" onclick="limpiaOpacidadModal();"><span class="fa fa-times"></span> No</button>
                <button class="btn btn-success btn-lg pull-right" onclick="cambiarEstadoOperacion();"><span class="fa fa-check"></span> Sí</button>           
            </div>
        </div>
    </div>
</div>

<!--- Guia --->
<ul id="tlyPageGuide" data-tourtitle="Procedimientos.">
    <!--- <li class="tlypageguide_top" data-tourtarget=".guiaProRegistrados">
        <div> Procedimientos <br>
            En esta sección se encuentran los procedimientos registrados.
        </div>
    </li> --->
    <li class="tlypageguide_top" data-tourtarget=".search">
        <div> Búsqueda <br>
            Puede realizar la búsqueda de un procedimiento.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaProRutas">
        <div> Rutas <br>
            Puede ir al detalle de la ruta para que consulte: Estados Relaciones y Flujo.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaProOperacion">
        <div> Operaciones <br>
            Agrega una nueva operación al procedimiento seleccionado.
        </div>
    </li>
    <!--- Agrega operacion --->
    <li class="tlypageguide_top" data-tourtarget=".guiaProNewNombre">
        <div> Nombre <br>
            Escriba el nombre correspondiente a la operación.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaProNewDesc">
        <div> Descripción <br>
            Escriba la descripción correspondiente a la operación.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaProNewBtnGuarda">
        <div> Guardar operacion<br>
            Guarda la información capturada de la operación.
        </div>
    </li>      
    <li class="tlypageguide_top" data-tourtarget=".guiaProNewElimina">
         <div> Eliminar <br>
            Puede eliminar la operación.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaProNewBtnCancela">
        <div> Cancelar operacion<br>
            Cancela la captura de la operacion.
        </div>
    </li> 
    
</ul>

