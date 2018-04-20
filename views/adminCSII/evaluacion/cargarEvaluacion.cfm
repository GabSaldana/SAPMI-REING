<cfprocessingdirective pageEncoding="utf-8">
<style type="text/css">
.textarea {

	height: 100%;
	width: 100%;
    border: none;
    resize: none;
    color:rgb(103, 106, 108);
}

.textarea:hover {
	border-color: #C6D2D2;
	border-width: 1px;
    border-style: solid;
    height: 100%;
}



.textarea:focus {
	border-color: #C6D2D2;
	border-width: 1px;
    border-style: solid;
    height: 100%;

    outline: none;
    -webkit-box-shadow: none;
    -moz-box-shadow: none;
    box-shadow: none;
}
</style>


<form id="form" action="#">
    <cfset auxSeccion = ''>
    <cfset auxAspecto = ''>
    <!--- <cfset textRow = []> --->
	<!--- <cfdump var="#getForm#"> --->
   	<input type="hidden" value="1" id="pkEstadoCursoEvaluacion" />
	<cfoutput query="prc.forma">
	<cfif auxSeccion NEQ #ID[currentrow]#>
    	<div class="row">
		    <div class="col-lg-12">
		        <div class="ibox float-e-margins">
		            <div class="ibox-title">
		                <h5>#SECCION[currentrow]#</h5>
		            </div>
		            <cfset auxSeccion = #ID[currentrow]#>
		            <div class="ibox-content">
		            	<cfset idTable= 'seccion' & '#ID[currentrow]#'>
		            	<cfset tipoCol = 0>
		                <table id='#idTable#' class="table table-responsive tabla_seccion" data-unique-id="id" data-show-header="false">
				        	<thead>
						        <tr>
						            <th data-field="id"></th>
            						<th data-field="tipo"></th>
						            <th class="text-center" data-field="aspecto">ASPECTO A EVALUAR</th>
						            <th class="text-center" data-field="escala">RESPUESTA</th>
						            <th class="text-center" data-field="observacion">OBSERVACIONES</th>
						        </tr>
						    </thead>
						    <tbody>
						        <cfloop index="x" from="1" to="#recordcount#">
						        	<cfif auxSeccion EQUAL #ID[x]#>
								        <cfif auxAspecto NEQ #ASPECTO[x]#>
									        <cfif #TIPO[x]# EQUAL 3>
									        	<tr>
									        		<td>#CVE[x]#</td>
									        		<td>#TIPO[x]#</td>
									        		<!--- <cfset arrayAppend(textRow, {"id": idTable, "nombre": "d"})> --->
										            <td class="col-lg-3">
										        		<div class="form-group">
                                                            <input type="hidden" id="#'pk'&cve[x]#" name="pk" value="0">
                                                            <input type="hidden" value="#cve[x]#" name="pkAspecto">                                                                    
                                                            <input type="hidden" id="#'aspecto'&cve[x]#" name="aspecto" value="0">                                                                    

										        			<textarea id="#'obs'&cve[x]#" class="form-control textarea" rows="3" placeholder="Ingresa tu respuesta"></textarea>
										                    <!--- <input id="escala" name="escala" type="text" class="form-control required"> --->
										        		</div>
										           	</td>
										           	<td class="col-lg-5"><label class="control-label">#ASPECTO[x]#</label></td>
										           	<td class="col-lg-4"></td>
										        </tr>
									        <cfelse>
									            	<cfif #tipoCol# EQUAL 0>
														<tr>
															<td>0</td>
										        			<td>x</td>
										        			<td class="col-lg-5 text-center"><label class="control-label">ASPECTO A EVALUAR</label></td>
										        			<td class="col-lg-3 text-center"><label class="control-label">RESPUESTA</label></td>
										        			<td class="col-lg-4 text-center"><label class="control-label">OBSERVACIONES</label></td>
										        		</tr>
										        		<tr>
															<td>#CVE[x]#</td>
										        			<td>#TIPO[x]#</td>
										        			<td class="col-lg-5">#ASPECTO[x]#</td>
											            	<td class="col-lg-3">
											        			<div class="form-group">
                                                                	<cfset qEscala = prc.escalas[#TIPO[x]#]>
                                                                    <input type="hidden" id="#'pk'&cve[x]#" name="pk" value="0">
                                                                    <input type="hidden" value="#cve[x]#" name="pkAspecto">                                                                    
                                                                    
											                    	<div class="campoValidacion">                                                                    
											                    	<select class="form-control m-b obligatorio"  id="#'aspecto'&cve[x]#" name="aspecto">
										                                <option value="0">Elegir una opción</option>
										                                <cfset total_records = qEscala.recordcount>
										                                <cfloop index="z" from="1" to="#total_records#">
										                                   <option value="#qEscala.val[z]#">#qEscala.des[z]#</option>
										                                </cfloop>
										                            </select>
                                                                    </div>
												                </div>
												           	</td>
												           	<td class="col-lg-4">
                                                            	<div class="form-group">
												           			<textarea id="#'obs'&cve[x]#" class="form-control textarea" rows="1" placeholder="Agregar observaciones"></textarea>
													           		<!--- <input id="obs" name="obs" type="text" class="form-control required"> --->
                                                                </div>    
												            </td>
										        		</tr>
										        		<cfset tipoCol = 1>
													<cfelse>
														<tr>
															<td>#CVE[x]#</td>
										        			<td>#TIPO[x]#</td>
										        			<td class="col-lg-5">#ASPECTO[x]#</td>
											            	<td class="col-lg-3">
											        			<div class="form-group">
                                                                	<cfset qEscala = prc.escalas[#TIPO[x]#]>
                                                                    <input type="hidden" id="#'pk'&cve[x]#" name="pk" value="0">
                                                                    <input type="hidden" value="#cve[x]#" name="pkAspecto">                                                                                                                                         
											                    	<div class="campoValidacion">
                                                                    <select class="form-control m-b obligatorio" id="#'aspecto'&cve[x]#" name="aspecto">
										                                <option value="0">Elegir una opción</option>
										                                <cfset total_records = qEscala.recordcount>
										                                <cfloop index="z" from="1" to="#total_records#">
										                                   <option value="#qEscala.val[z]#">#qEscala.des[z]#</option>
										                                </cfloop>
										                            </select>
                                                                    </div>
												                </div>
												           	</td>
												           	<td class="col-lg-4">
                                                            	<div class="form-group">
												           			<textarea id="#'obs'&cve[x]#" class="form-control textarea" rows="1" placeholder="Agregar observaciones"></textarea>
												                	<!--- <input id="obs" name="obs" type="text" class="form-control required"> --->
                                                                </div>    
												            </td>
										        		</tr>
													</cfif>
									        </cfif>


							        	</cfif>
							        	<cfset auxAspecto = #ASPECTO[x]#>
							        </cfif>
							    </cfloop>
						    </tbody>
					    </table>
				    </div>
		        </div>
		    </div>
		</div>
    </cfif>
	</cfoutput>
	<!--- <cfset textRow = SerializeJSON(textRow)> --->
</form>
<cfinclude template="cargarEvaluacion_js.cfm">

