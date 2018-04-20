<script type="text/javascript" src="/includes/js/plugins/clockpicker/bootstrap-clockpicker.min.js"></script>

<script type="text/javascript">
	 $(document).ready(function() {	
		consultaProcesoRol();
	  });
	 
	 function consultaProcesoRol(){
		$.post('/index.cfm/admonChat/admonChat/mostrarProcesosRol', function(data){    
            $('#tablaR').html(data);
     });
	 }
</script>