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
			$('.cont-reporte').hide();
			/*muestra todos los que contengan el texto*/
			$('.el-nombre').each(function(){
				if($(this).text().includes(texto)){
					$(this).parents().show();
				}
			});
			$('.el-cont-desc').each(function(){
				if($(this).text().includes(texto)){
					$(this).parents().show();
				}
			});
		});

		$('#tablaFormatos').bootstrapTable();
		
		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: Carga el reporte seleccionado
		* --->
		$(document).on('click', '.reporte', function() {
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
		$(document).on('click', '.bt-cerrar-captura', function() {
			$('#cont-Allreportes').slideToggle( 1000,'easeInExpo');
			$(this).parent().parent().slideToggle( 1000,'easeInExpo');
		});	
		<!---
		* Fecha      : Diciembre 2016
		* Autor      : Marco Torres
		* Descripcion: Carga la vista para generar reportes nuevos
		* --->
		$(document).on('click', '.buscarAsociados', function() {
			verFormatosRelacionados($(this).attr('data-rep-id'));
		});	

		$(document).on('click', '.copiar', function() {
			$('#modal-Copia').modal('toggle');
			document.getElementById("num").value = ($(this).data('repid'));
			document.getElementById("nombre").value = ($(this).data('nombre') + 'Copia');			
		});			

		$(document).on('click', '.eliminar', function() {
			$buttton = $(this);
			if (confirm('La siguente plantilla se eliminará permanetemente \n¿Desea eliminar esta plantilla?')) { 
				var pk_plantilla = $(this).attr('data-rep-id');
				$.post('<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.borraPlantilla")#</cfoutput>', { pk_plantilla: pk_plantilla}, 
					function(data){
						window.location="<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.index")#</cfoutput>";
					}
				);
			}
		});		
	})
	function guardaCopia(num, nombre){
		if(nombre.value.length < 1)
			toastr.error('Error','No se ingresó nombre a la plantilla');
		else{
			$.post('<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.copiarPlantilla")#</cfoutput>', {
				pkPlantilla:num.value,
				nombre:nombre.value
			},
			function(data){
				window.location="<cfoutput>#event.buildLink("formatosTrimestrales.plantillas.index")#</cfoutput>";
			});
		}
	}

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
			}
		);
	}	   
</script>
