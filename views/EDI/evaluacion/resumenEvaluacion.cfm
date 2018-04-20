<cfprocessingdirective pageEncoding="utf-8"> 
<cfset totalAnios = (prc.PROCESO.getFECHAFINPROC() + 1) - prc.PROCESO.getFECHAINIPROC()>
<cfset totalActividades = 0>
<!--- <cfdump var="#structKeyList(prc.RESUMEN)#" abort="false"> --->

<style type="text/css">
	.hr-line-dashed {
		border-top: 1px dashed #00695c;
	}
	thead > tr > th {
		text-transform: uppercase;
		vertical-align: middle !important;
	}
	.h2{
		font-size: 24px;
	}
	a:hover{
		text-decoration: none;
		color: #fff;
  }
  .tablaResumenProductos th{
    text-align: center !important;
  }
  .tablaResumenProductos td, .tablaResumenProductos th{    
    vertical-align: middle !important;
  }
  td .panel {
    margin: 0px;
  }
  .producto_evaluado{    
    color: #FF6600;
  }
  <!--- 
  .table > tbody > tr > th{
    vertical-align: middle !important;
    background-color: #f5f5f5;
  } --->
  
  @media (max-width : 720px) {
    .modal-lg{
      width: 95%;
    }
  }
</style>

<div class="row">
	<div class="col-sm-12">
		<div class="tabs-container">
			<ul class="nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#tabResumen" aria-expanded="true"> <i class="fa fa-check-square-o"></i> Resumen </a></li>
				<li class=""><a data-toggle="tab" href="#tabResumenDetalles" aria-expanded="false"><i class="fa fa-list"></i>  Detalles de la productividad </a></li>
        <li id="tabResSol" class=""><a data-toggle="tab" href="#tabResumenSolicitudes" aria-expanded="false"><i class="fa fa-edit"></i> Solicitudes al Comité Académico </a></li>
        <li id="tabActAlt" class=""><a data-toggle="tab" href="#tabActivAlternas" aria-expanded="false"><i class="fa fa-book"></i>  Actividades Alternas a la Docencia </a></li>
			</ul>			
			<div class="tab-content">
				<div id="tabResumen" class="tab-pane active">
					<div class="panel-body">
            <div class="row">
              <div class="col-sm-12">
                <!--- TODO: --->
                <!--- <cfdump var="#prc.productos#" abort="false"> --->
                <cfoutput>
                  <cfloop array="#ListToArray(listSort(structKeyList(prc.RESUMEN),"numeric"))#" index="x">			
                    <cfif x LTE 3>
                      <table id="tabla_#x#" class="table table-bordered table-hover text-center tablaResumen" data-toggle="table">
                        <thead>
                          <tr>
														<th class="text-center" colspan="#totalAnios+2#">#prc.RESUMEN[x]["ROMANO"]# - #prc.RESUMEN[x].NOMBRE#</th>
                          </tr>
                          <tr>
														<th class="text-center">Actividad</th>
														<cfloop from="#prc.PROCESO.getFECHAINIPROC()#" to="#prc.PROCESO.getFECHAFINPROC()#" index="i">
															<th class="text-center">#i#</th>
														</cfloop>
														<th class="text-center">PUNTOS OBTENIDOS</th>
													</tr>
                        </thead>
                        <tbody>
                          <cfloop collection="#prc.RESUMEN[x]#" item="subclasificacion">
                            <cfif compare(subclasificacion,"NOMBRE") NEQ 0 AND compare(subclasificacion,"PUNTAJECLASIFICACION") NEQ 0 AND compare(subclasificacion,"ROMANO") NEQ 0>
                              <tr class="fila_producto" data-clasif="#x#" data-subclasif="#subclasificacion#">                                
																<td>#prc.RESUMEN[x]["ROMANO"]#.#prc.RESUMEN[x][subclasificacion]["ROMANO"]#</td>
																<cfloop from="#prc.PROCESO.getFECHAINIPROC()#" to="#prc.PROCESO.getFECHAFINPROC()#" index="i">
																	<cfif structKeyExists(prc.RESUMEN[x][subclasificacion],i)>
																		<td>#prc.RESUMEN[x][subclasificacion][i]["PUNTAJE"]#</td>											
																	</cfif>
																</cfloop>
																<td>#prc.RESUMEN[x][subclasificacion]["PUNTAJESUBCLASIFICACION"]#</td>
															</tr>
                            </cfif>
                          </cfloop>
                          <tr>
														<td class="text-right" colspan="#totalAnios+1#"><b>TOTAL</b></td>
														<td>#prc.RESUMEN[x]["PUNTAJECLASIFICACION"]#</td>
													</tr>
                        </tbody>
                      </table>
                      <br>
											<div class="hr-line-dashed"></div>
											<br>
                      <cfset totalActividades += prc.RESUMEN[x]["PUNTAJECLASIFICACION"]>
                    <cfelseif x EQ 4>
                      <table id="tabla_#x#" class="table table-bordered table-hover text-center tablaResumen" data-toggle="table">
												<thead>
													<tr>
														<th class="text-center" rowspan="2">20% DEL TOTAL DE LA SUMA DE I + II + III</th>
														<th class="text-center" colspan="2">#prc.RESUMEN[x]["ROMANO"]# - #prc.RESUMEN[x].NOMBRE#</th>
														<th class="text-center" rowspan="2">PUNTAJE EFECTIVO</th>
														<th class="text-center" rowspan="2">TOTAL</th>
													</tr>
													<tr>
														<th class="text-center">Actividad</th>
														<th class="text-center">PUNTOS</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<cfset suma = 0>
														<cfif structKeyExists(prc.RESUMEN,1)>
															<cfset suma += prc.RESUMEN[1]["PUNTAJECLASIFICACION"]>
														</cfif>
														<cfif structKeyExists(prc.RESUMEN,2)>
															<cfset suma += prc.RESUMEN[2]["PUNTAJECLASIFICACION"]>
														</cfif>
														<cfif structKeyExists(prc.RESUMEN,3)>
															<cfset suma += prc.RESUMEN[3]["PUNTAJECLASIFICACION"]>
														</cfif>
														<cfset suma *= 0.20>
														<td>#suma#</td>
														<td>#prc.RESUMEN[x]["ROMANO"]#</td>
														<td>#prc.RESUMEN[x]["PUNTAJECLASIFICACION"]#</td>
														<cfif prc.RESUMEN[x]["PUNTAJECLASIFICACION"] GT suma >
															<td>#suma#</td>
															<td>#suma#</td>
															<cfset totalActividades += suma>
														<cfelse>								
															<td>#prc.RESUMEN[x]["PUNTAJECLASIFICACION"]#</td>
															<td>#prc.RESUMEN[x]["PUNTAJECLASIFICACION"]#</td>
															<cfset totalActividades += prc.RESUMEN[x]["PUNTAJECLASIFICACION"]>
														</cfif>																
													</tr>
												</tbody>
											</table>
											<br>
											<div class="hr-line-dashed"></div>
											<br>
                    <cfelse>                      
                      <table id="tabla_#x#" class="table table-bordered table-hover text-center tablaResumen" data-toggle="table">
												<thead>
													<tr>								
														<th class="text-center" colspan="2">#prc.RESUMEN[x]["ROMANO"]# - #prc.RESUMEN[x].NOMBRE#</th>								
													</tr>
													<tr>
														<th class="text-center">Actividad</th>
														<th class="text-center">PUNTOS</th>
													</tr>
												</thead>
												<tbody>
													<cfloop collection="#prc.RESUMEN[x]#" item="subclasificacion">
														<cfif compare(subclasificacion,"NOMBRE") NEQ 0 AND compare(subclasificacion,"PUNTAJECLASIFICACION") NEQ 0 AND compare(subclasificacion,"ROMANO") NEQ 0>
															<tr class="fila_producto" data-clasif="#x#" data-subclasif="#subclasificacion#">
																<td>#prc.RESUMEN[x]["ROMANO"]#.#prc.RESUMEN[x][subclasificacion]["ROMANO"]#</td>
																<td>#prc.RESUMEN[x][subclasificacion]["PUNTAJESUBCLASIFICACION"]#</td>
															</tr>															
														</cfif>								
													</cfloop>
                          <tr>
                            <td class="text-right"><b>TOTAL</b></td>
                            <td>#prc.RESUMEN[x]["PUNTAJECLASIFICACION"]#</td>
                          </tr>							
												</tbody>
											</table>
											<br>
											<div class="hr-line-dashed"></div>
											<br>
											<cfset totalActividades += prc.RESUMEN[x]["PUNTAJECLASIFICACION"]>
                    </cfif>						                  
                  </cfloop>
                  <h3 class="bg-primary p-sm b-r-md"><span class="fa fa-2x fa-check-square-o" style=" vertical-align: middle;"></span><b>&nbsp;&nbsp;PUNTAJE TOTAL DE ACTIVIDADES: #totalActividades#</b></h3>                
                </cfoutput>
              </div>
            </div>
          </div>
        </div>
        <div id="tabResumenDetalles" class="tab-pane">
					<div class="panel-body">
            <div class="row">
              <div class="col-sm-12">
                <ul id="agrupaciones" class="sortable-list connectList agile-list ui-sortable">
                  <cfoutput>
                    <cfloop array="#ListToArray(listSort(structKeyList(prc.RESUMEN),"numeric"))#" index="x">
                      <li id="clasif_#x#">
                        <div class="row">
                          <div class="col-sm-11 text-center">
                            <h3>#prc.RESUMEN[x]["ROMANO"]#.&nbsp;#prc.RESUMEN[x]["NOMBRE"]#</h3>															
                          </div>
                          <div class="col-sm-1 text-center">															
                            <span class="btn btn-default pull-right fa fa-minus minimizarCategoria" data-abierto="1"></span>
                          </div>														
                        </div>
                        <br>
                        <div class="prodContainer">                          
                            <div class="row">
                              <div class="col-sm-12">				
                                <table id="tabla_#x#" class="table table-bordered text-center tablaResumenProductos" data-toggle="table">
                                  <thead>
                        <tr>
                          <th rowspan="2" style="width:60%;">Producto</th>
                          <th rowspan="2">Año</th>
                          <th colspan="#prc.tiposEvaluacion.recordcount#">Evaluaciones</th>
                          <th rowspan="2" style="max-width:25%;">Observaciones</th>
                        </tr>
                                    <tr>
                                      <cfloop query="#prc.tiposEvaluacion#">
                                        <th>
                                          #NOMBRE_TIPOEVALUACION#
                                        </th>
                                      </cfloop>                                      
                                    </tr>
                                  </thead>
                                  <tbody id="tableBody_#x#">
                                    <!--- Si es escolaridad --->
                                    <cfif x EQ 6>
                                      <cfloop collection="#prc.resumen[x]#" item="subclasificacion">
                                        <cfif compareNoCase(subclasificacion, "NOMBRE") NEQ 0 AND compareNoCase(subclasificacion, "PUNTAJECLASIFICACION") NEQ 0 AND compareNoCase(subclasificacion, "ROMANO") NEQ 0>
                                          <cfloop collection="#prc.resumen[x][subclasificacion]#" item="anio">
                                            <cfif compareNoCase(anio, "PUNTAJESUBCLASIFICACION") NEQ 0 AND compareNoCase(anio, "ROMANO") NEQ 0 AND compareNoCase(anio, "SIN ASIGNAR") NEQ 0 >
                                              <cfloop array="#prc.resumen[x][subclasificacion][anio]["PRODUCTOS"]#" index="escolaridad">
                                                <tr class="producto" data-clasifnombre="#prc.resumen[x]["NOMBRE"]#" data-clasif="#x#" data-subclasif="#subclasificacion#" data-anio="#anio#">
                                                  
                                                  <td class="text-left">
                                                    <div class="panel panel-info">
                                                      <div class="panel-heading text-white clearfix">                                                                             
                                                        <!--- <a class="fa fa-chevron-down pull-right"></a> --->
                                                        <span class="btn btn-default btn-xs pull-right fa fa-plus minimizarProducto" data-abierto="0"></span>                         
                                                        #escolaridad.getCLASIFICACION_ROMANO()#.#escolaridad.getSUBCLASIFICACION_ROMANO()# -                                                       
                                                      </div>
                                                      <div class="panel-body" style="display: none; padding: 0px">
                                                        <div id="#escolaridad.getPK_ESCOLARIDAD()#_escolaridad">                                                    
                                                          <div class="widget-text-box datos no-margins" style="padding: 0px;">
                                                            <table class="table table-hover no-margins">
                                                              <tbody> 
                                                                <tr>Formación Académica / #escolaridad.getGRADO()#</tr>
                                                                <tr>
                                                                  <td>Grado:</td>
                                                                  <td><label class="control-label">#escolaridad.getGRADO()#</label></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>Campo de Conocimiento:</td>
                                                                  <td><label class="control-label">#escolaridad.getCAMPO_CONOCIMIENTO()#</label></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>Escuela:</td>
                                                                  <td><label class="control-label">#escolaridad.getESCUELA()#</label></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>Cédula Profesional:</td>
                                                                  <td><label class="control-label">#escolaridad.getCEDULA_PROFESIONAL()#</label></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>¿Estuvo en PNPC?:</td>
                                                                  <td><label class="control-label">#iIf((escolaridad.getPNPC() EQ 1), de("SI"), de("NO")) #</label></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>Fecha de Inicio:</td>
                                                                  <td><label class="control-label">#dateFormat(escolaridad.getFECHA_INICIO(),"dd/mm/yyyy")#</label></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>Fecha de Fin:</td>
                                                                  <td><label class="control-label">#dateFormat(escolaridad.getFECHA_TERMINO(),"dd/mm/yyyy")#</label></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>Fecha de Obtención:</td>
                                                                  <td><label class="control-label">#dateFormat(escolaridad.getFECHA_OBTENCION(),"dd/mm/yyyy")#</label></td>
                                                                </tr>
                                                              </tbody>
                                                            </table>
                                                          </div>
                                                          <div class="widget-text-box datos no-margins" style="padding: 0px;">
                                                            <table class="table table-hover no-margins">
                                                              <thead>
                                                                <th colspan="2">
                                                                  <label class="control-label">Documentos Anexos</label>
                                                                </th>
                                                              </thead>
                                                              <tbody>
                                                                <div class="col-sm-12">
                                                                  <td>
                                                                    <span style="color:red;">*</span> Copia del Diploma:
                                                                  </td>
                                                                </div>
                                                                <div class="col-sm-12">
                                                                  <td>
                                                                      <button class="btn btn-success btn-xs btn-rounded btn-outline btnFile pull-right" onclick="descargaComprobanteConsulta(#Session.cbstorage.usuario.VERTIENTE#,377,#escolaridad.getPK_ESCOLARIDAD()#);">
                                                                        <small>Descargar</small> <span class="fa fa-download"></span>
                                                                      </button>
                                                                  </td>
                                                                </div>
                                                              </tbody>
                                                            </table>
                                                          </div>
                                                        </div>
                                                      </div>
                                                    </div>
                                                  </td>


                                                  <!--- Si la fila(producto) corresponde a el proceso actual --->
                                                  <cfif escolaridad.getPROCESO() EQ prc.proceso.getPKPROCESO()>
                                                    <cfset claseFila ="">
                                                  <!--- Si NO corresponde al proceso actual --->
                                                  <cfelse>
                                                    <cfset claseFila ="producto_evaluado">
                                                  </cfif>

                                                  <td class="#claseFila#">
                                                    #escolaridad.getANIO()#
                                                  </td>

                                                  <cfset conEtapas= 0>
                                                  <cfloop array="#escolaridad.getEVALUACIONES()#" index="evaluacion">
                                                    <cfif Len(evaluacion.getFECHA_CAPTURA())>
                                                      <td class="#claseFila#">#val(evaluacion.getPUNTAJE_OBTENIDO())#</td>                                                      
                                                    <cfelse>
                                                      <td class="#claseFila#">-</td>
                                                    </cfif> 
                                                    <cfset conEtapas++>
                                                  </cfloop>
                                                  <cfloop from="#conEtapas#" to="4" index="abd">
                                                    <td class="#claseFila#"></td>
                                                  </cfloop>

                                                  <td class="text-justify #claseFila#">
                                                    <cfloop array="#escolaridad.getEVALUACIONES()#" index="evaluacion">
                                                      <cfif Len(evaluacion.getCOMENT_EVAL())>
                                                        <p>
                                                          <b>#evaluacion.getNOMBRE_TIPO_EVALUACION()#:</b>
                                                          #REReplace(evaluacion.getCOMENT_EVAL2(), "<p>|</p>|<pre>|</pre>", "" , "all")#
                                                        </p>
                                                      </cfif>
                                                    </cfloop>                                                  
                                                  </td>

                                                </tr>
                                              </cfloop>                                              
                                            </cfif>
                                          </cfloop>                                                                                      
                                        </cfif>
                                      </cfloop>
                                    <cfelse>
                                      <cfloop array="#prc.productos#" index="elem">
                                        <cfset producto = elem.REPORTE>
                                        <cfset ruta = elem.RUTA>
                                        <cfset filas = producto.getFilas()>
                                        <cfset encabezado = producto.getEncabezado()>
                                        <cfset columnas = encabezado.getColumnas()>
                                        <cfset pkReporte = producto.getPkReporte()>
                                        <cfset pkformato = producto.getPkTFormato()>  

                                        <cfloop array="#producto.getFILAS()#" index="fila">
                                          <cfif fila.getCLASIFICACION() EQ x>

                                            <tr class="producto" data-clasifnombre="#elem.RUTA[1]#" data-clasif="#fila.getCLASIFICACION()#" data-subclasif="#fila.getSUBCLASIFICACION()#" data-anio="#fila.getANIO()#">
                                              <td class="text-left">
                                                <div class="panel panel-info">
                                                  <div class="panel-heading text-white clearfix">                                                                             
                                                    <!--- <a class="fa fa-chevron-down pull-right"></a> --->
                                                    <span class="btn btn-default btn-xs pull-right fa fa-plus minimizarProducto" data-abierto="0"></span>                         
                                                    #fila.getCLASIFICACION_ROMANO()#.#fila.getSUBCLASIFICACION_ROMANO()# - #UCase(fila.getNombreProducto())#                                                      
                                                  </div>
                                                  <div class="panel-body" style="display: none; padding: 0px">
                                                    <div id="#fila.getPK_FILA()#_fila">                                                    
                                                      <div class="widget-text-box datos no-margins" style="padding: 0px;">
                                                        <table class="table table-hover no-margins">
                                                          <tbody> 
                                                            <tr>#arrayToList(ruta," / ")#</tr>            
                                                            <cfloop  array="#columnas#" index="columna">
                                                              <tr>
                                                                <cfif  NOT (columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido")>
                                                                  <td>
                                                                    <cfif columna.getrequerido() eq 'true'><span style="color:red;">*</span> </cfif>
                                                                    <cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>:
                                                                  </td>
                                                                  <td>
                                                                    <cftry>
                                                                      <label class="control-label"><cfoutput>#fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()#</cfoutput></label>
                                                                      <cfcatch>
                                                                      </cfcatch>
                                                                    </cftry>
                                                                  </td>
                                                                </cfif>
                                                              </cfloop>
                                                            </tr>
                                                          </tbody>
                                                        </table>
                                                        <cfoutput>
                                                          <div class="widget-text-box no-margins" style="padding: 0px;">
                                                            <table class="table table-hover no-margins">
                                                              <thead id="numDocs#fila.getPK_FILA()#">
                                                                <th colspan="2">
                                                                  <label class="control-label">Documentos Anexos</label>
                                                                </th>
                                                              </thead>
                                                              <tbody>
                                                                <cfset totArch = 0>
                                                                <cfloop  array="#columnas#" index="columna">
                                                                  <tr>
                                                                    <cftry>  
                                                                      <cfif TRIM(fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()) NEQ ''>

                                                                        <cfif  columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido">
                                                                          <cfset totArch = totArch + 1>
                                                                          <div class="col-sm-12">
                                                                            <td><cfif columna.getrequerido() eq 'true'><span style="color:red;">*</span> </cfif>
                                                                              <cfoutput>#columna.getNOM_COLUMNA()# </cfoutput>:</td>
                                                                            </div>
                                                                            <div class="col-sm-12">
                                                                              <td>
                                                                                <button class="btn btn-success btn-xs btn-rounded btn-outline btnFile pull-right" onclick="descargaComprobanteConsulta(#pkformato#,#fila.getPK_FILA()#,#columna.getpk_columna()#);"><small>Descargar</small> <span class="fa fa-download"></span></button>
                                                                              </td>
                                                                            </div>
                                                                          </cfif>

                                                                        </cfif>
                                                                        <cfcatch>
                                                                          Dato no disponible
                                                                        </cfcatch>
                                                                      </cftry>
                                                                    </tr>
                                                                  </cfloop>
                                                                  <script>
                                                                    if (#totArch# == 0) { $('##numDocs#fila.getPK_FILA()#').addClass('hide'); }
                                                                  </script>
                                                                </tbody>
                                                              </table>                                        
                                                            </div>                                        
                                                          </cfoutput>                         
                                                        </div>                                    
                                                      </div>                                                              
                                                    </div>
                                                  </div>
                                                </td>                                            
                                                <!--- Si la fila(producto) corresponde a el proceso actual --->
                                                <cfif fila.getPROCESO() EQ prc.proceso.getPKPROCESO()>
                                                  <cfset claseFila ="">
                                                  <!--- Si NO corresponde al proceso actual --->
                                                <cfelse>
                                                  <cfset claseFila ="producto_evaluado">
                                                </cfif>

                                                <td class="#claseFila#">
                                                  #fila.getANIO()#
                                                </td>
                                                <cfset conEtapas= 0>
                                                <cfloop array="#fila.getEVALUACION_ETAPAS()#" index="evaluacion">
                                                  <cfif Len(evaluacion.getFECHA_CAPTURA())>
                                                    <cfif fila.getPKTPRODUCTOEDI() NEQ evaluacion.getFK_RECLASIFICACION() AND Len(evaluacion.getFK_RECLASIFICACION()) GT 0>
                                                      <td class="#claseFila#">#val(evaluacion.getPUNTAJE_OBTENIDO())#<span class="text-danger">*</span></td>                            
                                                    <cfelse>
                                                      <td class="#claseFila#">#val(evaluacion.getPUNTAJE_OBTENIDO())#</td>                            
                                                    </cfif>
                                                  <cfelse>
                                                    <td class="#claseFila#">-</td>
                                                  </cfif>
                                                  <cfset conEtapas++>
                                                </cfloop>                              
                                                <cfloop from="#conEtapas#" to="4" index="abd">

                                                  <td class="#claseFila#"></td>
                                                </cfloop>

                                                <td class="text-justify #claseFila#">

                                                 <cfloop array="#fila.getEVALUACION_ETAPAS()#" index="evaluacion">
                                                   <cfif Len(evaluacion.getCOMENT_EVAL())>
                                                     <p>
                                                      <b>#evaluacion.getNOMBRE_TIPO_EVALUACION()#:</b>
                                                      #REReplace(evaluacion.getCOMENT_EVAL2(), "<p>|</p>|<pre>|</pre>", "" , "all")#
                                                    </p>
                                                  </cfif>
                                                </cfloop>

                                                <!--- <cfdump var="#fila.getEVALUACION_ETAPAS()#" abort="true"  /> --->
                                              </td>
                                            </tr>
                                          </cfif>                                                                                                   
                                        </cfloop>                                    
                                      </cfloop>
                                    </cfif>
                                  </tbody>
                                </table>
                                <!--- <div id="clasif_#x#_#anio#" class="m-b m-b-md producto_anio">																							
                                </div> --->
                              </div>
                            </div>																                          	
                        </div>
                        <h4 class="bg-primary p-sm b-r-md"><span class="fa fa-check-square-o" style=" vertical-align: middle;"></span><b>&nbsp;&nbsp;PUNTAJE DE CLASIFICACIÓN : #prc.RESUMEN[x]["PUNTAJECLASIFICACION"]#</b></h4>
                      </li>
                    </cfloop>                   
                  </cfoutput>       
                </ul>                                 
              </div>
            </div>
          </div>
        </div>
        <div id="tabResumenSolicitudes" class="tab-pane">
          <div class="panel-body">
            <div class="col-md-12">
              <div id="divSolicitudComiteEva"></div>
              <br>
              <div id="divSolicitudResidenciaEva"></div>
            </div>
          </div>
        </div>
        <div id="tabActivAlternas" class="tab-pane">
          <div class="panel-body">

            <div class="col-md-12">
              <label class="control-label">
                Coordinación o participación en comités tutoriales de alumnos de posgrado para el seguimiento de las actividades curriculares y tesis de alumnos del Instituto.
              </label>
            </div>
            <div class="form-group">
              <div class="row">
                <div class="col-sm-12">
                  <div id="documentosComites"></div>
                </div>
              </div>
            </div>
            <div class="col-md-12">
              <label class="control-label">
                Impartición de seminarios de titulación, cursos de propósito específico de 21 horas o más, cursos de educación continua de 21 horas o más, o diplomados, registrados en la Secretaría, o en la Secretaría Académica o en la Coordinación General de Formación e Innovación Educativa.
              </label>
            </div>
            <div class="form-group">
              <div class="row">
                <div class="col-sm-12">
                  <div id="documentosSeminarios"></div>
                </div>
              </div>
            </div>
            <div class="col-md-12">
              <label class="control-label">
                Asesoría a alumnos o personal académico en laboratorios de investigación por un mínimo de dos horas diarias.
              </label>
            </div>
            <div class="form-group">
              <div class="row">
                <div class="col-sm-12">
                  <div id="documentosAsesorias"></div>
                </div>
              </div>
            </div>

          </div>
        </div>
        
      </div>
    </div>
  </div>
</div>

<form id="downloadComprobanteInv" action="<cfoutput>#event.buildLink('formatosTrimestrales.capturaFT.descargarComprobante')#</cfoutput>" method="POST" target="_blank">
	<input type="hidden" id="pkCatFmtInv"		name="pkCatFmt">
	<input type="hidden" id="pkColDownInv"		name="pkColDown">
	<input type="hidden" id="pkFilaDownInv"		name="pkFilaDown">
</form>

<script>
  $(document).ready(function(){
    
    $(".nav-tabs li").click(function() {
      var nomTab                 = $(this).find("a").attr("href");
      var falgResumenSolicitudes = $("#falgTabResumenSolicitudes").val();
      var falgActivAlternas      = $("#falgTabActivAlternas").val();

      switch(nomTab) {
        case "#tabResumenSolicitudes":
          if(falgResumenSolicitudes == 0) {
            $("#falgTabResumenSolicitudes").val(1);
            getTablaSolicitudComite("divSolicitudComiteEva");
            getSolicitudResidenciaInv("divSolicitudResidenciaEva");
          }
          break;
        case "#tabActivAlternas":
          if(falgActivAlternas == 0) {
            $("#falgTabActivAlternas").val(1);
            documentosComites();
            documentosSeminarios();
            documentosAsesorias();
          }
          break;
      }
    });
    
  });

  function ordenarProductos(selector){
    return $($(selector).toArray().sort((a,b) => {
      var clasifA = parseInt($(a).data('clasif'));
      var clasifB = parseInt($(b).data('clasif'));
      var subclasifA = parseInt($(a).data('subclasif'));
      var subclasifB = parseInt($(b).data('subclasif'));
      var anioA = parseInt($(a).data('anio'));
      var anioB = parseInt($(b).data('anio'));
      return clasifA - clasifB || subclasifA - subclasifB || anioA - anioB;      
    }));		
	}

	function descargaComprobanteConsulta(pkformato, pkfila, pkcol){
		$("#pkColDownInv").val(pkcol);
		$("#pkFilaDownInv").val(pkfila);
		$("#pkCatFmtInv").val(pkformato);
		$('#downloadComprobanteInv').submit();
	}

  function documentosComites(){
    $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
      documentos: 757,
      requerido:  0,
      extension:  JSON.stringify(['txt', 'pdf']),
      convenio:   $('#pkAspProcValSol').val(),
      recargar:   'documentosComites();'
    }, function(data) {
      $("#documentosComites").html(data);
    });
  }

  function documentosSeminarios(){
    $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
      documentos: 758,
      requerido:  0,
      extension:  JSON.stringify(['txt', 'pdf']),
      convenio:   $('#pkAspProcValSol').val(),
      recargar:   'documentosSeminarios();'
    }, function(data) {
      $("#documentosSeminarios").html(data);
    });
  }

  function documentosAsesorias(){
    $.post('<cfoutput>#event.buildLink("adminCSII.ftp.archivo.consultaDocumentos")#</cfoutput>', {
      documentos: 759,
      requerido:  0,
      extension:  JSON.stringify(['txt', 'pdf']),
      convenio:   $('#pkAspProcValSol').val(),
      recargar:   'documentosAsesorias();'
    }, function(data) {
      $("#documentosAsesorias").html(data);
    });
  }

	$(function(){

    <!--- $('.tablaResumenProductos').bootstrapTable(); --->

    $('.tablaResumen').each((indice,elemento) => {      
      var filas_array = $(elemento).find('tr.fila_producto');
      var filas_ordenadas = ordenarProductos(filas_array);
      filas_array.detach();
      $(elemento).find('tbody').prepend(filas_ordenadas);      
    });
		
    var productosOrdenados = ordenarProductos('.producto');    
		var clasif_array = [];
		$.each(productosOrdenados,(indice,elemento) => clasif_array.push($(elemento).data('clasif')));
		clasif_array = clasif_array.filter((indice,elemento) => clasif_array.indexOf(elemento) == indice);				
		$.each(productosOrdenados,(indice,elemento) => {
			var clasificacion = $(elemento).data('clasif');
			var subclasificacion = $(elemento).data('subclasif');
			var clasificacionNombre = $(elemento).data('clasif');
			var anio = $(elemento).data('anio');
			$('#tableBody_'+clasificacion).append(elemento);
		});
		$.each($('.producto_anio'), (indice,elemento) => { 
				if(!$(elemento).find('.producto').length){
					$(elemento).parent().hide();					
				}	
		});

		<!--- debugger; --->

		$('.minimizarCategoria').click(function (e) { 
			var data_abierto = $(this).data('abierto');
			if(data_abierto){			
				$(this).data('abierto', 0).addClass('fa-plus').removeClass('fa-minus');
				$(this).parent().parent().parent().find('.prodContainer').slideUp(300);
			}else{
				$(this).data('abierto', 1).addClass('fa-minus').removeClass('fa-plus');
				$(this).parent().parent().parent().find('.prodContainer').slideDown(300);
			}	
		});


		$('.minimizarProducto').click(function (e) { 
			var data_abierto = $(this).data('abierto');
			if(data_abierto){			
				$(this).data('abierto', 0).addClass('fa-plus').removeClass('fa-minus');
				$(this).parent().parent().find('.panel-body').slideUp(250);
			}else{
				$(this).data('abierto', 1).addClass('fa-minus').removeClass('fa-plus');
				$(this).parent().parent().find('.panel-body').slideDown(250);
			}		
		});		
	});
</script>
