<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

	function ordernarProductos(selector){
		return $($(selector).toArray().sort((a,b) => {
			var clasifA = $(a).data('clasif');
			var clasifB = $(b).data('clasif');
			var subclasifA = $(a).data('subclasif');
			var subclasifB = $(b).data('subclasif');
			return parseInt(clasifA) - parseInt(clasifB) || parseInt(subclasifA) - parseInt(subclasifB);
		}));
	}

	var validacion = $("#validaPuntajes").validate({
		rules: {
		<cfloop from="1" to="#arrayLen(prc.productos)#" index="numReporte2">
			<cfset producto2 = prc.productos[numReporte2].reporte>
			<cfset filas = producto2.getFilas()>
			<cfloop array="#filas#" index="fila">
				<cfloop array="#fila.getEVALUACION_ETAPAS()#" index="etapa">
					<cfif #isNumeric(etapa.getFK_RECLASIFICACION())#>
						<cfif #etapa.getREC_TIPOPUNTUACION()# EQ 2 or #etapa.getREC_TIPOPUNTUACION()# EQ 3>
							name_<cfoutput>#etapa.getPK_EVALUACIONETAPA()#</cfoutput>: {min:0, max:<cfoutput>#etapa.getREC_PUNTMAX()#</cfoutput>},
						</cfif>
					<cfelse>
						<cfif #etapa.getNuevoTipoPuntuacion()# EQ 2 or #etapa.getNuevoTipoPuntuacion()# EQ 3>
							name_<cfoutput>#etapa.getPK_EVALUACIONETAPA()#</cfoutput>: {min:0, max:<cfoutput>#etapa.getNuevoPuntajeMaximo()#</cfoutput>},
						</cfif>
					</cfif>
				</cfloop>
			</cfloop>
		</cfloop>
	}, submitHandler: function(form) {
			return true;
		}
	});


	$('.selectpicker').selectpicker();

	$(document).ready(function() {
		$('#divSelectEvalProductos').html('');
		$('#prodContEval').detach().appendTo('#divSelectEvalProductos');
		$(".accionesEvaluacion .botonValidarEval").remove();
		$(".btn-observacion").hide();
		$(".validaEvaluacion2").hide();

		$('.productoEvaluacionEval').each((indice,elemento)=>{
			if(!$(elemento).find('.productoEvaluado').length){
				$(elemento).remove();
			}
		});
		
		var array_ordenados = ordernarProductos('.productoEvaluacion');		
		$('#prodContNoEval').html(array_ordenados);
		
		var array_ordenados_eval = ordernarProductos('.productoEvaluacionEval');		
		$('#prodContEval').html(array_ordenados_eval);

		$("#tabla_reclasificacion").bootstrapTable();

		/*
	    * Descripcion: 	Pinta los valores de las evaluaciones anteriores
	    * Fecha: 		Febrero de 2018
	    * @author: 		Alejandro Tovar
	    */

		<!--- se asignan los valores guardados, a los elementos --->
			<cftry>
		<cfloop from="1" to="#arrayLen(prc.productos)#" index="numReporte2">
			<cfset producto2 = prc.productos[numReporte2].reporte>
			<cfset filas = producto2.getFilas()>
			<cfloop array="#filas#" index="fila">
				<cfset fila.setEtapasEditar(prc.validaciones.ACCIONESCVE)><!--- se define que etapas son editables --->
				<cfif fila.getPROCESO() EQ prc.PROCESO.getPKPROCESO()>
				<cfloop array="#fila.getEVALUACION_ETAPAS()#" index="etapa">
					<cfif #IsNumeric(etapa.getPUNTAJE_OBTENIDO())#>
						<cfif #etapa.getNuevoTipoPuntuacion()# EQ 3> //Productos tipo horas
							$(".et_"+<cfoutput>#etapa.getPK_EVALUACIONETAPA()#</cfoutput>+"").attr('puntajeMax', <cfoutput>#etapa.getNuevoPuntajeMaximo()#</cfoutput>);
							var puntajeMax = $("[pkEtapaHoras=<cfoutput>#etapa.getPK_EVALUACIONETAPA()#</cfoutput>]").attr('puntajeMax');
							var horas = <cfoutput>#etapa.getPUNTAJE_OBTENIDO()#</cfoutput>;
							var res = Math.round(horas / puntajeMax);
							$("[pkEtapaHoras=<cfoutput>#etapa.getPK_EVALUACIONETAPA()#</cfoutput>]").val(res);
							$("#<cfoutput>#etapa.getPK_EVALUACIONETAPA()#</cfoutput>").val(<cfoutput>#etapa.getPUNTAJE_OBTENIDO()#</cfoutput>);
						<cfelseif #etapa.getNuevoTipoPuntuacion()# EQ 2> //Productos tipo input
							eval('validacion.settings.rules.name_'+<cfoutput>#etapa.getPK_EVALUACIONETAPA()#</cfoutput>+'.max =' +<cfoutput>#etapa.getNuevoPuntajeMaximo()#</cfoutput>+'');
							$("#<cfoutput>#etapa.getPK_EVALUACIONETAPA()#</cfoutput>").val(<cfoutput>#etapa.getPUNTAJE_OBTENIDO()#</cfoutput>);
						<cfelseif #etapa.getNuevoTipoPuntuacion()# EQ 1> //Productos tipo select
							$("#"+<cfoutput>#etapa.getPK_EVALUACIONETAPA()#</cfoutput>+"").children('option:last').remove();
							$("#"+<cfoutput>#etapa.getPK_EVALUACIONETAPA()#</cfoutput>+"").append("<option value="+<cfoutput>#etapa.getNuevoPuntajeMaximo()#</cfoutput>+">"+<cfoutput>#etapa.getNuevoPuntajeMaximo()#</cfoutput>+"</option>");
							$("#<cfoutput>#etapa.getPK_EVALUACIONETAPA()#</cfoutput>").val(<cfoutput>#etapa.getPUNTAJE_OBTENIDO()#</cfoutput>);
						</cfif>
					</cfif>
				 <cfif etapa.getEDITABLE()>
					<cfif etapa.getFK_EVALUADOR() neq '' and etapa.getFK_EVALUADOR() eq Session.cbstorage.usuario.PK>
						$("#tipoEvaluacion").val(<cfoutput>#etapa.getFK_TIPO_EVALUACION()#</cfoutput>);
					</cfif>
				  </cfif>
				  
				 <cfif not etapa.getEDITABLE()>
					<cfif etapa.getFK_EVALUADOR() neq '' and etapa.getFK_EVALUADOR() eq Session.cbstorage.usuario.PK>
						$("#tipoEvaluacionRealizada").val(<cfoutput>#etapa.getFK_TIPO_EVALUACION()#</cfoutput>);
					<cfelseif arraycontains(session.cbstorage.grant,'evalEDI.reclaEval')>
						$("#tipoEvaluacionRealizada").val(3);
					</cfif>
				</cfif>
				
				</cfloop>
				
				</cfif>
			</cfloop>
		</cfloop>
		<cfcatch>
		
		</cfcatch>
		</cftry>


		/*
	    * Descripcion: 	Pinta botones para la validacion de la evaluacion y deshabilita las evaluaciones anteriores
	    * Fecha: 		Febrero de 2018
	    * @author: 		Alejandro Tovar
	    */
		<cfoutput>
			<cfif #listFind(prc.validaciones.ACCIONESCVE,'solicEDI.evalSIP','$')#>
				if( $("##tipoEvaluacion").val() == 1 ){
					$("##pkAspiranteProceso").val(#prc.validaciones.PK_ASPROC#);
					$(".accionesEvaluacion .botonValidarEval").remove();
					$(".btn-observacion").show();
					$(".validaEvaluacion2").show();
					$(".accionesEvaluacion").append("<button class='btn btn-lg btn-circle btn-success botonValidarEval' onclick='validarEvaluacion(\"solicEDI.evalSIP\",#prc.validaciones.PK_ASPROC#, 1);' data-toggle='tooltip' title='Validar evaluación SIP'><i class='fa fa-thumbs-o-up'></i></button>");
					if( $("##pkMovimiento").val() == <cfoutput>#application.SIIIP_CTES.MOVIMIENTO.MANTIENE_RESIDENCIA#</cfoutput> ){
						$(".accionesEvaluacion").append("<button class='btn btn-lg btn-circle btn-warning' onclick='mantenerResidencia(\"solicEDI.mantRES\",#prc.validaciones.PK_ASPROC#, #prc.pkUsuario#, 1);' data-toggle='tooltip' title='Mantener residencia'><i class='fa fa-check-circle-o'></i></button>");
						$(".accionesEvaluacion").append("<button class='btn btn-lg btn-circle btn-danger ml5' onclick='mantenerResidencia(\"solicEDI.mantRES\",#prc.validaciones.PK_ASPROC#, #prc.pkUsuario#, 0);' data-toggle='tooltip' title='Retirar residencia'><i class='fa fa-chain-broken'></i></button>");
						$(".validaEvaluacion2").hide();
						$(".botonValidarEval").hide();
					}
				}
			</cfif>
			
			<cfif #listFind(prc.validaciones.ACCIONESCVE,'solicEDI.evalCE','$')#>
				if( $("##tipoEvaluacion").val() == 2 ){
					$("##pkAspiranteProceso").val(#prc.validaciones.PK_ASPROC#);
					$(".accionesEvaluacion .botonValidarEval").remove();
					$(".btn-observacion").show();
					$(".validaEvaluacion2").show();
					$(".accionesEvaluacion").append("<button class='btn btn-lg btn-circle btn-success botonValidarEval' onclick='validarEvaluacion(\"solicEDI.evalCE\",#prc.validaciones.PK_ASPROC#, 2);' data-toggle='tooltip' title='Validar evaluación CE'><i class='fa fa-thumbs-o-up'></i></button>");
				}
			</cfif>

			<cfif #listFind(prc.validaciones.ACCIONESCVE,'solicEDI.evalCA','$')#>
				if( $("##tipoEvaluacion").val() == 3 ){
					$("##pkAspiranteProceso").val(#prc.validaciones.PK_ASPROC#);
					$(".accionesEvaluacion .botonValidarEval").remove();
					$(".btn-observacion").show();
					$(".validaEvaluacion2").show();
					$(".accionesEvaluacion").append("<button class='btn btn-lg btn-circle btn-success botonValidarEval' onclick='validarEvaluacion(\"solicEDI.evalCA\",#prc.validaciones.PK_ASPROC#, 3);' data-toggle='tooltip' title='Validar evaluación CA'><i class='fa fa-thumbs-o-up'></i></button>");
				}
			</cfif>

			<cfif #listFind(prc.validaciones.ACCIONESCVE,'solicEDI.evalRI','$')#>
				if( $("##tipoEvaluacion").val() == 4 ){
					$("##pkAspiranteProceso").val(#prc.validaciones.PK_ASPROC#);
					$(".RI").removeAttr("disabled");
					$(".accionesEvaluacion .botonValidarEval").remove();
					$(".btn-observacion").show();
					$(".validaEvaluacion2").show();
					$(".accionesEvaluacion").append("<button class='btn btn-lg btn-circle btn-success botonValidarEval' onclick='validarEvaluacion(\"solicEDI.evalRI\",#prc.validaciones.PK_ASPROC#, 4);' data-toggle='tooltip' title='Validar evaluación RI'><i class='fa fa-thumbs-o-up'></i></button>");
					$(".accionesEvaluacion").append("<button class='btn btn-lg btn-circle btn-warning ml5' onclick='documentosRI();' data-toggle='tooltip' title='Documentos RI'><i class='fa fa-file-o'></i></button>");
				}
			</cfif>
		</cfoutput>

		var clasif = $('#clasifSeleccionada').val();
		var subClasif = $('#subClasifSeleccionada').val();			

		$('.verClasif[data-clasif='+clasif+']').trigger('click');
		$('.verProducto[data-clasif='+clasif+'][data-subclasif='+subClasif+']').trigger('click');

		/*
	    * Descripcion: 	Coloca al producto un color verde, una vez realizada la evaluacuón
	    * Fecha: 		Enero de 2018
	    * @author: 		Alejandro Tovar
	    */
		$('.guardaContinua').each(function() {
			pkEtapa = $(this).attr('pk_etapa');
	        if( ($(this).val()).length > 0 ){
	        	$("ul .productoNoEvaluado input#"+pkEtapa+"").closest("li").css("background-color", "#ebfaeb");
	        }
		});
		$('.guardaFija').each(function() {
			pkEtapa = $(this).attr('pk_etapa');
	        if( ($(this).val()).length > 0 ){
	        	$("ul .productoNoEvaluado select#"+pkEtapa+"").closest("li").css("background-color", "#ebfaeb");
	        }
		});
		$('.guardaHoras').each(function() {
			pkEtapa = $(this).attr('pk_etapa');
	        if( ($(this).val()).length > 0 ){
	        	$("ul .productoNoEvaluado input#"+pkEtapa+"").closest("li").css("background-color", "#ebfaeb");
	        }
		});
		
		$('.inProductoEvaluado').each(function() {
			if ($("#tipoEvaluacion").val() == '' ){
				pkEtapa = $(this).attr('pk_etapa');
		        if( ($(this).val()).length > 0 ){
		        	$("ul .productoNoEvaluado input#"+pkEtapa+"").closest("li").css("background-color", "#ebfaeb");
	        	}
			}	
		});
		
		$('.guardaContinuaEvaluado').undelegate();
		$('.guardaContinuaEvaluado').keypress(function(e) {
			if(e.which == 13) {
	 			var puntajesEva = [];
	 	    	pkEtapa 	 = $(this).attr('pk_etapa');
		        puntajes	 = $(this).val();
				pkEvaluacion = $(this).attr('pk_evaluacion');
				accion 		 = $(this).attr('accion') == undefined ? 0 : $(this).attr('accion');
		        puntajesEva.push({pkEtapa, puntajes, pkEvaluacion, accion});
		        guardaPuntajes(puntajesEva);
				puntajesEva = [];
			}
	    });

		$("#otrosAdjuntosNRI").hide();
		otrosAdjuntos();
    });

	/*
    * Descripcion: 	Reclasificación del producto
    * Fecha: 		Febrero de 2018
    * @author: 		Alejandro Tovar
    */
	function reclasificaProducto(pkProductoRec, clasificacion, subclasificacion, puntajeMaximo) {
		pkEvalEtapa 	= $("#reclasificaProducto").val();
		tipoPuntuacion 	= $("#tipoPuntuacion").val();
		$.post('<cfoutput>#event.buildLink("EDI.evaluacion.reclasificacionProducto")#</cfoutput>',{
			pkProdRecla: pkProductoRec,
			pkEvalEtapa: pkEvalEtapa
		}, function(data){
			if (data > 0){
				$("#botRec_"+pkEvalEtapa+"").remove();
				$("#msgRec_"+pkEvalEtapa+"").remove();

				toastr.success('Producto reclasificado correctamente');
				$(".modal_reclasificacion").modal('hide');

				$("#recla_"+pkEvalEtapa+"").append('<span id="botRec_'+pkEvalEtapa+'"><button class="btn btn-success fa fa-reply btn-xs" title="Quitar reclacificación" onclick="desReclasificar('+pkEvalEtapa+');"></button></span><br>');

				$("#recla_"+pkEvalEtapa+"").append('<span id="msgRec_'+pkEvalEtapa+'"><b class="text-success" style="font-size:18px">Reclasificado a '+clasificacion+'. '+subclasificacion+'</b></span>');

				//Asigna valores maximos de la reclasificación
				
				if( $("#"+pkEvalEtapa+"").val() == '' || $("#"+pkEvalEtapa+"").val() != 0   ){
					if( tipoPuntuacion == 1){
						$("#"+pkEvalEtapa+"").children('option:last').remove();
						$("#"+pkEvalEtapa+"").append("<option value="+puntajeMaximo+" selected>"+puntajeMaximo+"</option>");
					}
					if( tipoPuntuacion == 2){
						$("#"+pkEvalEtapa+"").val(puntajeMaximo);
						eval('validacion.settings.rules.name_'+pkEvalEtapa+'.max =' +puntajeMaximo+'');
					}
					if( tipoPuntuacion == 3){
						$("#"+pkEvalEtapa+"").val(puntajeMaximo);
					}
				}

				//Guardado de puntajes
				$(".validaEvaluacion2").trigger('click');
			}
		});
	}

	function descargaComprobante(pkformato, pkfila, pkcol){
		$("#pkColDownInv").val(pkcol);
		$("#pkFilaDownInv").val(pkfila);
		$("#pkCatFmtInv").val(pkformato);
		$("#vertiente").val($("#pkVertiente").val());
		$('#downloadComprobanteInv').submit();
	}

	$('.guardaContinua').keyup(function(){
		if( $(this).val() == '0' ){
			$(".modalCalificacionCero").modal();
			$("#pkEvalEtapaCalificacion").val($(this).attr('pk_etapa'));
			pkEtapa 	 = $(this).attr('pk_etapa');
			puntajes	 = $(this).val();
			pkEvaluacion = $(this).attr('pk_evaluacion');
			accion 		 = $(this).attr('accion') == undefined ? 0 : $(this).attr('accion');

			$("#pkEtapaCero").val(pkEtapa);
			$("#pkEvaluacionCero").val(pkEvaluacion);
			$("#accionCero").val(accion);
    	}
	});

	$('.guardaFija').change(function(){
		if( $(this).val() == '0' ){
			$(".modalCalificacionCero").modal();
			$("#pkEvalEtapaCalificacion").val($(this).attr('pk_etapa'));
			pkEtapa 	 = $(this).attr('pk_etapa');
			puntajes	 = $(this).val();
			pkEvaluacion = $(this).attr('pk_evaluacion');
			accion 		 = $(this).attr('accion') == undefined ? 0 : $(this).attr('accion');

			$("#pkEtapaCero").val(pkEtapa);
			$("#pkEvaluacionCero").val(pkEvaluacion);
			$("#accionCero").val(accion);
		}
	});

	$('.calculaHoras').keyup(function(){
		pkEtapa = $(this).attr('pk_etapa');
		puntajeObtenido = $(this).val() * $(this).attr('puntajeMax');
		$("#"+pkEtapa+"").val(puntajeObtenido);

		if( $(this).val() == '0' ){
			$(".modalCalificacionCero").modal();
			$("#pkEvalEtapaCalificacion").val(pkEtapa);
			puntajes	 = $(this).val();
			pkEvaluacion = $(this).attr('pk_evaluacion');
			accion 		 = $(this).attr('accion') == undefined ? 0 : $(this).attr('accion');

			$("#pkEtapaCero").val(pkEtapa);
			$("#pkEvaluacionCero").val(pkEvaluacion);
			$("#accionCero").val(accion);
		}
	});

	function editaComentario(pkEval) {
		arrancarTinyMCE();
		$(".mdl-comentarEval").modal('show');
		$("#pkEvalComent").val(pkEval);
		var comentario = $("#coment2_"+pkEval+"").html();
		tinyMCE.get("inContentCorreo").setContent(comentario);
	}

	function otrosAdjuntos(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 920,
			requerido: 0,
			extension: JSON.stringify(['pdf']),
			convenio: '<cfoutput>#prc.validaciones.PK_ASPROC#</cfoutput>',
			recargar: 'otrosAdjuntos()'
		}, function(data) {
			$("#otrosAdjuntosRI").html(data);
			$(".subirOtros").hide();
			$(".comentaOtros").hide();
			$(".comentarioOtros").hide();
			$(".eliminaOtros").hide();
		});
	}

	function otrosAdjuntosN(){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaOtros")#</cfoutput>', {
			documentos: 920,
			requerido: 0,
			extension: JSON.stringify(['pdf']),
			convenio: '<cfoutput>#prc.validaciones.PK_ASPROC#</cfoutput>',
			recargar: 'otrosAdjuntos()'
		}, function(data) {
			$("#otrosAdjuntosNRI").html(data);
		});
	}

	function documentosRI(){
		if ( $('#documentosRI').css('display') == 'none' ){
			$('#documentosRI').css('display', 'block');
		}else {
			$('#documentosRI').css('display', 'none');
		}
	}

</script>
