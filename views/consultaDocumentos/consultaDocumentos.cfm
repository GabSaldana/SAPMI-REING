<cfprocessingdirective pageEncoding="utf-8">

<div class="ibox float-e-margins">
    <div class="ibox-title">
        <h5>Documentos complemetarios</h5>
    </div>
    <div class="ibox-content">
        <div class="row">
            <div class="col-md-5">
                <cfif isDefined('prc.docs.recordCount')>
                    <table id="docsTable" class="table table-responsive" data-pagination="true" data-page-size="10" data-unique-id="id">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Nombre</th>
                                <th>Rol</th>
                            </tr>
                        </thead>
                        <tbody>
                            <cfloop index='i' from='1' to='#prc.docs.recordCount#'>
                                <tr><cfoutput>
                                    <td>#i#</td>
                                    <td>#prc.docs.NOMBRE[i]#
                                        <button class="btn btn-link btn-xs pull-right" onclick="obtenerDocumento(#prc.docs.PK[i]#);"><i class="fa fa-search"></i></button>
                                        <br><small class="pull-left"> #prc.docs.FECHA[i]# </small>
                                    </td>
                                    <td>
                                        <cfif application.SIE_CTES.ROLES.ALUM eq prc.docs.Rol[i]> Alumno
                                        <cfelseif application.SIE_CTES.ROLES.DOCE eq prc.docs.Rol[i]> Docente
                                        <cfelseif application.SIE_CTES.ROLES.PAAE eq prc.docs.Rol[i]> PAAE
                                        <cfelseif application.SIE_CTES.ROLES.DIR eq prc.docs.Rol[i]> Directivo de unidad académica
                                        <cfelseif application.SIE_CTES.ROLES.FUN eq prc.docs.Rol[i]> Funcionario del área central
                                        <cfelseif application.SIE_CTES.ROLES.EGRE eq prc.docs.Rol[i]> Egresado </cfif>
                                    </td>
                                </cfoutput></tr>
                            </cfloop>
                        </tbody>
                    </table>
                </cfif>
            </div>
            <div class="col-md-7">
                <div id="previewDoc" class="well" style="width: 100%; height: 75vh;">
                    
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function obtenerDocumento(pkDoc){
        $.post('<cfoutput>#event.buildLink("cargaArchivos.cargaArchivos.obtenerDocumento")#</cfoutput>',{
            pkDoc: pkDoc
        }, function(data){
            var base64 = /^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$/;
            if (data.match(base64)){
                var str = '<object data="data:application/pdf;base64,'+data+'" type="application/pdf" width="100%" height="100%"></object>';        
            } else {
                var str = '<div class="alert alert-danger" style="margin: auto;">Error al cargar documento</div>';
            }
            $("#previewDoc").html(str);
        });
    }

    $(document).ready(function(){
        $('#docsTable').bootstrapTable();
    });
</script>

<style type="text/css">
    #docsTable table{
        border: #f5f5f5 !important;
    }
    #docsTable thead{
        background-color: #e7e7e7 !important;
    }
    #docsTable .th-inner, #docsTable td{
        padding: 4px 4px 4px 8px !important;
    }
</style>