<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="acumulados_js.cfm">

<br>
<div class="ibox float-e-margins">
    <div class="ibox-title">
        <h5 class="selecciona-tema">Busqueda por año</h5>
    </div>
	<div class="ibox-content">
		<form role="form" id="form-accion" class="form-horizontal">
			<div class="form-group">
                <label class="control-label col-sm-2">Año:</label>
				<div class="col-sm-8">
	             	<select class="form-control m-b" data-style="btn-primary btn-outline" id="anio" onchange="obtenerFormatos();"> 
	             		<option selected disabled>Elije un año</option>
	                    <cfset total_records = prc.Anios.recordcount>
	                    <cfloop index="x" from="#total_records#" to="1" step="-1">
	                        <cfoutput><option value="#prc.Anios.ANIO[x]#">#prc.Anios.ANIO[x]#</option></cfoutput>
                    	</cfloop>
	              	</select>
				</div>
			</div>
		</form>
	</div>
</div>


<div id="box-formatosRegistrados">
    <div class="ibox float-e-margins">
        <div id="tituloFormatos" class="ibox-title">
            <h5>Reportes acumulados</h5>
        </div>

        <div class="ibox-content">
        	<input type="hidden" id="in-pkFormato" value="0"> 
			<input type="hidden" id="in-pkPeriodo" value="0">

            <div id="tablaFormatos"></div>
        </div>
    </div>
</div>



<div id="mdl-nuevoPeriodo" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" onclick="reiniciaAniosSelect();" aria-hidden="true">×</button>
                <h4 class="modal-title">Nuevo periodo</h4>
            </div>
            <div class="modal-body">
	            <form role="form" id="form-accion" class="form-inline">
					<div class="form-group">
		            	<label class="control-label">Año del nuevo periodo:</label>
		            	<select class="form-control" id="anioPeriodo" name="anioPeriodo"></select>
		            </div>
			    </form>
			</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal" onclick="reiniciaAniosSelect();"><span class="fa fa-times"></span> Cancelar</button>
                <button class="btn btn-success btn-lg pull-right" onclick="agregarPeriodo();"><span class="fa fa-check"></span> Crear</button>
            </div>
        </div>
    </div>
</div>

<div id="pnl-Formato" style="display:none">
	<div class="panel panel-success">
		<div class="panel-heading">
			Formato: <strong><span id="displayNombre"></span></strong>
			<i id="btn-cerrarTablaFormato" class="btn btn-success btn-xs pull-right" onclick="cerrarTablaFormato()" title="Cerrar Formato" style="font-size: 20px;"><i class="fa fa-times"></i> </i><br><br>
        </div>
		<div class="panel-body">
			<div id="divInfoGral"></div>
			<div id="tablaFormatoVista" style="overflow-x:auto;"></div>
		</div>
	</div>
</div>

