<!-----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Administracion de registro de solicitudes al comite
* Fecha:       28 de diciembre de 2017
* Descripcion: Vista con la informacion de todos los registros
* Autor:       JLGC    
* ================================
----->
<cfprocessingdirective pageEncoding="utf-8">
<link  href="/includes/css/fileinput.css" media="all" rel="stylesheet" type="text/css">
<cfinclude template="V_Comite_js.cfm">
<style type="text/css">
    .content {
        height: 25vh !important;
    }
</style>
<input type="hidden" id="hfPkComite" value="0">

<div class="wrapper wrapper-content animated fadeIn">
    <form id="formComite" class="form-horizontal" role="form" onsubmit="return false;">
        <h3>Solicitud al comite</h3>
        <section>
            <div class="form-group">                    
                <label class="control-label col-sm-2">Tipo</label>
                <div class="col-sm-9">                    
                    <select id="ddlTipo" name="ddlTipo" class="form-control" style="text-transform: none;">
                        <option value="0">Seleccione tipo...</option>
                        <cfoutput query="prc.tipoSolicitud">
                            <option value="#PK#">#NOMBRE#</option>
                        </cfoutput>
                    </select>
                </div>                    
            </div>
            <div class="form-group">                    
                <label class="control-label col-sm-2">Solicitud:</label>
                <div class="col-sm-9">     
                    <textarea id="inDescripcion" name="inDescripcion" class="form-control required" style="text-transform: none;" placeholder="Ingresar la descripción de la solicitud"></textarea>
                </div>                    
            </div>
        </section>
     
        <h3>Documento de la solicitud</h3>
        <section>
            <div class="form-group">                    
                <label class="control-label col-sm-2">Documento:</label>
                <div class="col-sm-9">     
                    <div id="docComiteNuevo"></div>
                </div>                    
            </div>
        </section>
    </form>
    <br>
    <div id="contenidoTablaComite"></div>
</div>

<div id="mdl-admon-comite" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false" style="z-index: 9999">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" onclick="limpiaFormulario();" aria-hidden="true">×</button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <form id="formComiteEdit" class="form-horizontal" role="form" onsubmit="return false;">
                    <div>
                        <label class="control-label">Tipo: </label>
                        <div class="input-group">          
                            <span class="input-group-addon">
                                <span class="fa fa-tasks"></span>
                            </span>                  
                            <select id="ddlTipoEdi" name="ddlTipoEdi" class="form-control" style="text-transform: none;">
                                <option value="0">Seleccione tipo...</option>
                                <cfoutput query="prc.tipoSolicitud">
                                    <option value="#PK#">#NOMBRE#</option>
                                </cfoutput>
                            </select>
                        </div>                    
                    </div>
                    <div>
                        <label class="control-label">Solicitud: </label>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="fa fa-file-text-o"></span>
                            </span>  
                            <textarea id="inDescripcionEdi" name="inDescripcionEdi" class="form-control" style="text-transform: none;" placeholder="Ingresar la descripción de la solicitud"></textarea>
                        </div>                    
                    </div>
                    <div>
                        <label class="control-label">Documento: </label>
                        <div class="input-group">
                            <div id="docComite"></div>
                        </div>                    
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal" onclick="limpiaFormulario();"><span class="fa fa-times"></span> Cancelar</button>
                <button type="button" class="btn btn-success btn-lg pull-right" id="btn-admon-comiteEdi" onclick="editarComiteModal();"></button>
            </div>
        </div>
    </div>
</div>
