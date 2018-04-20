<!---
* =========================================================================
* IPN - CSII
* Sistema:	EVALUACION 
* Modulo:	Edicion de Plantillas para los Formatos Trimestrales  con Columna de Tipo Catalago
* Fecha:    
* Descripcion:	
* Autor: 
* =========================================================================
--->

<cfprocessingdirective pageEncoding="utf-8">

<script  type="text/javascript">
<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: carga la vista inicial que contiene todos los elementos visibles
* --->
function cargarInicio(){
	cargarConfiguracion();
	cargarTablap3();
	cargaConfigGral();	
}




function cargaInfoGralp1(){
	$.post('<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.cargaInfoGral")#</cfoutput>', {
		formato: $('#in-formatos').val()
		}, 
		function(data){
			$('#divInfoGral').html( data );
		}
    );	
}
<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: carga la vista de edicion del encabezado general del reporte
* --->
function cargaEncabezadop2(){
	$.post('<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.cargaEncabezado")#</cfoutput>', {
			formato: $('#in-formatos').val(),
		}, 
		function(data){
			$('#tablaConfig').html( data );	
    	}
    );
}

<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: carga la vista de de la tabla (vista previa de la captura)
* --->
function cargarTablap3(){
	$.post('<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.getTabla")#</cfoutput>', {
			formato: $('#in-formatos').val()
		}, 
		function(data){
			$('#tabla').html( data );			
    	}
    );
}


function cargaConfigGralp4(){
	$.post('<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.cargaConfigGral")#</cfoutput>', {
		formato: $('#in-formatos').val()
		}, 
		function(data){
			$('#divConfigGral').html( data );
		}
    );	
}

<!---
* Fecha      : Diciembre 2016
* Autor      : Marco Torres
* Descripcion: Carga la vista de configuracion de la columna
* --->
function cargarVistaConfiguracionCol(fila,columna,nivelesEncabezado){
	$('#cont-columna').show();
	
	$('#cont-formato').addClass( 'col-md-8').removeClass( 'col-md-12');
	if(fila < nivelesEncabezado){
		$.post('<cfoutput>#event.buildLink("formatosTrimestrales.configuracion.getColumna")#</cfoutput>', {
			fila:fila,
			columna: columna,
			}, 
			function(data){
				$('#confColumna').html( data );
			}
	    );
	}			
}


$(document).ready(function() {

	var pkformato = 0;	

	$("#st-nvo-rep").steps({
		headerTag: "h3",
		bodyTag : "div",
		transitionEffect: "slideLeft",
		autoFocus: true,
		labels: {
			finish: "Terminar",
			next: "Siguiente",
			previous: "Anterior",
			cancel: "Cancelar"
		},
		onStepChanging: function(e, currentIndex, newIndex) {		
			
			var validator;
			var cambiar = false;

 			$.validator.addMethod("valueNotEquals", function(value, element, arg){
  				return arg != value;
 			}, "Seleccione una opción");

 			$.validator.setDefaults({
 				errorElement: "span",
 				errorClass: "help-block",
 				highlight: function (element, errorClass, validClass) {
 					$(element).closest('.form-group').addClass('has-error');
 				},
 				unhighlight: function (element, errorClass, validClass) {
 					$(element).closest('.form-group').removeClass('has-error');
 				},
 				errorPlacement: function (error, element) {
 					if (element.parent('.input-group').length || element.prop('type') === 'checkbox' || element.prop('type') === 'radio') {
 						error.insertAfter(element.parent());
 					} else {
 						error.insertAfter(element);
 					}
 				}
 			});

			switch(currentIndex){
				case 0:
				validator = $('#registroForm').validate({
					rules:{
						selectClasif: { valueNotEquals: "0" },
						selectArea: { valueNotEquals: "0" }
					},
					messages:{
						selectClasif: { valueNotEquals: "Seleccione una opción" },
						selectArea: {valueNotEquals: "Seleccione una opción" }
					}
				});


				if($("#in-formatos").val() == 0){					
					if(validator.form()){
												
						var clave = 'SGE-EV-'+$('#in-claveFormato').val();
						var nombre = $('#in-nombreFormato').val();	
						var vigencia = $("#in-vigencia").val();
						var uresponsable = $("#sl-area").find(":selected").val();
						var instrucciones = $("#descripcion").val();

						$.ajax({
							type:"POST",
							async:false,
							url:"/index.cfm/formatosTrimestrales/configuracion/insertarFormato",
							data:{	clave: clave,
									nombre: nombre,
									vigencia: vigencia,
									uresponsable: uresponsable,
									instrucciones: instrucciones
								},
							success:function(data){
								if(data > 0){
									cambiar = true;
									toastr.success('Formato guardado', ''+clave);							
									pkformato = data;
									
									$("#in-formatos").val(pkformato);
									cargaEncabezadop2();																

								}
								else{
									cambiar = false;
									toastr.error('Hubo un problema en la actualización','Error');
								}
							}
						});
					}					
				}
				else{								
					if(validator.form()){											
						cambiar = true;						
					}
					else{
						cambiar = false;
					}				
				}			
				break;
				case 1:		
					cambiar = true;			
					cargarTablap3();
				break;
				case 2:
					cargaConfigGralp4();										
						cambiar = true;	
				break;
				default:
				break;
			}				

			if(currentIndex > newIndex){
				return true;
			}

			return cambiar;	
        	        	
        },        
        onFinished: function(e, currentIndex, newIndex) {
        	alert('El reporte ha sido Guardado');
        	window.location.assign('<cfoutput>#event.buildLink("formatosTrimestrales.configuracion")#</cfoutput>');
        },
        onCanceled: function(e, currentIndex, newIndex) {
        	alert('El reporte ha sido eliminado');
        	if($("#in-formatos").val() != 0){
        		alert('Eliminando reporte');
        	}
        	window.location.assign('<cfoutput>#event.buildLink("formatosTrimestrales.configuracion")#</cfoutput>');
        }
    });
	
	cargaInfoGralp1();
	
	/*se deben de cargar despues de creado el reporte*/
	//cargarTablap3();	

});
function cargaVistaPrevia(){} 
</script>