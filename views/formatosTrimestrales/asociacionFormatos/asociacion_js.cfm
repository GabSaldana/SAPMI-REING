<cfprocessingdirective pageEncoding="utf-8">
<script type="text/javascript">

    $(document).ready(function() {
        $("#box-asociaColumnas").hide();
        $("#box-formatosRegistrados").hide();
        asociaciones();
    });


    <!---
    * Fecha      : Marzo 2017
    * Autor      : Alejandro Tovar
    * Descripcion: Obtiene la vista que permite asociar formatos.
    * --->
    function dragDrop(){
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.getDragDrop")#</cfoutput>',{
            },
            function(data){
                $('#dragDrop').html( data );
        });
    }


    <!---
    * Fecha      : Marzo 2017
    * Autor      : Alejandro Tovar
    * Descripcion: Obtiene la vista que muestra la tabla de formatos asociados.
    * --->
    function asociaciones(){
        $("#box-asociaColumnas").hide();
        $("#box-asociaciones").show();
        $("#box-formatosRegistrados").hide();
        $("#arrayFormatos").val('');
        $("#columnaOrigen").val('');
        $.post('<cfoutput>#event.buildLink("formatosTrimestrales.asociacionFormatos.getReportesAsociados")#</cfoutput>',{
            },
            function(data){
                $('#asociaciones').html( data );
        });
    }


    <!---
    * Fecha      : Marzo 2017
    * Autor      : Alejandro Tovar
    * Descripcion: Obtiene la vista que permite asociar formatos.
    * --->
    function showDragDrop(){
        dragDrop();
        $("#box-asociaColumnas").hide();
        $("#box-asociaciones").hide();
        $("#box-formatosRegistrados").show();
        $('#asociaciones').empty();
    }


    <!---
    * Fecha      : Marzo 2017
    * Autor      : Alejandro Tovar
    * Descripcion: Muestra la tabla que tiene las relaciones de formatos.
    * --->
    function cierraDragDrop(){
        $("#box-asociaciones").show();
        $("#box-formatosRegistrados").hide();
        $('#dragDrop').empty();
        asociaciones();
    }


</script>
