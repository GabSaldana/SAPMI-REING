<cfoutput>
	<cfdump var="#Session#">
	<cfdump var="#prc#">
</cfoutput>

<h1>M&oacute;dulo de Ingresos Excedentes</h1>
<h3><cfoutput>Rol: #Session.cbstorage.usuario.rol#</cfoutput></h3>
<p>Acciones:</p>
<cfif ArrayFind(Session.cbstorage.grant,'Presupuestacion.muestra')>
	<button type="button" class="btn btn-success">Muestra</button>
</cfif>

<cfif ArrayFind(Session.cbstorage.grant,'Presupuestacion.valida')>
	<button type="button" class="btn btn-danger">Valida</button>
</cfif>