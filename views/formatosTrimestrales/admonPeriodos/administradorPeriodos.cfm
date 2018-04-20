<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="administradorPeriodos_js.cfm">

<br>
<div class="ibox float-e-margins">
    <div class="ibox-title">
        <h5 class="selecciona-tema">Busqueda por periodos</h5>
    </div>
	<div class="ibox-content">
		<form role="form" id="form-accion" class="form-horizontal">
			<div class="form-group">
                <label class="control-label col-sm-2">Periodo:</label>
				<div class="col-sm-8" id="PeriodosSelect">
	             	<select class="form-control m-b selectpicker" data-live-search="true" data-style="btn-primary btn-outline" id="Periodos" name="Periodos"> 
	             		<option selected disabled>Seleccione un periodo</option>
	                    <cfset total_records = prc.Periodos.recordcount>
	                    <cfloop index="x" from="#total_records#" to="1" step="-1">
	                        <cfoutput><option value="#prc.periodos.pk[x]#">#prc.Periodos.NOMBRE[x]#</option></cfoutput>
                    	</cfloop>
	              	</select>
				</div>
				<button id="btn-nuevoPeriodo" type="button" class="btn btn-primary" data-tooltip="tooltip" title="Nuevo periodo" data-toggle="modal" data-target="#mdl-nuevoPeriodo" onclick="obtenerAnios();"><i class="fa fa-plus"></i></button>
			</div>
		</form>
	</div>
</div>


<div id="box-formatosRegistrados">
    <div class="ibox float-e-margins">
        <div id="tituloFormatos" class="ibox-title">
            <h5>Formatos Registrados</h5>
        </div>

        <div class="ibox-content">
        	<input type="hidden" id="in-pkFormato" value="0"> 
			<input type="hidden" id="in-pkPeriodo" value="0">
			<button id="btn-ValidarAll" class="btn btn-primary pull-left btn-outline dim" style="display:none" onclick="crearReportesSeleccionados();"><span class="fa fa-check-square-o"></span> Crear los formatos seleccionados de la página actual</button>
			
			<div>
				<a id="lanzaMsj" class="fa fa-info-circle fa-3x" style="float:left"></a>
				<div id="mensaje" class="alert alert-info row col-md-4" style="margin-left:1%">
					<strong>Info!</strong><br>
					Seleccione el siguiente botón <i class="fa fa-square-o" aria-hidden="true"></i> ubicado en la cabecera de la tabla para seleccionar todos los formatos, o solo los formatos que usted quiera y pulse el botón de la izquierda para crear el formato.
				</div>
			</div>

            <div id="tablaFormatos">Seleccione un periodo para ver los formatos registrados</div>
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
			<i id="btn-cerrarTablaFormato" class="btn btn-success btn-xs pull-right" onclick="cerrarTablaFormato();" title="Cerrar Formato" style="font-size:22px;"><span class="fa fa-times"> </span></i>
			<br>
			Trimestre: <strong><span id="displayTrimestre"></span></strong>
        </div>
		<div class="panel-body">
			<div id="divInfoGral"></div>
			<div id="tablaFormatoVista" style="overflow-x:auto;"></div>
		</div>
	</div>
</div>

<!--- ********************************************************* Guia ********************************************************* --->
<ul id="tlyPageGuide" data-tourtitle="Administración de formatos."> 
	<!--- ---------------(Tabla principal Periodos) --->
	<li class="tlypageguide_top" data-tourtarget=".PeriodosSelect">
		<div>Periodo<br>
		Seleccione un trimestre para visualizar el estado de los reportes asignados al trimestre. Se desplegará a continuación, una tabla con los reportes pertenecientes al trimestre seleccionado así como aquellos disponibles para su asignación.<br>Nota:<br>La disposición de reportes en el módulo “Administración de períodos de captura” está ligada a la aprobación por parte de la Dirección de Evaluación de  los reportes y sus correspondientes periodos de captura, si un reporte no figura durante la búsqueda  de un periodo a pesar de estar registrado en el módulo “Captura de formatos” es probable que el formato no cuente con la aprobación de la dirección de Evaluación o no haya sido asignado al periodo al que se pretende acceder.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget="#btn-nuevoPeriodo">
		<div>Agregar nuevos períodos<br>
		Al seleccionar el botón <i class="fa fa-plus"></i> se desplegará una ventana para solicitar la apertura de un nuevo año de registro de reportes en el sistema.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget="#btn-ValidarAll">
		<div>Validar múltiples formatos<br>
		Seleccione el siguiente botón para crear aquellos formatos marcados <i class="fa fa-check-square-o"></i> en la cabecera de la tabla, puede seleccionar dentro de la tabla uno, o múltiples formatos para su creación.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".search">
		<div>Buscar<br>
		En la tabla puede realizar una búsqueda por datos específicos.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaHistorial">
		<div>Estado<br>
		Número que representa el estado en que se encuentra el reporte, al dar click en el "Estado" de un reporte se mostrará el historial de estado el cual ofrece una explicación detallada de los estados por los que ha pasado el reporte.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaComentarios">
		<div>Comentarios<br>
		Al seleccionar el botón <i class="fa fa-server"></i> se mostrará el listado de comentarios realizados al reporte a lo largo de su captura y validación.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".validarformato">
		<div>Crear formatos<br>
		Los formatos no creados tienen un botón amarillo con el que pueden ser creados.<br>
		Nota:<br>
		Posterior a la creación del reporte el icono correspondiente cambiará y el formato podrá ser capturado.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".vistaformato">
		<div>Vista previa<br>
		Los formatos creados cuentan con un botón azul para poder ver la vista previa del formato.</div>
	</li>

	<!--- ---------------(Panel vista previa de reporte Formato Azul)............... --->
	<li class="tlypageguide_right" data-tourtarget="#guiaVerDatos">
		<div>Ver datos del formato<br>
		Active o desactive la vista de las filas de datos del formato.</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget="#guiaVerTotal">
		<div>Ver totales del formato<br>
		Active o desactive la vista de la última fila del total del formato.</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget="#guiaVerSubSecciones">
		<div>Ver subsecciones del formato<br>
		Active o desactive la vista de las filas de subsecciones del formato.</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget="#guiaVerSubTotales">
		<div>Ver subtotales del formato<br>
		Active o desactive la vista de las filas de subtotales del formato.</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget="#btn-notaTecnica">
		<div>Nota técnica<br>
		Este botón permite adjuntar una "Nota técnica" al registro del reporte para el trimestre seleccionado. La "Nota técnica" podrá ser vista por los usuarios que visualicen el reporte.</div>
	</li>
	
</ul>