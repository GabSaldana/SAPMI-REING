 <!---
* =========================================================================
* IPN - CSII
* Sistema:SIIIP
* Modulo:Generador PDF
* Descripcion:
* Autor: Alejandro Rosales
* =========================================================================
--->
<!--- <cfdump var="#prc#" abort="true"> --->
<cfprocessingdirective pageEncoding="utf-8">
<cfdocument format="PDF" name="documento" saveAsName = "detallesAutoevaluacion.pdf" unit="cm" margintop="3" marginbottom="1" marginleft="1" marginright="1" orientation="portrait" pagetype="letter">	
<style type="text/css">
		.tbl {background-color:#000;}
		.tbl td,th,caption{background-color:#fff}
</style>
<cfset page=1>
<cfset pageWM = []>
<cfdocumentitem type="header">
			<table >
				<tr>
					<td>
						<img height="104" width="291" src="file:///C:\ColdFusion11\SIIIP\wwwroot\includes\img\logo\logo_sep.png">
					</td>
					<td width="1000">
						
					</td>
					<td>
						<img height="86" width="322" src="file:///C:\ColdFusion11\SIIIP\wwwroot\includes\img\login\IPN-AlingR_guinda.png">
					</td>
				</tr>
			</table>
</cfdocumentitem>
	<body style="font-family:Arial">
 	<!---- Inicio de tabla de datos generales ----->
	
		<cfdocumentsection>
			
		<div style="font-family:Arial">
		<table width="100%" cellpadding="10">
			<thead>
				<tr style="font-size:16px">
					<th align="left">
						Investigadores
					</th>
					<th align="left">
						Firma
					</th>
					
				</tr>
			</thead>
			<tbody>
				<cfloop query="#prc.consulta#">
					<cfoutput>
						<tr style="font-size:15px">
							<td>#UCase(ACRONIMO)# #NOMBRE#</td>
							<td>____________________________</td>
						<tr>
					</cfoutput>
				</cfloop>
			</tbody>
		</table>
		</div>
		<cfdocumentitem type="footer">				
		<cfset page= page+(ceiling((prc.consulta.recordcount)/18))>
		<div style="font-family:Arial">
			<center>
				<table>
						<tr>
							<td>
								<font size="1">
								Edificio de la Secretaría Académica, 2° piso, Av. Luis Enrique Erro S/N, Unidad Profesional "Adolfo López Mateos", Zacatenco T.+52 (55) 5729-6000 ext. 50486, 50479 y 50593, www.sip.ipn.mx				  </font>	
							</td>
						</tr>
				</table>
			</center>
		</div>
	</cfdocumentitem>
	</cfdocumentsection>
	<!---- Fin de tabla de datos generales ----->
	
	<cfdocumentitem type="pagebreak">
	</cfdocumentitem>
	<!--- <cfdocumentitem type="pagebreak" /> --->
	<!--- Cantidad de investigadores ----->
	<cfset num_investigador = prc.consulta.RECORDCOUNT>
	<!--- <cfoutput>#num_investigador#</cfoutput>
	 --->
	 <!--- <cfloop from="1" to="#num_investigador#" index="i"> --->
	 	<cfloop from="1" to="#num_investigador#" index="i">
	 		<!--- Carta --->
	 		<cfdocumentsection>

	 		<div style="font-family:Arial">
	 		<div style="font-size:16px">
	 			<p align="right">Ciudad de México, <cfoutput>#prc.Fecha.FECHA[1]#</cfoutput></p>
	 			<br>
				<p align="left">
					SIP/DI/DOPI/EDI-<cfoutput>#prc.folio[i].PKASPIRANTE[1]#</cfoutput>/<cfoutput>#Right(prc.proceso.getNOMBREPROCESO(), 2)#</cfoutput>
					<br style="display: block; margin: 4px 0;">
					<b><cfoutput>#prc.nombre[i]#</cfoutput></b>
					<br style="display: block; margin: 4px 0;">
					<cfif prc.consulta.genero[i] EQ 1>ACADÉMICO<cfelse>ACADÉMICA</cfif> DE <cfoutput>#prc.consulta.ur[i]#</cfoutput>
					<br style="display: block; margin: 4px 0;">	
					Presente
				</p>
			</div>
			<div style="font-size:14px">
				<p align="left" style="line-height: 1.5;">
					Adjunto al presente remito a usted el dicatamen del resultado de su solicitud presentada en la Convocatoria del Porgrama de Estimulos al Dsempeño de los Investigadores (EDI) <cfoutput>#prc.proceso.getFECHAINIPROC()#-#prc.proceso.getFECHAFINPROC()#</cfoutput>.
				</p>
				<br style="display: block; margin: 4px 0;">
				<p align="left" style="line-height: 1.5;">
					En su caso, podrá interponer un Recurso de Inconformidad, de acuerdo a los artículos 37, 38, y 39 del Reglamento EDI.
					El cual deberá registrar a través de la página del Sistema Institucional de Información de Investigación y Posgrado
					<b>(SIIIP: www.siiip.ipn.mx)</b>, en la pestaña <i> Aplicación al Estímulo del Desempeño de los Investigadores </i>, en la columna de Resultados y dar clic en Aplicar Recurso de Inconformidad. En este módulo podrá seleccionar los productos sobre los cuales se inconforma, agregar la observación sobre el producto y adjuntar los probatorios en archivo con extensión pdf.
				</p>
				<p align="left" style="line-height: 1.5;">
					Derivado de este registro, se generará el escrito del Recurso de Inconformidad al Dictamen de la Convocatoria 2016-
					2018, este documento se deberá imprimir, firmar y entregar en la División de Operación y Promoción a la Investigación de la Dirección de Investigación, en un periodo máximo 12 días hábiles a partir de la recepción de este documento por su Unidad Académica, en un horario de 9:00 a 14:00 y de 16:00 a 18:00 h.
				</p>
				<p>
					Agradezco de antemano apoyo para continuar con este proceso y aprovecho la ocasión para enviarle un cordial saludo.
				</p>
			</div>
				<BR>
				<div style="font-size:16px">
					Atentamente
				</div>
				<div style="font-size:15px">
					<br style="display: block; margin: 4px 0;">
					<b>"LA TÉCNICA AL SERVICIO DE LA PATRIA"</b>
				</div>
				<br>
				<br>
				<div style="font-size:15px">
					<b><cfoutput>#application.SIIIP_CTES.DIRECTOR_NOMBRE#</cfoutput></b>
				</div>
				<div style="font-size:16px">
					<br style="display: block; margin: 4px 0;">
					Director<cfif application.SIIIP_CTES.DIRECTOR_GENERO EQ 2>a</cfif> de Investigación
				</div>
				<br>
				<div style="font-size:15px">
					<b>Anexo:</b>
				</div>
				<div style="font-size:16px">
					<br>
					<div style="text-indent: 50px;">Dictamen</div>
				</div>
				<br>
				<small>
					<cfoutput>#application.SIIIP_CTES.DIRECTOR_INICIALES#</cfoutput>
				</small>
				
			</div>
<cfdocumentitem type="footer">
		<cfset page= page+1>	
		<div style="font-family:Arial">
			<center>
				<table >
						<tr>
							<td>
								<font size="1">
								Edificio de la Secretaría Académica, 2° piso, Av. Luis Enrique Erro S/N, Unidad Profesional "Adolfo López Mateos", Zacatenco T.+52 (55) 5729-6000 ext. 50486, 50479 y 50593, www.sip.ipn.mx				  </font>	
							</td>
						</tr>
				</table>
			</center>
		</div>
	</cfdocumentitem>
	 		</cfdocumentsection>
	 		<!--- </font> --->
	 		<!--- Fin de carta ---->
	 		<cfdocumentitem type="pagebreak">
			</cfdocumentitem>
	 		<cfdocumentsection>
	 		<style type="text/css">
				table .producto, table .producto td .producto tr{
  					border: groove black;
				}
				table.producto {
  				border-width: 1px 1px 1px 1px;
				font-size: 10px;
				font-family:Arial;
				}
				table.producto td {
  					border-width: 1px 0px 0px 1px;
				}
				table.producto th {
  					border-width: 1px 1px 1px 1px;
				}
				table.producto tr {
  					border-width: 1px 1px 1px 0px;
				}
				
				table.producto td.oscuro {
  					border-width: 1px 1px 1px 1px;
				}
				
				
			</style>
	 		<div style="font-size:9pt;font-family:Arial;">

	 		<cfset arrayAppend(pageWM, page)>
	 		<table width="100%"	border="1" class="producto" cellspacing=0 cellpadding=0 bordercolor="#000000" >
				<tr>
					<td rowspan="2"  bgcolor="#404040" class="oscuro" >
						<font color="#FFFAFA" >
							<b><center>DICTAMEN RESULTADO DE LA EVALUACIÓN</center></b>
						</font>
					</td>
					<td>
						<center>EDI-<cfoutput>#prc.folio[i].PKASPIRANTE[1]#</cfoutput></center>
					</td>
				</tr>
				<tr>
					<td>
						<center>Ciudad de México, <cfoutput>#prc.Fecha.FECHA[1]#</cfoutput></center>
					</td>
				</tr>
			</table>
			<table width="100%"	border="0" style="font-size: 10px;">
				<tr >
					<td height="2px">
					</td>
				</tr>
			</table>

			<table width="49%"	class="producto"  border=1 cellspacing=0 cellpadding=0 bordercolor="#000000" style="font-size: 10px;float: right;">
				<tr>
					<td bgcolor="#404040"  height="23px" width="50%" class="oscuro">
						<font color="#FFFAFA">
							<center>NIVEL ASIGNADO</center>
						</font>
					</td>
					<td>
						<cfif prc.consulta.NIVEL_ASIGNADO_CA[i] NEQ ''>
							<center><cfoutput>#prc.consulta.NIVEL_ASIGNADO_CA[i]#</cfoutput></center>
						<cfelse>
							<center>Sin Evaluación</center>
						</cfif>
					</td>
				</tr>
				<tr>
					<td bgcolor="#404040"  height="23px" class="oscuro"> 
						<font color="#FFFAFA">
							<center>PERIODO DE VIGENCIA</center>
						</font>
					</td>
					<td>
						<center><cfoutput>PERIODO</cfoutput></center>
					</td>
				</tr>
			</table>
			<table width="50%"	class="producto" border=.5   cellspacing=0 cellpadding=0 bordercolor="#000000" style="font-size: 10px;">
				<tr >
					<td bgcolor="#404040"  height="23px"  width="30%" class="oscuro">
						<font color="#FFFAFA">
							<center>ACADÉMICO</center>
						</font>
					</td>
					<td>
						<center><cfoutput>#prc.nombre[i]#</cfoutput></center>
					</td>
				</tr>
				<tr >
					<td bgcolor="#404040"  height="23px" class="oscuro">
						<font color="#FFFAFA">
							<center>DEPENDENCIA</center>
						</font>
					</td>
					<td>
						<center><cfoutput>#prc.ur[i]#</cfoutput></center>
					</td>
				</tr>
			</table>
			
			
			<!---- loooop complicado ----->
			<cfset totalAnios="#(prc.proceso.getFECHAFINPROC()-prc.proceso.getFECHAINIPROC())+1#">
			<cfset totalActividades = 0>
			<cfloop collection="#prc.clasificaciones#" item="clasificacion">
				<cfif val(clasificacion) LTE 3>
				
					<table class="producto" width="50%"	border=2 cellspacing=0 cellpadding=0 bordercolor="#000000" style="font-size: 9px; float: left;margin-top:5px">
						<tr bgcolor="#04040">
							<td bgcolor="#404040" colspan="<cfoutput>#2+totalAnios#</cfoutput>" height="20px" class="oscuro">
								<font color="#FFFAFA">
									<center><cfoutput>#uCase(prc.clasificaciones[clasificacion]["ROMANO"]&". "&prc.clasificaciones[clasificacion]["NOMBRE"])#</cfoutput></center>
								</font>
							</td>
						</tr>
						<tr bgcolor="#404040">
							<td  bgcolor="#404040" width="17%"  height="20px">
								<font color="#FFFAFA">
									<center>ACTIVIDAD</center>
								</font>
							</td>
							<cfoutput>
								<cfloop from="#prc.proceso.getFECHAINIPROC()#" to="#prc.proceso.getFECHAFINPROC()#" index="anio">
									<td bgcolor="##404040">
										<font color="##FFFAFA">
											<center>#anio#</center>
										</font>
									</td>
								</cfloop>
							</cfoutput>
							<td bgcolor="#404040">
								<font color="#FFFAFA">
									<center>PUNTOS</center>
								</font>
							</td>
						</tr>
						<cfoutput>
							<cfloop collection="#prc.clasificaciones[clasificacion]["SUBCLASIFICACIONES"]#" item="subclasificacion">
								<tr>		
									<td bgcolor="##404040" height="13px">
										<font color="##FFFAFA">
											<center>#prc.clasificaciones[clasificacion]["ROMANO"]#.#prc.clasificaciones[clasificacion]["SUBCLASIFICACIONES"][subclasificacion]["ROMANO"]#</center>
										</font>
									</td>														
									<cfloop from="#prc.proceso.getFECHAINIPROC()#" to="#prc.proceso.getFECHAFINPROC()#" index="anio">
										<td>
											<center>
												<cfif structKeyExists(prc.resumen[i],clasificacion)>
													<cfif structKeyExists(prc.resumen[i][clasificacion],subclasificacion)>
														<cfif structKeyExists(prc.resumen[i][clasificacion][subclasificacion], anio)>
															#prc.resumen[i][clasificacion][subclasificacion][anio]["PUNTAJE"]#
														<cfelse>
															0
														</cfif>
													<cfelse>
														0
													</cfif>
												<cfelse>
													0
												</cfif>
											</center>
										</td>
									</cfloop>
									<td>
										<center>
											<cfif structKeyExists(prc.resumen[i],clasificacion)>
												<cfif structKeyExists(prc.resumen[i][clasificacion],subclasificacion)>
													#prc.resumen[i][clasificacion][subclasificacion]["PUNTAJESUBCLASIFICACION"]#
												<cfelse>
													0
												</cfif>
											<cfelse>
												0
											</cfif>
										</center>
									</td>
								</tr>
							</cfloop>
							<tr>
								<td bgcolor="##404040" colspan="#totalAnios#">
								</td>
								<td bgcolor="##404040">
									<font color="##FFFAFA">
										<center>TOTAL</center>
									</font>
								</td>
								<td>
									<center>
										<cfif structKeyExists(prc.resumen[i],clasificacion)>
											#prc.resumen[i][clasificacion]["PUNTAJECLASIFICACION"]#
											<cfset totalActividades += prc.resumen[i][clasificacion]["PUNTAJECLASIFICACION"]>
										<cfelse>
											0
										</cfif>
									</center>
								</td>
							</tr>
						</cfoutput>
					</table>
				
					
				<cfelseif val(clasificacion) EQ 4>
					<table class="producto" width="49%"	border=.5 cellspacing=0 cellpadding=0 bordercolor="#000000" style="font-size: 9px;margin:5px">
						<tr>
							<td bgcolor="#404040" rowspan="2"  height="40px">
								<font color="#FFFAFA">
									<center>20% DEL TOTAL DE LA SUMA<br>DE I+II+III</center>
								</font>
							</td>
							<td bgcolor="#404040" colspan="2">
								<font color="#FFFAFA">
									<center><cfoutput>#uCase(prc.clasificaciones[clasificacion]["ROMANO"]&". "&prc.clasificaciones[clasificacion]["NOMBRE"])#</cfoutput></center>
								</font>
							</td>
							<td bgcolor="#404040" rowspan="2">
								<font color="#FFFAFA">
									<center>PUNTAJE EFECTIVO</center>
								</font>
							</td>
							<td bgcolor="#404040" rowspan="2">
								<font color="#FFFAFA">
									<center>TOTAL</center>
								</font>
							</td>							
						</tr>		
						<tr>
							<td bgcolor="#404040">
								<font color="#FFFAFA">
									<center>ACTIVIDAD</center>
								</font>
							</td>
							<td bgcolor="#404040">
								<font color="#FFFAFA">
									<center>PUNTOS</center>
								</font>
							</td>
						</tr>
						<cfoutput>
							<tr>								
								<cfset suma = 0>
								<cfif structKeyExists(prc.RESUMEN[i],1)>
									<cfset suma += prc.RESUMEN[i][1]["PUNTAJECLASIFICACION"]>
								</cfif>
								<cfif structKeyExists(prc.RESUMEN[i],2)>
									<cfset suma += prc.RESUMEN[i][2]["PUNTAJECLASIFICACION"]>
								</cfif>
								<cfif structKeyExists(prc.RESUMEN[i],3)>
									<cfset suma += prc.RESUMEN[i][3]["PUNTAJECLASIFICACION"]>
								</cfif>
								<cfset suma *= 0.20>
								<td height="20px">
									<center>#suma#</center>
								</td>

								<cfif structKeyExists(prc.RESUMEN[i], clasificacion)>
									<td>
										<center>#prc.RESUMEN[i][clasificacion]["ROMANO"]#</center>
									</td>
									<td>
										<center>#prc.RESUMEN[i][clasificacion]["PUNTAJECLASIFICACION"]#</center>
									</td>
									<cfif prc.RESUMEN[i][clasificacion]["PUNTAJECLASIFICACION"] GT suma >
										<td><center>#suma#</center></td>
										<td><center>#suma#</center></td>
										<cfset totalActividades += suma>
									<cfelse>								
										<td><center>#prc.RESUMEN[i][clasificacion]["PUNTAJECLASIFICACION"]#</center></td>
										<td><center>#prc.RESUMEN[i][clasificacion]["PUNTAJECLASIFICACION"]#</center></td>
										<cfset totalActividades += prc.RESUMEN[i][clasificacion]["PUNTAJECLASIFICACION"]>
									</cfif>
								<cfelse>
									<td>
										<center>-</center>
									</td>
									<td>
										<center>0</center>
									</td>
									<td><center>0</center></td>
									<td><center>0</center></td>
								</cfif>																							
							</tr>
						</cfoutput>									
					</table>
				<cfelseif val(clasificacion) EQ 7>
					<table class="producto" border=.5 cellspacing=0 cellpadding=1 bordercolor="#000000" style="table-layout: fixed; font-size: 9px;  width: 10px;margin:5px">
						<tr>
							<td <!--- width="100%" ---> bgcolor="#404040" colspan="<cfoutput>#2+totalAnios#</cfoutput>">
								<font color="#FFFAFA">
									<center>VII. ACTIVIDADES ACADÉMICO-<br>ADMINISTRATIVAS</center>
								</font>
							</td>
						</tr>
						<tr>
							<td width="50%" bgcolor="#404040">
								<font color="#FFFAFA">
									<center>ACTIVIDAD</center>
								</font>
							</td>							
							<td width="50%" bgcolor="#404040">
								<font color="#FFFAFA">
									<center>PUNTOS</center>
								</font>
							</td>
						</tr>							
						<cfoutput>
							<cfloop collection="#prc.clasificaciones[clasificacion]["SUBCLASIFICACIONES"]#" item="subclasificacion">
								<tr>		
									<td bgcolor="##404040">
										<font color="##FFFAFA">
											<center>#prc.clasificaciones[clasificacion]["ROMANO"]#.#prc.clasificaciones[clasificacion]["SUBCLASIFICACIONES"][subclasificacion]["ROMANO"]#</center>
										</font>
									</td>																							
									<td>
										<center>
											<cfif structKeyExists(prc.resumen[i],clasificacion)>
												<cfif structKeyExists(prc.resumen[i][clasificacion],subclasificacion)>
													#prc.resumen[i][clasificacion][subclasificacion]["PUNTAJESUBCLASIFICACION"]#
												<cfelse>
													0
												</cfif>
											<cfelse>
												0
											</cfif>
										</center>
									</td>
								</tr>
							</cfloop>	
							<tr>								
								<td bgcolor="##404040">
									<font color="##FFFAFA">
										<center>TOTAL</center>
									</font>
								</td>
								<td>
									<center>
										<cfif structKeyExists(prc.resumen[i],clasificacion)>
											#prc.resumen[i][clasificacion]["PUNTAJECLASIFICACION"]#
											<cfset totalActividades += prc.resumen[i][clasificacion]["PUNTAJECLASIFICACION"]>
										<cfelse>
											0
										</cfif>
									</center>
								</td>
							</tr>			
						</cfoutput>
					</table>
				<cfelse>
					<table class="producto" width="20"	border=.5 cellspacing=0 cellpadding=1 bordercolor="#000000" style="font-size: 9px; float:left; margin:5px">
						<tr>
							<td bgcolor="#404040" colspan="<cfoutput>#2+totalAnios#</cfoutput>">
								<font color="#FFFAFA">
									<center><cfoutput>#uCase(prc.clasificaciones[clasificacion]["ROMANO"]&". "&prc.clasificaciones[clasificacion]["NOMBRE"])#</cfoutput></center>
								</font>
							</td>
						</tr>
						<tr>
							<td bgcolor="#404040">
								<font color="#FFFAFA">
									<center>ACTIVIDAD</center>
								</font>
							</td>							
							<td bgcolor="#404040">
								<font color="#FFFAFA">
									<center>PUNTOS</center>
								</font>
							</td>
						</tr>	
						<cfoutput>
							<cfloop collection="#prc.clasificaciones[clasificacion]["SUBCLASIFICACIONES"]#" item="subclasificacion">
								<tr>		
									<td bgcolor="##404040">
										<font color="##FFFAFA">
											<center>#prc.clasificaciones[clasificacion]["ROMANO"]#.#prc.clasificaciones[clasificacion]["SUBCLASIFICACIONES"][subclasificacion]["ROMANO"]#</center>
										</font>
									</td>																							
									<td>
										<center>
											<cfif structKeyExists(prc.resumen[i],clasificacion)>
												<cfif structKeyExists(prc.resumen[i][clasificacion],subclasificacion)>
													#prc.resumen[i][clasificacion][subclasificacion]["PUNTAJESUBCLASIFICACION"]#
												<cfelse>
													0
												</cfif>
											<cfelse>
												0
											</cfif>
										</center>
									</td>
								</tr>
							</cfloop>						
							<tr>								
								<td bgcolor="##404040">
									<font color="##FFFAFA">
										<center>TOTAL</center>
									</font>
								</td>
								<td>
									<center>
										<cfif structKeyExists(prc.resumen[i],clasificacion)>
											#prc.resumen[i][clasificacion]["PUNTAJECLASIFICACION"]#
											<cfset totalActividades += prc.resumen[i][clasificacion]["PUNTAJECLASIFICACION"]>
										<cfelse>
											0
										</cfif>
									</center>
								</td>
							</tr>
						</cfoutput>				

				</cfif>				
			</cfloop>
			<!---- fin de looo complicado ----->
			<br>
			<table class="producto" width="30%"	border=.5 cellspacing=0 cellpadding=0 bordercolor="#000000" style="font-size: 9px;  float: right;">
				<tr>
					<td colspan="4" bgcolor="#404040"  height="25px">
						<font color="#FFFAFA">
							<center>TOTAL DE ACTIVIDADES</center>
						</font>
					</td>
				</tr>
				<tr>
					<td colspan="4"  height="25px">
						<center><cfoutput>#totalActividades#</cfoutput></center>
					</td>
				</tr>
			</table>			
		
			<br>
			<cfif isQuery(prc.observaciones[i]) AND prc.observaciones[i].RECORDCOUNT GT 0>
				<table class="producto" width="30%" border=.5 cellspacing=0 cellpadding=1 bordercolor="#000000" style="font-size: 9px;  float: right;">
					<tr>
						<td colspan="4" bgcolor="#404040"  height="25px">
							<font color="#FFFAFA">
								<center>OBSERVACIONES</center>								
							</font>
						</td>
					</tr>
					<tr>
						<td colspan="4">						
							<cfoutput>#prc.observaciones[i].OBSERVACION_CA[1]#</cfoutput>
						</td>
					</tr>
				</table>
			</cfif>

			<table class="firmar" width="50%" style="font-size: 10px; margin-top: 100px; float: right;">
				<tbody>
					<tr>
						<td align="center">
							<b>__________________________________________________________</b>
						</td>
					</tr>
					<tr>
						<td align="center">
							<font size="2">
								<b><cfoutput>#application.SIIIP_CTES.DIRECTOR_NOMBRE#</cfoutput></b>
								<br <!--- style="display: block; margin: 4px 0;" --->>
								Director<cfif application.SIIIP_CTES.DIRECTOR_GENERO EQ 2>a</cfif> de Investigación
							</font>
						</td>
					</tr>
					
				</tbody>
			</table>
		</div>
			<cfdocumentitem type="footer">
		<cfset page= page+1>	
		<div style="font-family:Arial">
			<center>
				<table>
						<tr>
							<td>
								<font size="1">
								Edificio de la Secretaría Académica, 2° piso, Av. Luis Enrique Erro S/N, Unidad Profesional "Adolfo López Mateos", Zacatenco T.+52 (55) 5729-6000 ext. 50486, 50479 y 50593, www.sip.ipn.mx				  </font>	
							</td>
						</tr>
				</table>
			</center>
		</div>
	</cfdocumentitem>
		</cfdocumentsection>
		<cfdocumentitem type="pagebreak">
		</cfdocumentitem>
	 </cfloop>
	</font>
</body>

</cfdocument>
<cfset pages = []>
<cfset page = page-1>

<cfloop from="1" to="#page#" index="i">
	<cfif NOT arrayFind(pageWM, i)>
		<cfset arrayAppend(pages, i)>
	</cfif>
</cfloop>
<cfpdf action="addWatermark"  pages ="#ArrayToList(pages, ",")#" image = "C:\ColdFusion11\siiip\wwwroot\includes\img\logo\logo_mex1.png" source="documento"  foreground="no" showonprint="yes" opacity="10"> 
<!--- <cfheader name="content-disposition" value="attachment; filename=""reporteResultados.pdf""" />
 ---><cfcontent type="application/pdf" variable="#toBinary(documento)#">