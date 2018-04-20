<!DOCTYPE html>
<cfprocessingdirective pageEncoding="utf-8">
<html>
    <head>
        <meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">

	    <title>SIIIP | IPN</title>

	    <!-- Hojas de estilo -->

		<link rel="stylesheet" href="/includes/css/jquery-ui/jquery-ui.css">
	    <link rel="stylesheet" href="/includes/font-awesome/css/font-awesome.css">

	    <link rel="stylesheet" href="/includes/bootstrap/3.3.4/css/bootstrap.min.css">
	    <link rel="stylesheet" href="/includes/css/inspinia/animate.css">
	    <link rel="stylesheet" href="/includes/css/inspinia/style.css">
	    <link rel="stylesheet" href="/includes/css/plugins/pageguide/pageguide.min.css">
	    <link rel="stylesheet" href="/includes/css/plugins/toastr/toastr.min.css">
	    <link rel="stylesheet" href="/includes/css/plugins/datapicker/datepicker3.css">

		<!--- <link rel="stylesheet" href="/includes/css/accionesFormativas.css"> --->

	    <!-- jQuery -->
		<script type="text/javascript" src="/includes/js/jquery/jquery-2.1.4.min.js"></script>
		
		<script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.15.0/jquery.validate.min.js"></script>
		<script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.15.0/localization/messages_es.min.js"></script>
		
		<!--- Bootstrap --->
		<script type="text/javascript" src="/includes/bootstrap/3.3.4/js/bootstrap.min.js"></script>

		<!-- Plugins -->
		<script type="text/javascript" src="/includes/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/pageguide/pageguide.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/toastr/toastr.min.js"></script>
		<script type="text/javascript" src="/includes/js/plugins/datepicker/bootstrap-datepicker.js"></script>
		
    	<!--- <cfinclude template="Main_js.cfm"> --->

    </head>

    <body>
		<div id="wrapper">         
			<cfoutput>
				#renderView()#
			</cfoutput>
		</div>
	</body>

	<style>
		body{
			background-color: white;
		}
	</style>


</html>   
