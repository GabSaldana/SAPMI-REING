<cfprocessingdirective pageEncoding="utf-8"/>
<!DOCTYPE html>
<html>
    <head>
        <meta name="description" content="">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Planeación 2018</title>
        <!---CSS --->
        <link href="/includes/css/circulos/api.css" rel="stylesheet">
        <!--pagina de incio-->
        <link href="/includes/fontawesome/on-server/css/font-awesome-animation.min.css" rel="stylesheet">
        <!--Materialize icons-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--jQuery-->
        <script src="/includes/js/jquery.js"></script>
        <!---MATERIALIZE--->
        <script src="/includes/js/materialize.min.js"></script>
        <!--FONT AWESOME-->
        <script defer src="/includes/fontawesome/on-server/js/fontawesome-all.min.js"></script>
        <!--ACCORDION-->
        <script src="/includes/accordion/js/accordion.min.js"></script>
        <script> $accordion = $("#accordion").accordion({"path":"/includes/accordion/"}); </script>
        <!---SWEET ALERT--->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <!---LIBRERIAS NECESARIAS PARA EL COMPONENTE--->
        <link rel="stylesheet" href="/includes/css/plugins/toastr/toastr.min.css">
        <link rel="stylesheet" href="/includes/bootstrap/3.3.4/css/bootstrap.min.css">
        <link rel="stylesheet" href="/includes/bootstrap/bootstrap-select/bootstrap-select.min.css">
        <link rel="stylesheet" href="/includes/bootstrap/bootstrap-toggle/bootstrap-toggle.min.css">
        <link rel="stylesheet" href="/includes/bootstrap/bootstrap-checkbox/bcheckbox.css">
        <!-- jQuery -->
        <script type="text/javascript" src="/includes/js/jquery/jquery-ui/jquery-ui-1.11.4.min.js"></script>
        <script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.14.0/jquery.validate.min.js"></script>
        <script type="text/javascript" src="/includes/js/jquery/jquery-validation-1.14.0/localization/messages_es.min.js"></script>
        <script type="text/javascript" src="/includes/js/jquery/nestable/jquery.nestable.js"></script>
        <!--- Bootstrap --->
        <script type="text/javascript" src="/includes/bootstrap/3.3.4/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/includes/bootstrap/bootstrap-select/bootstrap-select.min.js"></script>
        <script type="text/javascript" src="/includes/bootstrap/bootstrap-toggle/bootstrap-toggle.min.js"></script>
        <!-- Plugins -->
        <script type="text/javascript" src="/includes/js/plugins/toastr/toastr.min.js"></script><!--- no funciono es toastr tal vez por la version de JQUERY --->
        <style>
            .head { 
                width:100%;
            } 
             .clearfix::after {
                content: "";
                clear: both;
                display: table;
            }    
      </style>
    </head>
    <body style="background-color: #ffffff;">
        <nav class="navbar navbar-light bg-faded mb-0" style="position: fixed;border-bottom: 5px solid #6C1D45;padding:0px;">
            <div class="head">
                <div class="clearfix">
                   <div id="sep" class="logo-contenedor" style="text-align:left; float: left; width: 40%; padding-left: 20px;">
                        <img src="/includes/images/moviles/sep.jpg" >
                    </div>
                   <div id="ipn" class="logo-contenedor" style="text-align:left; float: right; width: 60%;">
                        <img src="/includes/images/moviles/ipn.jpg" >
                    </div>
               </div>
            </div>
        </nav>
        <div id="principal" class="container-fluid">
            <cfoutput>#renderView()#</cfoutput>
        </div>
    </body> 
</html>