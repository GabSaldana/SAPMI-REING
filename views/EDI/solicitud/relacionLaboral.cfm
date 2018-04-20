 <!---
* =========================================================================
* IPN - CSII
* Sistema:	SIIIP
* Modulo:	Generador PDF
* Fecha:	Diciembre de 2017
* Autor:	Roberto Cadena
* =========================================================================
--->
<cfdocument format="PDF" saveAsName = "cartaNoRelacionLaboral.pdf" unit="cm" margintop="5" marginbottom="3" marginleft="1" marginright="1" orientation="portrait" pagetype="letter">
	<cfdocumentitem type="header"><br>		
		<table width="100%"> 
			<tr> 
				<td>
					<img height="104" width="291" src="file:///C:\ColdFusion11\cfusion\wwwroot\includes\img\logo\logo_sep.png">
				</td>
				<td width="1000"></td>
				<td>
					<img height="86" width="322" src="file:///C:\ColdFusion11\cfusion\wwwroot\includes\img\login\IPN-AlingR_guinda.png">
				</td> 
			</tr>			
			<tr>	
				<td></td><td></td>
				<td colspan="3">
					&nbsp;Número de Folio: <cfoutput>#prc.folio.PKASPIRANTE[1]#</cfoutput><br>
					Ciudad de México, <cfoutput>#prc.fecha.FECHA[1]#</cfoutput>
				</td>
			</tr>
		</table>
	</cfdocumentitem>
	<body background="file:///C:\ColdFusion11\CFUSION\wwwroot\includes\img\logo\logo_mex.png"  style="font-size: 13px;font-family: Arial,Helvetica Neue,Helvetica,sans-serif;">
		<br><br><br>
		C. Presidente del Comité Académico del
		<br>	Estímulo al Desempeño de los Investigadores
		<br>
		Presente,
		<br><br><br>
		Por este medio declaro:
		<br><br><br>
		1.-Ser académico de tiempo completo y exclusivo del Instituto Politécnico Nacional.
		<br><br>
		2.-No tener ningún tipo de relación contractual con otra institución o dependencia.
		<br><br>
		3.-No tener ninguna relación laboral con el Centro de Investigación y de Estudios Avanzados (CINVESTAV).
		<br><br>
		4.-No haber solicitado ingreso en el mismo periodo al Programa de Estímulos al Desempeño Docente (EDD).
		<br><br>
		5.-Informar por escrito a la Dirección de Investigación cualquier tipo de modificación en mi estado laboral dentro del Instituto durante el periodo en el que sea beneficiario del Estímulo al Desempeño de los Investigadores (EDI) 2018-2020.
		<br><br><br><br><br><br>
		<b>Atentamente</b>
		<br><br>
		<table style="font-size: 13px;font-family: Arial,Helvetica Neue,Helvetica,sans-serif;">
			<tr>
				<td width="270px">
					<br><b>Firma:</b>
				</td>
				<td width="270px">
					______________________________
				</td>
			</tr>
				<tr>
				<td width="270px">
					<br><b>Nombre completo:</b>
				</td>
				<td width="270px">
					<br><cfoutput>#prc.datos.nombre# #prc.datos.appat# #prc.datos.apmat#</cfoutput>
				</td>
			</tr>
				<tr>
				<td width="270px">
					<br><b>Número de empleado:</b>
				</td>
				<td width="270px">
					<br><cfoutput>#prc.datos.NUMEMPLEADO#</cfoutput>
				</td>
			</tr>
				<tr>
				<td width="270px">
					<br><b>Unidad Académica y/o Centro:</b>
				</td>
				<td width="270px">
					<br><cfoutput>#prc.ur.NOMBRE#</cfoutput>
				</td>
			</tr>
		</table>
	</body>
	<cfdocumentitem type="footer">
		<style type="text/css">		
			table{
				font-size: 12.5px;				
				font-family: Arial,Helvetica Neue,Helvetica,sans-serif;
			}			
			.centrar{
				text-align: center;
			}
		</style>
		<br>
		<table width="100%">
				<tr>
					<td >
						Edificio de la Secretaría Académica, 2° piso, Av. Luis Enrique Erro S/N, Unidad Profesional "Adolfo López Mateos", Zacatenco T.+52 (55) 5729-6000 ext. 50486, 50479 y 50593, www.sip.ipn.mx
					</td>	
				</tr>
		</table>
	</cfdocumentitem>

</cfdocument>