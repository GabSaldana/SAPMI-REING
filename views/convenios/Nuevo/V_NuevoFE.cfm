<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Convenios
* Fecha:       Junio de 2017
* Descripcion: Vista donde se puede dar de alta un convenio de tipo Firma Electronica
* Autor:       SGS
* ================================
---->

<cfprocessingdirective pageEncoding="utf-8">

<form id="formGenerales">
	<div class="row">
		<div class="form-group col-md-10 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Nombre del Proyecto :</label>
			<input type="text" id="nombreCFE" name="nombreCFE" class="form-control guiaFormNombre" maxlength="100">
		</div>
	</div>
	<div class="row">    
		<div class="form-group col-md-10 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Objetivo :</label>
			<input type="text" id="descripcionCFE" name="descripcionCFE" class="form-control guiaFormDescripcion" maxlength="300">
		</div>
	</div>    
	<div class="row">    
		<div class="form-group col-md-10 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Modalidad :</label>
			<select id="modalidadCFE" name="modalidadCFE" class="form-control guiaFormModalidad">
				<option value="">Seleccione una Modalidad...</option>
				<cfset total_records = prc.Modalidades.recordcount />
				<cfloop index="x" from="1" to="#total_records#">
					<cfoutput><option value="#prc.Modalidades.PK[x]#">#prc.Modalidades.NOMBRE[x]#</option></cfoutput>
				</cfloop>
			</select>
		</div>
	</div>
	<div class="row">    
		<div class="form-group col-md-5 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Fecha de inicio de vigencia :</label>
			<div class="input-group date" id="divFechIniVig">
				<input type="text" id="fechaInicioCFE" name="fechaInicioCFE" class="form-control guiaFormFechaIni" maxlength="10" readonly="readonly">
				<span class="input-group-addon">
					<span class="fa fa-calendar"></span>
				</span>
			</div>    
		</div>
		<div class="form-group col-md-5">
			<label class="labelConvenio"><span class="text-warning">*</span> Fecha de fin de vigencia :</label>
			<div class="input-group date" id="divFechFinVig">
				<input type="text" id="fechaFinCFE" name="fechaFinCFE" class="form-control guiaFormFechaFin" maxlength="10" readonly="readonly">
				<span class="input-group-addon">
					<span class="fa fa-calendar"></span>
				</span>
			</div>    
		</div>
	</div>
	<div class="row">
		<div class="form-group col-md-10 col-md-offset-1">
			<input id="concurrencia" name="concurrencia" type="checkbox" value="2"><label class="labelConvenio"> &nbsp;&nbsp;¿Es concurrente?</label></input>
		</div>
	</div>
	<div id="sinConcurrencia" class="row">
		<div class="form-group col-md-5 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Monto total del Proyecto :</label>
			<div class="input-group">
				<span class="input-group-addon">
					<span class="fa fa-usd"></span>
				</span>
				<input type="text" id="montoTotalDirCFA" name="montoTotalDirCFA" class="form-control" maxlength="16" ></input>
			</div>
			<label id="montoTotalDirCFA-error" class="error" for="montoTotalDirCFA" style="display: none;"></label>
		</div>
	</div>
	<div id="esConcurrente" class="row" style="display: none;">    
		<div class="form-group col-md-5 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Monto comprometido por el IPN :</label>
			<div class="input-group">
				<span class="input-group-addon">
					<span class="fa fa-usd"></span>
				</span>
				<input type="text" id="montoLiquidoCFE" name="montoLiquidoCFE" class="form-control guiaFormMontoIPN" maxlength="16" onclick="this.select()"onkeyup="sumMontos();">
			</div>
			<label id="montoLiquidoCFE-error" class="error" for="montoLiquidoCFE" style="display: none;"></label>
		</div>
		<div class="form-group col-md-5">
			<label class="labelConvenio"><span class="text-warning">*</span> Monto que dará CONACYT :</label>
			<div class="input-group">
				<span class="input-group-addon">
					<span class="fa fa-usd"></span>
				</span>
				<input type="text" id="montoConacytCFE" name="montoConacytCFE" class="form-control guiaFormMontoCONACYT" maxlength="16" onclick="this.select()" onkeyup="sumMontos();">  
			</div>
			<label id="montoConacytCFE-error" class="error" for="montoConacytCFE" style="display: none;"></label>
		</div>
	</div>
	<div id="esConcurrente" class="row" style="display: none;">
		<div class="form-group col-md-10 col-md-offset-1">
			<input id="concurrenciaEspecie" name="concurrenciaEspecie" type="checkbox" value="3"><label class="labelConvenio"> &nbsp;&nbsp;¿Es concurrente en especie?</label></input>
		</div>
	</div>
	<div id="concurrenteEspecie" class="row" style="display: none;">    
		<div class="form-group col-md-5 col-md-offset-1">
			<label class="labelConvenio"> Monto en Infraestructura :</label>
			<div class="input-group">
				<span class="input-group-addon">
					<span class="fa fa-usd"></span>
				</span>
				<input type="text" id="montoEspecieCFE" name="montoEspecieCFE" class="form-control guiaFormMontoEspecie" maxlength="16" onclick="this.select()" onkeyup="sumMontos();"> 
			</div>
			<label id="montoEspecieCFE-error" class="error" for="montoEspecieCFE" style="display: none;"></label>
		</div>
		<div class="form-group col-md-5">
			<label class="labelConvenio"><span class="text-warning">*</span> Monto en Espacio físico :</label>
			<div class="input-group">
				<span class="input-group-addon">
					<span class="fa fa-usd"></span>
				</span>
				<input type="text" id="montoEspacioCFE" name="montoEspacioCFE" class="form-control guiaFormMontoCONACYT" maxlength="16" onclick="this.select()" onkeyup="sumMontos();">  
			</div>
			<label id="montoConacytCFE-error" class="error" for="montoEspacioCFE" style="display: none;"></label>
		</div>
	</div>
	<div class="row">
		<div class="form-group col-md-5 col-md-offset-1" style="display: none;" id="concurrenteEspecie">
			<label class="labelConvenio"><span class="text-warning">*</span> Institución colaboradora :</label>
			<select id="colaborativaCFE" name="colaborativaCFE" class="form-control guiaFormInstitucion">
				<option value="">Seleccione una Institución...</option>
				<cfset total_records = prc.Instituciones.recordcount />
				<cfloop index="x" from="1" to="#total_records#">
					<cfoutput><option value="#prc.Instituciones.PK[x]#">#prc.Instituciones.NOMBRE[x]#</option></cfoutput>
				</cfloop>
			</select>
		</div>    
		<div class="form-group col-md-5" style="display: none;" id="esConcurrenteTot">            
			<label class="labelConvenio"> Monto Total :</label>
			<label class="labelConvenioControl consulta guiaFormMontoTotal"> $ <span id="montoTotalCFA">0</span></label>
		</div>
	</div>
</form>

<script>
	$(document).ready(function() {

		$("#divFechIniVig").datepicker( {format: "dd/mm/yyyy"} );
		$("#divFechFinVig").datepicker( {format: "dd/mm/yyyy"} );

		$("#formGenerales").validate({
			rules: {
				nombreCFE:              {required: true, iniciaConLetra: true},
				descripcionCFE:         {required: true, iniciaConLetra: true},
				modalidadCFE:           {required: true},
				colaborativaCFE:        {required: true},
				fechaInicioCFE:         {required: true},
				fechaFinCFE:            {required: true, fechaMayor: true},
				montoLiquidoCFE:        {required: true, number: true},
				montoConacytCFE:        {required: true, number: true},
				montoEspacioCFE:        {required: true, number: true},
				montoEspecieCFE:        {number: true},
				montoTotalDirCFA: 		{required: true, number: true}
			}, messages: {
				montoLiquidoCFE:        {maxlength:"Por favor, no escribas más de 10 digitos."},
				montoConacytCFE:        {maxlength:"Por favor, no escribas más de 10 digitos."},
				montoEspecieCFE:        {maxlength:"Por favor, no escribas más de 10 digitos."},
				montoEspacioCFE:        {maxlength:"Por favor, no escribas más de 10 digitos."},
				montoTotalDirCFA: 		{maxlength:"Por favor, no escribas más de 10 digitos."}
			}, errorPlacement: function (error, element) {
				if ( element.attr("name") == "fechaInicioCFE") {
					error.insertAfter($("#fechaInicioCFE").parent());
				} else if ( element.attr("name") == "fechaFinCFE" ) {
					 error.insertAfter($("#fechaFinCFE").parent());
				} 
				else {
					error.insertAfter(element);
				}
			}, submitHandler: function(form) {
				return false;
			}
		});

		/** Validacion para que el campo siempre inicie con una letra ( COPIADA DE CURSOS ) */ 
		jQuery.validator.addMethod("iniciaConLetra", function (value, element) {
			if (/^[a-zA-Z_áéíóúñ\s]/.test(value)){
				return true;
			}else{
				return false;
			};
		}, "* Debe comenzar con una letra.");

		/** Valida que la fecha de inicio no sea mayor que la fecha final */
		$.validator.addMethod("fechaMayor", function(value, element) { 
        	return element.value > $('#fechaInicioCFE').val();
    	}, "Rango de fecha incorrecto.");

		$("#montoLiquidoCFE").focus(function () {
			var valor = parseInt($(this).val().replace(/,/g,'').replace('.00',''));
			if (!isNaN(valor)){ $(this).val(valor); }
			
		});

		$("#montoLiquidoCFE").focusout(function () { 
			if ($(this).val() != 0){
				$(this).val(formatoMonetario($(this).val()));
			}          
		});

		// $("#montoLiquidoCFE").change(function () { 
		//     var valorIPN     = 0;
		//     var valorCONACYT = 0;
		//     if ( $(this).val() != "")               { valorIPN     = parseInt($(this).val().replace(/,/g,'').replace('.00','')); }
		//     if ( $("#montoConacytCFE").val() != "") { valorCONACYT = parseInt($("#montoConacytCFE").val().replace(/,/g,'').replace('.00','')); }
		//     $("#montoTotalCFE").text(formatoMonetario(valorIPN + valorCONACYT));
		// });

		// $("#montoConacytCFE").change(function () {
		//     var valorIPN     = 0;
		//     var valorCONACYT = 0;
		//     if ( $(this).val() != "")               { valorCONACYT = parseInt($(this).val().replace(/,/g,'').replace('.00','')); }
		//     if ( $("#montoLiquidoCFE").val() != "") { valorIPN     = parseInt($("#montoLiquidoCFE").val().replace(/,/g,'').replace('.00','')); }
		//     $("#montoTotalCFE").text(formatoMonetario(valorIPN + valorCONACYT));
		// });

		$("#montoConacytCFE").focus(function () {
			var valor = parseInt($(this).val().replace(/,/g,'').replace('.00',''));
			if (!isNaN(valor)){ $(this).val(valor); }
		});

		$("#montoConacytCFE").focusout(function () { 
			if ($(this).val() != 0){
				$(this).val(formatoMonetario($(this).val()));
			}          
		});

		$("#montoEspecieCFE").focus(function () {
			var valor = parseInt($(this).val().replace(/,/g,'').replace('.00',''));
			if (!isNaN(valor)){ $(this).val(valor); }
		});

		$("#montoEspecieCFE").focusout(function () { 
			if ($(this).val() != 0){
				$(this).val(formatoMonetario($(this).val()));
			}          
		});

		$("#montoEspacioCFE").focus(function () {
			var valor = parseInt($(this).val().replace(/,/g,'').replace('.00',''));
			if (!isNaN(valor)){ $(this).val(valor); }
		});

		$("#montoEspacioCFE").focusout(function () { 
			if ($(this).val() != 0){
				$(this).val(formatoMonetario($(this).val()));
			}          
		})

		$("#montoTotalDirCFA").focus(function () {
			var valor = parseInt($(this).val().replace(/,/g,'').replace('.00',''));
			if (!isNaN(valor)){ $(this).val(valor); }
		});

		$("#montoTotalDirCFA").focusout(function () { 
			if ($(this).val() != 0){
				$(this).val(formatoMonetario($(this).val()));
			}          
		});

		$("#concurrencia").click(function(){
			if($(this).prop('checked')){
		   		$("[id*=esConcurrente]").css("display", "block");
		   		$("#esConcurrenteTot").css("display", "block");
		   		$("#sinConcurrencia").css("display", "none"); 
		   		$("#esConcurrenteTot").addClass('col-md-offset-1');
		   		if($("#concurrenciaEspecie").prop('checked')){
					$("[id*=concurrenteEspecie]").css("display", "block");
					$("#esConcurrenteTot").removeClass('col-md-offset-1');
				} 
			}else{
				 $("#sinConcurrencia").css("display", "block");
		  	 	$("[id*=esConcurrente]").css("display", "none");
		  	 	$("#esConcurrenteTot").css("display", "none");
		  	 	$("#esConcurrenteTot").removeClass('col-md-offset-1');
		  	 	$("[id*=concurrenteEspecie]").css("display", "none");
			}
		});

		$("#concurrenciaEspecie").click(function(){
			if($(this).prop('checked')){
		   		$("[id*=concurrenteEspecie]").css("display", "block");
		   		$("#esConcurrenteTot").removeClass('col-md-offset-1');
		   		
			}else{	 
		  	 	$("[id*=concurrenteEspecie]").css("display", "none");
		  	 	$("#esConcurrenteTot").addClass('col-md-offset-1');
		  	 	$("#montoEspecieCFE").val("");
		  	 	$("#montoEspacioCFE").val("");
		  	 	sumMontos();
			}
		});
	});

	function formatoMonetario(valor){
		var cantidad = parseFloat(valor).toFixed(2);
		var parts = cantidad.toString().split(".");
		parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		var res = parts.join(".");      
		return res;
	};

	function sumMontos() {
		var valorIPN     = 0;
		var valorCONACYT = 0;
		var valorESPECIE = 0;
		var valorESPACIO = 0;

		if ( $("#montoConacytCFE").val() != "") { valorCONACYT 	= parseInt($("#montoConacytCFE").val().replace(/,/g,'').replace('.00','')); }
		if ( $("#montoLiquidoCFE").val() != "") { valorIPN     	= parseInt($("#montoLiquidoCFE").val().replace(/,/g,'').replace('.00','')); }
		if ( $("#montoEspecieCFE").val() != "") { valorESPECIE  = parseInt($("#montoEspecieCFE").val().replace(/,/g,'').replace('.00','')); }
		if ( $("#montoEspacioCFE").val() != "") { valorESPACIO  = parseInt($("#montoEspacioCFE").val().replace(/,/g,'').replace('.00','')); }

		$("#montoTotalCFA").text(formatoMonetario(valorIPN + valorCONACYT + valorESPECIE + valorESPACIO));
	};
</script>