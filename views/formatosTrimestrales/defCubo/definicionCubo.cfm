<cfprocessingdirective pageEncoding="utf-8">

<div class="panel panel-default">
    <div class="panel-heading">
        Definición del cubo: <strong><cfoutput>#prc.infoCubo.NOMBRECUBO[1]# - #prc.infoCubo.PREFIJO[1]#</cfoutput></strong>
        <i id="btn-cerrarTablaFormato" class="btn btn-default btn-xs pull-right" onclick="muestraFotmatos();" title="Cerrar" style="font-size: 20px;"><i class="fa fa-times"></i></i>

        <cfif #prc.infoCubo.CREADO[1]# EQ 1>
            <i class="btn btn-default btn-xs pull-right valid" title="Cubo validado" style="font-size: 20px;"><i class="fa fa-lock"></i></i>
        <cfelse>
            <i class="btn btn-default btn-xs pull-right unValid" onclick="validaCubo();" title="Validar cubo" style="font-size: 20px;"><i class="fa fa-unlock"></i></i>
        </cfif>
        <br><br>
    </div>

    <div class="panel-body">
        <div class="row">
            <div id="addDimensiones" class="col-md-6">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div align="center">
                            <strong>Dimensiónes</strong>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="list-group">
                            <cfloop index="x" from="1" to="#prc.dimensionesAsociadas.recordcount#">
                                <cfoutput>
                                    <a id="#prc.dimensionesAsociadas.PKDIMENSION[x]#" name="#prc.dimensionesAsociadas.NOMBREDIMENSION[x]#" onclick="getcolumasDimensionAdd(this);">
                                        <div class="list-group-item">
                                            <span>#prc.dimensionesAsociadas.NOMBREDIMENSION[x]#</span>
											<span class="pull-right"> 
                                        		<button class="btn btn-xs btn-danger borrar delDim" onclick="verificarAsociacionDimension(<cfoutput>#prc.dimensionesAsociadas.PKDIMENSION[x]#</cfoutput>);">											
													<span class="fa fa-trash"></span>
                                        		</button>
                                    		</span>
                                        </div>
                                    <a>
                                </cfoutput>
                            </cfloop>        
                        </div>

                        <div class="row">
                            <div class="col-md-6"> 
                                <button id="asociaDimen" type="button" class="btn btn-block btn-primary" data-toggle="modal" href="#mdl-Asocia-dimen"><span class="fa fa-paperclip"></span> Asociar dimensión</button>
                            </div>
                            <div class="col-md-6">
                                <button id="agregaDimen" type="button" class="btn btn-block btn-primary" data-toggle="modal" href="#mdl-Add-dimen"><span class="fa fa-plus"></span> Agregar dimensión</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="addColumns" class="col-md-4">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <div class="cabeceraColumna" align="center">
                            Atributos de la dimension <strong></strong>
                            <i class="btn btn-xs pull-right" onclick="ocultaColumnas();" title="Cerrar"><i class="fa fa-times"></i></i>
                        </div>

                        <input id="dimenSelected" type="hidden">
                    </div>
                    <div class="panel-body">

                        <div class="list-group"> </div>
                    </div>
                </div>
            </div>

            <div id="addHechos" class="col-md-6">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div align="center">
                            <strong>Métricas</strong>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="list-group">
                            <cfloop index="x" from="1" to="#prc.hechos.recordcount#">
                                <div class="list-group-item clearfix"><span class="elemento"><cfoutput>#prc.hechos.NOMBREHECHO[x]#</cfoutput></span>
                                    <span class="pull-right"> 
                                        <button class="btn btn-xs btn-danger borrar delHec" onclick="cambiaEstadoHecho(<cfoutput>#prc.hechos.PKHECHO[x]#</cfoutput>);">
                                            <span class="fa fa-trash"></span>
                                        </button> 
                                    </span>
                                </div>
                            </cfloop>    
                        </div>
                        <div style="width:75%; margin-left:14%"> 
                            <button id="agregaHecho" type="button" class="btn btn-block btn-primary" data-toggle="modal" href="#mdl-Add-hecho"><span class="fa fa-plus"></span> Agregar métrica</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal animated fadeIn" id="mdl-Add-dimen" tabindex="-1" role="dialog" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Nueva dimensión</h4>
            </div>
            <div class="modal-body">
                <div>
                    <label class="control-label">Nombre de la dimensión</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <input type="text" id="nombreDimen" class="form-control" placeholder="Ingresar nombre de dimensión" onkeyup="this.value=this.value.replace(' ', '_')" maxlength="27"/>
                    </div>                  
                </div>
            </div>
            <div class="modal-footer ">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cerrar</button>
                <button class="btn btn-success btn-lg pull-right" onclick="guardaDimension();"><span class="fa fa-check"></span> Guardar</button>
            </div>
        </div>
    </div>
</div>


<div class="modal animated fadeIn" id="mdl-Asocia-dimen" tabindex="-1" role="dialog" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Asociar dimensión a cubo</h4>
            </div>
            <div class="modal-body">
                <div>
                    <label class="control-label">Dimensión</label>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <span class="fa fa-tag"></span>
                        </span>
                        <select id="dimensionAsociar" class="form-control">     
                            <option value="0" selected="selected">Seleccione una dimensión</option>
                            <cfset total_records = prc.dimensiones.recordcount/>
                            <cfloop index="x" from="1" to="#total_records#">
                                <cfoutput><option value="#prc.dimensiones.PKDIMENSION[x]#" >#prc.dimensiones.NOMBREDIMENSION[x]#</option></cfoutput>
                            </cfloop>
                        </select>
                    </div>
                </div>
            </div>
            <div class="modal-footer ">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cerrar</button>
                <button class="btn btn-success btn-lg pull-right" onclick="asociaDimensionCubo();"><span class="fa fa-check"></span> Asociar</button>
            </div>
        </div>
    </div>
</div>



<script>

    $(document).ready(function() {

        $("#addColumns").hide();

        <cfif #prc.infoCubo.CREADO[1]# EQ 1>
            $("#agregaDimen").hide();
            $("#asociaDimen").hide();
            $("#agregaColna").hide();
            $("#agregaHecho").hide();
            $(".borrar").hide();
        </cfif>///
        

    });


    <!---
     * Autor: Alejandro Tovar
    * Descripcion: Oculta panel de columnas.
    * --->
    function ocultaColumnas(){
        $("#addColumns").hide();
        $("#addDimensiones").removeClass('col-md-4').addClass('col-md-6');
        $("#addHechos").removeClass('col-md-4').addClass('col-md-6');
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Asocia una dimension al cubo.
    * --->
    function asociaDimensionCubo(){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.asociaDimensionCubo")#</cfoutput>',{
                pkDimension: $("#dimensionAsociar").val(),
                pkCubo: $("#pkCubo").val()
            },
            function(data){
                if(data > 0){
                    toastr.success('asociada exitosamente', 'Dimensión');
                    $('#addDimensiones .list-group').append('<a onclick="getcolumasDimensionAdd('+ $("#dimensionAsociar").val() +');"><div class="list-group-item clearfix"><span>'+ $("#dimensionAsociar option:selected").text() +'</span><span class="pull-right"><button class="btn btn-xs btn-danger borrar delDim" onclick="verificarAsociacionDimension('+ $("#dimensionAsociar").val() +');"><span class="fa fa-trash"></span></button></span></div></a>');                           
                    $("#dimensionAsociar").val('0');
                    $("#mdl-Asocia-dimen").modal('hide');                   
                }
            }
        );
    }

    <!---
    * Fecha: Mayo 2017
    * Autor: Ana Belem Juarez Mendez
    * Descripcion: Verifica si la dimensión esta asociada a algun formato del cubo.
    * --->
    function verificarAsociacionColumna(pkColumna){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.existeAsociacionColumna")#</cfoutput>',{
                pkColumna: pkColumna
            },
            function(data){
                if (data){
                    toastr.warning('', 'La columna está asociada, no se puede eliminar.');
                }else {
                    eliminarColumna(pkColumna);
                }     
            }
        );
    }

    <!---
    * Fecha: Mayo 2017
    * Autor: Ana Belem Juarez Mendez
    * Descripcion: Verifica si la dimensión esta asociada a algun formato del cubo.
    * --->
    function verificarAsociacionDimension(pkDimension){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.existeAsociacionDimension")#</cfoutput>',{
                pkCubo: $("#pkCubo").val(),
                pkDimension: pkDimension
            },
            function(data){
                if (data){
                    toastr.warning('', 'La dimensión está asociada, no se puede eliminar.');
                }else {
                    eliminarDimension( pkDimension);
                }     
            }
        );
    }

    <!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Borra un hecho.
    * --->
    function cambiaEstadoHecho(pkHecho){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.existeAsociacionHecho")#</cfoutput>',{
                pkHecho: pkHecho
            },
            function(data){
                if (data){
                    toastr.warning('', 'La métrica está asociada, no se puede eliminar.');
                }else {
                    borraHecho(pkHecho);
                }     
            }
        );
    }

   <!---
    * Fecha: Mayo 2017
    * Autor: Ana Belem Juarez Mendez
    * Descripcion:Borra una columna de una dimension.
    * --->
    function eliminarColumna(pkColumna){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.eliminarColumna")#</cfoutput>',{
                pkColumna: pkColumna
            },
            function(data){
                if (data > 0){
                    toastr.success('', 'Columna eliminada exitosamente.');
                    obtenerDefinicion($("#pkCubo").val());
                }else {	
                    toastr.error('', 'Error al eliminar columna.');
                }      
            }
        );
    } 

    <!---
    * Fecha: Mayo 2017
    * Autor: Ana Belem Juarez Mendez
    * Descripcion: Desasocia la dimensión con el cubo.
    * --->
    function eliminarDimension(pkDimension){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.desasociarCuboDimension")#</cfoutput>',{
                pkCubo: $("#pkCubo").val(),
                pkDimension: pkDimension
            },
            function(data){
                if (data > 0){
                    toastr.success('', 'Dimensión eliminada exitosamente.');
                    obtenerDefinicion($("#pkCubo").val());
                    $("#inDimension option[value="+pkDimension+"]").remove(); 
                    $("#inDimensionUpdate option[value="+pkDimension+"]").remove(); 
                }else {	
                    toastr.error('', 'Error al eliminar dimension.');
                }      
            }
        );
    } 

    <!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Borra un hecho.
    * --->
    function borraHecho(pkHecho){

        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.cambiaEstadoHecho")#</cfoutput>',{
                pkHecho: pkHecho
            },
            function(data){
                if (data > 0){
                    toastr.success('', 'Métrica eliminada exitosamente.');
                    obtenerDefinicion($("#pkCubo").val());
                     $("#inHechoUpdate option[value="+pkHecho+"]").remove(); 
                     $("#inHecho option[value="+pkHecho+"]").remove();                         
                }else {
                    toastr.success('', 'Error al eliminar métrica.');
                }      
            }
        );
    } 


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene las columnas que pertenecen a una dimension.
    * --->
    function getcolumasDimensionAdd(pkDimension){
        var pkDimen = $(pkDimension).attr('id');
        $.ajax({
            type:"POST",
            async:false,
            url:"<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.getcolumasDimension")#</cfoutput>",
            data:{
                pkDimension: pkDimen
            },
            success:function(data){
                $('#addColumns .cabeceraColumna strong').text($(pkDimension).attr('name'));
                $('#addColumns .list-group').empty();

                for (var i = 0; i < data.ROWCOUNT ; i++ ){
                    <cfif #prc.infoCubo.CREADO[1]# EQ 1>
                        $('#addColumns .list-group').append('<div class="list-group-item clearfix"><span>'+ data.DATA.NOMCOL[i]+'</span><span class="pull-right"></span></div>');
                    <cfelse>
                        $('#addColumns .list-group').append('<div class="list-group-item clearfix"><span>'+ data.DATA.NOMCOL[i]+'</span><span class="pull-right"></span></div>');
                    </cfif>///
                }

                $("#addColumns").show();
                $("#addDimensiones").removeClass('col-md-6').addClass('col-md-4');
                $("#addHechos").removeClass('col-md-6').addClass('col-md-4');
                $("#dimenSelected").val(pkDimen);
            }
        });
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Guarda el nombre del hecho.
	* -------------------------------
    * Descripcion de la modificacion:  Modificación para guardar null en tipo de hecho.
    * Fecha de la modificacion: 23/05/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
	* -------------------------------
    * --->
    function guardaHecho(){
      var tipoHe = "";
      if(validarInput( $("#nombreHecho"))){
    	 $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.guardaHecho")#</cfoutput>',{
                nombreHecho: $("#nombreHecho").val(),
                tipoHecho:   tipoHe,
                pkCubo:      $("#pkCubo").val()
            },
            function(data){
                if (data > 0){
                    toastr.success('Agregada exitosamente', 'Métrica');
                    $('#addHechos .list-group').append('<div class="list-group-item clearfix"><span>'+ $("#nombreHecho").val() +'</span><span class="pull-right"><button class="btn btn-xs btn-danger borrar delHec" onclick="cambiaEstadoHecho('+ data +');"><span class="fa fa-trash"></span></button></span></div>');

                    $('#inHecho').append('<option value="' + data + '" >'+ $("#nombreHecho").val() +'</option>');
                    $('#inHechoUpdate').append('<option value="' + data + '" >'+ $("#nombreHecho").val() +'</option>');
                    $("#btn_hecho").show();
                    $("#mdl-Add-hecho").modal('hide');
                    $("#nombreHecho").val('');
                }
            }
        );	
      }    
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Guarda columna asociada a una dimensión.
	* -------------------------------
    * Descripcion de la modificacion:  Modificación para guardar null en tipo de columna.
    * Fecha de la modificacion: 23/05/2017
    * Autor de la modificacion: Ana Belem Juarez Mendez
	* -------------------------------
    * --->
    function guardaColumnaDim(){
    	var inTipoCol = "";
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.clasifDefCubo.guardaColDim")#</cfoutput>',{
                nombreCol: $("#inNombreCol").val(),
                tipoCol:   inTipoCol,
                descrCol:  $("#inDescCol").val(),
                pkDimens:  $("#dimenSelected").val()
            },
            function(data){
                if (data > 0){
                    toastr.success('Guardada exitosamente', 'Columna');

                    $('#addColumns .list-group').append('<div class="list-group-item clearfix"><span>'+ $("#inNombreCol").val() +'</span><span class="pull-right"></span></div>');

                    $("#mdl-Add-colDim").modal('hide');

                    var valDimUno = $("#inDimension").val();
                    var valDimTres = $("#inDimensionUpdate").val();

                    if( valDimUno == $("#dimenSelected").val() ){
                        $('#inColDim').append('<option value="' + data + '" selected="selected">'+ $("#inNombreCol").val() +'</option>');
                    }

                    if( valDimTres == $("#dimenSelected").val() ){
                        $('#inColDimUpdate').append('<option value="' + data + '" selected="selected">'+ $("#inNombreCol").val() +'</option>');
                    }

                    $("#inNombreCol").val('');
                    $("#inDescCol").val('');
                }
            }
        );
    }


</script>
