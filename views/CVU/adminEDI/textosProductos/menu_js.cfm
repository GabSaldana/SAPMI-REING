<!---
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      CVU edicion productos (copia menu CVU)
* Sub modulo:  -
* Fecha:       04 de diciembre de 2017
* Descripcion: Contenido js que sera usado por la vista de Menu
* Autor:       JLGC
* ================================
--->

<cfprocessingdirective pageEncoding="utf-8"/>

<script type="text/javascript">

	$(document).ready(function() {
		cargaClasificaciones();
		ocultaMenuDerecho();

		tinymce.init({
            selector: "textarea#inComent",
            language: 'es_MX',
            height: 250,
            resize: false,
            menubar: false,
            plugins: 'textcolor',
            toolbar: 'undo redo | bold italic | forecolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent',

            spellchecker_callback: function(method, data, success) {
                if (method == "spellcheck") {
                    var words = data.match(this.getWordCharPattern());
                    var suggestions = {};

                    for (var i = 0; i < words.length; i++) {
                        suggestions[words[i]] = ["First", "second"];
                    }

                    success({words: suggestions, dictionary: true});
                }

                if (method == "addToDictionary") {
                    success();
                }
            }
        });
	});

	/*MENU DERECHO*/
	function ocultaMenuDerecho(){
		$("#menuDerecho").css("display","none");
	}

	function muestraMenuDerecho(){
		$("#menuDerecho").css("display","");
	}

	function cargaClasificaciones(){
        $.post('<cfoutput>#event.buildLink("CVU.Productos.textosListaClasificacion")#</cfoutput>', {
        }, function(data) {
            $("#divClasificacion").html(data);
        });
	}

	function cargaSeleccion(pkproductop){
		muestraMenuDerecho();
		$.post('<cfoutput>#event.buildLink("CVU.productos.getTextosSeleccion")#</cfoutput>', {
			pkPadre: pkproductop,
			vista: 1
			}, 
			function(data){
				if(data==0)
					$('#divSeleccion').html('<div class="alert alert-info"><span class="fa fa-warning"></span> Para regresar a un nivel anterior seleccione una opción en el menu de la izquerda</div>');	
				else
					$('#divSeleccion').html(data);
			}
	    );	
	}

	function cargahistorial(pkPadrep){
		muestraMenuDerecho();
		$.post('<cfoutput>#event.buildLink("CVU.productos.textosCargahistorial")#</cfoutput>', {
			pkPadre: pkPadrep
			}, 
			function(data){
				$('#divFiltro').html( data );
			}
	    );	
	}
</script>