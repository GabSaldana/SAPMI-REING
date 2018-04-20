<cfprocessingdirective pageEncoding="utf-8">
<cfoutput>
    <script type="text/javascript">

        function addTitulo(num){
            var datos = $('##' + num).bootstrapTable('getData');
            var textIn = [];
            $.each(datos, function(i, value) {
                if(value.tipo == 3) {
                    textIn.push({indice:i, id:value.id});
                }
            });
            for (var i = 0; i < textIn.length ; i++) {
                desc = $('##' + num).bootstrapTable('getRowByUniqueId', textIn[i].id)
                $('##' + num).bootstrapTable('insertRow', { index: textIn[i].indice+i, row: {
                        id: '0',
                        tipo: '0',
                        aspecto: desc.escala,
                        escala: 'x',
                        observacion: '-'
                    }
                });
            }
            $.each(datos, function(index, value) {
                if(value.tipo == 0 || value.tipo == 3) {
                    $('##' + num).bootstrapTable('mergeCells', {
                        index: index,
                        field: 'aspecto',
                        colspan: 3
                    });
                }
            });
        }
		<!---
		Fecha: 8 de junio de 2016
		Autor: Ing. Víctor Manuel Mazón Sánchez
		8-Se separa la función del document,ready para manejarla más facilmente
		9-Se cambia la manera en la que recupera la información de la vista
		10-Se le agrega que se lleve los campos de PK para cuando sea necesario hacer un update
		--------------------------
		--->
		function guardarEvaluacion(){
			var estadoDestino=$('##pkEstadoCursoEvaluacion').val();
			var evaluacion =[];
			$("[name=pkAspecto]").each(function(index,item1){
				evaluacion[index]={pk: $("##pk"+this.value).val(), aspecto: this.value, escala: $("##aspecto"+this.value).val(), obs: $("##obs"+this.value).val()};});
			$.ajax({
				url: '<cfoutput>#event.buildLink("adminCSII.evaluacion.evaluacion.guardarEncuesta")#</cfoutput>',
				type: 'POST',
				dataType: 'json',
				data: {pkusuarioEval:#prc.pkusuarioEval#, participante: #Session.cbstorage.usuario.PK#, eval: 1, estado:estadoDestino, data:JSON.stringify(evaluacion)},
				error: function(){alert(this.data)}
			}).done(function(data) {
				toastr.success('Guardada exitosamente.','Evaluación');
				//$('##modal-evaluacion').modal('toggle');
				//	$("##modal-evaluacion").modal();
				if($("##pkParticipante").val() != undefined){
					getTablaEvaluarAcc();
				}
			}).fail(function() {
			    alert( "error" );
			  })
		
		}

		<!---
		Fecha: 8 de junio de 2016
		Autor: Ing. Víctor Manuel Mazón Sánchez
		Se crea la función de Terminar evaluación
		--->	

		function terminarEvaluacion(){
			if(!validarTodos()){
				// alert('Para concluir la evaluación debe seguir las indicaciones arriba descritas');
				return;			
			}
			$('##pkEstadoCursoEvaluacion').val(2);
			guardarEvaluacion();
			$('##modal-evaluacion').modal('toggle');		
		}
		
		
        $(document).ready(function() {
		
            $('.tabla_seccion').bootstrapTable();
            $('.tabla_seccion').bootstrapTable('hideColumn', 'id');
            $('.tabla_seccion').bootstrapTable('hideColumn', 'tipo');

            $(".tabla_seccion").each(function(){
                addTitulo($(this).attr('id'));
            });

			$('select.obligatorio').change(function() {
			  validarSelect(this);
			});
            $('.btn-guardar').unbind("click");
            $('.btn-terminar').unbind("click");			

            $('.btn-guardar').click(guardarEvaluacion);
            $('.btn-terminar').click(terminarEvaluacion);			
			
			

        });

</cfoutput>
		<!---
		* Fecha : 10 de Agosto de 2016
		* Autor : Alejandro Tovar
		* Comentario: Llenado de tabla para evaluación de acciones formativas en registro de participantes.
		--->
		function getTablaEvaluarAcc(){
			$.post('/index.cfm/cursos/participantes/cargarTablaEvaluarAcc', {
				pkParticipante: $("#pkParticipante").val()
				}, function(data){
				$('#contenidoTablaEvaluarAcc').html(data);
			});
		}

    </script>
