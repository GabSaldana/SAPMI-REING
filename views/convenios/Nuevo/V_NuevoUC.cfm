<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Convenios
* Fecha:       Junio de 2017
* Descripcion: Vista donde se puede dar de alta un convenio de tipo UCMexus
* Autor:       SGS
* ================================
---->

<cfprocessingdirective pageEncoding="utf-8">

<form id="formGenerales">
	<div class="row">
		<div class="form-group col-md-10 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Nombre del Proyecto :</label>
			<input type="text" id="nombreCUC" name="nombreCUC" class="form-control guiaFormNombre" maxlength="100">
		</div>
	</div>
	<div class="row">    
		<div class="form-group col-md-10 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Objetivo :</label>
			<input type="text" id="descripcionCUC" name="descripcionCUC" class="form-control guiaFormDescripcion" maxlength="300">
		</div>
	</div>    
	<div class="row">    
		<div class="form-group col-md-10 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Institución colaboradora :</label>
			<select id="colaborativaCUC" name="colaborativaCUC" class="form-control guiaFormInstitucion">
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
				<input type="text" id="fechaInicioCUC" name="fechaInicioCUC" class="form-control guiaFormFechaIni" maxlength="10" readonly="readonly">
				<span class="input-group-addon">
					<span class="fa fa-calendar"></span>
				</span>
			</div>    
		</div>
		<div class="form-group col-md-5">
			<label class="labelConvenio"><span class="text-warning">*</span> Fecha de fin de vigencia :</label>
			<div class="input-group date" id="divFechFinVig">
				<input type="text" id="fechaFinCUC" name="fechaFinCUC" class="form-control guiaFormFechaFin" maxlength="10" readonly="readonly">
				<span class="input-group-addon">
					<span class="fa fa-calendar"></span>
				</span>
			</div>    
		</div>
	</div>
		<div class="row">
		<div class="form-group col-md-5 col-md-offset-1">
			<label class="labelConvenio"><span class="text-warning">*</span> Monto total del Proyecto :</label>
			<div class="input-group">
				<span class="input-group-addon">
					<span class="fa fa-usd"></span>
				</span>
				<input type="text" id="montoTotalCUC" name="montoTotalCUC" class="form-control guiaFormInMontoTotal" maxlength="16" ></input>
			</div>
			<label id="montoTotalCUC-error" class="error" for="montoTotalCUC" style="display: none;"></label>
		</div>
	</div>
</form>

<script>
	$(document).ready(function() {

		$("#divFechIniVig").datepicker( {format: "dd/mm/yyyy"} );
		$("#divFechFinVig").datepicker( {format: "dd/mm/yyyy"} );
		
		$("#formGenerales").validate({
			rules: {
				nombreCUC:              {required: true, iniciaConLetra: true},
				descripcionCUC:         {required: true, iniciaConLetra: true},
				colaborativaCUC:        {required: true},
				fechaInicioCUC:         {required: true},
				fechaFinCUC:            {required: true, fechaMayor: true},
				montoTotalCUC:          {required: true, number: true}
			}, messages: {
				montoTotalCUC:        {maxlength:"Por favor, no escribas más de 10 digitos."}
			}, errorPlacement: function (error, element) {
				if ( element.attr("name") == "fechaInicioCUC") {
					error.insertAfter($("#fechaInicioCUC").parent());
				} else if ( element.attr("name") == "fechaFinCUC" ) {
					 error.insertAfter($("#fechaFinCUC").parent());
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
        	return element.value > $('#fechaInicioCUC').val();
    	}, "Rango de fecha incorrecto.");

		// $("#montoLiquidoCUC").change(function () { 
		//     var valorIPN     = 0;
		//     var valorCONACYT = 0;
		//     if ( $(this).val() != "")               { valorIPN     = parseInt($(this).val().replace(/,/g,'').replace('.00','')); }
		//     if ( $("#montoConacytCUC").val() != "") { valorCONACYT = parseInt($("#montoConacytCUC").val().replace(/,/g,'').replace('.00','')); }
		//     $("#montoTotalCUC").text(formatoMonetario(valorIPN + valorCONACYT));
		// });

		// $("#montoConacytCUC").change(function () {
		//     var valorIPN     = 0;
		//     var valorCONACYT = 0;
		//     if ( $(this).val() != "")               { valorCONACYT = parseInt($(this).val().replace(/,/g,'').replace('.00','')); }
		//     if ( $("#montoLiquidoCUC").val() != "") { valorIPN     = parseInt($("#montoLiquidoCUC").val().replace(/,/g,'').replace('.00','')); }
		//     $("#montoTotalCUC").text(formatoMonetario(valorIPN + valorCONACYT));
		// });

		$("#montoTotalCUC").focus(function () {
			var valor = parseInt($(this).val().replace(/,/g,'').replace('.00',''));
			if (!isNaN(valor)){ $(this).val(valor); }
		});

		$("#montoTotalCUC").focusout(function () { 
			if ($(this).val() != 0){
				$(this).val(formatoMonetario($(this).val()));
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

</script>