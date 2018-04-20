<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="encabezadoPadre_js.cfm">
<div class="container" >
    <div class="row">
        <div class="col-md-12">
            
            <input type="hidden" id="pkNombreAsociacion" value="<cfoutput>#prc.pkAsociacion#</cfoutput>">

            <style type="text/css">
                label input[type="radio"] ~ i.fa.fa-square-o{
                    color: #585858; display: inline;
                }
                label input[type="radio"] ~ i.fa.fa-check-square-o{
                    display: none;
                }
                label input[type="radio"]:checked ~ i.fa-square-o{
                    display: none;
                }
                label input[type="radio"]:checked ~ i.fa.fa-check-square-o{
                    color: #585858; display: inline;
                }
                .Azul{
                    background-color:#4499EE; color: #585858;
                }
                .Gris{
                    background-color:#E1E1E1; color: #585858;
                }
                .Naranja{
                    background-color:#F8AC59; color: #585858;
                }
            </style>

            <div class="panel panel-primary">
                <div class="panel-heading"><strong>Formato contenedor</strong>
                    <i class="btn btn-primary btn-xs pull-right" id="vistaPreviaBtn" onclick="asociaciones()" title="Cerrar" style="font-size:20px;"><i class="fa fa-times"></i></i><br><br>
                </div>
                <div class="panel-body">
                    <div class="col-sm-6">
                        <label style="text-align:right;" class="control-label">Elije una plantilla para la clasificaci&oacute;n de formatos</label>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-tags"></span>
                            </span>
                            <select id="pkplantilla" name="pkplantilla" class="form-control m-b" data-style="btn-primary btn-outline" onchange="resetClasifiaciones();">
                                <option selected disabled>Elije una plantilla para la clasificaci&oacute;n de formatos</option>
                                <cfset total_records = prc.plantillas.recordcount>
                                <cfloop index="x" from="#total_records#" to="1" step="-1">
                                    <cfoutput><option value="#prc.plantillas.CVE[x]#">#prc.plantillas.NOMBRE[x]#</option></cfoutput>
                                </cfloop>
                            </select>
                        </div>
                    </div>
                    <br><br><br><br><br>
                    <cfset encabezado = prc.reporte[1].getEncabezado()>
                    <cfset columnas = encabezado.getColumnas()>
                    <cfset nombreFormato = prc.reporte[1].getNombre()>
                    
                    <cfoutput>
                        <div id="#prc.pkFormato[1]#"> </div>
                    </cfoutput>

                    <div style="background-color:#1C84C6; color:#fff; text-align:center"><br><strong><cfoutput> #nombreFormato# </cfoutput></strong><br><br></div>
                    <br>
                    <div style="overflow-x:auto">
                        <table class="table table-bordered">
                            <cfloop from="1" to="#encabezado.getniveles()+1#" index="k">
                                <cfif k lt encabezado.getniveles()+1>
                                    <tr style="background-color:#4499EE; color:#fff">
                                        <cfloop array="#columnas#" index="columna">
                                            <cfif columna.getNivel() eq k>
                                                <cfoutput>
                                                    <td align="center" colspan="#columna.gettotalHijosUltimoNivel()#">
                                                        <div data-toggle="buttons"
                                                            <cfloop from="1" to="#ArrayLen(prc.colores)#" index="j">
                                                                <cfif #prc.colores[j].pkCol# EQ #columna.getpk_columna()#>
                                                                    class="#prc.colores[j].color#"
                                                                </cfif>
                                                            </cfloop>
                                                        >
                                                            &nbsp;&nbsp;#columna.getNOM_COLUMNA()#&nbsp;&nbsp;
                                                            <label class="btn btn-xs">
                                                              <input type="radio" id="#columna.getpk_columna()#" onchange="setColOrigen(#columna.getpk_columna()#);"><i class="fa fa-square-o fa-2x"></i><i class="fa fa-check-square-o fa-2x"></i>
                                                            </label>
                                                        </div>
                                                    </td>
                                                </cfoutput>
                                            </cfif>
                                        </cfloop>
                                    </tr>
                                </cfif>
                            </cfloop>
                        </table>
                    </div>
                    <div class="alert alert-info row">
                        <strong>Info!: </strong>Seleccione una columna del primer formato, para asociar con las columnas de los formatos asociados.<br><br>
                        <div class="col-md-6">
                            <div align="center">
                                <div data-toggle="buttons">
                                    <label class="btn" disabled>
                                      <input type="radio"><i class="fa fa-square-o fa-2x"></i><i class="fa fa-check-square-o fa-2x"></i>
                                    </label>Indicador de celda no selecionada.
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div align="center">
                                <div data-toggle="buttons">
                                    <label class="btn" disabled>
                                      <input type="radio" checked=""><i class="fa fa-square-o fa-2x"></i><i class="fa fa-check-square-o fa-2x"></i>
                                    </label>Indicador de celda selecionada.
                                </div>
                            </div>
                        </div>
                        <br><br>
                        La columna que esta asociada en todos los formatos se muestran de color <span class="badge" style="background-color:#4499EE">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> 
                        , no asociada en todos los formatos se muestra de color  <span class="badge" style="background-color:#F8AC59">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        y sin asociación se muestra de color  <span class="badge" style="background-color:#E1E1E1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>.
                    </div>
                </div>
            </div>

            <div class="panel panel-info">
                <div class="panel-heading"><strong>Formatos asociados</strong></div>
                <div class="panel-body">

                    <div class="alert alert-info row">
                        <strong>Info!: </strong>Seleccione una columna del primer formato, y asocie las columnas del resto de los formatos dando click en la columna deseada.<br><br>
                        <div class="col-md-6">
                            <div align="center">
                                <button class="btn btn-success btn-xs" disabled><span class="fa fa-circle-o fa-2x"></span></button> Indicador de celda no relacionada
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div align="center">
                                <button class="btn btn-info btn-xs" disabled><span class="fa fa-dot-circle-o fa-2x"></span></button> Indicador de celda relacionada
                            </div>
                        </div>
                    </div>

                    <cfloop from="2" to="#ArrayLen(prc.reporte)#" index="j">
                        <cfset encabezado = prc.reporte[j].getEncabezado()>
                        <cfset columnas = encabezado.getColumnas()>
                        <cfset nombreFormato = prc.reporte[j].getNombre()>

                        <cfif #prc.reporte[j].getnombre()# NEQ #prc.reporte[1].getnombre()#>
                            <cfoutput>
                                <div id="#prc.pkFormato[j]#"> </div>
                            </cfoutput>

                            <div style="background-color:#3299DC; color:#fff; text-align:center"><br><strong><cfoutput> #nombreFormato# </cfoutput></strong><br><br></div>
                            <br>
                            <div style="overflow-x:auto">
                                <table class="table table-bordered" >
                                    <cfloop from="1" to="#encabezado.getniveles()+1#" index="i">
                                        <cfif i lt encabezado.getniveles()+1>
                                            <tr style="background-color:#43AAFF; color:#fff">
                                                <cfloop array="#columnas#" index="columna">
                                                    <cfif columna.getNivel() eq i>
                                                        <cfoutput>
                                                            <cfif arrayFind(#prc.colAsociada#,#columna.getpk_columna()#)>
                                                                <td style="background-color:##65DFE4" align="center" colspan="#columna.gettotalHijosUltimoNivel()#">
                                                                    &nbsp;&nbsp;#columna.getNOM_COLUMNA()#&nbsp;&nbsp;
                                                                    <button style="background-color:##65DFE4;" class="btn btn-xs" onclick="desasociaColumna(#columna.getpk_columna()#, #prc.pkFormato[j]#);"><span id="#columna.getpk_columna()#" class="fa fa-dot-circle-o fa-2x"></span></button>
                                                                </td>
                                                            <cfelse>
                                                                <td align="center" colspan="#columna.gettotalHijosUltimoNivel()#">
                                                                    &nbsp;&nbsp;#columna.getNOM_COLUMNA()#&nbsp;&nbsp;
                                                                    <button style="background-color:##43AAFF;" class="btn btn-xs" onclick="relacionaColumna(#columna.getpk_columna()#, #prc.pkFormato[j]#);"><span class="fa fa-circle-o fa-2x"></span></button>
                                                                </td>
                                                            </cfif>
                                                        </cfoutput>
                                                    </cfif>
                                                </cfloop>
                                            </tr>
                                        </cfif>
                                    </cfloop>
                                </table><br><br><br>
                            </div>
                        </cfif>
                    </cfloop>
                </div>
            </div>
        </div>
    </div>
</div>

<cfif #IsArray(prc.promedio)#>
    <div class="modal" id="mdl-promedios" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="$('.modal-backdrop').remove();">×</button>
                    <h4 class="modal-title">Información de las asociaciones</h4>
                </div>
                <div class="modal-body">
                    <table id="tabla_promds" class="table table-striped table-responsive" data-pagination="true" data-page-size="10">
                        <thead>
                            <th class="text-center" data-formatter="getIndex">#</th>
                            <th data-sortable='true'>Nombre del formato asociado</th>
                            <th class="text-center">Coincidencia</th>
                            <th class="text-center">Columnas asociadas</th>
                        </thead>
                        <tbody>
                            <cfloop from="2" to="#ArrayLen(prc.reporte)#" index="j">
                                <cfset nombreFormato = prc.reporte[j].getNombre()>
                                <cfoutput>
                                    <tr>
                                        <td> #j-1# </td>
                                        <td> #nombreFormato# </td>
                                        <td> #prc.promedio[j-1]#% </td>
                                        <td> #prc.celdasRelacionadas[j-1]# </td>
                                    </tr>
                                </cfoutput>
                            </cfloop>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</cfif>


<ul id="tlyPageGuide" data-tourtitle="Asociacion de formatos">

    <li class="tlypageguide_right" data-tourtarget="#pkplantilla">
        Elige una plantilla para clasificar el formato contenedor y asociados.
    </li>

    <li class="tlypageguide_right" data-tourtarget=".clasFmt">
        Elige una plantilla para clasificar el formato.
    </li>

</ul>

