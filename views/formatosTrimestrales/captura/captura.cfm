<!---
* =========================================================================
* IPN - CSII
* Sistema:	EVALUACION
* Modulo:	Edicion de Plantillas para los Formatos Trimestrales  con Columna de Tipo Catalago
* Fecha:
* Descripcion:
* Autor:
* =========================================================================
--->

<cfprocessingdirective pageEncoding="utf-8">
 <div class="container" >
	<div class="row">
		<div class="ibox" id="divSeleccion">
	        <div class="ibox-title">
	            <h5 class="selecciona-tema">Filtros de Busqueda</h5>
	        </div>

			<div class="ibox-content">
				<form role="form" id="form-accion" class="form-horizontal">
					<div class="form-group">
	                    <label class="control-label col-sm-2 " for="">Periodo:</label>
						<div class="col-sm-10">
			             	<select class="form-control m-b selectpicker show-tick filtrarPeriodo" multiple title="TODOS" data-live-search="true" data-style="btn-primary btn-outline" id="sel-Periodos" name="Periodos" multiple>
			             		<cfset total_records = prc.Periodos.recordcount>
			                    <cfloop index="x" from="1" to="#total_records#">
			                        <cfoutput>
				                        <option value="#prc.periodos.pk[x]#" data-content="<span class='label label-primary'>#prc.Periodos.nombre[x]#</span>">
					                        #prc.Periodos.nombre[x]#
										</option>
									</cfoutput>
		                    	</cfloop>
			              	</select>
						</div>
					</div>
					<div class="form-group">
	                    <label class="control-label col-sm-2"  for="">Formato:</label>
						<div class="col-sm-10">
			             	<select class="form-control m-b selectpicker show-tick filtrarFormato"  id="sel-formatos"  data-live-search="true" data-style="btn-primary btn-outline" name="formatos">
			             		<cfset total_records = prc.formatos.recordcount>
			             		<option value="0" Selected="selected">TODOS</option>
			                    <cfloop index="x" from="1" to="#total_records#">
			                        <cfoutput>
				                        <option value="#prc.formatos.pk[x]#" <!---  data-content="<span class='label label-default'>#prc.formatos.nombre[x]#</span>" --->>
					                        #prc.formatos.nombre[x]#
										</option>
									</cfoutput>
		                    	</cfloop>
			              	</select>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>


<div id="admonFormatos">
</div>



<div id="mdl-addComentario" class="modal small inmodal fade modaltext" tabindex="-1" role="dialog"  aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="mail-box-header">
                <h2>Motivo del rechazo</h2>
            </div>
            <div class="mail-body">
                <input id="inRegistro" type="hidden" value="">
                <input id="inAccion"   type="hidden" value="">
                <input id="edoDesti"   type="hidden" value="">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>Destinatarios</h5>
                                <div class="ibox-tools">
                                    <a data-toggle="collapse" data-target=".collapse">
                                        <i class="fa fa-chevron-down"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content collapse">
                                <div class="wrapper destinatarios"> </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="space-25"></div>
                <div class="space-25"></div>

                <div class="form-group"><label class="col-sm-1 control-label pull-left"><h4>Asunto:</h4></label>
                    <div class="col-sm-10"><input id="inAsunto" type="text" class="form-control" value=""></div>
                </div><br><br><br>
                <div id="check" class="checkbox">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="checkbox" data-toggle="toggle" data-on="<i class='fa fa-exclamation'></i> Prioritario" data-off="No" data-width="115" data-onstyle="danger" checked>
                </div>
            </div>

            <textarea id="inComent" name="inComent" rows="15" cols="80" style="width: 80%"> </textarea>

            <div class="mail-body text-right tooltip-demo">
                <button type="button" class="btn btn-success btn-lg ml5" onclick="registrarComentario();">Guardar comentario</button>
            </div>
        </div>
    </div>
</div>

<!--- ********************************************************* Guia ********************************************************* --->
<ul id="tlyPageGuide" data-tourtitle="Captura de información">

	<!--- --------------(Ventana principal "Captura de información")-------------- ----------------------------->
	<li class="tlypageguide_top" data-tourtarget="#divSeleccion">
		<div>Filtros de Búsqueda<br>		
		Para realizar la captura de información trimestral es necesario seleccionar a través de los filtros de búsqueda del módulo, el reporte o reportes que se pretenden capturar. Una vez que se han ingresado los parámetros de búsqueda, los resultados se mostrarán en forma de tabla en el apartado “Reportes trimestrales”.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".filtrarPeriodo">
		<div>Filtros de periodos<br>
		Cree una búsqueda de formatos seleccionando un periodo o periodos.Dentro de esta opción es posible seleccionar múltiples trimestres como parametros de busqueda.</div>
	</li>
	<li class="tlypageguide_bottom" data-tourtarget=".filtrarFormato">
		<div>Filtros por formatos<br>
		Cree una búsqueda de formatos seleccionando el nombre del formato de reporte. Adicional al listado de formatos que muestra esta opción, es posible escribir el nombre del formato que se desea buscar, la opción mostrará a continuación, aquellas opciones que coincidan con el título ingresado.</div>
	</li>	 
	<li class="tlypageguide_top" data-tourtarget="#admonFormatos">
		<div>Reportes trimestrales<br>
		Una vez que se han establecido los parámetros de búsqueda de reportes, el apartado “Reportes trimestrales” mostrará los resultados de la búsqueda a través de una tabla.
		<br>Nota: <br>
		 La captura de reportes en el módulo “Captura de información trimestral” requiere la aprobación por parte de la Dirección de Evaluación de los reportes y sus correspondientes periodos de captura, si un reporte no figura durante la búsqueda dentro del módulo, es probable que el reporte no cuente con la aprobación de la Dirección de Evaluación o no haya sido asignado al periodo al que se pretende acceder.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".search">
		<div>Buscar formatos<br>
		Realice una búsqueda de formatos por datos específicos.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaHistorial">
		<div>Estado<br>
		Número que representa el estado en que se encuentra el reporte, al dar click en el "Estado" de un reporte se mostrará el historial de estado el cual ofrece una explicación detallada de los estados por los que ha pasado el reporte.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaCapturar">
		<div>Captura o editar formato<br>
		Al oprimir este botón se desplegará un panel para capturar o editar la información del reporte seleccionado.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaConsultar">
		<div>Consultar de formato<br>
		Una vez que el formato ya ha sido capturado puede consultar el mismo en un panel emergente.</div>
	</li>
	
	<li class="tlypageguide_top" data-tourtarget=".guiaRechazar">
		<div>Rechazar formato<br>
		El formato puede ser rechazado, se envía una notificación a quien realizó la petición de validar el formato y da la opción de agregar un comentario con motivos de la acción.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaComentarios">
		<div>Comentarios<br>
		Al seleccionar el botón <i class="fa fa-server"></i> se mostrará el listado de comentarios realizados al reporte a lo largo de su captura y validación.</div>
	</li>
	<!--- --------------(Panel vista previa de reporte Formato Azul)-------------------- -------------------------- --->

	<li class="tlypageguide_bottom" data-tourtarget="#guiaVerDatos">
		<div>Ver datos del formato<br>
		Active o desactive la vista de las filas de datos del formato.</div>
	</li>
	<li class="tlypageguide_bottom" data-tourtarget="#guiaVerSubSecciones">
		<div>Ver subsecciones del formato<br>
		Active o desactive la vista de las filas de subsecciones del formato.</div>
	</li>
	<li class="tlypageguide_bottom" data-tourtarget="#guiaVerSubTotales">
		<div>Ver subtotales del formato<br>
		Active o desactive la vista de las filas de subtotales del formato.</div>
	</li>
	<li class="tlypageguide_bottom" data-tourtarget="#guiaVerTotal">
		<div>Ver totales del formato<br>
		Active o desactive la vista de la última fila del total del formato.</div>
	</li>
	
	<li class="tlypageguide_top" data-tourtarget="#guiaEliminar">
		<div>Eliminar<br>
		Elimine un formato.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget="#btn-notaTecnica">
		<div>Nota Técnica<br>
		Este botón permite adjuntar una "Nota técnica" al registro del reporte para el trimestre seleccionado.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget="#btn-crearFila">
		<div>Agregar fila<br>
		Puede añadir más filas al formato para capturar.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget="#btn-eliminarFilas">
		<div>Eliminar fila<br>
		Habilita o deshabilita la opción de eliminar filas del formato.</div>
	</li>
	<li class="tlypageguide_left" data-tourtarget="#editarFila">
		<div>Editar fila con formulario<br>
		Puede capturar o editar la información de la fila en un formulario.</div>
	</li>	
	<li class="tlypageguide_left" data-tourtarget="#btn-guardarDatos">
		<div>Guardar información<br>
		Guarda la información capturada de la fila del formato que se está editando.</div>
	</li>

	<!--- -------------------(Panel vista previa de reporte Formato Verde)............... ---> 

	<li class="tlypageguide_top" data-tourtarget="#guardarInfo">
		<div>Guardar Información<br>
		Al seleccionar el botón <i class="glyphicon glyphicon-floppy-disk"></i> se guardarán las modificaciones efectuadas al reporte. </div>
	</li>	
	<li class="tlypageguide_top" data-tourtarget="#notaTecnica">
		<div>Nota técnica<br>
		Este botón permite adjuntar una "Nota técnica" al registro del reporte para el trimestre seleccionado.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget="#anadirFila">
		<div>Añadir fila<br>
		Al seleccionar el botón <i class="glyphicon glyphicon-plus-sign"></i> se agregará una nueva fila al reporte en la parte inferior.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget="#eliminarFila">
		<div>Eliminar fila<br>
		Al seleccionar el botón <i class="glyphicon glyphicon-minus-sign"></i> se eliminará la fila inferior del reporte, para realizar la eliminación de múltiples filas es necesario seleccionar el conjunto de filas antes de seleccionar la opción.</div>
	</li>	
	<li class="tlypageguide_top" data-tourtarget="#comprobarSumas">
		<div>Comprobar sumas<br>
		Al seleccionar el botón <i class="fa fa-refresh"></i> se ejecutará una comprobación rápida de las operaciones del formato.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaValidar">
		<div>Validar reporte<br>
		Al seleccionar el botón <i class="fa fa-thumbs-o-up fa-2x"></i> se validará el formato y una notificación será enviada al responsable.Resulta evidente, pero necesario aclarar que la validación  de un reporte debe realizarse posterior a la captura de información del mismo.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaRechazar">
		<div>Rechazar reporte<br>
		Al seleccionar el botón <i class="fa fa-thumbs-o-down fa-2x"></i> el formato será rechazado y una notificación será enviada al usuario que realizó la petición de validar el formato, de manera opcional se desplegará la ventana de comentarios para agregar un comentario con el motivo del rechazo.</div>
	</li>
	<li class="tlypageguide_top" data-tourtarget=".guiaEliminar">
		<div>Eliminar reporte<br>
		Al seleccionar el botón <i class="fa fa-trash fa-2x"></i> el formato será eliminado.</div>
	</li>
	
</ul>


<script  type="text/javascript">

function getFormatos(){
	/*$('#tablaF').attr('src','capturaFT/getTabla?'+'periodo='+ $('#in-Periodos').val()+'&formato='+$('#in-formatos').val());  */
	if(($('#sel-Periodos').val()) == ''){							//A.B.J.M.
		$.post('capturaFT/getAdmonFormatos', {			
			periodo: '', 						
			formato: $('#sel-formatos').val()
		},
		function(data){
			$('#admonFormatos').html( data );		
    	}
    );
   	} else{
		$.post('capturaFT/getAdmonFormatos', {
			periodo: JSON.stringify($('#sel-Periodos').val()),
			formato: $('#sel-formatos').val()
			},
			function(data){
				$('#admonFormatos').html( data );
    		}
    	);
	}															//A.B.J.M.
}

$(document).ready(function() {
	tinymce.init({
	        selector: "textarea#inComent",
	        theme: "modern",
	        plugins: [
	            "advlist autolink autosave link image lists charmap print preview hr anchor pagebreak spellchecker",
	            "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
	            "save table contextmenu directionality emoticons template textcolor paste fullpage textcolor colorpicker codesample"
	        ],
	        external_plugins: {
	            //"moxiemanager": "/moxiemanager-php/plugin.js"
	        },
	        content_css: "",
	        add_unload_trigger: false,
	        autosave_ask_before_unload: false,

	        toolbar1: "bold italic underline strikethrough | alignleft aligncenter alignright alignjustify | styleselect formatselect fontselect fontsizeselect",
	        toolbar2: "cut copy paste pastetext | bullist numlist | outdent indent blockquote | undo redo | image | insertdatetime | forecolor backcolor",
	        toolbar3: "table | hr removeformat | subscript superscript | charmap | spellchecker | insertfile insertimage",
	        menubar: false,
	        toolbar_items_size: 'small',

	        style_formats: [
	            {title: 'Bold text', inline: 'b'},
	            {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
	            {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
	            {title: 'Example 1', inline: 'span', classes: 'example1'},
	            {title: 'Example 2', inline: 'span', classes: 'example2'},
	            {title: 'Table styles'},
	            {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}
	        ],

	        templates: [
	            {title: 'My template 1', description: 'Some fancy template 1', content: 'My html'},
	            {title: 'My template 2', description: 'Some fancy template 2', url: 'development.html'}
	        ],

	        spellchecker_callback: function(method, data, success) {
	            if (method == "spellcheck") {
	                var words = data.match(this.getWordCharPattern());
	                var suggestions = {};

	                for (var i = 0; i < words.length; i++) {
	                    suggestions[words[i]] = ["First", "second"];
	                }

	                success({words: suggestions, dictionary: true});
	            }

	            if (method == "addToDictionary") {
	                success();
	            }
	        }
	    });



	$('#sel-formatos').change(function(){
		getFormatos();
	});

	$('#sel-Periodos').change(function(){
		getFormatos();
	});
	getFormatos();
});

</script>