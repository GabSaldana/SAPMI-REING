<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Convenios
* Fecha:       Junio de 2017
* Descripcion: Vista donde se puede dar de alta un convenio de tipo Firma Autografa
* Autor:       SGS
* ================================
---->

<cfprocessingdirective pageEncoding="utf-8">

<form id="formGenerales">
	<div class="row">
		<div class="form-group col-md-10 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Nombre del Proyecto :</label>
			<input type="text" id="nombreCFA" name="nombreCFA" class="form-control guiaFormNombre" maxlength="100">
		</div>
	</div>
	<div class="row">    
		<div class="form-group col-md-10 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Objetivo :</label>
			<input type="text" id="descripcionCFA" name="descripcionCFA" class="form-control guiaFormDescripcion" maxlength="300">
		</div>
	</div>    
	<div class="row">    
		<div class="form-group col-md-5 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Modalidad :</label>
			<select id="modalidadCFA" name="modalidadCFA" class="form-control guiaFormModalidad">
				<option value="">Seleccione una Modalidad...</option>
				<cfset total_records = prc.Modalidades.recordcount />
				<cfloop index="x" from="1" to="#total_records#">
					<cfoutput><option value="#prc.Modalidades.PK[x]#">#prc.Modalidades.NOMBRE[x]#</option></cfoutput>
				</cfloop>
			</select>
		</div>
		<div class="form-group col-md-5">
			<label class="labelConvenio"><span class="text-warning">*</span> Institución colaboradora o Financiante :</label>
			<select id="colaborativaCFA" name="colaborativaCFA" class="form-control guiaFormInstitucion">
				<option value="">Seleccione una Institución...</option>
				<cfset total_records = prc.Instituciones.recordcount />
				<cfloop index="x" from="1" to="#total_records#">
					<cfoutput><option value="#prc.Instituciones.PK[x]#">#prc.Instituciones.NOMBRE[x]#</option></cfoutput>
				</cfloop>
			</select>
		</div>
	</div>
	<div class="row">    
		<div class="form-group col-md-5 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Fecha de inicio de vigencia :</label>
			<div class="input-group date" id="divFechIniVig">
				<input type="text" id="fechaInicioCFA" name="fechaInicioCFA" class="form-control guiaFormFechaIni" maxlength="10" readonly="readonly">
				<span class="input-group-addon">
					<span class="fa fa-calendar"></span>
				</span>
			</div>    
		</div>
		<div class="form-group col-md-5">
			<label class="labelConvenio"><span class="text-warning">*</span> Fecha de fin de vigencia :</label>
			<div class="input-group date" id="divFechFinVig">
				<input type="text" id="fechaFinCFA" name="fechaFinCFA" class="form-control guiaFormFechaFin" maxlength="10" readonly="readonly">
				<span class="input-group-addon">
					<span class="fa fa-calendar"></span>
				</span>
			</div>    
		</div>
	</div>
	<div class="row">
		<div class="form-group col-md-10 col-md-offset-1">
			<input id="concurrencia" name="concurrencia" type="checkbox" value="2"><label class="labelConvenio guiaFormConcurrencia"> &nbsp;&nbsp;¿Es concurrente?</label></input>
		</div>
	</div>
	<div id="sinConcurrencia" class="row">
		<div class="form-group col-md-5 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Monto total del Proyecto :</label>
			<div class="input-group">
				<span class="input-group-addon">
					<span class="fa fa-usd"></span>
				</span>
				<input type="text" id="montoTotalDirCFA" name="montoTotalDirCFA" class="form-control guiaFormInMontoTotal" maxlength="16" ></input>
			</div>
			<label id="montoTotalDirCFA-error" class="error" for="montoTotalDirCFA" style="display: none;"></label>
		</div>
	</div>
		<div id="esConcurrente" class="row" style="display: none;">    
			<div class="form-group col-md-5 col-md-offset-1">
				<label class="labelConvenio"><span class="text-warning">*</span> Monto que recibiría IPN :</label>
				<div class="input-group">
					<span class="input-group-addon">
						<span class="fa fa-usd"></span>
					</span>
					<input type="text" id="montoLiquidoCFA" name="montoLiquidoCFA" class="form-control guiaFormMontoIPN" maxlength="16" onclick="this.select()" onkeyup="sumMontos();">  
				</div>
				<label id="montoLiquidoCFA-error" class="error" for="montoLiquidoCFA" style="display: none;"></label>
			</div>
			<div class="form-group col-md-5">
				<label class="labelConvenio"> Monto Institución Colaboradora :</label>
				<div class="input-group">
					<span class="input-group-addon">
						<span class="fa fa-usd"></span>
					</span>
					<input type="text" id="montoEspecieCFA" name="montoEspecieCFA" class="form-control guiaFormMontoEspecie" maxlength="16" onclick="this.select()" onkeyup="sumMontos();"> 
				</div>
				<label id="montoEspecieCFA-error" class="error" for="montoEspecieCFA" style="display: none;"></label>
			</div>
		</div>
		<div id="esConcurrente" class="row" style="display: none;">    
			<div class="form-group col-md-5 col-md-offset-1">
				<label class="labelConvenio"><span class="text-warning">*</span> Monto liquido a comprometer IPN :</label>
				<div class="input-group">
					<span class="input-group-addon">
						<span class="fa fa-usd"></span>
					</span>
					<input type="text" id="montoConacytCFA" name="montoConacytCFA" class="form-control guiaFormMontoCONACYT" maxlength="16" onclick="this.select()" onkeyup="sumMontos();">  
				</div>
				<label id="montoConacytCFA-error" class="error" for="montoConacytCFA" style="display: none;"></label>
			</div>
			<div class="form-group col-md-5">
				<label class="labelConvenio"> Monto total del Proyecto :</label>
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
				nombreCFA:              {required: true, iniciaConLetra: true},
				descripcionCFA:         {required: true, iniciaConLetra: true},
				modalidadCFA:           {required: true},
				colaborativaCFA:        {required: true},
				fechaInicioCFA:         {required: true},
				fechaFinCFA:            {required: true, fechaMayor: true},
				montoLiquidoCFA:        {required: true, number: true},
				montoConacytCFA:        {required: true, number: true},
				montoEspecieCFA: 		{number: true},
				montoTotalDirCFA: 		{required: true, number: true}
			}, messages: {
				montoLiquidoCFA:        {maxlength:"Por favor, no escribas más de 10 digitos."},
				montoConacytCFA:        {maxlength:"Por favor, no escribas más de 10 digitos."},
				montoEspecieCFA:        {maxlength:"Por favor, no escribas más de 10 digitos."},
				montoTotalDirCFA: 		{maxlength:"Por favor, no escribas más de 10 digitos."}
			}, errorPlacement: function (error, element) {
				if ( element.attr("name") == "fechaInicioCFA") {
					error.insertAfter($("#fechaInicioCFA").parent());
				} else if ( element.attr("name") == "fechaFinCFA" ) {
					 error.insertAfter($("#fechaFinCFA").parent());
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

		/** Validacion para que la fecha de inicio no sea mayor que la de fin */
		$.validator.addMethod("fechaMayor", function(value, element) { 
        	return element.value > $('#fechaInicioCFA').val();
    	}, "Rango de fecha incorrecto.");


		$("#montoLiquidoCFA").focus(function () {
			var valor = parseInt($(this).val().replace(/,/g,'').replace('.00',''));
			if (!isNaN(valor)){ $(this).val(valor); }
			
		});

		$("#montoLiquidoCFA").focusout(function () { 
			if ($(this).val() != 0){
				$(this).val(formatoMonetario($(this).val()));
			}          
		});

		// $("#montoLiquidoCFA").change(function () { 
		//     var valorIPN     = 0;
		//     var valorCONACYT = 0;
		//     if ( $(this).val() != "")               { valorIPN     = parseInt($(this).val().replace(/,/g,'').replace('.00','')); }
		//     if ( $("#montoConacytCFA").val() != "") { valorCONACYT = parseInt($("#montoConacytCFA").val().replace(/,/g,'').replace('.00','')); }
		//     $("#montoTotalCFA").text(formatoMonetario(valorIPN + valorCONACYT));
		// });

		// $("#montoConacytCFA").change(function () {
		//     var valorIPN     = 0;
		//     var valorCONACYT = 0;
		//     if ( $(this).val() != "")               { valorCONACYT = parseInt($(this).val().replace(/,/g,'').replace('.00','')); }
		//     if ( $("#montoLiquidoCFA").val() != "") { valorIPN     = parseInt($("#montoLiquidoCFA").val().replace(/,/g,'').replace('.00','')); }
		//     $("#montoTotalCFA").text(formatoMonetario(valorIPN + valorCONACYT));
		// });

		$("#montoConacytCFA").focus(function () {
			var valor = parseInt($(this).val().replace(/,/g,'').replace('.00',''));
			if (!isNaN(valor)){ $(this).val(valor); }
		});

		$("#montoConacytCFA").focusout(function () { 
			if ($(this).val() != 0){
				$(this).val(formatoMonetario($(this).val()));
			}          
		});

		$("#montoEspecieCFA").focus(function () {
			var valor = parseInt($(this).val().replace(/,/g,'').replace('.00',''));
			if (!isNaN(valor)){ $(this).val(valor); }
		});

		$("#montoEspecieCFA").focusout(function () { 
			if ($(this).val() != 0){
				$(this).val(formatoMonetario($(this).val()));
			}          
		});

		$("#montoTotalDirCFA").focusout(function () { 
			if ($(this).val() != 0){
				$(this).val(formatoMonetario($(this).val()));
			}          
		});

		$("#concurrencia").click(function(){
			if($(this).prop('checked')){
		   		$("[id*=esConcurrente]").css("display", "block");
		   		$("#sinConcurrencia").css("display", "none");  
			}else{
				 $("#sinConcurrencia").css("display", "block");
		  	 	$("[id*=esConcurrente]").css("display", "none");
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
		if ( $("#montoConacytCFA").val() != "") { valorCONACYT = parseInt($("#montoConacytCFA").val().replace(/,/g,'').replace('.00','')); }
		if ( $("#montoLiquidoCFA").val() != "") { valorIPN     = parseInt($("#montoLiquidoCFA").val().replace(/,/g,'').replace('.00','')); }
		if ( $("#montoEspecieCFA").val() != "") { valorESPECIE = parseInt($("#montoEspecieCFA").val().replace(/,/g,'').replace('.00','')); }
		$("#montoTotalCFA").text(formatoMonetario(valorIPN + valorCONACYT + valorESPECIE));
	};
</script>