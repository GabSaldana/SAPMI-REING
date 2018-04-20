<cfprocessingdirective pageEncoding="utf-8">
<script>
	tl.pg.init({
		"pg_caption": "Guía",
		"auto_refresh": true,
		"default_zindex": 999
	});	

	$(document).ready(function() {
		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: genera la busqueda de los reportes
		* ---> 
		$('#in-buscar').keypress(function(e){
			var texto = $(this).val().toUpperCase();
			/*oculta todos los reportes*/
			$('.contenedorDropPlantillas .cont-reporte').hide();
			/*muestra todos los que contengan el texto*/
			$('.el-nombre').each(function(){
				if($(this).text().toUpperCase().includes(texto)){
					$(this).parents().show();
				}
			});
			$('.el-cont-desc').each(function(){
				if($(this).text().toUpperCase().includes(texto)){
					$(this).parents().show();
				}
			});
		});

		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: Carga el reporte seleccionado
		* --->
		$('.el-vista-previa-rep').click(function(){
			$('#cont-Allreportes').slideToggle( 1000,'easeOutExpo');
			$('#contEditarPlantilla').slideToggle( 1000,'easeOutExpo');
			$('#displayNombre').text($('.el-cont-desc',$(this).parent()).text());
			cargarEdicion($(this).attr('data-rep-id'));
			
		});

		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: Carga la vista para generar reportes nuevos
		* --->
		$('.bt-nuevoRep').click(function(){
			$('#cont-Allreportes').slideToggle( 1000,'easeOutExpo');
			$('#contNuevaPlantilla').slideToggle( 1000,'easeOutExpo');			
			cargarNuevo();
		});

		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: Carga la vista para generar reportes nuevos
		* --->
		$('.bt-cerrar-captura').click(function(){
			$('#cont-Allreportes').slideToggle( 1000,'easeInExpo');
			$(this).parent().parent().slideToggle( 1000,'easeInExpo');
		});	

		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: Carga la vista para generar reportes nuevos
		* --->
		$('.buscarAsociados').click(function(){
			verFormatosRelacionados($(this).attr('data-rep-id'));
		});

		$('.el-eliminar').click(function(){
			$buttton = $(this);
			if (confirm('¿Desea eliminar esta plantilla? \n Esta accion es irreversible')) { 
				var pk_plantilla = $(this).attr('data-rep-id');
				$.post('<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.borraPlantilla")#</cfoutput>', { pk_plantilla: pk_plantilla}, 
					function(data){
						if(data == 1){
							$buttton.closest('div.cont-reporte').remove();
						}
					}
				);
			}
		});	

		$( ".cont-reporte" ).draggable({
			revert: "invalid", 
			containment: ".wrapper-content",
			cursor: "move",	    
			zIndex:800,
			helper:function(event,ui){
				var element=$("<div></div>");
				return element.append($(this).html());
			}       
		});

		$(".contenedorDropAsociacion").droppable({
			accept: " .cont-reporte",
			activeClass: "dropActive",	
			drop: function( event, ui ) {
				var plantSelect = [];
				$('#asociacion').children('.cont-reporte').each(function(){
					plantSelect.push($(this).attr('data-rep-id'));	
				});
				if(plantSelect.length < 2){
					$(this).append(ui.draggable);
					ui.draggable.removeClass('col-md-6 ').addClass('col-md-12');
				} 
				else
					toastr.error('Error','Las sociaciones como máximo pueden tener 6 plantillas.');
			}
		});

		$(".contenedorDropPlantillas").droppable({
			accept: " .cont-reporte",
			//activeClass: "dropActive",	
			drop: function( event, ui ) {
				$(this).append(ui.draggable);
				ui.draggable.removeClass('col-md-12').addClass('col-md-6');
			}
		});       

		$('#bt-configuracion').click(function(){
			var nombres = '';
			$('#asociacion').children('.cont-reporte').each(function(){
				if(nombres == '')
					nombres = nombres + $(this).attr('name');
				else
					nombres = nombres + '-'+ $(this).attr('name');
			});
			var plantSelect = [];
			$('#asociacion').children('.cont-reporte').each(function(){
				plantSelect.push($(this).attr('data-rep-id'));	
			});
			if(plantSelect.length > 1){
				$('#cont-Allreportes').slideToggle( 1000,'easeOutExpo');
				$('#contAsociacion').slideToggle( 1000,'easeOutExpo');
			
				$.post('<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.vistaAsociarElementos")#</cfoutput>',{
					plantSelect:JSON.stringify(plantSelect),
					nombres:nombres
					}, 
					function(data){
						$('#divAsociacion').html( data );
					});
			}
			else
				toastr.error('Error','Al menos se deben asociar 2 plantillas');
		});
	})

	function cargarNuevo(){
		$.post('<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.nuevaPlantilla")#</cfoutput>', 
		   function(data){
				$('#divNuevaPlantilla').html( data );
		   });
	}

	function cargarEdicion(pkPlantilla){	
		$.post('<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.editarPlantilla")#</cfoutput>',{
			pkPlantilla:pkPlantilla
			},
		   function(data){
				$('#divEditarPlantilla').html( data );
		   });
	}

	function verFormatosRelacionados(pk_plantilla){
		$.post('<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.getFormatosRelacionados")#</cfoutput>', { pk_plantilla: pk_plantilla}, 
			function(data){
				datos = [];
				for( var k=0; data.ROWCOUNT > k ; k++){
				   datos.push({
					   id: data.DATA.PK_CATALOGOPLANTILLA[k],
					   tema: k+1,
					   formato: data.DATA.NOMBRE_FORMATO[k],  
					   claveFor: data.DATA.CLAVE_FORMATO[k],  
					   nomCol: data.DATA.NOMBRE_COLUMNA[k],  
					   actualizacion: data.DATA.FECHA_MODIFICACION[k]             
				   });
				}				
				$('#tblFormatosRel').bootstrapTable('load', datos);
				$('#modal-Formatos').modal('toggle');
			});
	}
</script>
