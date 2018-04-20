<!---
===============================================================================
* IPN - CSII
* Sistema: SIIIP
* Modulo: registo
* Sub modulo: con numero de empleado
* Fecha: Octubre/2017
* Descripcion: Permite el registro a los investigadores con numero de empleado
* Autor: Daniel Memije
===============================================================================
--->

<!DOCTYPE html>
<cfprocessingdirective pageEncoding="utf-8">   
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SIIP | IPN</title>

    <!-- Hojas de estilo -->
    <link href="/includes/bootstrap/3.3.4/css/bootstrap.min.css" rel="stylesheet">
    <link href="/includes/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="/includes/css/plugins/toastr/toastr.min.css" rel="stylesheet" >
    <link href="/includes/css/inspinia/animate.css" rel="stylesheet">
    <link href="/includes/css/inspinia/style.css" rel="stylesheet">
    <link href="/includes/bootstrap/bootstrap-checkbox/bcheckbox.css" rel="stylesheet">
    <link href="/includes/css/plugins/datapicker/datepicker3.css" rel="stylesheet">
    <link href="/includes/css/plugins/select2/select2.min.css" rel="stylesheet">
    <link href="/includes/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">


    <!-- Scripts -->
    <script src="/includes/js/jquery/jquery-2.1.4.min.js"></script>
    <script src="/includes/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/includes/js/plugins/toastr/toastr.min.js"></script>
    <script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.15.0/jquery.validate.min.js"></script>
		<script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.15.0/localization/messages_es.min.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/datepicker/bootstrap-datepicker.js"></script>		
		<script type="text/javascript" src="/includes/js/plugins/datepicker/locales/bootstrap-datepicker.es.js"></script>		
		<script type="text/javascript" src="/includes/js/plugins/datepicker/locales/bootstrap-datepicker.es.js"></script>		
		<script type="text/javascript" src="/includes/js/plugins/select2/select2.full.min.js"></script>				
		<script type="text/javascript" src="/includes/js/plugins/sweetalert/sweetalert.js"></script>
		<cfinclude template="investigadorSinNumEmpleado_js.cfm">


	<style type="text/css">

		.wrapper .middle-box {
			max-width: 80vw;
			margin-top: 0px;
		}

		.hr-line-dashed{
			border-top: 1px dashed #337ab7;
		}

		h2.text-center{
			margin-top: 20px;
    	margin-bottom: 20px;
    	font-size: 21px;
		}

		.requerido{
			color: #ed5565;
		}
		
		#toast-container > .toast {
    	background-image: none !important;
		}
		#toast-container > .toast:before {
	    position: fixed;
	    font-family: FontAwesome;
	    font-size: 24px;
	    line-height: 18px;
	    float: left;
	    color: #FFF;
	    padding-right: 0.5em;
	    margin: auto 0.5em auto -1.5em;
		}  
		#toast-container > .toast-warning:before {
			padding: 9px 0px;
    	content: "\f06a";
		}
		#toast-container > .toast-error:before {
			padding: 9px 0px;
		  content: "\f071";
		}
		#toast-container > .toast-info:before {
			padding: 9px 0px;
		  content: "\f05a";
		}
		#toast-container > .toast-success:before {
			padding: 9px 0px;
		  content: "\f00c";
		}

		.select2-container--default .select2-selection--single,
		.select2-container--default .select2-selection--multiple {
		  border-color: #e7eaec;
		}
		.select2-container--default.select2-container--focus .select2-selection--single,
		.select2-container--default.select2-container--focus .select2-selection--multiple {
		  border-color: #1ab394;
		}
		.select2-container--default .select2-results__option--highlighted[aria-selected] {
		  background-color: #1ab394;
		}
		.select2-container--default .select2-search--dropdown .select2-search__field {
		  border-color: #e7eaec;
		}
		.select2-dropdown {
		  border-color: #e7eaec;
		}
		.select2-dropdown input:focus {
		  outline: none;
		}
		.select2-selection {
		  outline: none;
		}
		.ui-select-container.ui-select-bootstrap .ui-select-choices-row.active > a {
		  background-color: #1ab394;
		}
		.select2-selection{
			border-radius: 1px !important;
			border: 1px solid #e5e6e7 !important;		
			height: 100% !important;
		}
		.select2-container--default .select2-selection--single .select2-selection__rendered {
    	color: #444;
    	line-height: 1.42857143 !important;
		}
	</style>
</head>

<body class="gray-bg">	
	
	<div class="wrapper wrapper-content animated fadeInDown">
		<div class="middle-box">
			<div class="row">
				<div class="col-md-12 bg-primary">
					<h2 class="text-center">Por favor proporcione la información requerida a continuación para <b>generar</b> su usuario y contraseña, con los cuales podrá tener acceso al sistema</h2>
				</div>			
			</div>			
			<div class="hr-line-dashed"></div>
			<div class="row" style="margin-top: 45px;">
				
				<div class="col-md-12">
					<form id="reg_form" role="form">                        
            <div class="row">
							<div class="col-md-4 form-group">										
								<label for="in_reg_nombre" class="control-label"><span class="requerido">*</span>Nombre</label>
								<input id="in_reg_nombre" name="in_reg_nombre" placeholder="" class="form-control" type="text">
							</div>
							<div class="col-md-4 form-group">										
								<label for="in_reg_apPaterno" class="control-label"><span class="requerido">*</span>Apellido Paterno</label>
								<input id="in_reg_apPaterno" name="in_reg_apPaterno" placeholder="" class="form-control" type="text">
							</div>
							<div class="col-md-4 form-group">										
								<label for="in_reg_apMaterno" class="control-label"><span class="requerido">*</span>Apellido Materno</label>
								<input id="in_reg_apMaterno" name="in_reg_apMaterno" placeholder="" class="form-control" type="text">
							</div>															
						</div>

						<div class="row">
							<div class="col-md-4 form-group">										
								<label for="in_reg_rfc" class="control-label"><span class="requerido">*</span>RFC</label>
								<input id="in_reg_rfc" name="in_reg_rfc" placeholder="" class="form-control" type="text">
							</div>
							<div class="col-md-4 form-group">										
								<label for="in_reg_curp" class="control-label"><span class="requerido">*</span>CURP</label>
								<input id="in_reg_curp" name="in_reg_curp" placeholder="" class="form-control" type="text">
							</div>
							<div class="col-md-4 form-group">										
								<label for="in_reg_nacionalidad" class="control-label"><span class="requerido">*</span>Nacionalidad</label>
								<select id="in_reg_nacionalidad" name="in_reg_nacionalidad" style="width: 100%;" class="required form-control">
									<option value="-1">Seleccione una Opción</option>
									<cfoutput>
										<cfloop query="#prc.nacionalidades#">
											<option value="#PK_NACIONALIDAD#">#NACIONALIDAD#</option>
										</cfloop>
									</cfoutput>									
								</select>																
							</div>
						</div>

						<div class="row">
							<div class="col-md-4 form-group">										
								<label for="in_reg_calle" class="control-label"><span class="requerido">*</span>Calle</label>
								<input id="in_reg_calle" name="in_reg_calle" placeholder="" class="form-control" type="text">
							</div>
							<div class="col-md-4 form-group">										
								<label for="in_reg_numero" class="control-label"><span class="requerido">*</span>Número</label>
								<input id="in_reg_numero" name="in_reg_numero" placeholder="" class="form-control" type="text">
							</div>
							<div class="col-md-4 form-group">										
								<label for="in_reg_cPostal" class="control-label"><span class="requerido">*</span>Código Postal</label>
								<input id="in_reg_cPostal" name="in_reg_cPostal" placeholder="" class="form-control" type="text">
							</div>
						</div>						

						<div class="row">
							<div class="col-md-4 form-group">										
								<label for="in_reg_colonia" class="control-label"><span class="requerido">*</span>Colonia</label>
								<input id="in_reg_colonia" name="in_reg_colonia" placeholder="" class="form-control" type="text" disabled>
								<input id="in_reg_pkColonia" type="hidden" value="0">
							</div>
							<div class="col-md-4 form-group">										
								<label for="in_reg_delegacion" class="control-label"><span class="requerido">*</span>Delegación o Municipio</label>
								<input id="in_reg_delegacion" name="in_reg_delegacion" placeholder="" class="form-control" type="text" disabled>
								<input id="in_reg_pkDelegacion" type="hidden" value="0">
							</div>
							<div class="col-md-4 form-group">										
								<label for="in_reg_entFederativa" class="control-label"><span class="requerido">*</span>Entidad Federativa</label>
								<input id="in_reg_entFederativa" name="in_reg_entFederativa" placeholder="" class="form-control" type="text" disabled>
								<input id="in_reg_pkEntidad" type="hidden" value="0">
							</div>															
						</div>

						<div class="row">
							<div class="col-md-4 form-group">										
								<label for="in_reg_pais" class="control-label"><span class="requerido">*</span>País</label>
								<select id="in_reg_pais" name="in_reg_pais" style="width: 100%;" class="required form-control">
									<option value="-1">Seleccione una Opción</option>
									<cfoutput>
										<cfloop query="#prc.paises#">
											<option value="#PK_PAIS#">#NOMBRE_PAIS#</option>
										</cfloop>
									</cfoutput>									
								</select>
							</div>
							<div class="col-md-4 form-group">										
								<label for="in_reg_fechaNacimiento" class="control-label"><span class="requerido">*</span>Fecha de Nacimiento</label>								
								<div class="date">
									<div class="input-group giaP1FechaIni">
										<input id="in_reg_fechaNacimiento" name="in_reg_fechaNacimiento" type="text" value="" class="required form-control">
										<span class="input-group-addon" data-toggle="tooltip" data-placement="top" title="Seleccionar Fecha de Inicio">
											<span class="fa fa-calendar"></span>
										</span>
									</div>
								</div>
							</div>
							<div class="col-md-4 form-group">										
								<label for="in_reg_genero" class="control-label"><span class="requerido">*</span>Género</label>								
								<div>
										<div class="radio radio-primary radio-inline">
											<input id="in_reg_generoFem" name="in_reg_genero" type="radio" value="2">
											<label for="in_reg_generoFem"><i class="fa fa-lg fa-female"></i> Femenino </label>
										</div>
										<div class="radio radio-primary radio-inline">
											<input id="in_reg_generoMasc" name="in_reg_genero" type="radio" value="1" class="required">
											<label for="in_reg_generoMasc"><i class="fa fa-lg fa-male"></i> Masculino </label>
										</div>
									</div>
							</div>															
						</div>

						<div class="row">
							<div class="col-md-6 form-group">										
								<label for="in_reg_niveles" class="control-label"><span class="requerido">*</span>Niveles</label>
								<select id="in_reg_niveles" name="in_reg_niveles" style="width: 100%;" class="required form-control">
									<option value="-1">Seleccione una Opción</option>
									<cfoutput>
										<cfloop query="#prc.clasificacion#">
											<option value="#CLASE#">#DESCRIPCION#</option>
										</cfloop>
									</cfoutput>									
								</select>
							</div>
							<div class="col-md-6 form-group">										
								<label for="in_reg_dependencia" class="control-label"><span class="requerido">*</span>Dependencia</label>
								<select id="in_reg_dependencia" name="in_reg_dependencia" style="width: 100%;" class="required form-control" disabled>
									<option value="-1">Seleccione una Opción</option>									
								</select>
							</div>							
						</div>

						<div class="row">
							<div class="col-md-6 form-group">										
								<label for="in_reg_correoInst" class="control-label"><span class="requerido">*</span>Correo Electrónico Institucional</label>
								<input id="in_reg_correoInst" name="in_reg_correoInst" placeholder="" class="form-control" type="text">
							</div>
							<div class="col-md-6 form-group">										
								<label for="in_reg_validCorreoInst" class="control-label"><span class="requerido">*</span>Verificar Correo</label>
								<input id="in_reg_validCorreoInst" name="in_reg_validCorreoInst" placeholder="" class="form-control" type="text">
							</div>							
						</div>

						<!--- <div class="row">
							<div class="col-md-6 form-group">										
								<label for="in_reg_preguntaSecreta" class="control-label"><span class="requerido">*</span>Pregunta Secreta</label>
								<input id="in_reg_preguntaSecreta" name="in_reg_preguntaSecreta" placeholder="" class="form-control" type="text">
							</div>
							<div class="col-md-6 form-group">										
								<label for="in_reg_preguntaSecretaResp" class="control-label"><span class="requerido">*</span>Respuesta a la Pregunta Secreta</label>
								<input id="in_reg_preguntaSecretaResp" name="in_reg_preguntaSecretaResp" placeholder="" class="form-control" type="text">
							</div>							
						</div> --->

						<div class="col-md-12"><div class="hr-line-dashed"></div></div>

						<div class="row">
							<div class="col-md-4 form-group">
								<button onclick="regresarInicio();" type="button" class="btn btn-block btn-info"><i class="fa fa-arrow-circle-left"></i> Regresar</button>																	
							</div>							
							<div class="col-md-4 form-group">
								<button onclick="limpiarFormulario();" type="button" class="btn btn-block btn-warning"><i class="fa fa-eraser"></i> Limpiar</button>																		
							</div>
							<div class="col-md-4 form-group">
								<button onclick="guardarInvestigadorSinNumEmpleado();" type="button" class="btn btn-block btn-success"><i class="fa fa-floppy-o"></i> Enviar</button>																	
							</div>
						</div>

	        </form>
				</div>				
			</div>
		</div>			
</body>

</html>
