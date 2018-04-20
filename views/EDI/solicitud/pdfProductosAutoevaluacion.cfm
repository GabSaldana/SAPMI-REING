 <!---
* =========================================================================
* IPN - CSII
* Sistema:SIIIP
* Modulo:Generador PDF
* Descripcion:
* Autor: Alejandro Rosales
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<cfdocument format="PDF" saveAsName = "detallesAutoevaluacion.pdf" unit="cm" margintop="4" marginbottom="3" marginleft="1" marginright="1" orientation="portrait" pagetype="letter">		
	<style type="text/css">			
		br {
   			display: block;
   			margin: 4px 0;
		}
		table, table td {
  			border: solid #7F7F7F;
		}
		table {
  			border-width: 1px 1px 0px 1px;
		}
		table td {
  			border-width: 0px 0px 1px 0px;
		}
		table th {
  			border-width: 0px 0px 1px 0px;
		}
		.producto{
			font-size: 8px;
			border-top: none !important;
		}
		.hd{
			border: none;
		}
	</style>
	<font face="calibri">
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
		<center>PRODUCTIVIDAD ENVIADA</center>
		<br>
		<!----- ----->
		<table class="hd" width="100%" cellspacing=0 cellpadding=0 bordercolor="#000000" style="font-size: 13px;">
			<tr>
				<td class="hd" align="right">
					Ciudad de México, <cfoutput>#prc.Fecha.FECHA[1]#</cfoutput>
				</td>
			</tr>
		</table>

		<table width="100%"	<!--- border="1" ---> cellspacing=0 cellpadding=0 bordercolor="#000000" style="font-size: 10px;">
			<tr>
				<td bgcolor="#404040" style="color: #FFFAFA;">				
					<center>ACADÉMICO</center>		
				</td>
				<td>
					<center>
						<cfoutput>#prc.nombre#</cfoutput>
					</center>
				</td>
			</tr>
			<tr>
				<td bgcolor="#404040" style="color: #FFFAFA;">
					<center>DEPENDENCIA</center>		
				</td>
				<td>
					<center><cfoutput>#prc.ur#</cfoutput></center>
				</td>
			</tr>
		</table>
		<br>
		<!----- ----->
	<cfoutput>
		<cfloop array="#ListToArray(listSort(structKeyList(prc.AUTOEVALUACION),"numeric"))#" index="x">
			<table class="hd" width="100%" cellspacing=0 cellpadding=0 bordercolor="##000000" style="font-size: 10px;">
				<thead>
					<th class="hd" bgcolor="##404040" style="color: ##FFFAFA;">
						<h3>#x#.&nbsp;#prc.AUTOEVALUACION[x]["NOMBRE"]#</h3>
					</th>
				</thead>														
			</table>
			<br>
			<cfloop from="#prc.PROCESO.getFECHAINIPROC()#" to="#prc.PROCESO.getFECHAFINPROC()#" index="anio">
				<cfloop array="#prc.productos#" index="elem">
					<cfset producto = elem.REPORTE>
					<cfset ruta = elem.RUTA>
					<cfset filas = producto.getFilas()>
					<cfset encabezado = producto.getEncabezado()>
					<cfset columnas = encabezado.getColumnas()>
					<cfset pkReporte = producto.getPkReporte()>
					<cfset pkformato = producto.getPkTFormato()>																			
					<cfloop array="#producto.getFILAS()#" index="fila">
						<cfif fila.getANIO() EQ anio and fila.getCLASIFICACION() EQ x>
							<table width="100%" border=.5 cellspacing=0 cellpadding=0 bordercolor="##000000" style="font-size: 10px;">
								<tbody>
									<tr>
										<td width="15%">
											<h3>#anio#</h3>
										</td>
										<td width="85%">
											<cfoutput>	#fila.getCLASIFICACION()#.#fila.getSUBCLASIFICACION()# - #arrayToList(ruta," / ")#	</cfoutput>
										</td>
									</tr>
									
								</tbody>
							</table>					
							<table  width="100%" <!--- border=.5  ---> cellspacing=0 cellpadding=0 bordercolor="##000000" class="producto">
								<tbody>	
									<cfset a = 1>
									<tr>						
									<cfloop  array="#columnas#" index="columna">				
										<cfif  NOT (columna.getValidator() EQ "seleccionArchivo" OR  columna.getValidator() EQ "archivoRequerido")>
											<td bgcolor="##7F7F7F" style="color: ##FFFAFA;">
													<cfoutput>#columna.getNOM_COLUMNA()#</cfoutput>:
											</td>
											<td>
												<cftry>
													<cfoutput>#fila.getCeldabyPKColumna(columna.getpk_columna()).getvalorcelda()#</cfoutput>
													<cfcatch>
													</cfcatch>
												</cftry>
											</td>
											
										</cfif>
										<cfif a EQ arrayLen(columnas)>
											<td colspan="6">
											</td>
											</tr>
										<cfelseif a MOD 3 EQ 0>
											</tr><tr> 
										</cfif>
										<cfset a = a+1>
									</cfloop>
											
								</tbody>
							</table>	
							<br>																								
						</cfif>																							
					</cfloop>										
				</cfloop> 																		
			</cfloop>																				
		</cfloop>
	</cfoutput>
</font>
</cfdocument>