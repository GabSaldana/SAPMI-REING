 <!---
* =========================================================================
* IPN - CSII
* Sistema:	SIIIP
* Modulo:	Generador PDF
* Fecha:	Enero de 2018
* Autor:	Roberto Cadena
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<cfset totalAnios="#(prc.proceso.getFECHAFINPROC()-prc.proceso.getFECHAINIPROC())+1#">
<cfset totalActividades = 0>
<cfdocument format="PDF" saveAsName = "reporteResultados.pdf" unit="cm" margintop="3" marginbottom="1" marginleft="1" marginright="1" orientation="portrait" pagetype="letter">
	<cfdocumentitem type="header"><br>
		<table>
			<tr>
				<td>
					<img height="104" width="291" src="file:///C:\ColdFusion11\SIIP\wwwroot\includes\img\logo\logo_sep.png">
				</td>
				<td width="1000"></td>
				<td>
					<img height="86" width="322" src="file:///C:\ColdFusion11\SIIP\wwwroot\includes\img\login\IPN-AlingR_guinda.png">
				</td>
			</tr>
		</table>
	</cfdocumentitem>
	<body>
		<font face="calibri">
			<table width="100%"	border=.5 cellspacing=0 cellpadding=0 bordercolor="#000000" style="font-size: 10px;">
				<tr>
					<td rowspan="2"  bgcolor="#404040">
						<font color="#FFFAFA">
							<center>AUTOEVALUACIÓN (Solo información capturada no es definitiva)</center>
						</font>
					</td>
					<td>
						<center>AUTOEVALUACIÓN-<cfoutput>#prc.folio.PKASPIRANTE[1]#</cfoutput></center>
					</td>
				</tr>
				<tr>
					<td>
						<center>Ciudad de México, <cfoutput>#prc.Fecha.FECHA[1]#</cfoutput></center>
					</td>
				</tr>
			</table>

			<table width="100%"	border=.5 cellspacing=0 cellpadding=0 bordercolor="#000000" style="font-size: 10px;">
				<tr>
					<td bgcolor="#404040">
						<font color="#FFFAFA">
							<center>ACADÉMICO</center>
						</font>
					</td>
					<td>
						<center><cfoutput>#prc.nombre#</cfoutput></center>
					</td>
				</tr>
				<tr>
					<td bgcolor="#404040">
						<font color="#FFFAFA">
							<center>DEPENDENCIA</center>
						</font>
					</td>
					<td>
						<center><cfoutput>#prc.ur#</cfoutput></center>
					</td>
				</tr>
			</table>

			<cfloop collection="#prc.clasificaciones#" item="clasificacion">
				<cfif val(clasificacion) LTE 3>
					<table width="50%"	border=.5 cellspacing=0 cellpadding=0 bordercolor="#000000" style="font-size: 10px; float: left;">
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
									<td bgcolor="##404040">
										<font color="##FFFAFA">
											<center>#prc.clasificaciones[clasificacion]["ROMANO"]#.#prc.clasificaciones[clasificacion]["SUBCLASIFICACIONES"][subclasificacion]["ROMANO"]#</center>
										</font>
									</td>														
									<cfloop from="#prc.proceso.getFECHAINIPROC()#" to="#prc.proceso.getFECHAFINPROC()#" index="anio">
										<td>
											<center>
												<cfif structKeyExists(prc.resumen,clasificacion)>
													<cfif structKeyExists(prc.resumen[clasificacion],subclasificacion)>
														<cfif structKeyExists(prc.resumen[clasificacion][subclasificacion], anio)>
															#prc.resumen[clasificacion][subclasificacion][anio]["PUNTAJE"]#
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
											<cfif structKeyExists(prc.resumen,clasificacion)>
												<cfif structKeyExists(prc.resumen[clasificacion],subclasificacion)>
													#prc.resumen[clasificacion][subclasificacion]["PUNTAJESUBCLASIFICACION"]#
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
										<cfif structKeyExists(prc.resumen,clasificacion)>
											#prc.resumen[clasificacion]["PUNTAJECLASIFICACION"]#
											<cfset totalActividades += prc.resumen[clasificacion]["PUNTAJECLASIFICACION"]>
										<cfelse>
											0
										</cfif>
									</center>
								</td>
							</tr>
						</cfoutput>
					</table>
				<cfelseif val(clasificacion) EQ 4>
					<table width="50%"	border=.5 cellspacing=0 cellpadding=0 bordercolor="#000000" style="font-size: 10px;">
						<tr>
							<td bgcolor="#404040" rowspan="2">
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
								<td>
									<center>#suma#</center>
								</td>

								<cfif structKeyExists(prc.RESUMEN, clasificacion)>
									<td>
										<center>#prc.RESUMEN[clasificacion]["ROMANO"]#</center>
									</td>
									<td>
										<center>#prc.RESUMEN[clasificacion]["PUNTAJECLASIFICACION"]#</center>
									</td>
									<cfif prc.RESUMEN[clasificacion]["PUNTAJECLASIFICACION"] GT suma >
										<td><center>#suma#</center></td>
										<td><center>#suma#</center></td>
										<cfset totalActividades += suma>
									<cfelse>								
										<td><center>#prc.RESUMEN[clasificacion]["PUNTAJECLASIFICACION"]#</center></td>
										<td><center>#prc.RESUMEN[clasificacion]["PUNTAJECLASIFICACION"]#</center></td>
										<cfset totalActividades += prc.RESUMEN[clasificacion]["PUNTAJECLASIFICACION"]>
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
					<table width="21%"	border=.5 cellspacing=0 cellpadding=1 bordercolor="#000000" style="font-size: 10px; float:left; ">
						<tr>
							<td bgcolor="#404040" colspan="<cfoutput>#2+totalAnios#</cfoutput>">
								<font color="#FFFAFA">
									<center>VII. ACTIVIDADES ACADÉMICO-ADMINISTRATIVAS</center>
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
											<cfif structKeyExists(prc.resumen,clasificacion)>
												<cfif structKeyExists(prc.resumen[clasificacion],subclasificacion)>
													#prc.resumen[clasificacion][subclasificacion]["PUNTAJESUBCLASIFICACION"]#
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
										<cfif structKeyExists(prc.resumen,clasificacion)>
											#prc.resumen[clasificacion]["PUNTAJECLASIFICACION"]#
											<cfset totalActividades += prc.resumen[clasificacion]["PUNTAJECLASIFICACION"]>
										<cfelse>
											0
										</cfif>
									</center>
								</td>
							</tr>			
						</cfoutput>
					</table>
				<cfelse>
					<table width="14%"	border=.5 cellspacing=0 cellpadding=1 bordercolor="#000000" style="font-size: 10px; float:left; ">
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
											<cfif structKeyExists(prc.resumen,clasificacion)>
												<cfif structKeyExists(prc.resumen[clasificacion],subclasificacion)>
													#prc.resumen[clasificacion][subclasificacion]["PUNTAJESUBCLASIFICACION"]#
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
										<cfif structKeyExists(prc.resumen,clasificacion)>
											#prc.resumen[clasificacion]["PUNTAJECLASIFICACION"]#
											<cfset totalActividades += prc.resumen[clasificacion]["PUNTAJECLASIFICACION"]>
										<cfelse>
											0
										</cfif>
									</center>
								</td>
							</tr>
						</cfoutput>				

				</cfif>				
			</cfloop>		
		
			<br>
			<table width="30%"	border=.5 cellspacing=0 cellpadding=1 bordercolor="#000000" style="font-size: 10px;  float: right;">
				<tr>
					<td colspan="4" bgcolor="#404040">
						<font color="#FFFAFA">
							<center>TOTAL DE ACTIVIDADES</center>
						</font>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<center><cfoutput>#totalActividades#</cfoutput></center>
					</td>
				</tr>
			</table>			
		
			<br>
			<table width="30%" border=.5 cellspacing=0 cellpadding=1 bordercolor="#000000" style="font-size: 10px;  float: right;">
				<tr>
					<td colspan="4" bgcolor="#404040">
						<font color="#FFFAFA">
							<center>OBSERVACIONES</center>								
						</font>
					</td>
				</tr>
				<tr>
					<td colspan="4">						
						<cfif isQuery(prc.observaciones) AND prc.observaciones.RECORDCOUNT GT 0>
							<!--- <center> --->
								<cfoutput>#prc.observaciones.OBSERVACION_CA[1]#</cfoutput>
							<!--- </center> --->
						<cfelse>
							<center><i>La solicitud no cuenta con observaciones</i></center>
						</cfif>
					</td>
				</tr>
			</table>

		</font>
	</body>

	<cfdocumentitem type="footer">	
		<font face="calibri">
			<center>
				<table>
						<tr>
							<td>
								Este documento carece de validez oficial para la asignación de nivel, solo es un ejercicio de autoevaluación.
							</td>
						</tr>
				</table>
			</center>
		</font>
	</cfdocumentitem>
</cfdocument>
