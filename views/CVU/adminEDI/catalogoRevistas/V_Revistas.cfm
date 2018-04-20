<!-----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Administracion de catalogo de revistas
* Sub modulo:  -
* Fecha:       13 de diciembre de 2017
* Descripcion: Vista con la informacion de las revistas con la creacion de nuevas y su edicion
* Autor:       JLGC    
* ================================
----->
<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="V_Revistas_js.cfm">

<input type="hidden" id="hfPkRevista" value="0">
<input type="hidden" id="hfPkNivel" value="0">

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-10">
        <h2>Revistas</h2>
        <ol class="breadcrumb">
            <cfoutput>
            <li>
                <a href="#event.buildLink('inicio')#">Inicio</a>
            </li>
            <li class="active">
                <strong>Administración de revistas</strong>
            </li>
            </cfoutput>
        </ol>
    </div>
</div>

<div class="wrapper wrapper-content animated fadeIn">
    
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5>Revistas</h5>
            <div class="ibox-tools">
            </div>
        </div>
        <div class="ibox-content">
            <div class="lft-btn text-left">
                <button type="button" class="btn btn-primary btn-outline dim btn-crear" data-toggle="modal" href="#mdl-admon-revista"><span class="fa fa-leanpub"></span> Agregar nueva revista</button>
            </div>            
        </div>
        <div class="ibox-content">
            <div class="col-md-3" style="margin-top: -8px;">
                <strong>País:</strong>
                <select id="ddlPais" name="ddlPais" class="form-control selectpicker" data-live-search="true">
                    <cfoutput query="prc.Paises">
                        <option value="#PAIS#"><!--- #TOTPAIS#.  --->#PAIS#</option>
                    </cfoutput>
                </select>
            </div>
            <div class="col-md-3" style="margin-top: -8px;">
                <strong>Editorial:</strong>
                <select id="ddlEditorial" name="ddlEditorial" class="form-control selectpicker" data-live-search="true">
                    <cfoutput query="prc.Editoriales">
                        <option value="#EDITORIAL#"><!--- #TOTEDITORIAL#.  --->#EDITORIAL#</option>
                    </cfoutput>
                </select>
            </div>
            <div id="contenidoTablaRevistas" style="padding: 0px 15px 15px 15px;"></div>
        </div>
    </div>

</div>

<div id="mdl-admon-revista" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" style="z-index: 9999 !important;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <form id="formRevista" class="form-horizontal" role="form" onsubmit="return false;">
                    <div>
                        <label class="control-label">ISSN: </label>
                        <div class="input-group">          
                            <span class="input-group-addon">
                                <span class="fa fa-hashtag"></span>
                            </span>                  
                            <input type="text" id="inISSN" name="inISSN" class="form-control" placeholder="Ingresar el ISSN" />
                        </div>                    
                    </div>
                    <div>
                        <label class="control-label">Nombre: </label>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="fa fa-wikipedia-w"></span>
                            </span>  
                            <input type="text" id="inNombre" name="inNombre" class="form-control" placeholder="Ingresar el nombre" />
                        </div>                    
                    </div>
                    <div>
                        <label class="control-label">Editorial: </label>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="fa fa-book"></span>
                            </span>  
                            <input type="text" id="inEditorial" name="inEditorial" class="form-control" placeholder="Ingresar la editorial" />
                        </div>                    
                    </div>
                    <div>
                        <label class="control-label">Pais: </label>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="fa fa-map-marker"></span>
                            </span>  
                            <select id="ddlInPais" name="ddlInPais" class="form-control">
                                <cfoutput query="prc.Paises">
                                    <option value="#PAIS#">#PAIS#</option>
                                </cfoutput>
                            </select>
                        </div>                    
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cancelar</button>
                <button type="button" class="btn btn-success btn-lg pull-right" id="btn-admon-revista" onclick="guardaRevista();"></button>
            </div>
        </div>
    </div>
</div>

<div id="mdl-niveles" class="modal inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="limpiaModal();">×</button>
                <h4 class="modal-title">Niveles</h4>
            </div>
            <div class="modal-body">
                <input id="inProced" type="hidden">

                <form id="formNivel" class="form-horizontal" role="form" onsubmit="return false;">
                    <div class="form-group">
                        <div class="form-group">                    
                            <label class="control-label col-sm-2">Año</label>
                            <div class="col-sm-10">                    
                                <select id="ddlInAnio" name="ddlInAnio" class="form-control">
                                    <cfoutput query="prc.Anios">
                                        <option value="#ANIO#">#ANIO#</option>
                                    </cfoutput>
                                </select>
                            </div>                    
                        </div>
                        <div class="form-group">                    
                            <label class="control-label col-sm-2">Nivel:</label>
                            <div class="col-sm-10">                     
                                <cfoutput>    
                                    <cfset aNiveles = ['A|11', 'B|3', 'C|4', 'D|5', 'E|111', 'F|112', 'G|113'] />
                                    <select id="ddlInNivel" name="ddlInNivel" class="form-control">
                                        <option value="0">Seleccione nivel...</option>
                                        <cfloop from="1" to="#arrayLen(aNiveles)#" index="Y">
                                            <option value="#mid(aNiveles[Y], 3, 3)#">#mid(aNiveles[Y], 1, 1)#</option>
                                        </cfloop>
                                    </select>
                                </cfoutput>
                            </div>                    
                        </div>
                    </div>
                </form>
                <button type="button" class="btn btn-success btn-lg btn-block" id="btn-admon-niveles" onclick="guardaNivel();">Guardar nivel</button>
                <br><br>

                <div id="contenidoTablaNivel"></div>
                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal" onclick="limpiaModal();"><span class="fa fa-times"></span> Cancelar</button>
            </div>
        </div>
    </div>
</div>