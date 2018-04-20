<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Consulta la informacion del convenio por tipo Firma Autografa 
* Fecha:       09 de junio de 2017
* Descripcion: Vista donde se puede consultar toda la informacion de un combenio por PK y tipo convenio
* Autor:       Jose Luis Granados Chavez
* ================================
---->

<cfprocessingdirective pageEncoding="utf-8">

<!--- INI TABS CONSULTA CONVENIO --->
<div class="tabs-container">
	<ul class="nav nav-tabs">
		<li class="active guiaInfoGral"><a data-toggle="tab" href="#tabConGen-1"><i class="fa fa-circle" id="tabChConGen"></i>Generales</a></li>
		<li class="guiaInfoResponsable"><a data-toggle="tab" href="#tabConRes-2"><i class="fa fa-circle-o" id="tabChConRes"></i>Responsable</a></li>
		<li class="guiaInfoArchivos"><a data-toggle="tab" href="#tabConArc-3"><i class="fa fa-circle-o" id="tabChConArc"></i>Archivos</a></li>
	</ul>
	<div class="tab-content">
		<cfoutput query="prc.InfoConvenio">
		<div id="tabConGen-1" class="tab-pane active">
			<div class="panel-body">
				<!--- INI CONSULTA GENERALES --->
				<input type="hidden" id="tipoConvenio" value="#CONTIPO#">
				<input type="hidden" id="estadoConvenio" value="#CESESTADO#">
				<input type="hidden" id="validacionHabilitada" value="#ACCIONESCVE#">
				<div class="row">    
					<div class="form-group col-md-4 col-md-offset-1">
						<label class="labelConvenio">Tipo de convenio :</label><br>
						<label id="lblTipo" class="labelConvenioControl consulta">&nbsp;#CONNOMBRETIPO#</label>
					</div>
					<div class="form-group col-md-3">
						<label class="labelConvenio">Número de Folio :</label><br>
						<label id="lblRegistro" class="labelConvenioControl consulta">&nbsp;#CONREGISTRO#</label>
					</div>
					<cfif #REGISTRO_SIP# NEQ "">
						<div class="form-group col-md-3">
							<label class="labelConvenio">Número de Registro SIP :</label><br>
							<label id="lblRegistro" class="labelConvenioControl consulta">&nbsp;#REGISTRO_SIP#</label>
						</div>
					</cfif>
				</div>
				<div class="row">
					<div class="form-group col-md-10 col-md-offset-1">
						<label class="labelConvenio">Nombre del Proyecto:</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#CONNOMBRE#</label>
					</div>
				</div>
				<div class="row">    
					<div class="form-group col-md-10 col-md-offset-1">
						<label class="labelConvenio">Objetivo :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#CONDESCRIPCION#</label>
					</div>
				</div>
				<div class="row">    
					<div class="form-group col-md-5 col-md-offset-1">
						<label class="labelConvenio">Modalidad :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#CONNOMBREMODALIDAD#</label>
					</div>
					<div class="form-group col-md-5">
						<label class="labelConvenio">Institución colaboradora :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#CONNOMBREINSTITUCION#</label>
					</div>
				</div>
				<div class="row">    
					<div class="form-group col-md-5 col-md-offset-1">
						<label class="labelConvenio">Fecha de inicio de vigencia :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#CONFECHAVIGINI#</label> 
					</div>
					<div class="form-group col-md-5">
						<label class="labelConvenio">Fecha de fin de vigencia :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#CONFECHAVIGFIN#</label> 
					</div>
				</div>

			<cfif CONCURRENCIA EQ 2>
				<div class="row">    
					<div class="form-group col-md-5 col-md-offset-1">
						<label class="labelConvenio"> Monto IPN :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#CONMONTOLIQUIDO#</label> 
					</div>
					<div class="form-group col-md-5">
						<label class="labelConvenio"> Monto en especie concurrente :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#CONMONTOESPECIE#</label> 
					</div>
				</div>
				<div class="row">    
					<div class="form-group col-md-5 col-md-offset-1">
						<label class="labelConvenio"> Monto CONACYT :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#CONMONTOCONACYT#</label> 
					</div>
					<div class="form-group col-md-5">
						<label class="labelConvenio"> Monto total :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#CONMONTOTOTAL#</label> 
					</div>
				</div>
			<cfelse>
				<div class="row">    
					<div class="form-group col-md-5 col-md-offset-1">
						<label class="labelConvenio"> Monto total :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#CONMONTOTOTAL#</label> 
					</div>
				</div>
			</cfif>
				<!--- FIN  CONSULTA GENERALES --->
			</div>
		</div>
		<div id="tabConRes-2" class="tab-pane">
			<div class="panel-body">
				<!--- INI CONSULTA RESPONSABLE --->
				<div class="row">
					<div class="form-group col-md-9 col-md-offset-1">
						<label class="labelConvenio"> Número de empleado :</label><br>
						<label id="lblNumEmpleado" class="labelConvenioControl consulta">&nbsp;#RESNUMEMPLEADO#</label>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-3 col-md-offset-1">
						<label class="labelConvenio"> Nombre :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#RESNOMBRE#</label>
					</div>
					<div class="form-group col-md-3">
						<label class="labelConvenio"> Paterno :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#RESPATERNO#</label>
					</div>
					<div class="form-group col-md-3">
						<label class="labelConvenio"> Materno :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#RESMATERNO#</label>
					</div>
				</div>
				<div class="row">    
					<div class="form-group col-md-3 col-md-offset-1">
						<label class="labelConvenio">Sexo :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#RESSEXO#</label>
					</div>    
					<div class="form-group col-md-6">
						<label class="labelConvenio">Dependencia Académica :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#RESDEPENDENCIA#</label>
					</div>
				</div>
				<div class="row">    
					<div class="form-group col-md-6 col-md-offset-1">
						<label class="labelConvenio">Carrera :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#RESCARRERA#</label>
					</div>
					<div class="form-group col-md-3">
						<label class="labelConvenio">Grado académico :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#RESGRADO#</label>
					</div>
				</div>
				<div class="row">    
					<div class="form-group col-md-6 col-md-offset-1">
						<label class="labelConvenio"> Correo electrónico :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#RESMAIL#</label>
					</div>
					<div class="form-group col-md-3">
						<label class="labelConvenio"> Extensión :</label><br>
						<label class="labelConvenioControl consulta">&nbsp;#RESEXTENSION#</label>
					</div>
				</div>
				<!--- FIN  CONSULTA RESPONSABLE --->
			</div>
		</div>
		</cfoutput>
		<div id="tabConArc-3" class="tab-pane">
			<div class="panel-body">
				<input id="pkRegistroComentario" type="hidden" value="">
				<div id="docs" class="ibox-content" style="border: none;">
					<div id="docsConvenio"></div>
					<div id="docsOfSolicitudRev"></div>
					<div id="docsAnexoUnico"></div>
					<div id="docsActaConstitutiva"></div>
					<div id="docsPoderNotarialRep"></div>
					<div id="docsNombramientoRepLegal"></div>
					<div id="docsRfc"></div>
					<div id="docsComprobanteDomicilio"></div>
					<div id="docsIdentificacionRepLegal"></div>
					<div id="docsConvocatoria"></div>
					<div id="docsTerminosReferencia"></div>
					<div id="docsNombDirectorUr"></div>
					<div id="docsOtro"></div>
					<div id="docsResultados"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--- FIN TABS CONSULTA CONVENIO --->

<script type="text/javascript">
	<!---- Pone titulo al modal y cambia imagen en tab ---->
	$("#lblTitConConvenio").text( "Consulta convenio " + $("#lblTipo").text() + " : " + $("#lblRegistro").text() );
	if ( $("#lblNumEmpleado").html() != "&nbsp;" ) {
		$("#tabChConRes").removeClass("fa-circle-o").addClass("fa-circle");
	}

	$(document).ready(function() {

		<cfoutput>
			var pkConvenio = #prc.InfoConvenio.CONPK#;
			var pkEstado   = #prc.InfoConvenio.CESESTADO#;
		</cfoutput>///

		$("#comentarCom").removeClass('hide');
		$("#consultarCom").removeClass('hide');
		$('#comentarCom').attr('onclick','comentarConvenio('+ pkConvenio + ',' + pkEstado + ')');
		$('#consultarCom').attr('onclick','getComentariosConvenio('+ pkConvenio + ')');
			
			ofSolicitudRev(parseInt(1)); //obligatorio
			convenio(parseInt(1)); //obligatorio
			anexoUnico(parseInt(1)); //obligatorio
			actaConstitutiva(parseInt(1)); //obligatorio
			poderNotarialRep(parseInt(1)); //obligatorio
			nombramientoRepLegal(parseInt(1)); //obligatorio
			rfc(parseInt(1)); //obligatorio
			comprobanteDomicilio(parseInt(1)); //obligatorio
			identificacionRepLegal(parseInt(1)); //obligatorio
			convocatoria(parseInt(0)); //opcional
			terminosReferencia(parseInt(0)); //opcional
			nombDirectorUr(parseInt(0)); //opcional
			otro(parseInt(0)); //opcional
			resultados(parseInt(0)); //opcional
		
		
		$.post('<cfoutput>#event.buildLink("convenios.Consulta.archivosRequeridosCargados")#</cfoutput>', {
			pkRegistro:     $("#hfPkConvenio").val(),
			tipoConvenio:   2
		}, function(data) {
			if(data.EXITO){
				$("#tabChConArc").removeClass('fa-circle-o').addClass('fa-circle');
			}
		});
	});

	function convenio(index){
		
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 328,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'convenio()'
		}, function(data) {
			$("#docsConvenio").html(data);
			$(".btnSubirArchivo").hide();
			$(".archivoRequerido").hide();
		});
	}

	function anexoUnico(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 316,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'anexoUnico()'
		}, function(data) {
			$("#docsAnexoUnico").html(data); 
			$(".btnSubirArchivo").hide(); 
			$(".archivoRequerido").hide();      
		});
	}

	function actaConstitutiva(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 317,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'actaConstitutiva()'
		}, function(data) {
			$("#docsActaConstitutiva").html(data);
			$(".btnSubirArchivo").hide(); 
			$(".archivoRequerido").hide(); 
		});
	}
	
	function poderNotarialRep(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 321,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'poderNotarialRep()'
		}, function(data) {
			$("#docsPoderNotarialRep").html(data);
			$(".btnSubirArchivo").hide();
			$(".archivoRequerido").hide();
		});
	}

	function nombramientoRepLegal(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 320,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'nombramientoRepLegal()'
		}, function(data) {
			$("#docsNombramientoRepLegal").html(data);
		});
	}

	function rfc(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 322,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'rfc()'
		}, function(data) {
			$("#docsRfc").html(data);
			$(".btnSubirArchivo").hide();
			$(".archivoRequerido").hide();
		});
	}

	function comprobanteDomicilio(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 323,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'comprobanteDomicilio()'
		}, function(data) {
			$("#docsComprobanteDomicilio").html(data);
			$(".btnSubirArchivo").hide();
			$(".archivoRequerido").hide();
		});
	}

	function convocatoria(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 333,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'convocatoria()'
		}, function(data) {
			$("#docsConvocatoria").html(data);
			$(".btnSubirArchivo").hide();
			$(".archivoRequerido").hide();
		});
	}

	function terminosReferencia(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 329,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'terminosReferencia()'
		}, function(data) {
			$("#docsTerminosReferencia").html(data);
			$(".btnSubirArchivo").hide();
			$(".archivoRequerido").hide();
		});
	}

	function resultados(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 330,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'resultados()'
		}, function(data) {
			$("#docsResultados").html(data);
			$(".btnSubirArchivo").hide();
			$(".archivoRequerido").hide();
		});
	}

	function ofSolicitudRev(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 325,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'ofSolicitudRev()'
		}, function(data) {
			$("#docsOfSolicitudRev").html(data);
			$(".btnSubirArchivo").hide();
			$(".archivoRequerido").hide();
		});
	}

	function identificacionRepLegal(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 901,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'identificacionRepLegal()'
		}, function(data) {
			$("#docsIdentificacionRepLegal").html(data);
		});
	}

	function nombDirectorUr(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 902,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'nombDirectorUr()'
		}, function(data) {
			$("#docsNombDirectorUr").html(data);
		});
	}

	function otro(index){
		$.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
			documentos: 903,
			requerido: index == 1 ? 1 : 0,
			extension: JSON.stringify(['txt', 'pdf']),
			convenio: $("#hfPkConvenio").val(),
			recargar: 'otro()'
		}, function(data) {
			$("#docsOtro").html(data);
		});
	}

</script>