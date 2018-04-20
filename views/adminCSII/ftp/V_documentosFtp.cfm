<cfprocessingdirective pageEncoding="utf-8">
<link href="/includes/css/fileinput.css" media="all" rel="stylesheet" type="text/css">

<div class="wrapper wrapper-content animated fadeIn">
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <h5>Componentes FTP</h5>
            <div class="ibox-tools">
            </div>
        </div>
        <div class="ibox-content">
            <div class="row">
                <input id="pkRegistroComentario" type="hidden">
                <input id="pkTipoComentario"     type="hidden">

                <div id="consultaDatosTec"> </div>
                <div id="consultaFiniquito"> </div>
                <div id="consultaContrato"> </div>
                <div id="otrosAdjuntosN"> </div>
                <div id="otrosAdjuntos" class="panel-group"> </div>                
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(document).ready(function() {
        consultaDatosTec();
        consultaFiniquito();
        consultaContrato();
        $("#otrosAdjuntosN").empty();
        otrosAdjuntos();
    });


    function consultaDatosTec(){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 8,
            requerido: 1,
            extension: JSON.stringify(['txt', 'pdf']),
            convenio: 13,
            recargar: 'consultaDatosTec()'
        }, function(data) {
            $("#consultaDatosTec").html(data);
        });
    }


    function consultaFiniquito(){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 22,
            requerido: 1,
            extension: JSON.stringify(['txt', 'pdf']),
            convenio: 13,
            recargar: 'consultaFiniquito()'
        }, function(data) {
            $("#consultaFiniquito").html(data);
        });
    }


    function consultaContrato(){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 3,
            requerido: 0,
            extension: JSON.stringify(['txt', 'pdf']),
            convenio: 13,
            recargar: 'consultaContrato()'
        }, function(data) {
            $("#consultaContrato").html(data);
        });
    }


    function otrosAdjuntos(){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 43,
            requerido: 0,
            extension: JSON.stringify(['txt', 'pdf']),
            convenio: 13,
            recargar: 'otrosAdjuntos()'
        }, function(data) {
            $("#otrosAdjuntos").html(data);
        });
    }


    function otrosAdjuntosN(){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaOtros")#</cfoutput>', {
            documentos: 43,
            requerido: 0,
            extension: JSON.stringify(['txt', 'pdf']),
            convenio: 13,
            recargar: 'otrosAdjuntos()'
        }, function(data) {
            $("#otrosAdjuntosN").html(data);
        });
    }

</script>
