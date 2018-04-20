<cfprocessingdirective pageEncoding="utf-8"/>
<script type="text/javascript">
	$(document).ready(function(){
		
		/******************TOOLTIP**************************/
		  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

		  ga('create', 'UA-46156385-1', 'cssscript.com');
		  ga('send', 'pageview');
		  // tooltip
		  $('[data-toggle="tooltip"]').tooltip();   

		/******************ESCUCHAS DE EVENTOS**************************/  
	   $('#button').trigger( "click" );
	   
	   $("#docente").click(function(){
	   	console.log('docente')
	      var rol = 'docente';
	      localStorage.setItem('Rol',rol);
	    });
	    
	    $("#alumno").click(function(){
	    	console.log('alumno')
	      var rol = 'alumno';
	      localStorage.setItem('Rol',rol);
	    });

	    $("#paae").click(function(){
	    	console.log('paae')
	      var rol = 'paae';
	      localStorage.setItem('Rol',rol);
	    });

	    $("#egresado").click(function(){
	    	console.log('egresado')
	      var rol = 'egresado';
	      localStorage.setItem('Rol',rol);
	    });

	    $("#directivo").click(function(){
	    	console.log('directivo')
	      var rol = 'directivo';
	      localStorage.setItem('Rol',rol);
	    });

	    $("#funcionario").click(function(){
	    	console.log('funcionario')
	      var rol = 'funcionario';
	      localStorage.setItem('Rol',rol);
	    });

	});
</script>