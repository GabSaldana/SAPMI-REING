<!---
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Administracion de estado de los investigadores
* Fecha:       11 de diciembre de 2017
* Descripcion: Contenido js que sera usado por la vista
* Autor:       JLGC    
* ================================
--->

<cfprocessingdirective pageEncoding="utf-8">

<script type="text/javascript">  

    <!--- 
    * Descripcion:    Llena contenidoTablaInvestigadores con los investigadores
    * Fecha creacion: 11 de diciembre de 2017
    * @author:        JLGC
    --->
    function getTablaInvestigadores() {
        $.post('<cfoutput>#event.buildLink("EDI.solicitud.cargarTablaInvestigadores")#</cfoutput>', {
        }, function( dataTabla ) {
            $("#contenidoTablaInvestigadores").html( dataTabla );
        });
    }
  
    <!--- 
    * Descripcion:    Realiza el cambio de estado del investigador
    * Fecha creacion: 11 de diciembre de 2017
    * @author:        JLGC
    --->
    function guardaEstado(pkEstadoInvestigador){
        var estado = $("#ddlEstado"+pkEstadoInvestigador).val();

        $.post('<cfoutput>#event.buildLink("EDI.solicitud.editarEstadoInvestigador")#</cfoutput>', {
            pkEstadoInvestigador: pkEstadoInvestigador,
            estado:               estado
        }, function(data) {
            if ($.isNumeric(data)  && data > 0) {
                swal("El estado del investigador ha sido modificado", null, "success");
            }
            else {
                swal("Error al modificadar el estado del investigador", null, "error");
            }
        });
    }

    $(document).ready(function() {
        getTablaInvestigadores();
    });
</script>