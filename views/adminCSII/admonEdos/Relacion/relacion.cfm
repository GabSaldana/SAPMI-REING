<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="relacion_js.cfm">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Administración de estados</h2>
        <ol class="breadcrumb">
            <cfoutput>
                <li>
                    <a href="#event.buildLink('inicio')#">Inicio</a>
                </li>
                <li>
                    <a href="#event.buildLink('adminCSII/admonEdos/admonEdos')#">Control de estados</a>
                </li>
                <li>
                    <a href="#event.buildLink('adminCSII/admonEdos/admonEdos/setRutas')#?pkProcedimiento=<cfoutput>#prc.proced#</cfoutput>">Rutas</a>
                </li>
                <li class="active">
                    <strong>Relaciones</strong>
                </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    <div class="ibox float-e-margins">
        <div class="ibox-title guiaRelRegistradas">
            <h5>RELACIONES REGISTRADAS</h5>
            <input id="inRuta" type="hidden" value="<cfoutput>#prc.ruta#</cfoutput>">
            <input id="inProc" type="hidden" value="<cfoutput>#prc.proced#</cfoutput>">
            <div class="ibox-tools">
            </div>
        </div>
        <div class="ibox-content">
            <div id="tableRelacion"></div>
        </div>
    </div>
</div>

<div id="mdl-relacion" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Agregar relación</h4>
            </div>
            <div class="modal-body">
                <form id="nuevaRelacion" class="form-horizontal" role="form" onsubmit="return false;">
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-user"></span>
                            </span>
                            <select id="inRol" name="inRol" class="form-control guiaRelNewRol" onchange="consultarAcciones();">
                                <option value="" selected="selected">Seleccionar rol</option>
                                <cfset total_records = Request.rol.recordcount/>
                                <cfloop index="x" from="1" to="#total_records#">
                                    <cfoutput>
                                        <option value="#Request.rol.PK[x]#" >#Request.rol.NOMBRE[x]#</option>
                                    </cfoutput>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-cog"></span>
                            </span>
                            <select id="inAccion" name="inAccion" class="form-control guiaRelNewAccion">
                                <option value="" selected="selected">Seleccionar acción</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-arrow-down"></span>
                            </span>
                            <select id="inEdoAc" name="inEdoAc" class="form-control guiaRelNewEdoAct">
                                <option value="" selected="selected">Seleccionar estado actual</option>
                                <cfset total_records = Request.edo.recordcount/>
                                <cfloop index="x" from="1" to="#total_records#">
                                    <cfoutput><option value="#Request.edo.PK[x]#" >#Request.edo.NUM[x]# - #Request.edo.NOMBRE[x]#</option></cfoutput>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-arrow-right"></span>
                            </span>
                            <select id="inEdoSg" name="inEdoSg" class="form-control guiaRelNewEdoSig">
                                <option value="" selected="selected">Seleccionar estado siguiente</option>
                                <cfset total_records = Request.edo.recordcount/>
                                <cfloop index="x" from="1" to="#total_records#">
                                    <cfoutput><option value="#Request.edo.PK[x]#" >#Request.edo.NUM[x]# - #Request.edo.NOMBRE[x]#</option></cfoutput>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" onclick="limpiaModal();"><span class="fa fa-times"></span> Cancelar</button>
                <button type="button" class="btn btn-success btn-lg pull-right guiaRelBtnGuarda" onclick="addRelacion();">Guardar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade modaltext" id="mdl-confirma" tabindex="-1" role="dialog" aria-hidden="true" style="position: absolute; z-index: 9999 !important">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Eliminar relación</h4>
            </div>

            <input id="inPkRel" type="hidden" value="">
            <div class="modal-body"></div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> No</button>
                <button class="btn btn-success btn-lg pull-right" onclick="cambiarEstado();"><span class="fa fa-check"></span> Sí</button>           
            </div>
        </div>
    </div>
</div>


<div id="mdl-relOperacion" class="modal inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Relacionar operación</h4>
            </div>
            <div class="modal-body">
                <input id="inEdoAcc" type="hidden" value="">
                <input id="inRelOper" type="hidden" value="">
                <form id="accionOperacion" class="form-horizontal" role="form" onsubmit="return false;">
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-cog"></span>
                            </span>
                            <select id="inOpe" name="inOpe" class="form-control guiaRelONewOperacion">
                                <option value="" selected="selected">Seleccionar operacion</option>
                                <cfset total_records = Request.proced.recordcount/>
                                <cfloop index="x" from="1" to="#total_records#">
                                    <cfoutput>
                                        <option value="#Request.proced.PK[x]#" >#Request.proced.NOMBRE[x]#</option>
                                    </cfoutput>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-screenshot"></span>
                            </span>
                            <select id="inTipo" name="inTipo" class="form-control guiaRelONewTipoO">
                                <option value="" selected="selected">Seleccionar tipo de operación</option>
                                <cfset total_records = Request.tipoOper.recordcount/>
                                <cfloop index="x" from="1" to="#total_records#">
                                    <cfoutput><option value="#Request.tipoOper.PK[x]#" >#Request.tipoOper.NOMBRE[x]#</option></cfoutput>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                </form>
                <button type="button" class="btn btn-success btn-lg btn-block guiaRelOBtnGuarda" onclick="relacionaAccionOperacion();">Guardar relación</button>
                <br><br><br><br>

                <div id="tablaaccionOperacion"></div>
                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal" onclick="limpiaOper();"><span class="fa fa-times"></span> Cancelar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade modaltext" id="mdl-borra-oper" tabindex="-1" role="dialog" aria-hidden="true" data-keyboard="false" style="position: absolute; z-index: 9999 !important">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Eliminar operacion</h4>
            </div>

            <input id="inpkOper" type="hidden" value="">
            <div class="modal-body"></div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" onclick="cierraBorraOperacion();"><span class="fa fa-times"></span> No</button>
                <button class="btn btn-success btn-lg pull-right" onclick="cambiarEstadoOper();"><span class="fa fa-check"></span> Sí</button>           
            </div>
        </div>
    </div>
</div>


<!--- Guia --->
<ul id="tlyPageGuide" data-tourtitle="Relacion.">
   <!---  <li class="tlypageguide_top" data-tourtarget=".guiaRelRegistradas">
        <div> Relaciones de la Ruta <br>
            En esta sección se encuentran las relaciones registradas de la ruta seleccionada.
        </div>
    </li> --->
    <li class="tlypageguide_top" data-tourtarget=".guiaRelAgregarRelacion">
        <div> Agregar relación <br>
            Puede agregar una relación a la ruta.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".search">
        <div> Búsqueda <br>
            Puede realizar la búsqueda de una relación.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaRelEliminar">
        <div> Eliminar <br>
            Puede eliminar una relacion.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaRelAgregar">
        <div> Agregar <br>
            Puede agregar una operacion a la relacion.
        </div>
    </li>
    <!--- Agrega relacion --->
    <li class="tlypageguide_top" data-tourtarget=".guiaRelNewRol">
        <div> Seleccionar rol <br>
            Seleccione el rol correspondiente a la relación.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaRelNewAccion">
        <div> Seleccionar acción <br>
            Seleccione la acción correspondiente a la relación.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaRelNewEdoAct">
        <div> Seleccionar estado actual <br>
            Seleccione el estado actual correspondiente a la relación.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaRelNewEdoSig">
        <div> Seleccionar estado siguiente <br>
            Seleccione estado siguiente correspondiente a la relación.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaRelBtnGuarda">
        <div> Guardar relación<br>
            Guarda la información capturada de la relación.
        </div>
    </li>      
    <!--- Relacionar operacion --->
    <li class="tlypageguide_top" data-tourtarget=".guiaRelONewOperacion">
        <div> Seleccionar operación <br>
            Seleccione la operación a relacionar.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaRelONewTipoO">
        <div> Seleccionar tipo de operación <br>
            Seleccione el tipo de operación a relacionar.
        </div>
    </li>
    <li class="tlypageguide_top" data-tourtarget=".guiaRelOBtnGuarda">
        <div> Guardar relación<br>
            Guarda la información capturada de la relación.
        </div>
    </li>     
</ul>