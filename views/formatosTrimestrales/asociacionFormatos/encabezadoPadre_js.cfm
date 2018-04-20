<cfprocessingdirective pageEncoding="utf-8">
<script>

    $(document).ready(function() {

        tl.pg.init({
             "pg_caption": "Gu&#237;a",
              "auto_refresh": true ,
              "default_zindex":9999,
              "custom_open_button":'#guiaPaginaActual'
        });

        $("#tabla_promds").bootstrapTable();

        function getIndex(value, row, index) {
            return index+1;
        }

        $('.skin-4').removeAttr('style');

        $("#arrayFormatos").val('<cfoutput>#prc.formatos#</cfoutput>');

        <cfif #prc.plantillaSelect# NEQ 0>
            $("#pkplantilla").val('<cfoutput>#prc.plantillaSelect#</cfoutput>');
        </cfif>///
        
        $("#mdl-promedios").modal();

        obtenerElementosRegistrados();

        colOrigen = $("#columnaOrigen").val();

        $('#'+colOrigen+'').prop("checked", "checked");

    });


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Establece el pk de la columa seleccionada y trae las posibles asociaciones de columnas
    * --->
    function setColOrigen(pkCol){
        $("#columnaOrigen").val(pkCol);
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.getTabla")#</cfoutput>', {
                pkColumnaOrigen: $("#columnaOrigen").val(),
                pkAsociacion: $("#pkNombreAsociacion").val()
            }, 
            function(data){
                $("#box-asociaColumnas").show();
                $('#tabla').html(data);
            }
        );
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Registra una nueva relacion de columnas o actualiza una existente.
    * --->
    function relacionaColumna(pkCol, pkFormato){
        
        if ( $("#columnaOrigen").val() >= 1 ){
            $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.setRelacionColumnas")#</cfoutput>',{
                pkOrigen: $("#columnaOrigen").val(),
                pkAsociado: pkCol,
                pkFormato: pkFormato
                },
                function(data){
                    if (data >= 1){
                        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.getTabla")#</cfoutput>', {
                                pkColumnaOrigen: $("#columnaOrigen").val(),
                                pkAsociacion: $("#pkNombreAsociacion").val()
                            }, 
                            function(data){
                                $("#box-asociaColumnas").show();
                                $('#tabla').html(data);
                            }
                        );
                        toastr.success('Relacionada correctamente','Columna');
                    }
                }
            );
        }else {
            toastr.warning(' ','Seleccione columna a asociar');
        }
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene los elementos de plantilla asociados a un formato
    * --->
    function obtenerElementosRegistrados(){
        <cfif #prc.plantillaSelect# NEQ 0>
            $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.getElementosByPlantilla")#</cfoutput>', {
                    pkPlantilla: $("#pkplantilla").val()
                }, 
                function(data){

                    var formatos = JSON.parse($("#arrayFormatos").val());
                    var select = '<option value="0" selected disabled>Seleccione la clasificaci&oacute;n del formato</option>';

                    for (var i = 0; i < data.ROWCOUNT; i++){
                        select = select +'<option value="' + data.DATA.ELEMENTO[i] +'">' + data.DATA.ELEMENTO[i] + '</option>';
                    }

                    for (var j = 1; j < formatos.length; j++){
                        var selecto = '<div class="col-sm-5"><label style="text-align:right;" class="control-label">Seleccione la clasificaci&oacute;n para el formato</label><div class="input-group"><span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span></span><select class="clasFmt form-control m-b '+formatos[j]+'" data-style="btn-primary btn-outline' + formatos[j] +'" onchange="guardaElemento(' + formatos[j] + ');">' + select + '</select></div></div><br><br><br><br>';

                        $('#'+formatos[j]+'').empty();
                        $('#'+formatos[j]+'').append(selecto);
                    }

                    <cfloop from="1" to="#prc.valorElementos.recordcount#" index="i">
                        <cfloop from="1" to="#ArrayLen(prc.pkFormato)#" index="j">
                            <cfif #prc.valorElementos.PKFORMATO[i]# EQ #prc.pkFormato[j]#>
                                $('.'+'<cfoutput>#prc.pkFormato[j]#</cfoutput>'+'').val('<cfoutput>#prc.valorElementos.VALORELEMENTO[i]#</cfoutput>');
                            </cfif>///
                        </cfloop>///
                    </cfloop>///
                }
            );
        </cfif>///
        <cfif not #IsArray(prc.promedio)#>
            $('.modal-backdrop').remove();
        </cfif>///
        $('#mdl-cubrir').modal('hide');
        $('.cargandoDiv').remove();
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Obtiene los elementos de plantilla para asociar a un formato
    * --->
    function obtenerElementosPlantilla(){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.getElementosByPlantilla")#</cfoutput>', {
                pkPlantilla: $("#pkplantilla").val()
            },
            function(data){

                var formatos = JSON.parse($("#arrayFormatos").val());
                var select = '<option value="0" selected disabled>Seleccione la clasificaci&oacute;n del formato</option>';

                for (var i = 0; i < data.ROWCOUNT; i++){
                    select = select +'<option value="' + data.DATA.ELEMENTO[i] +'">' + data.DATA.ELEMENTO[i] + '</option>';
                }

                for (var j = 1; j < formatos.length; j++){
                    var selecto = '<div class="col-sm-5"><label style="text-align:right;" class="control-label">Seleccione la clasificaci&oacute;n para el formato</label><div class="input-group"><span class="input-group-addon"><span class="glyphicon glyphicon-tag"></span></span><select class="clasFmt form-control m-b '+formatos[j]+'" data-style="btn-primary btn-outline' + formatos[j] +'" onchange="guardaElemento(' + formatos[j] + ');">' + select + '</select></div></div><br><br><br><br>';

                    $('#'+formatos[j]+'').empty();
                    $('#'+formatos[j]+'').append(selecto);
                }
            }
        );
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Guarda el elemento que se asocia a un formato
    * --->
    function guardaElemento(pkFormato){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.guardaClasificacionFormato")#</cfoutput>', {
                pkFormato: pkFormato,
                pkPlantilla: $("#pkplantilla").val(),
                clasificacion: $('#'+pkFormato+' option:selected').text(),
                pkNombreAsociacion: $("#pkNombreAsociacion").val()
            }, 
            function(data){
                if (data >= 1){
                    toastr.success('clasificado correctamente', 'Formato');
                }
            }
        );
    }


    <!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Cambia el estado de la asociacion de las columnas.
    * --->
    function desasociaColumna(pkColumna, pkFormato){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.cambiaEdoAsocColumns")#</cfoutput>', {
                pkColOrigen: $("#columnaOrigen").val(),
                pkColAsociada: pkColumna,
                pkFormato: pkFormato
            },
            function(data){
                if (data > 0){
                    cambiaEstiloDesasociacion(pkColumna, pkFormato);
                    toastr.success('desasociada exitosamente', 'Columna');
                    $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.getTabla")#</cfoutput>', {
                            pkColumnaOrigen: $("#columnaOrigen").val(),
                            pkAsociacion: $("#pkNombreAsociacion").val()
                        },
                        function(data){
                            $("#box-asociaColumnas").show();
                            $('#tabla').html(data);
                        }
                    );
                }else {
                    toastr.success('al desasociar columna', 'Error');
                }
            }
        );
    }


    <!---
    * Fecha: Abril 2017
    * Autor: Alejandro Tovar
    * Descripcion: Cambia el estado de la columna desasociada.
    * --->
    function cambiaEstiloDesasociacion(pkColumna, pkFormato){
        $('#'+ pkColumna +'').toggleClass('fa-dot-circle-o fa-circle-o');
        $('#'+ pkColumna +'').parent().removeAttr('onclick');
        $('#'+ pkColumna +'').parent().attr('onclick','relacionaColumna('+pkColumna + ',' + pkFormato+ ')');
        $('#'+ pkColumna +'').parent().removeAttr('style');
        $('#'+ pkColumna +'').parent().attr('style', 'background-color:#43AAFF;');
        $('#'+ pkColumna +'').parent().parent().removeAttr('style');
        $('#'+ pkColumna +'').parent().parent().attr('style', 'background-color:#43AAFF;');
    }


    <!---
    * Fecha: Marzo 2017
    * Autor: Alejandro Tovar
    * Descripcion: Resetea clasificaciones de los formatos
    * --->
    function resetClasifiaciones(){
        if (confirm("Si cambia la plantilla se perderá la clasificación de los formatos, y deberá clasificar nuevamente")){
            $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.resetClasifiacion")#</cfoutput>', {
                    pkNombreAsociacion: $("#pkNombreAsociacion").val(),
                    pkPlantilla: $("#pkplantilla").val()
                }, 
                function(data){
                    if (data >= 1){
                        toastr.success('Realice la clasificacion de los formatos', '');
                        obtenerElementosPlantilla();
                    }
                }
            );
        }else {
            $("#pkplantilla").val('<cfoutput>#prc.plantillaSelect#</cfoutput>');
        }
    }



</script>
