
<cfprocessingdirective pageEncoding="utf-8">

<script type="text/javascript">  

    $(document).ready(function(){
        <cfset pkUsuario = deserializeJSON(prc.datos)>

        getTablaCartas(<cfoutput>#pkUsuario[1]["USUARIO CAI"]#</cfoutput>);
        getInfoGeneral(<cfoutput>#pkUsuario[1]["USUARIO CAI"]#</cfoutput>);
        getInfoSni(<cfoutput>#pkUsuario[1]["USUARIO CAI"]#</cfoutput>);
       
    });


    function getTablaCartas(pkDato){
        $.post('<cfoutput>#event.buildLink("convenios.informacion.getTablaCartas")#</cfoutput>',{
            pkUsuario: pkDato
        },function(data){
            $('#tablaCartas').html(data);
        });
    }


    function getInfoGeneral(pkDato){
        $.post('<cfoutput>#event.buildLink("convenios.informacion.getInfoGeneral")#</cfoutput>',{
            pkUsuario: pkDato
        },function(data){
            $('#datosGenerales').html(data);
        });
    }


    function getInfoSni(pkDato){
        $.post('<cfoutput>#event.buildLink("convenios.informacion.getInfoSni")#</cfoutput>',{
            pkUsuario: pkDato
        },function(data){
            $('#informacionSni').html(data);
        });
    }



</script>