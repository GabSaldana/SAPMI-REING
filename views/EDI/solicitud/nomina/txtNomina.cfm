<cfcontent type="text/plain">

<cfif prc.tipoDoc EQ 1>
	<cfheader name="content-disposition" value="attachment;filename=reporteNomina.txt">
<cfelseif prc.tipoDoc EQ 2>
	<cfheader name="content-disposition" value="attachment;filename=reporteNomina.prn">
</cfif>

<cfoutput query="prc.nomina">
	#DATOS & Chr(13)& Chr(10)#
</cfoutput>

<cfsetting enablecfoutputonly="yes">