<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Consulta la informacion del convenio por tipo Firma Electronica 
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
                        <label class="labelConvenio">Nombre del Proyecto:</label><br>
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
                        <label class="labelConvenio">Modalidad :</label><br>
                        <label class="labelConvenioControl consulta">&nbsp;#CONNOMBREMODALIDAD#</label>
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

                <cfswitch expression="#CONCURRENCIA#"> 
                    <cfcase value="1">      <!-- sin concurrencia -->
                        <div class="row">    
                            <div class="form-group col-md-5 col-md-offset-1">
                                <label class="labelConvenio"> Monto total :</label><br>
                                <label class="labelConvenioControl consulta">&nbsp;#CONMONTOTOTAL#</label> 
                            </div>
                        </div>
                    </cfcase> 
                    <cfcase value="2">      <!-- concurrencia simple -->
                        <div class="row">    
                                <div class="form-group col-md-5 col-md-offset-1">
                                    <label class="labelConvenio"> Monto IPN :</label><br>
                                    <label class="labelConvenioControl consulta">&nbsp;#CONMONTOLIQUIDO#</label> 
                                </div>
                                <div class="form-group col-md-5">
                                    <label class="labelConvenio"> Monto CONACYT :</label><br>
                                    <label class="labelConvenioControl consulta">&nbsp;#CONMONTOCONACYT#</label> 
                                </div>
                        </div>
                        <div class="row">    
                            <div class="form-group col-md-5 col-md-offset-1">
                                <label class="labelConvenio"> Monto total :</label><br>
                                <label class="labelConvenioControl consulta">&nbsp;#CONMONTOTOTAL#</label> 
                            </div>
                        </div>
                    </cfcase>
                    <cfdefaultcase>     <!-- concurrencia en especie-->
                        <div class="row">    
                            <div class="form-group col-md-5 col-md-offset-1">
                                <label class="labelConvenio"> Monto IPN :</label><br>
                                <label class="labelConvenioControl consulta">&nbsp;#CONMONTOLIQUIDO#</label> 
                            </div>
                            <div class="form-group col-md-5">
                                <label class="labelConvenio"> Monto CONACYT :</label><br>
                                <label class="labelConvenioControl consulta">&nbsp;#CONMONTOCONACYT#</label> 
                            </div>
                        </div>
                        <div class="row">    
                            <div class="form-group col-md-5 col-md-offset-1">
                                <label class="labelConvenio"> Monto en especie concurrente :</label><br>
                                <label class="labelConvenioControl consulta">&nbsp;#CONMONTOESPECIE#</label> 
                            </div>
                            <div class="form-group col-md-5">
                                <label class="labelConvenio"> Monto en Espacio físico :</label><br>
                                <label class="labelConvenioControl consulta">&nbsp;#CONMONTOESPACIO#</label> 
                            </div>
                        </div>
                        <div class="row">    
                            <div class="form-group col-md-5 col-md-offset-1">
                                <label class="labelConvenio"> Institución colaboradora :</label><br>
                                <label class="labelConvenioControl consulta">&nbsp;#CONNOMBREINSTITUCION#</label> 
                            </div>
                            <div class="form-group col-md-5">
                                <label class="labelConvenio"> Monto Total :</label><br>
                                <label class="labelConvenioControl consulta">&nbsp;#CONMONTOTOTAL#</label> 
                            </div>
                        </div>
                    </cfdefaultcase> 
                </cfswitch> 
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
                    <div id="docsOfSuficienciaPresup"></div>
                    <div id="docsNombTitularDep"></div>
                    <div id="docsCartaConcurrencia"></div>
                    <div id="docsOfSolicitudRev"></div>
                    <div id="docsConvocatoria"></div>
                    <div id="docsTerminosReferencia"></div>
                    <div id="docsResultados"></div>
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


            convocatoria(parseInt(1));  //obligatorio
            terminosReferencia(parseInt(1)); //obligatorio
            resultados(parseInt(1)); //obligatorio
            ofSuficienciaPresup(parseInt(0)); //opcional
            nombTitularDep(parseInt(0)); //opcional
            cartaConcurrencia(parseInt(0)); //opcional

        $.post('<cfoutput>#event.buildLink("convenios.Consulta.archivosRequeridosCargados")#</cfoutput>', {
            pkRegistro:     $("#hfPkConvenio").val(),
            tipoConvenio:   1
        }, function(data) {
            if(data.EXITO){
                $("#tabChConArc").removeClass('fa-circle-o').addClass('fa-circle');
            }
        });
    });

    function ofSuficienciaPresup(index){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 331,
            requerido: index == 1 ? 1 : 0,
            extension: JSON.stringify(['txt', 'pdf']),
            convenio: $("#hfPkConvenio").val(),
            recargar: 'ofSuficienciaPresup()'
        }, function(data) {
            $("#docsOfSuficienciaPresup").html(data);
            $(".btnSubirArchivo").hide();
            $(".archivoRequerido").hide();
        });
    }

    function nombTitularDep(index){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 332,
            requerido: index == 1 ? 1 : 0,
            extension: JSON.stringify(['txt', 'pdf']),
            convenio: $("#hfPkConvenio").val(),
            recargar: 'nombTitularDep()'
        }, function(data) {
            $("#docsNombTitularDep").html(data);
            $(".btnSubirArchivo").hide();
            $(".archivoRequerido").hide();
        });
    }

    function cartaConcurrencia(index){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 326,
            requerido: index == 1 ? 1 : 0,
            extension: JSON.stringify(['txt', 'pdf']),
            convenio: $("#hfPkConvenio").val(),
            recargar: 'cartaConcurrencia()'
        }, function(data) {
            $("#docsCartaConcurrencia").html(data);
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

    function terminosReferencia(index){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 329,
            requerido: index == 1 ? 1 : 0,
            extension: JSON.stringify(['txt', 'pdf']),
            convenio: $("#hfPkConvenio").val(),
            recargar: 'terminosReferencia()'
        }, function(data) {
            $("#docsTerminosReferencia").html(data);
            $(".btnSubirArchivo").hide();
            $(".archivoRequerido").hide();
        });
    }

    function resultados(index){
        $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
            documentos: 330,
            requerido: index == 1 ? 1 : 0,
            extension: JSON.stringify(['txt', 'pdf']),
            convenio: $("#hfPkConvenio").val(),
            recargar: 'resultados()'
        }, function(data) {
            $("#docsResultados").html(data);
            $(".btnSubirArchivo").hide();
            $(".archivoRequerido").hide();
        });
    }

</script>