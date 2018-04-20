<!---
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Administracion de catalogo de revistas
* Fecha:       13 de diciembre de 2017
* Descripcion: Contenido js que sera usado por la vista
* Autor:       JLGC    
* ================================
--->

<cfprocessingdirective pageEncoding="utf-8">

<script type="text/javascript">  

    <!--- 
    * Descripcion:    Llena contenidoTablaRevistas
    * Fecha creacion: 13 de diciembre de 2017
    * @author:        JLGC
    --->
    function getTablaRevistas() {
        $.post('<cfoutput>#event.buildLink("CVU.productos.cargarTablaRevistas")#</cfoutput>', {
             pais:      $("#ddlPais").val(),
             editorial: $("#ddlEditorial").val()
        }, function( dataTabla ) {
            $("#contenidoTablaRevistas").html( dataTabla );
        });
    }

    <!--- 
    * Descripcion:    Llena contenidoTablaNivel
    * Fecha creacion: 18 de diciembre de 2017
    * @author:        JLGC
    --->
    function getTablaNiveles(PkRevista) {
        $.post('<cfoutput>#event.buildLink("CVU.productos.getTablaNivelesByRevista")#</cfoutput>', {
             PkRevista: PkRevista
        }, function( dataTabla ) {
            $("#contenidoTablaNivel").html( dataTabla );
        });
    }

    function getSelectPais(txtEditorial) {
        $.post('<cfoutput>#event.buildLink("CVU.productos.obtenerEditoriales")#</cfoutput>', {
            pais: $("#ddlPais").val()
        }, function(data) {
            $("#ddlEditorial").empty();
            for( var i = 0; i < data.ROWCOUNT ; i++ ) {   
                $("#ddlEditorial").append($("<option></option>")
                   .attr("value",data.DATA.EDITORIAL[i])
                   .text(data.DATA.EDITORIAL[i])); //data.DATA.TOTEDITORIAL[i] + '. ' + 
            }
            if (txtEditorial != null) $("#ddlEditorial").val(txtEditorial);
            getTablaRevistas();
            $('#ddlPais.selectpicker').selectpicker('refresh');
            $('#ddlEditorial.selectpicker').selectpicker('refresh');
        });
    }

    function limpiaFormulario() {
        $("#formRevista")[0].reset();
        $(".form-control").removeClass('error');
    }

    function validarRevista() {
        var validar = $("#formRevista").validate({
            rules: {
                inISSN:      {required: true},
                inNombre:    {required: true, nombre: true},
                inEditorial: {required: true, nombre: true}
            },
            errorPlacement: function (error, element) {
                error.insertAfter($(element).parent());
            },
            submitHandler: function(form){
                return false;
            }
        }); 
        return validar.form();
    }

    function agregarRevista() {
        if(validarRevista()) {
            var ISSN      = $("#inISSN").val();
            var Nombre    = $("#inNombre").val();
            var Editorial = $("#inEditorial").val();
            var Pais      = $("#ddlInPais").val();

            $.post('<cfoutput>#event.buildLink("CVU.productos.agregarRevista")#</cfoutput>', {
                Nombre:    Nombre,
                Editorial: Editorial,
                Pais:      Pais,
                ISSN:      ISSN
            }, function(data) {
                $("#mdl-admon-revista").modal('hide');
                if ($.isNumeric(data)  && data > 0) {
                    swal("La revista se agrego con exito", null, "success");
                    $("#ddlPais").val(Pais);
                    getSelectPais(Editorial);
                }
                else {
                    swal("Error al agregar la revista", null, "error");
                }
            });
        }
    }

    function editarRevista(PkRevista) {
        if(validarRevista()) {
            var PkRevista = PkRevista;
            var Nombre    = $("#inNombre").val();
            var Editorial = $("#inEditorial").val();
            var Pais      = $("#ddlInPais").val();
            var ISSN      = $("#inISSN").val();

            $.post('<cfoutput>#event.buildLink("CVU.productos.editarRevista")#</cfoutput>', {
                PkRevista: PkRevista,
                ISSN:      ISSN,
                Nombre:    Nombre,
                Editorial: Editorial,
                Pais:      Pais
            }, function(data) {
                $("#mdl-admon-revista").modal('hide');
                if ($.isNumeric(data)  && data > 0) {
                    swal("La revista se edito con exito", null, "success");
                    $("#ddlPais").val(Pais);
                    getSelectPais(Editorial);
                }
                else {
                    swal("Error al editar la revista", null, "error");
                }
            });

        }
    }

    function guardaRevista() {
        PkRevista = $("#hfPkRevista").val();
        if (PkRevista == "0") {
            agregarRevista();
        }
        else {
            editarRevista(PkRevista);
        }
    }
 
    $.validator.addMethod("valueNotEquals", function(value, element, arg){ return arg !== value;  });

    function validarNivel() {
        var validar = $("#formNivel").validate({
            rules: {
                ddlInAnio:  {valueNotEquals: "0"},
                ddlInNivel: {valueNotEquals: "0"}
            },
            messages: {
                ddlInAnio:  {valueNotEquals: "Debe seleccionar el año"},
                ddlInNivel: {valueNotEquals: "Debe seleccionar el nivel"}
            }  
        }); 
        return validar.form();
    }

    function agregarNivel() {
        var PkRevista = $("#hfPkRevista").val();
        var PkNivel   = $("#hfPkNivel").val();

        if(validarNivel()) {
            var Nivel     = $("#ddlInNivel option:selected").text();
            var Anio      = $("#ddlInAnio").val();
            var Producto  = $("#ddlInNivel").val();

            $.post('<cfoutput>#event.buildLink("CVU.productos.agregarNivel")#</cfoutput>', {
                PkRevista:  PkRevista,
                Nivel:      Nivel,
                Anio:       Anio,
                Producto:   Producto

            }, function(data) {
                if ($.isNumeric(data)  && data > 0) {
                    swal("El nivel fue agregado a la revista con exito", null, "success");
                    salidaNuevoNivel();
                    getTablaNiveles(PkRevista);
                    refrescaAnios(PkRevista, 0, 0, 1);
                    $("#ddlInNivel").val("0");
                }
                else {
                    swal("Error al agregar el nivel a la revista", null, "error");
                }
            });
        }
    }

    function editarNivel() {
        var PkRevista = $("#hfPkRevista").val();
        var PkNivel   = $("#hfPkNivel").val();

        if(validarNivel()) {
            var Nivel     = $("#ddlInNivel option:selected").text();
            var Anio      = $("#ddlInAnio").val();
            var Producto  = $("#ddlInNivel").val();

            $.post('<cfoutput>#event.buildLink("CVU.productos.editarNivel")#</cfoutput>', {
                PkNivel:   PkNivel,
                PkRevista: PkRevista,
                Nivel:     Nivel,
                Anio:      Anio,
                Producto:  Producto

            }, function(data) {
                if ($.isNumeric(data)  && data > 0) {
                    swal("El nivel fue editado con exito", null, "success");
                    salidaNuevoNivel();
                    getTablaNiveles(PkRevista);
                    refrescaAnios(PkRevista, 0, 0, 1);
                    $("#ddlInNivel").val("0");
                    $("#btn-admon-niveles").html('Guardar nivel');
                }
                else {
                    swal("Error al editar el nivel", null, "error");
                }
            });
        }
    }

    function eliminarNivel(PkNivel) {
       var PkRevista = $("#hfPkRevista").val();

        $.post('<cfoutput>#event.buildLink("CVU.productos.eliminarNivel")#</cfoutput>', {
            PkNivel:  PkNivel
        }, function(data) {
            if ($.isNumeric(data)  && data > 0) {
                swal("El nivel fue eliminado con exito", null, "success");
                salidaNuevoNivel();
                getTablaNiveles(PkRevista);
                refrescaAnios(PkRevista, 0, 0, 1);
                $("#ddlInNivel").val("0");
            }
            else {
                swal("Error al eliminar el nivel a la revista", null, "error");
            }
        });
    }


    function guardaNivel() {
        PkNivel = $("#hfPkNivel").val();
        if (PkNivel == "0") {
            agregarNivel();
        }
        else {
            editarNivel(PkNivel);
        }
    }

    function limpiaModal() {
        $("#mdl-niveles").modal('hide');
        $("#ddlInAnio").removeClass("error");
        $("#ddlInAnio-error").remove();
        $("#ddlInNivel").removeClass("error");
        $("#ddlInNivel-error").remove();
        $("#formNivel")[0].reset();
        $("#hfPkNivel").val(0);
        $("#btn-admon-niveles").html('Guardar nivel');
    }

    function salidaNuevoNivel() {
        $("#ddlInAnio").val("");
        $("#ddlInNivel").val("");
        $("#hfPkNivel").val(0);
    }

    function arregloAnios() {
        var anioAct = new Date();
        var anios = [];
        for( var x = 2013; x <= anioAct.getFullYear()+1 ; x++ ) {   
            anios.push(x);
        }
        return anios;
    }

    <!--- 
    * params: pkRevista: PK de la revista
              anioSel:    Valor del año seleccionado del combo
              nivelSel:   Valor del nivel seleccionado del combo
              origen:     1 si es de carga inicial con valor de revista, 2 que va a la edicion de un nivel 
    --->
    function refrescaAnios(pkRevista, anioSel, nivelSel, origen) {
        $.post('<cfoutput>#event.buildLink("CVU.productos.obtenerAnios")#</cfoutput>', {
            pkRevista: pkRevista
        }, function(data) {
           $("#ddlInAnio").empty();

            var anios = arregloAnios();
            if (data.ROWCOUNT != 0) { 
                for( var y = 0; y < data.ROWCOUNT ; y++ ) {   
                    anios.splice(anios.indexOf(data.DATA.ANIO[y]), 1);
                }
            } 
            
            if (anioSel != 0) { 
                anios.push(anioSel); 
            } 
            else { 
                $("#ddlInAnio").append($("<option></option>").attr("value",0).text("SELECCIONE AÑO...")); 
            }
            
            for( var z = 0; z < anios.length ; z++ ) {   
                $("#ddlInAnio").append($("<option></option>")
                   .attr("value",anios[z])
                   .text(anios[z]));
            }

            if (anioSel != 0) { 
                $("#ddlInAnio").val(anioSel); 
                $("#ddlInNivel option:contains('" + nivelSel + "')").prop("selected",true); 
            } 
            else { 
                $("#ddlInAnio").val("0"); 
                $("#ddlInNivel").val("0"); 
            }
        });
    }

    $(document).ready(function() {
        getTablaRevistas();
        getSelectPais();

        $(".btn-crear").on("click", function() {        
            limpiaFormulario();
            
            $("#mdl-admon-revista .modal-title").text("Agregar revista");
            $("#btn-admon-revista").html('<span class="fa fa-check"></span> Guardar');
            $("#hfPkRevista").val("0");
            
            $("#ddlInPais option:selected" ).first();
        });

        $( "#ddlPais.selectpicker" ).change(function() {
            getSelectPais();
        });

        $( "#ddlEditorial.selectpicker" ).change(function() {
            getTablaRevistas();
        });

        jQuery.validator.addMethod("nombre", function (value, element) {
            if (/^[a-zA-Z_áéíóúñ\s]/.test(value)){
                return true;
            }else{
                return false;
            };
        }, "* Debe comenzar con una letra.");
    });
</script>