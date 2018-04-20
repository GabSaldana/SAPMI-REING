<!---
* ================================
* IPN – CSII
* Sistema: SII
* Modulo: Tablas Dinamicas
* Sub modulo: Explorador de conjuntos de datos
* Fecha 23 de Marzo de 2017
* Descripcion:
* Script correspondiente al submodulo del explorador de conjuntos de datos
* Autor:Jonathan Martinez
* ================================
--->
 <script type="text/javascript">
	 $( document ).ready(function() {
		 $(".ver-datos").click(function (){
			 var conjunto=$(this).parents(".conjunto");
			 var datos=conjunto.children(".datos");
			 var info=conjunto.children(".info");
			 var conjuntoAnt=conjunto.prev("div.conjunto");
			 var conjuntosSig=conjunto.nextAll(".conjunto");	
			 conjunto.addClass("data-active fast-animated bounceOutDown");
			 <!---
			     Determina si el elemento que fue seleccionado es el ultimo de la coleccion y ejecuta el codigo correspondiente en cada caso. Si el elemento no es el ultimo ademas de las modificaciones a la vista y la ejecucion de las animaciones definidas para este anima los elementos siguientes.		
			 --->
			 if(!conjuntosSig.length){
				 $(this).hide();
				 conjunto.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
				 function(e) {
				     conjuntoAnt.addClass("row ")
					 conjunto.addClass("row ");
					 conjunto.switchClass(" bounceOutDown"," bounceInUp");
					 conjunto.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
				     function(e) {
				    	 conjunto.removeClass("bounceInUp");
						 datos.show();
						 info.animate({height:datos.height()},400);	 
				    	 $('html,body').animate({ scrollTop: conjunto.offset().top - ( $(window).height() - conjunto.outerHeight(true) ) / 3 }, 500);
					 });	
				 });
			 }	
			 else{
				 conjuntosSig.addClass("fast-animated  bounceOutDown",300);
				 $(this).hide();
				 conjunto.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
				 function(e) {   
					 conjuntosSig.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
				     function(e) {
						 conjuntoAnt.addClass("row ")
						 conjunto.addClass("row ");	
						 conjunto.switchClass(" bounceOutDown","  bounceInUp");
						 conjunto.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
					     function(e) {
					         datos.show();
							 info.animate({height:datos.height()});
					    	 $('html,body').animate({ scrollTop: datos.offset().top - ( $(window).height() - datos.outerHeight(true) ) / 2 }, 500);	
						     conjuntosSig.switchClass("bounceOutDown","  bounceInUp");
						     conjuntosSig.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
					    	 function(e) {
					    		 conjuntosSig.removeClass("bounceInUp");
					    		 conjunto.removeClass("bounceInUp");			
					    	 });		
						 });		
					 });
				 });	
			 }	
		 });
		 <!---
			 *Fecha :17 de agosto de 2015
			 *Descripcion: La funcion definida para el evento de click sobre el elemento con clase "close-data" que corresponde al boton de cerrar en la tabla de datos de un conjunto en la vista y que oculta los datos del conjunto 
			 * @author Arturo Christian Santander Maya 
		 --->
		 $(".close-data").click(function(){
		     var conjunto=$(this).parents(".conjunto");
			 var datos=conjunto.children(".datos");
			 var info=conjunto.children(".info");
			 var conjuntoAnt=conjunto.prev("div.conjunto");
			 var conjuntosSig=conjunto.nextAll(".conjunto");	
			 conjunto.addClass("fast-animated bounceOutDown");
			 <!---
				 Determina si el elemento que fue seleccionado es el ultimo de la coleccion y ejecuta el codigo correspondiente en cada caso. Si el elemento no es el ultimo ademas de las modificaciones a la vista y la ejecucion de las animaciones definidas para este, anima los elementos siguientes.		
			 --->
			 if(!conjuntosSig.length){		
				 datos.hide();
				 conjunto.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
				 function(e) {
				     info.height("0%");	   
				     conjunto.removeClass(" row data-active");
				     if(!conjuntoAnt.hasClass("data-active"))
						 conjuntoAnt.removeClass("row");
					 info.find(".ver-datos").show();
					 conjunto.switchClass(" bounceOutDown"," bounceInUp");
					 conjunto.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
				     function(e) {				
				    	 conjunto.removeClass("fast-animated bounceInUp"); 
				     });
				 });		    	
				    
			 }	
		     else{
				 conjuntosSig.addClass("fast-animated  bounceOutDown",200);
				 conjunto.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
			     function(e) {	    
					 datos.hide();
					 conjuntosSig.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
				     function(e) {
						 info.height("0%");
						 conjunto.removeClass("data-active");
						 if (!conjunto.next().hasClass("data-active"))
							 conjunto.removeClass("row ");
						 if(!conjuntoAnt.hasClass("data-active"))
							 conjuntoAnt.removeClass("row");
						 info.find(".ver-datos").show();
						 conjunto.switchClass(" bounceOutDown","  bounceInUp");
						 conjunto.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
					     function(e) {					
						     $('html,body').animate({ scrollTop: info.offset().top - ( $(window).height() - info.outerHeight(true) ) / 2 }, 500);	
						     conjuntosSig.switchClass("bounceOutDown","  bounceInUp");	
						     conjuntosSig.one('webkitAnimationEnd oanimationend msAnimationEnd animationend',   
					    	 function(e) {				
					    		 conjuntosSig.removeClass("fast-animated bounceInUp");
					    		 conjunto.removeClass("fast-animated bounceInUp");			
					    	 });		
						 });		
					 });
				 });	
			 }		
		 });    
	 });
 </script>