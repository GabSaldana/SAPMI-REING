<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Consulta la informacion del convenio por tipo UC-Mexus
* Fecha:       09 de junio de 2017
* Descripcion: Vista donde se puede consultar toda la informacion de un combenio por PK y tipo convenio
* Autor:       Jose Luis Granados Chavez
* ================================
---->

<cfprocessingdirective pageEncoding="utf-8">

<!--- INI TABS CONSULTA CONVENIO --->
<div class="tabs-container">
    <ul class="nav nav-tabs">
        <li class="active guiaInfoGral"><a data-toggle="tab" href="#tabConGen-1"><i class="fa fa-circle" id="tabChConGen"></i>Generales</a></li>
        <li class="guiaInfoResponsable"><a data-toggle="tab" href="#tabConRes-2"><i class="fa fa-circle-o" id="tabChConRes"></i>Responsable</a></li>
        <li class="guiaInfoArchivos"><a data-toggle="tab" href="#tabConArc-3"><i class="fa fa-circle-o" id="tabChConArc"></i>Archivos</a></li>
    </ul>
    <div class="tab-content">
        <cfoutput query="prc.InfoConvenio">
        <div id="tabConGen-1" class="tab-pane active">
            <div class="panel-body">
                <!--- INI CONSULTA GENERALES --->
                <input type="hidden" id="tipoConvenio" value="#CONTIPO#">
                <input type="hidden" id="estadoConvenio" value="#CESESTADO#">
                <input type="hidden" id="validacionHabilitada" value="#ACCIONESCVE#">
                <div class="row">    
                    <div class="form-group col-md-4 col-md-offset-1">
                        <label class="labelConvenio">Tipo de convenio :</label><br>
                        <label id="lblTipo" class="labelConvenioControl consulta">&nbsp;#CONNOMBRETIPO#</label>
                    </div>
                    <div class="form-group col-md-3">
                        <label class="labelConvenio">Número de Folio :</label><br>
                        <label id="lblRegistro" class="labelConvenioControl consulta">&nbsp;#CONREGISTRO#</label>
                    </div>
                    <cfif #REGISTRO_SIP# NEQ "">
                        <div class="form-group col-md-3">
                            <label class="labelConvenio">Número de Registro SIP :</label><br>
                            <label id="lblRegistro" class="labelConvenioControl consulta">&nbsp;#REGISTRO_SIP#</label>
                        </div>
                    </cfif>
                </div>
                <div class="row">
                    <div class="form-group col-md-10 col-md-offset-1">
                        <label class="labelConvenio">Nombre del Proyecto :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#CONNOMBRE#</label>
                    </div>
                </div>
                <div class="row">    
                    <div class="form-group col-md-10 col-md-offset-1">
                        <label class="labelConvenio">Objetivo :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#CONDESCRIPCION#</label>
                    </div>
                </div>
                <div class="row">    
                    <div class="form-group col-md-10 col-md-offset-1">
                        <label class="labelConvenio">Institución colaboradora :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#CONNOMBREINSTITUCION#</label>
                    </div>
                </div>
                <div class="row">    
                    <div class="form-group col-md-5 col-md-offset-1">
                        <label class="labelConvenio">Fecha de inicio de vigencia :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#CONFECHAVIGINI#</label> 
                    </div>
                    <div class="form-group col-md-5">
                        <label class="labelConvenio">Fecha de fin de vigencia :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#CONFECHAVIGFIN#</label> 
                    </div>
                </div>
                <div class="row">    
                    <div class="form-group col-md-5 col-md-offset-1">
                        <label class="labelConvenio"> Monto total :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#CONMONTOTOTAL#</label> 
                    </div>
                </div>
                <!--- FIN  CONSULTA GENERALES --->
            </div>
        </div>
        <div id="tabConRes-2" class="tab-pane">
            <div class="panel-body">
                <!--- INI CONSULTA RESPONSABLE --->
                <div class="row">
                    <div class="form-group col-md-9 col-md-offset-1">
                        <label class="labelConvenio"> Número de empleado :</label><br>
                        <label id="lblNumEmpleado" class="labelConvenioControl consulta">&nbsp;#RESNUMEMPLEADO#</label>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-3 col-md-offset-1">
                        <label class="labelConvenio"> Nombre :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#RESNOMBRE#</label>
                    </div>
                    <div class="form-group col-md-3">
                        <label class="labelConvenio"> Paterno :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#RESPATERNO#</label>
                    </div>
                    <div class="form-group col-md-3">
                        <label class="labelConvenio"> Materno :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#RESMATERNO#</label>
                    </div>
                </div>
                <div class="row">    
                    <div class="form-group col-md-3 col-md-offset-1">
                        <label class="labelConvenio">Sexo :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#RESSEXO#</label>
                    </div>    
                    <div class="form-group col-md-6">
                        <label class="labelConvenio">Dependencia Académica :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#RESDEPENDENCIA#</label>
                    </div>
                </div>
                <div class="row">    
                    <div class="form-group col-md-6 col-md-offset-1">
                        <label class="labelConvenio">Carrera :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#RESCARRERA#</label>
                    </div>
                    <div class="form-group col-md-3">
                        <label class="labelConvenio">Grado académico :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#RESGRADO#</label>
                    </div>
                </div>
                <div class="row">    
                    <div class="form-group col-md-6 col-md-offset-1">
                        <label class="labelConvenio"> Correo electrónico :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#RESMAIL#</label>
                    </div>
                    <div class="form-group col-md-3">
                        <label class="labelConvenio"> Extensión :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#RESEXTENSION#</label>
                    </div>
                </div>
                <!--- FIN  CONSULTA RESPONSABLE --->
            </div>
        </div>
        </cfoutput>
        <div id="tabConArc-3" class="tab-pane">
            <div class="panel-body">
                <input id="pkRegistroComentario" type="hidden" value="">
                <div id="docs" class="ibox-content" style="border: none;">
                    <div id="docsConvenio"></div>
                    <div id="docsOfSolicitudRev"></div>
                    <div id="docsConvocatoria"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--- FIN TABS CONSULTA CONVENIO --->

<script type="text/javascript">
    <!---- Pone titulo al modal y cambia imagen en tab ---->
    $("#lblTitConConvenio").text( "Consulta convenio " + $("#lblTipo").text() + " : " + $("#lblRegistro").text() );
    if ( $("#lblNumEmpleado").html() != "&nbsp;" ) {
        $("#tabChConRes").removeClass("fa-circle-o").addClass("fa-circle");
    }

    $(document).ready(function() {

        <cfoutput>
            var pkConvenio = #prc.InfoConvenio.CONPK#;
            var pkEstado   = #prc.InfoConvenio.CESESTADO#;
        </cfoutput>///

        $("#comentarCom").removeClass('hide');
        $("#consultarCom").removeClass('hide');
        $('#comentarCom').attr('onclick','comentarConvenio('+ pkConvenio + ',' + pkEstado + ')');
        $('#consultarCom').attr('onclick','getComentariosConvenio('+ pkConvenio + ')');


            convenio(parseInt(1)); //obligatorio
            ofSolicitudRev(parseInt(1)); //obligatorio
            convocatoria(parseInt(1)); //obligatorio

        $.post('<cfoutput>#event.buildLink("convenios.Consulta.archivosRequeridosCargados")#</cfoutput>', {
            pkRegistro:     $("#hfPkConvenio").val(),
            tipoConvenio:   3
        }, function(data) {
            if(data.EXITO){
                $("#tabChConArc").removeClass('fa-circle-o').addClass('fa-circle');
            }
        });
    });

    function convenio(index){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 328,
            requerido: index == 1 ? 1 : 0,
            extension: JSON.stringify(['txt', 'pdf']),
            convenio: $("#hfPkConvenio").val(),
            recargar: 'convenio()'
        }, function(data) {
            $("#docsConvenio").html(data);
            $(".btnSubirArchivo").hide();
            $(".archivoRequerido").hide();
        });
    }

    function ofSolicitudRev(index){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 325,
            requerido: index == 1 ? 1 : 0,
            extension: JSON.stringify(['txt', 'pdf']),
            convenio: $("#hfPkConvenio").val(),
            recargar: 'ofSolicitudRev()'
        }, function(data) {
            $("#docsOfSolicitudRev").html(data);
            $(".btnSubirArchivo").hide();
            $(".archivoRequerido").hide();
        });
    }

    function convocatoria(index){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 333,
            requerido: index == 1 ? 1 : 0,
            extension: JSON.stringify(['txt', 'pdf']),
            convenio: $("#hfPkConvenio").val(),
            recargar: 'convocatoria()'
        }, function(data) {
            $("#docsConvocatoria").html(data);
            $(".btnSubirArchivo").hide();
            $(".archivoRequerido").hide();
        });
    }
</script>