<cfprocessingdirective pageEncoding="utf-8">
 <cfinclude template="asignacionInvestigadores_js.cfm"> 
<div class="row wrapper border-bottom white-bg page-heading">
    <div class="ibox float-e-margins">
        <div class="ibox-content">
            <label for="selecEvaluador">Selecciona a un evaluador:</label>
            <select class="selectpicker" data-width="100%" data-live-search="true" data-style="btn-success btn-outline" name="selecEvaluador" id="selecEvaluador">
                  <cfoutput query="prc.evaluadores">
                      <option value="#PKEVALUADOR#" data-sip="#EVALSIP#" data-ca="#EVALCA#" data-ce="#EVALCE#" data-ri="#EVALRI#">#NOMBRE# #PATERNO# #MATERNO# - #DEPENDENCIA#</option>
                  </cfoutput>
            </select>
            <div id="listaInvestigadores"></div>
        </div>
    </div>
</div>
<div id="mdl-correo" class="modal inmodal fade modaltext" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                <h4 class="modal-title">Notificación por correo electrónico a evaluadores</h4>
            </div>
            <div class="modal-body">
                <div id="MensajeCorreo"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cancelar</button>
                <button type="button" class="btn btn-success btn-lg pull-right" id="btn-enviarCorreo"><span class="fa fa-check"></span> Enviar Notificación</button>
            </div>
        </div>
    </div>
</div>