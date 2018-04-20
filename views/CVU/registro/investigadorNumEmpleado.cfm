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
    <meta content="width=device-width, initial-scale=1.0">

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

		<cfinclude template="investigadorNumEmpleado_js.cfm">


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

	</style>
</head>

<body class="gray-bg">		
	<div class="wrapper wrapper-content">
		<div class="middle-box">
			<div class="row">
				<div class="col-md-8 col-md-offset-2 bg-primary">
					<h2 class="text-center">Por favor proporcione la información requerida a continuación para <b>generar</b> su usuario y contraseña, con los cuales podrá tener acceso al sistema</h2>
				</div>			
			</div>			
			<div class="col-md-8 col-md-offset-2"><div class="hr-line-dashed"></div></div>
			<div class="row" style="margin-top: 45px;">
				
				<div class="col-md-8 col-md-offset-2">
					<form id="reg_form" role="form">                        
            <div class="row">
							<div class="col-md-12 form-group">										
								<label for="in_reg_numEmpleado" class="control-label"><span class="requerido">*</span>Número de Empleado</label>
								<input id="in_reg_numEmpleado" name="in_reg_numEmpleado" placeholder="" class="form-control" type="text">
							</div>							
						</div>

						<div class="row">
							<div class="col-md-12 form-group">										
								<label for="in_reg_plazaCat" class="control-label"><span class="requerido">*</span>Categoría de Plaza</label>
								<input id="in_reg_plazaCat" name="in_reg_plazaCat" placeholder="" class="form-control" type="text">
							</div>							
						</div>

						<div class="row">
							<div class="col-md-12 form-group">										
								<label for="in_reg_curp" class="control-label"><span class="requerido">*</span>CURP</label>
								<input id="in_reg_curp" name="in_reg_curp" placeholder="" class="form-control" type="text">
							</div>							
						</div>

						<div class="row">
							<div class="col-md-12 form-group">										
								<label for="in_reg_correoInst" class="control-label"><span class="requerido">*</span>Correo Electrónico</label>
								<input id="in_reg_correoInst" name="in_reg_correoInst" placeholder="" class="form-control" type="text">
							</div>							
						</div>

						<div class="row">
							<div class="col-md-12 form-group">										
								<label for="in_reg_validCorreoInst" class="control-label"><span class="requerido">*</span>Verificar Correo</label>
								<input id="in_reg_validCorreoInst" name="in_reg_validCorreoInst" placeholder="" class="form-control" type="text">
							</div>							
						</div>

						<!--- <div class="row">
							<div class="col-md-12 form-group">										
								<label class="control-label"><span class="requerido">*</span>Pregunta Secreta</label>
								<input placeholder="" class="form-control" type="text">
							</div>							
						</div>

						<div class="row">
							<div class="col-md-12 form-group">										
								<label class="control-label"><span class="requerido">*</span>Respuesta a la Pregunta Secreta</label>
								<input placeholder="" class="form-control" type="text">
							</div>							
						</div>	 --->						

						<div class="col-md-12"><div class="hr-line-dashed"></div></div>

						<div class="row">
							<div class="col-md-4 form-group">
								<button onclick="regresarInicio();" type="button" class="btn btn-block btn-info"><i class="fa fa-arrow-circle-left"></i> Regresar</button>																	
							</div>							
							<div class="col-md-4 form-group">
								<button onclick="limpiarFormulario();" type="button" class="btn btn-block btn-warning"><i class="fa fa-eraser"></i> Limpiar</button>																		
							</div>
							<div class="col-md-4 form-group">
								<button onclick="guardarInvestigadorNumEmpleado();" type="button" class="btn btn-block btn-success"><i class="fa fa-floppy-o"></i> Enviar</button>																	
							</div>
						</div>

	        </form>
				</div>				
			</div>
		</div>

</body>

</html>
