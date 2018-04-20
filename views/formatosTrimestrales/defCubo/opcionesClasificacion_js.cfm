<cfprocessingdirective pageEncoding="utf-8">

<script>

    $(document).ready(function() {

        $("#bx-clasif").hide();
        $("#bx-colDim").hide();
        $("#btn_hecho").hide();
        $("#btn_dim").hide();
        $("#indicaciones").hide();
        $(".cont-dimensiones").hide();
        $(".cnt-hechos").hide();

        $("#inDimension").change(function() {
            getcolumasDimension();
            $("#inClasificacion").val() > 0 ? $("#btn_dim").show() 
                                            : $("#btn_dim").hide();
        });

        $("#inDimensionUpdate").change(function() {
            getcolumasDimensionUpdate();
        });

        $("#inHecho").change(function() {
            $("#inHecho").val() > 0 ? $("#btn_hecho").show() 
                                    : $("#btn_hecho").hide();
        });

        $("#inClasificacion").change(function() {
            $("#inClasificacion").val() > 0 ? $("#btn_dim").show() 
                                            : $("#btn_dim").hide();
        });

    });


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene las columnas que pertenecen a una dimension.
    * --->
    function getcolumasDimension(){
        if ($("#inDimension").val() > 0){
            $.ajax({
                type:"POST",
                async:false,
                url:"<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getcolumasDimension")#</cfoutput>",
                data:{
                    pkDimension: $("#inDimension").val()
                },
                success:function(data){
                    $('#inColDim').empty();
                    $('#inColDim').append('<option value="0">Seleccione un atributo</option>');

                    for (var i = 0; i < data.ROWCOUNT ; i++ ){
                    	if(data.DATA.NOMCOL[i] == 'NOMBRE') {
                    		$('#inColDim').append($("<option selected></option>").attr("value",data.DATA.PKCOL[i]).text(data.DATA.NOMCOL[i]));
                    	} else {
                    		$('#inColDim').append($("<option></option>").attr("value",data.DATA.PKCOL[i]).text(data.DATA.NOMCOL[i]));
                    	}                       
                    }
                }
            });

            $("#bx-clasif").show();
            $("#bx-colDim").show();
        }else {
            $("#bx-clasif").hide();
            $("#bx-colDim").hide();
        }
    }



    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene las columnas que pertenecen a una dimension.
    * --->
    function getcolumasDimensionUpdate(){
        $.ajax({
            type:"POST",
            async:false,
            url:"<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getcolumasDimension")#</cfoutput>",
            data:{
                pkDimension: $("#inDimensionUpdate option:selected").val()
            },
            success:function(data){
                $('#inColDimUpdate').empty();
                $('#inColDimUpdate').append('<option value="0" selected="selected">Seleccione un atributo</option>');

                for (var i = 0; i < data.ROWCOUNT ; i++ ){
                		$('#inColDimUpdate').append($("<option></option>").attr("value",data.DATA.PKCOL[i]).text(data.DATA.NOMCOL[i]));
                }
            }
        });
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Asocia una columna con una dimension.
    * --->
    function asociaDimension(){
        var colms = JSON.parse($("#pksColumnas").val());
        if (colms.length > 0){
            $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.asociaDimensionColumna")#</cfoutput>',{
                    pkFormato:   $("#pksColumnas").val(),
                    pkDimension: $("#inDimension").val(),
                    pkColumna:   $("#inColDim").val(),
                    pkClasif:    $("#inClasificacion").val(),
                    pkCubo:      $("#pkCubo").val()
                },
                function(data){
                    if (data > 0){
                        toastr.success('asociadas correctamente', 'Columnas y dimension');
                    	columnaSeleccionada();
                    	 $(".actualizaDimension").modal('hide');
                    	document.getElementById("inDimensionUpdate").value = $("#inDimension").val(); 
                    	getcolumasDimensionUpdate();
                    	document.getElementById("inColDimUpdate").value = $("#inColDim").val();  
                    	document.getElementById("inClasificacionUpdate").value = $("#inClasificacion").val(); 
                    	document.getElementById("inDimension").value = 0;
                    	$("#bx-colDim").hide();  
                    	$("#bx-clasif").hide();
                    	$("#btn_dim").hide();
                    }else if (data == 0){
                        toastr.warning('Alguna de las columnas seleccionadas, fue previamente asociada.');
                    }
                }
            );
        }else {
            toastr.warning('Seleccione al menos una columna');
        }
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Asocia una columna con un hecho.
    * --->
    function asociaHecho(){
        var colms = JSON.parse($("#pksColumnas").val());
        if (colms.length > 0 && $("#inHecho").val() >0){
            $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.asociaColumnaHecho")#</cfoutput>',{
                    pkFormato: $("#pksColumnas").val(),
                    pkHecho:   $("#inHecho").val(),
                    pkCubo:    $("#pkCubo").val()
                },
                function(data){
                    if (data > 0){
                        toastr.success('Columnas asociadas exitosamente.');                
                        columnaSeleccionada();     
                        document.getElementById("inHechoUpdate").value = $("#inHecho").val();
                        document.getElementById("inHecho").value = 0;
                        $('#btn_hecho').hide();
                    }else if (data == 0){
                        toastr.warning('Alguna de las columnas seleccionadas, fue previamente asociada.');
                    }
                }
            );
        }else {
            toastr.warning('Seleccione al menos una columna');
        }
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Actualiza el registro de una columna asociada a un hecho
    * --->
    function actualizaHecho(){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.actualizaRelHecho")#</cfoutput>',{
                pkHecho: $("#inHechoUpdate").val(),
                pkHecoColumna: $("#pkHechoColm").val()
            },
            function(data){
                data > 0 ? toastr.success('Relación actualizada exitosamente.') : toastr.error('Error al actualizar relación.');
                $(".actualizaHecho").modal('hide');
            }
        );
    }


	 <!---
    * Fecha: Mayo 2017
    * Autor: Ana Belem Juarez Mendez
    * Descripcion: Desasocia un registro de una columna y un hecho
    * --->
    function desasociarHecho(){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.desasociarHecho")#</cfoutput>',{
                pkHecoColumna: $("#pkHechoColm").val()
            },
            function(data){
                data > 0 ? toastr.success('Métrica desasociada exitosamente.') : toastr.error('Error al desasociar métrica.');
                $(".actualizaHecho").hide();                       
       		    $(".cnt-hechos").show();
            }
        );
    }
    
    
    <!---
    * Fecha: Mayo 2017
    * Autor: Ana Belem Juarez Mendez
    * Descripcion: Desasocia una dimensión de una columna
    * --->
    function desasociarDimension(){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.desasociarDimension")#</cfoutput>',{              
                pkRelCols:   $("#pkDimCols").val()
            },
            function(data){
                data > 0 ? toastr.success('Dimensión desasociada exitosamente.') : toastr.error('Error al desasociar dimensión.');
                $(".actualizaDimension").hide();
                $(".cont-dimensiones").show();
            }
        );
    }

    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Actualiza el registro de una columna asociada a una dimensión
    * --->
    function actualizaDimension(){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.actualizaRelDimension")#</cfoutput>',{
                pkCubo:      $("#pkCubo").val(),
                pkDimension: $("#inDimensionUpdate").val(),
                pkColDim:    $("#inColDimUpdate").val(),
                pkClasif:    $("#inClasificacionUpdate").val(),
                pkRelCols:   $("#pkDimCols").val()
            },
            function(data){
                data > 0 ? toastr.success('Relación actualizada exitosamente.') : toastr.error('Error al actualizar relación.');
                $(".actualizaDimension").modal('hide');
            }
        );
    }


</script>
