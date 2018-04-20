<!---
* =========================================================================
* IPN - CSII
* Sistema:	EVALUACION 
* Modulo:	Edicion de Plantillas para los Formatos Trimestrales  con Columna de Tipo Catalaogo
* Fecha:    
* Descripcion:	
* Autor: 
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<style type="text/css">
	.navy-bg-documento {
		/*1c84c6*/
		/*D8D8D8*/
        background-color: #E6E6E6!important;
        color: #000000!important;
    }
    .img-documento {
    	width: 100%;
    	height: auto;
	}
	.widget-documento {
  		border-radius: 5px;
  		border-style: solid;
  		border-width: thin;
  		border-color: #B3B3B3;
  		/*overflow-y: scroll;*/
  		/*overflow-x: scroll;*/
  		
  		/*overflow: scroll;
  		*//*height: auto;;
  		*//*max-height: 5000px;*/
  		/*padding: 15px 20px;
  		margin-bottom: 10px;
  		margin-top: 10px;*/ 
  	}
  	.nombreComprobante{
  		max-height: 40px;
  		overflow-y: scroll;
  	}
  	.p-lg-documento {
  		padding-top: 10px;
  		padding-left: 20px;
  		padding-right: 20px;
  		padding-bottom: 10px;
  		position:relative;
  		/*padding: 20px; 
  		*/
  	}
  	.acciones{
  		position: relative;
		/*left: :    80px;
		*/top:   30px;
  	}
</style>
<cfif prc.validacion EQ 1>
	<cfinclude template="/views/formatosTrimestrales/funcionesVerificarLlenado_js.cfm">
<cfelse>
	<cfinclude template="/views/formatosTrimestrales/funcionesVerificarLlenadoNoRequerido_js.cfm">
</cfif>
<link href="/includes/css/fileinput.css" media="all" rel="stylesheet" type="text/css">
<!---- Porpuesta de vista previa del documento ----->
<!--- <div class="row archivo">
	<div class="col-sm-3">
    	<div class="widget-documento navy-bg-documento  p-lg-documento text-center">
        	<div class="row">
        		<div class="col-md-4">
        			<img class="img-documento" src="/includes/img/documentoPDF.png">	
        		</div>
        		<div class="col-md-8">
        			<div class="row">
        				<div class="col-sm-12">
        					<div class="text-left">
        						Nombre de archivo 
        						<BR>
        						<div style="overflow: auto;">
        							<b>archivo_lago_de_prueba.zip</b>
        						</div>
        					</div>
        				</div>
        				<div class="col-sm-12">
        					<div class="acciones">
        						<font size="1">
        							<button type="button" class="btn btn-success btn-xs"><i class="fa fa-download"></i> Descargar</button>
       								<button type="button" class="btn btn-warning btn-xs"><i class="fa fa-edit"></i> Editar</button>
       								<button type="button" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> Eliminar</button>	
       							</font>	
       						</div>
        				</div>
        			</div>		
        			    			
        		</div>
        	</div>
       </div>
	</div>                   
</div> --->
<!--- </div> --->
<br>
<cfset encabezado = prc.reporte.getEncabezado()>
<cfset pkCFormato = prc.reporte.getPkcformato()>
<!--- <cfset pkProducto = prc.reporte.getPKPRODUCTO()> --->
<input type="hidden" id="pkColDoc" value="0">
<input type="hidden" id="pkFmtDoc" value="<cfoutput>#pkCFormato#</cfoutput>">
<div class="container">
	<input type="hidden" id="pkFila" value="0"><br>
	<form class="form-horizontal" role="form" id="formularioFormato"></form><hr>
	<button id="btn-guardarDatos" class="btn btn-success pull-right"><i class="fa fa-floppy-o"></i> Guardar datos</button>
</div>
<div id="mdl-alerta" class="modal inmodal fade modaltext" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-sm">
		<div class="modal-content" style="width:322px">
			<div class="modal-header">
				<button id="closeModal" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title">Datos modificados</h4>
			</div>
			<div class="modal-body">
				<p id="alertaPregunta" style="display:none">Los datos de esta fila han sido modificados.<br> <br>¿Desea guardarlos antes de continuar?</p>
				<p id="alertaOk" style="display:none">Datos invalidos en el formulario.<br><br>Debe corregir los datos si desea guardarlos.</p>
			</div>
			<div class="modal-footer">
				<button id="btn-NoGuardarCerrar" class="btn btn-white" style="display:none">Cerrar sin guardar</button>
				<button id="btn-GuardarCerrar" class="btn btn-success" style="display:none">Guardar y cerrar</button>
				<button id="btn-cerrarModal" class="btn btn-danger" style="display:none" data-dismiss="modal">Cerrar</button>
			</div>
		</div>
	</div>
</div>

<div class="modal inmodal fade modaltext" id="subirDocumento" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            	<!--- <input type="hidden" id="pkColDoc" value="0">
            	<input type="hidden" id="pkFmtDoc" value="<cfoutput>#pkCFormato#</cfoutput>"> --->
            	
                <span type="button" class="close" data-dismiss="modal" aria-hidden="true">×</span>
                <h4 class="modal-title">Adjuntar documento</h4>
            </div>
            <div class="modal-body">
                <div class="row" id="subirArchivos">
                    <input id="subirArchivo" name="upload_files" type="file" multiple class="file-loading">
                </div>
            </div>
            <div class="modal-footer ">
                <span type="button" class="btn btn-warning btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cancelar</span>
            </div>
        </div>
    </div>
</div>

<form id="downloadComprobanteEd" action="<cfoutput>#event.buildLink('formatosTrimestrales.capturaFT.descargarComprobante')#</cfoutput>" method="post" target="_blank">
    <input type="hidden" id="pkCatFmt"   name="pkCatFmt" value="<cfoutput>#pkCFormato#</cfoutput>">
    <input type="hidden" id="pkColDownEd"  name="pkColDown">
    <input type="hidden" id="pkFilaDownEd" name="pkFilaDown">
</form>

<script>
	
	var datosSinModificar;
	var nuevosDatos;
	var validado = true;
	var sumables = <cfoutput>#encabezado.getJSONSumables()#</cfoutput>;
	var asociaciones = <cfoutput>#serializeJSON(prc.optionsmap)#</cfoutput>;
	var CatalogoOrigen = <cfoutput>#prc.reporte.getpkCatalogoOrigen()#</cfoutput>;
	var CatalogoDestino = <cfoutput>#prc.reporte.getpkCatalogoDestino()#</cfoutput>;
	var ultimoNivel = [
		<cfoutput>
			<cfloop array="#encabezado.getColumnasUltimoNivel()#" index="columna">
				{
					"requerido": "#columna.getRequerido()#",
					"valor": "#columna.getNom_columna()#",
					"type":  "#columna.getType()#",
					"source":  #serializeJSON(columna.getSource())#,
					"data":  "#columna.getData()#",
					<cfif #columna.getBloqueada()#>
						"renderer": "columnaBloqueada",
					<cfelse>
						"renderer": "#columna.getRenderer()#",
					</cfif>
						"validator": "#columna.getValidator()#"
				},
			</cfloop>
		</cfoutput>
	];
	 //console.log(ultimoNivel);
	
	<!--- Creacion del formulario --->
	var divLleno = 0;					// Contador para ver cuantos input tienen los div
	var divTotal = 0;					// Bandera para los div y ver si tienen un input de total o no
	for (var i = 0; i < ultimoNivel.length; i++) {
		if(ultimoNivel[i].requerido == 'true'){
			ultimoNivel[i].valor = '<font color="#BEAF19">* </font>'+ultimoNivel[i].valor;
		}
		if (ultimoNivel[i].renderer == "noRender") {
			if (ultimoNivel[i].type == "text") {
				/*Campo requerido en el formulario*/

				if(ultimoNivel[i].validator == 'cadenaCuatroMilRequerida'){
					$("#formularioFormato").append('<div class="form-group"><label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-2">'+ultimoNivel[i].valor+':</label><div class="col-sm-9"><textarea style="resize: none;" rows="10" type="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="required form-control counterCaracteres4000Max" val-pkcolumna='+ultimoNivel[i].data+'></textarea><label class="pull-right">Caracteres escritos: 0 de 4000</label></div></div>');
						divLleno=0;
				} else if(ultimoNivel[i].validator == 'cadenaMil' || ultimoNivel[i].validator == 'cadenaMilRequerida'){
					$("#formularioFormato").append('<div class="form-group"><label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-2">'+ultimoNivel[i].valor+':</label><div class="col-sm-9"><textarea style="resize: none;" rows="10" type="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="required form-control counterCaracteres1000Max" val-pkcolumna='+ultimoNivel[i].data+'></textarea><label class="pull-right">Caracteres escritos: 0 de 1000</label></div></div>');
						divLleno=0;
				} else {
					$("#formularioFormato").append('<div class="form-group"><label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-2">'+ultimoNivel[i].valor+':</label><div class="col-sm-9"><input type="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="required form-control" val-pkcolumna='+ultimoNivel[i].data+'></div></div>');
						divLleno=0;
				}
			} else if (ultimoNivel[i].type == "numeric") {
				if (divLleno==0) {$("#formularioFormato").append('<div class="form-group numeric"></div>');divTotal=0;}
				$("#formularioFormato .numeric:last-child").append('<label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-2">'+ultimoNivel[i].valor+':</label><div class="col-sm-2"><input type="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="required form-control" val-pkcolumna='+ultimoNivel[i].data+'></div>');
				divLleno++;
				if (divLleno>1){divLleno=0;}
			} else if (ultimoNivel[i].type == "dropdown"){
				if(ultimoNivel[i].validator == 'seleccionMultiple'){
					$("#formularioFormato").append('<div class="form-group"><label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-2">'+ultimoNivel[i].valor+':</label><div class="col-sm-9"><div class="checkboxes" val-pkcolumna='+ultimoNivel[i].data+'></div></div></div>');
					divLleno=0;
					for (var j = 0; j < ultimoNivel[i].source.length; j++) {
						$("#formularioFormato div[val-pkcolumna="+ultimoNivel[i].data+"]").append('<div class="checkbox checkbox-inline checkbox-primary"><input type="checkbox" id="checkbox-'+ultimoNivel[i].source[j].replace(/\s+/g,"")+'" value='+ultimoNivel[i].source[j].replace(/\s+/g,"_")+'><label for="checkbox-'+ultimoNivel[i].source[j].replace(/\s+/g,"")+'">'+ultimoNivel[i].source[j]+'</label></div>');
					}
				} else if(ultimoNivel[i].validator == 'seleccionUnica'){
					$("#formularioFormato").append('<div class="form-group"><label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-2">'+ultimoNivel[i].valor+':</label><div class="col-sm-9"><div class="radios" val-pkcolumna='+ultimoNivel[i].data+'></div></div></div>');
					divLleno=0;
					for (var j = 0; j < ultimoNivel[i].source.length; j++) {
						$("#formularioFormato div[val-pkcolumna="+ultimoNivel[i].data+"]").append('<div class="radio radio-inline radio-primary"><input type="radio" id="radio-'+ultimoNivel[i].source[j].replace(/\s+/g,"")+'" value='+ultimoNivel[i].source[j].replace(/\s+/g,"_")+' name=radio'+ultimoNivel[i].data+'><label for="radio-'+ultimoNivel[i].source[j].replace(/\s+/g,"")+'">'+ultimoNivel[i].source[j]+'</label></div>');
					} 
				} else if(ultimoNivel[i].validator == 'listaReordenable'){
					$("#formularioFormato").append('<div class="form-group"><label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-2">'+ultimoNivel[i].valor+':</label><div class="col-sm-9"><div class="dd" val-pkcolumna='+ultimoNivel[i].data+'>Ordena las opciones de mayor a menor importancia<ol class="dd-list"></ol></div></div></div>');
					divLleno=0;
					for (var j = 0; j < ultimoNivel[i].source.length; j++) {
						$("#formularioFormato div[val-pkcolumna="+ultimoNivel[i].data+"]").children().append('<li class="dd-item" data-id="'+ultimoNivel[i].source[j].replace(/\s+/g,"_")+'" id="'+ultimoNivel[i].source[j].replace(/\s+/g,"_")+'"><div class="dd-handle"><i class="fa fa-circle text-success"></i> '+ultimoNivel[i].source[j]+'</div></li>');
					}
				} else if(ultimoNivel[i].validator == 'seleccionArchivo'){
					$("#formularioFormato").append('<div id="ftp'+ultimoNivel[i].data+'" class="form-group"><label  class="control-label col-sm-2">'+ultimoNivel[i].valor+'</label><div class="col-sm-9"><div id="divInput'+ultimoNivel[i].data+'"><input id="subirArchivo'+ultimoNivel[i].data+'"  pkCol="'+ultimoNivel[i].data+'"  name="upload_files" type="file" multiple class="file-loading subirArchivo"></div> <br> '+getMenuArchivo(ultimoNivel[i].data,ultimoNivel[i].valor)+' <input type="hidden" class="form-control" val-pkcolumna='+ultimoNivel[i].data+'><div style="display:none" class="cancelar'+ultimoNivel[i].data+' text-right"><a onclick="cancelarEdicion('+ultimoNivel[i].data+');" class="btn btn-warning"><i class="fa fa-times"></i> Cancelar</a></div></div>  </div>');
					
					divLleno=0;
					
				} else if(ultimoNivel[i].validator == 'archivoRequerido'){
					$("#formularioFormato").append('<div id="ftp'+ultimoNivel[i].data+'" class="form-group"><label  class="control-label col-sm-2">'+ultimoNivel[i].valor+'</label><div class="col-sm-9"><div id="divInput'+ultimoNivel[i].data+'"><input id="subirArchivo'+ultimoNivel[i].data+'"  pkCol="'+ultimoNivel[i].data+'"   name="upload_files" type="file" multiple class="file-loading subirArchivo"></div> <br> '+getMenuArchivo(ultimoNivel[i].data,ultimoNivel[i].valor)+' <input type="hidden" class="form-control col-sm-2" val-pkcolumna='+ultimoNivel[i].data+'><div style="display:none" class="cancelar'+ultimoNivel[i].data+' text-right"><a onclick="cancelarEdicion('+ultimoNivel[i].data+');" class="btn test btn-warning"><i class="fa fa-times"></i> Cancelar</a></div></div>   </div>');
					
					divLleno=0;
				}
			}

		} else if (ultimoNivel[i].renderer == "columnaBloqueada") {
			if (ultimoNivel[i].type == "text") {
				$("#formularioFormato").append('<div class="form-group"><label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-2">'+ultimoNivel[i].valor+':</label><div class="col-sm-9"><input type="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="required form-control" val-pkcolumna='+ultimoNivel[i].data+' readonly></div>');
					divLleno=0;
			} else if (ultimoNivel[i].type == "numeric") {
				if (divLleno==0) {$("#formularioFormato").append('<div class="form-group numeric"></div>');divTotal=0;}
				$("#formularioFormato .numeric:last-child").append('<label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-2">'+ultimoNivel[i].valor+':</label><div class="col-sm-2"><input type="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="required form-control" val-pkcolumna='+ultimoNivel[i].data+' readonly>');
				divLleno++;
				if (divLleno>1){divLleno=0;}
			} else if (ultimoNivel[i].type == "dropdown") {
				$("#formularioFormato").append('<div class="form-group"><label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-2">'+ultimoNivel[i].valor+':</label><div class="col-sm-9"><select type="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="required form-control" val-pkcolumna='+ultimoNivel[i].data+' disabled><option value="0">Seleccione una opción</option></select></div></div>');
				divLleno=0;
				for (var j = 0; j < ultimoNivel[i].source.length; j++) {
					$("#formularioFormato select[val-pkcolumna="+ultimoNivel[i].data+"]").append('<option value='+ultimoNivel[i].source[j].replace(/\s+/g,"")+'>'+ultimoNivel[i].source[j]+'</option>');
				}
			} else if (ultimoNivel[i].type == "date") {
				$("#formularioFormato").append('<div class="form-group"><label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-2">'+ultimoNivel[i].valor+':</label><div class="col-sm-4"><div class="date"><div class="input-group"><input type="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="required form-control" val-pkcolumna='+ultimoNivel[i].data+' disabled><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div></div></div></div>');
				divLleno=0;
			}

		} else if (ultimoNivel[i].renderer == "columnaFecha") {
			$("#formularioFormato").append('<div class="form-group"><label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-2">'+ultimoNivel[i].valor+':</label><div class="col-sm-4"><div class="date"><div class="input-group"><input type="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="required form-control" val-pkcolumna='+ultimoNivel[i].data+'><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div></div></div></div>');
			divLleno=0;

		} else if (ultimoNivel[i].renderer == "columnaDropdown") {
			$("#formularioFormato").append('<div class="form-group"><label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-2">'+ultimoNivel[i].valor+':</label><div class="col-sm-9"><select type="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="required form-control" val-pkcolumna='+ultimoNivel[i].data+'><option value="0">Seleccione una opción</option></select></div></div>');
			divLleno=0;
			for (var j = 0; j < ultimoNivel[i].source.length; j++) {
				$("#formularioFormato select[val-pkcolumna="+ultimoNivel[i].data+"]").append('<option value='+ultimoNivel[i].source[j].replace(/\s+/g,"")+'>'+ultimoNivel[i].source[j]+'</option>');
			}
			
		} else if (ultimoNivel[i].renderer == "columnaSumable") {
			if (divTotal==1) {$("#formularioFormato").append('<div class="form-group numeric"></div>');divTotal=0;}
			$("#formularioFormato .numeric:last-child").append('<label for="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="control-label col-sm-1">'+ultimoNivel[i].valor+':</label><div class="col-sm-2"><input type="'+ultimoNivel[i].valor.replace(/\s+/g,"").replace(/(<([^>]+)>)/ig,"")+'" class="required form-control" val-pkcolumna='+ultimoNivel[i].data+' readonly></div>');
			divLleno=0;
			divTotal=1;

		}
	}

	<cfloop array="#encabezado.getColumnas()#" index="columnaUltimoNivel">
		<cfloop array="#encabezado.getColumnas()#" index="columna">
			<cfif columnaUltimoNivel.getPk_Padre() eq columna.getData() and columna.getNom_columna() neq '-'>
				if (!$("#padre-<cfoutput>#columnaUltimoNivel.getPk_Padre()#</cfoutput>").length) {
					$('#formularioFormato [val-pkcolumna="<cfoutput>#columnaUltimoNivel.getData()#</cfoutput>"]').parent().parent().before('<label id="padre-<cfoutput>#columnaUltimoNivel.getPk_Padre()#</cfoutput>" style="margin-left:50px"><cfoutput>#columna.getNom_columna()#</cfoutput></label>');
				}
			</cfif>
		</cfloop>
	</cfloop>

	<cfloop array="#encabezado.getColumnas()#" index="columnaAntNivel">
		<cfloop array="#encabezado.getColumnas()#" index="columna">
			<cfif columnaAntNivel.getPk_Padre() eq columna.getData() and columna.getNom_columna() neq '-'>
				if (!$("#padre-<cfoutput>#columnaAntNivel.getPk_Padre()#</cfoutput>").length) {
					$("#padre-<cfoutput>#columnaAntNivel.getData()#</cfoutput>").before('<label id="padre-<cfoutput>#columnaAntNivel.getPk_Padre()#</cfoutput>" style="margin-left:30px"><cfoutput>#columna.getNom_columna()#</cfoutput></label>');
				}
			</cfif>
		</cfloop>
	</cfloop>
	
	for (var i = 0; i < sumables.length; i++) {
		for (var j = 0; j < sumables[i].origen.length; j++) {
			$("#formularioFormato input[val-pkcolumna="+sumables[i].origen[j]+"]").attr("sumaDestino",sumables[i].destino);
			$("#formularioFormato input[val-pkcolumna="+sumables[i].origen[j]+"]").attr("origen"+sumables[i].destino,j+1);
			$("#formularioFormato input[val-pkcolumna="+sumables[i].origen[j]+"]").addClass("suma");
		}
		$("#formularioFormato input[val-pkcolumna="+sumables[i].destino+"]").attr("elementosSuma",sumables[i].origen.length);
	}

	$('.date').datepicker({
		format: 'dd/mm/yyyy',
		language: 'es',
		calendarWeeks: true,
		autoclose: true,
		startDate: '01/01/2000',
		todayHighlight: true
	});

	$('.suma').change(function() {
		var destino = $(this).attr("sumaDestino");
		var elementosSuma = $("#formularioFormato input[val-pkcolumna="+destino+"]").attr("elementosSuma");
		var sumatoria = 0;
		for(var i = 1; i <= elementosSuma; i++){
			sumatoria = sumatoria + Number($("#formularioFormato input[origen"+destino+"="+i+"]").val());
		}
		$("#formularioFormato input[val-pkcolumna="+destino+"]").val(sumatoria);
	});

	$('.counterCaracteres1000Max').keyup(function() {
		var size = $(this).val().length;
		$(this).next().html('Caracteres escritos: '+size+' de 1000');
	});

	$('.counterCaracteres4000Max').keyup(function() {
		var size = $(this).val().length;
		$(this).next().html('Caracteres escritos: '+size+' de 4000');
	});

	$('.dd').nestable({maxDepth:1});

	for(var valor in asociaciones){
		for(var i = 0; i < asociaciones[valor].length; i++){
			asociaciones[valor][i] = asociaciones[valor][i].replace(/\s+/g,"");
		}
	}

	// console.log(CatalogoOrigen+' '+CatalogoDestino);
	$("#formularioFormato select[val-pkcolumna="+CatalogoOrigen+"]").change(function() {
		mostrarCatalogo(0);
	});

	function mostrarCatalogo(obtieneDatos){
		$("#formularioFormato select[val-pkcolumna="+CatalogoDestino+"] option").each(function(){
			$(this).show();
		});
		if (obtieneDatos==0) {
			$("#formularioFormato select[val-pkcolumna="+CatalogoDestino+"]").val(0);
		}
		if($("#formularioFormato select[val-pkcolumna="+CatalogoOrigen+"]").val()!=0){
			var valor = $("#formularioFormato select[val-pkcolumna="+CatalogoOrigen+"]").find('option:selected').text();
			$("#formularioFormato select[val-pkcolumna="+CatalogoDestino+"] option").each(function(){
				if ($(this).val()!=0) {
				    if(asociaciones[valor].indexOf($(this).val()) == -1){
						$(this).hide();
					}
				}
			});
		}
	}

	<!--- Funciones para limpiar el modal de alerta--->
	$('#btn-cerrarModal').click(function(){
		$('#alertaOk').hide();
		$('#btn-cerrarModal').hide();
	});

	$('#closeModal').click(function(){
		$('#alertaPregunta').hide();
		$('#alertaOk').hide();
		$('#btn-NoGuardarCerrar').hide();
		$('#btn-GuardarCerrar').hide();
		$('#btn-cerrarModal').hide();
	});

	<!--- Funciones para guardar los datos de la fila antes de cerrar el panel--->
	function cerrarLlenado(){
		nuevosDatos = recolectarDatos();
		var cerrar = true;
		for (var i = 0; i < nuevosDatos.length; i++) {
			if(nuevosDatos[i] != datosSinModificar[i]){
				$("#mdl-alerta").modal('show');
				$('#alertaPregunta').show();
				$('#btn-GuardarCerrar').show();
				$('#btn-NoGuardarCerrar').show();
				cerrar = false;
				break;
			}
		}
		if(cerrar == true){
			$('#divLlenado').hide();
			$('#divVistaLlenado').slideToggle(1000,'easeOutExpo');
		}
	}

	$('#btn-GuardarCerrar').click(function(){
		validarFormulario();
		$('#alertaPregunta').hide();
		$('#btn-GuardarCerrar').hide();
		$('#btn-NoGuardarCerrar').hide();
		if (validado) {
			saveDatosFormulario();
			$("#mdl-alerta").modal('hide');
			$('#divLlenado').hide();
			$('#divVistaLlenado').slideToggle(1000,'easeOutExpo');
		} else {
			$('#alertaOk').show();
			$('#btn-cerrarModal').show();
		}
	});

	$('#btn-NoGuardarCerrar').click(function(){
		$("#mdl-alerta").modal('hide');
		$('#alertaPregunta').hide();
		$('#btn-GuardarCerrar').hide();
		$('#btn-NoGuardarCerrar').hide();
		$('#divLlenado').hide();
		$('#divVistaLlenado').slideToggle(1000,'easeOutExpo');
	});
	
	<!--- Funciones para guardar los datos de la fila --->
	$('#btn-guardarDatos').click(function(){
		validarFormulario();
		if(validado){
			nuevosDatos = recolectarDatos();
			var sinModificacion = false;
			for (var i = 0; i < nuevosDatos.length; i++) {
				if(nuevosDatos[i] != datosSinModificar[i]){
					saveDatosFormulario();
					sinModificacion = true;
					break;
				}
			}
			if(sinModificacion == false){
				toastr.warning('','Datos sin modificación');
			} else {
				datosSinModificar = recolectarDatos();
			}
		}else {
			alert('Algunos datos no son válidos, favor de verificar la información capturada.');	
		}
	});

	function saveDatosFormulario(){
		var fila = [];
		var valor;
		for (var i = 0; i < ultimoNivel.length; i++) {
			if ($("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").is("select")) {
				if ($("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").val() != 0) {
					valor = $("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"] option:selected").text();
				} else{
					valor = '';
				}
			} else if ($("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").is("div")){
				if ($("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").hasClass("checkboxes")) {
					var checkboxes = {};
					$("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"] input[type=checkbox]").each(function(){
						checkboxes[$(this).val()] = $(this).is(":checked");
					});
					valor = JSON.stringify(checkboxes);
				} else if ($("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").hasClass("radios")) {
					var radios = {};
					$("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"] input[type=radio]").each(function(){
						radios[$(this).val()] = $(this).is(":checked");
					});
					valor = JSON.stringify(radios);
				} else if ($("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").hasClass("dd")) {
					valor = JSON.stringify($("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").nestable('serialize'));
				}
			} else {
				valor = $("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").val();
			}
			var datosGuardar = {'valor': valor, 'pkColumna': ultimoNivel[i].data}
			fila.push(datosGuardar);
		}
		return $.ajax({
			type:'POST',
			url:'<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.saveDatosFormulario")#</cfoutput>',
			data:{
				fila: JSON.stringify(fila),
				pkFila: $("#pkFila").val()
			},
			success:function(data){
				if (data > 0){
					toastr.success('exitosamente','Datos guardados');
					cargaTabla($("#pkProductoPadre").val(),'-');
					$("#boxesContraparte").slideToggle( 1000,'easeOutExpo');
					$("#divTabla").show();
				} else {
					toastr.error('al guardar los datos','Problema');
				}
			}
		});
	}

	<!--- Funciones para obtener los datos de la fila --->
	function obtenerDatosFila(pkFila){
		return $.ajax({
			type:'POST',
			url:'<cfoutput>#event.buildLink("formatosTrimestrales.capturaFT.getFilaData")#</cfoutput>',
			data:{
				pkFila: pkFila
			},
			async: false,
			success:function(data){
				limpiarValidaciones();
				for (var i = 0; i < data.DATA.COLUMNA.length; i++) {
					$("#formularioFormato input[val-pkcolumna="+data.DATA.COLUMNA[i]+"]").val(data.DATA.VALOR[i]);
					$("#formularioFormato textarea[val-pkcolumna="+data.DATA.COLUMNA[i]+"]").val(data.DATA.VALOR[i]);
					if (data.DATA.VALOR[i] != null){
						if ($("#formularioFormato [val-pkcolumna="+data.DATA.COLUMNA[i]+"]").is("textarea") && $("#formularioFormato [val-pkcolumna="+data.DATA.COLUMNA[i]+"]").hasClass('counterCaracteres1000Max')){
							$("#formularioFormato [val-pkcolumna="+data.DATA.COLUMNA[i]+"]").next().html('Caracteres escritos: '+data.DATA.VALOR[i].length+' de 1000');
						} else if ($("#formularioFormato [val-pkcolumna="+data.DATA.COLUMNA[i]+"]").is("textarea") && $("#formularioFormato [val-pkcolumna="+data.DATA.COLUMNA[i]+"]").hasClass('counterCaracteres4000Max')){
							$("#formularioFormato [val-pkcolumna="+data.DATA.COLUMNA[i]+"]").next().html('Caracteres escritos: '+data.DATA.VALOR[i].length+' de 4000');
						} else if ($("#formularioFormato [val-pkcolumna="+data.DATA.COLUMNA[i]+"]").is("div") && $("#formularioFormato [val-pkcolumna="+data.DATA.COLUMNA[i]+"]").hasClass('checkboxes')){
							checkboxes = JSON.parse(data.DATA.VALOR[i]);
							for(var valores in checkboxes){
								$("#formularioFormato .checkboxes input[value="+valores+"]").attr('checked', checkboxes[valores]);
							}
						} else if ($("#formularioFormato [val-pkcolumna="+data.DATA.COLUMNA[i]+"]").is("div") && $("#formularioFormato [val-pkcolumna="+data.DATA.COLUMNA[i]+"]").hasClass('radios')){
							radios = JSON.parse(data.DATA.VALOR[i]);
							for(var valores in radios){
								$("#formularioFormato .radios input[value="+valores+"]").attr('checked', radios[valores]);
							}
						} else if ($("#formularioFormato [val-pkcolumna="+data.DATA.COLUMNA[i]+"]").is("div") && $("#formularioFormato [val-pkcolumna="+data.DATA.COLUMNA[i]+"]").hasClass('dd')){
							list = JSON.parse(data.DATA.VALOR[i]);
							for(var i = 1; i < list.length; i++){
								$("#"+list[i].id).insertAfter("#"+list[i-1].id);
							}	
						} else if ($("#formularioFormato [val-pkcolumna="+data.DATA.COLUMNA[i]+"]").is("input")){
							if((data.DATA.VALOR[i]).includes(".zip")){
								
								// $('#ftp'+data.DATA.COLUMNA[i]+' a').removeAttr( 'style' );
								/*actualizacion*/
								$('#archivoMenu'+data.DATA.COLUMNA[i]).removeAttr( 'style' );
								$('#divInput'+data.DATA.COLUMNA[i]).hide();



							}
						}
					}
					if (typeof data.DATA.VALOR[i] === 'string') {
						$("#formularioFormato select[val-pkcolumna="+data.DATA.COLUMNA[i]+"]").val(data.DATA.VALOR[i].replace(/\s+/g,""));
					}
					if(!data.DATA.VALOR[i]) {
						$("#formularioFormato select[val-pkcolumna="+data.DATA.COLUMNA[i]+"]").val(0);
					}
				}
				datosSinModificar = recolectarDatos();
				mostrarCatalogo(1);
			}
		});
	}

	function recolectarDatos(){
		var datos = [];
		for (var i = 0; i < ultimoNivel.length; i++) {
			datos[i] = $("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").val();
			if ($("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").is("div") && $("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").hasClass('checkboxes')){
				var checkboxes = {};
				$("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"] input[type=checkbox]").each(function(){
					checkboxes[$(this).val()] = $(this).is(":checked");
				});
				datos[i] = JSON.stringify(checkboxes);
			} else if ($("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").is("div") && $("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").hasClass('radios')){
				var radios = {};
				$("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"] input[type=radio]").each(function(){
					radios[$(this).val()] = $(this).is(":checked");
				});
				datos[i] = JSON.stringify(radios);
			} else if ($("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").is("div") && $("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").hasClass('dd')) {
				datos[i] = JSON.stringify($("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").nestable('serialize'));
			}
		}
		return datos;
	}

	<!--- Funciones que validan los datos del formulario --->
	$('#formularioFormato').keyup(function(){
		validarFormulario();
	});

	function validarFormulario(){
		validado = true;
		limpiarValidaciones();
		for (var i = 0; i < ultimoNivel.length; i++) {
			if (!$("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").is("select")) {
				if(typeof ultimoNivel[i].validator !== 'undefined'){
					if(typeof window[ultimoNivel[i].validator] === 'function'){
						valor = $("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").val();
						if(! window[ultimoNivel[i].validator](valor)){
							$("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").addClass('error');
							$("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").after('<label id="error-'+ultimoNivel[i].data+'" class="text-danger">Datos invalidos</label>');
							validado = false;
						}
					} else {
						valor = $("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").val();
						if(!valor.match(window[ultimoNivel[i].validator])){
							$("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").addClass('error');
							$("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").after('<label id="error-'+ultimoNivel[i].data+'" class="text-danger">Datos invalidos</label>');
							validado = false;
						}
					}
				}
			} else {
				/*valida los combos*/
				if(typeof window[ultimoNivel[i].validator] === 'function'){
						valor = $("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").val();
						if(! window[ultimoNivel[i].validator](valor)){
							$("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").addClass('error');
							$("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").after('<label id="error-'+ultimoNivel[i].data+'" class="text-danger">Datos invalidos</label>');
							validado = false;
						}
					}
				
			}
		}
	}

	function limpiarValidaciones(){
		for (var i = 0; i < ultimoNivel.length; i++) {
			$("#formularioFormato [val-pkcolumna="+ultimoNivel[i].data+"]").removeClass('error');
			$("#error-"+ultimoNivel[i].data).remove();
		}
	}


	$(document).ready(function() {

        <!---
        * Descripcion: sube un archivo previamente seleccionado
        * Fecha: octubre de 2017
        * @author: Alejandro Tovar
        --->
        $(".subirArchivo").fileinput({
            uploadUrl: '<cfoutput>#event.buildLink('formatosTrimestrales.capturaFT.subirArchivo')#</cfoutput>',
            maxFileCount: 1,
            maxFileSize: 10000,
            msgSizeTooLarge: '"{name}" excede el tamaño máximo, <b>10 MB</b> permitidos!',
            overwriteInitial: false,
            uploadAsync: true,
            browseClass: "btn btn-primary",
            removeClass: "btn btn-danger",
            showUpload: false, // hide upload button
            showRemove: true,
            uploadExtraData: function (previewId, index){
                var info = {
                    pkColumna:  $("#pkColDoc").val(),
                    pkCFormato: $("#pkFmtDoc").val(),
                    pkFila:     $("#pkFila").val()
                };

                return info;
            },
            slugCallback: function(filename) {
                return filename;
            }
        })
        .on('filebatchpreupload', function(event, data) {

        	var ext         = (data.filenames[0]).substring((data.filenames[0]).lastIndexOf(".")+1).toString();
            var puntos      = (data.filenames[0]).split('.').length;
            var extensiones = ['pdf'];
            // /*Verifica que la extension del documento sea la permitida*/
            if(!validarExtension(ext, extensiones)){
                return {
                    message: "Extension del documento no permitida, solo se aceptan las siguientes extensiones [pdf]"
                };
            }

            /*Verifica que el nombre del documento no tenga caracteres especiales*/
            if (caracteresEspeciales(data.filenames[0])) {
                return {
                    message: "El nombre del documento no debe contener espacios ni los siguientes caracteres ^<>@!\#$%^&*()+[]{}?:;|ñÑáéíóúÁÉÍÓÚ'\"\\,/~`-=!"
                };
            }

            /*Verifica que el nombre del documento no tenga dos puntos*/
            if (puntos > 2){
               return {
                    message: "El nombre del documento no puede tener dos puntos."
                };
            }

            /*Verifica la longitud del nombre del documento*/
            if (data.filenames[0].length > 24) {
                return {
                    message: "El nombre del documento no debe exceder 20 caracteres!"
                };
            }
        })
        .on('fileuploaded', function(event, files) {
        	 var nombreFile = files.filenames[0];
        	 var res = nombreFile.substring(0, nombreFile.indexOf("."));
        	 var documento = res +'.zip';
        	 $('#error-'+$("#pkColDoc").val()+'').remove();
        	 //$('#ftp'+$("#pkColDoc").val()+' a').removeAttr( 'style' );
        	 $('#ftp'+$("#pkColDoc").val()+' input:hidden').val(documento);
        	 $("#subirArchivo"+$("#pkColDoc").val()).fileinput('clear');
        	 $("#subirArchivo"+$("#pkColDoc").val()).fileinput('enable');
        	 $("#subirArchivo"+$("#pkColDoc").val()).fileinput('refresh');
        	 $('#archivoMenu'+$("#pkColDoc").val()).show();
    		 $('#divInput'+$("#pkColDoc").val()).hide();
    		 $('.cancelar'+$("#pkColDoc").val()).css('display','none');
             //$("#subirDocumento").modal('hide');
        }).on("filebatchselected", function(event, files) {
    		$("#pkColDoc").val($(this).attr('pkCol'));
    		$("#subirArchivo"+$("#pkColDoc").val()).fileinput("upload");
		});

    });


    <!---
    * Fecha : Junio de 2017
    * Autor : Alejandro Tovar
    * Comentario: Lanza la modal correspondiente al archivo para cargar archivos.
    --->
    function lanzaModalFTP(pkcol){
    	$("#pkColDoc").val(pkcol);
        $('#subirDocumento').modal();
    }


    <!---
    * Fecha : Junio de 2017
    * Autor : Alejandro Tovar
    * Comentario: Lanza la modal correspondiente al archivo para cargar archivos.
    --->
    function descargaComprobante(pkcol){
    	$("#pkColDownEd").val(pkcol);
    	$("#pkFilaDownEd").val($("#pkFila").val());
    	$('#downloadComprobanteEd').submit();
    }

    <!---
    * Fecha : Marzo de 2018
    * Autor : Alejandro Rosales
    * Comentario: Limpia el archivo asociado
    --->
    function eliminarComprobante(pkCol){

    	$.post('<cfoutput>#event.buildLink('formatosTrimestrales.capturaFT.eliminarComprobante')#</cfoutput>',{
    		PKCATFMT: $("#pkFmtDoc").val(),
    		PKCOLDEL: pkCol,
    		PKFILADEL: $("#pkFila").val()
    	},function(data){
    		if(data > 0){
    			$('#archivoMenu'+pkCol).hide();
    			$('#divInput'+pkCol).show();
    			$('#formularioFormato [val-pkcolumna="'+pkCol+'"]').val('');
    			
    		}
    	});
    }
    <!---
    * Fecha : Marzo de 2018
    * Autor : Alejandro Rosales
    * Comentario: Edicion del archivo asociado
    --->
    function editarComprobante(pkCol){
    	$('#archivoMenu'+pkCol).hide();
    	$('#divInput'+pkCol).show();
    	$('.cancelar'+pkCol).removeAttr('style');
    }

    <!---
    * Fecha : Marzo de 2018
    * Autor : Alejandro Rosales
    * Comentario: Edicion del archivo asociado
    --->
    function cancelarEdicion(pkCol){
    	$('#archivoMenu'+pkCol).show();
    	$('#divInput'+pkCol).hide();
    	$('.cancelar'+pkCol).css('display','none');
    }
    function getMenuArchivo(pkCol, nombreArchivo){
    	var str = '<div id="archivoMenu'+pkCol+'" style="display:none" class="row archivoMenu'+pkCol+'"><div class="col-sm-6"><div class="widget-documento navy-bg-documento  p-lg-documento text-center"><div class="row"><div class="col-md-4"><img class="img-documento" src="/includes/img/documentoPDF.png"></div><div class="col-md-8"><div class="row"><div class="col-sm-12"><div class="text-left">Evidencia <BR><div class="nombreComprobante" style="overflow: auto;"><b>'+nombreArchivo+'</b></div></div></div><div class="col-sm-12"><div class="text-left acciones"><font size="1"><button type="button" class="btn btn-success btn-xs" onclick="descargaComprobante('+ pkCol +');"><i class="fa fa-download"></i> Descargar</button><button type="button" class="btn btn-warning btn-xs" onclick="editarComprobante('+pkCol+')"><i class="fa fa-edit"></i> Editar</button><button type="button" onclick="eliminarComprobante('+pkCol+')" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> Eliminar</button></font>	</div></div></div></div></div></div></div></div>';
    	return str;
    }
    





</script>