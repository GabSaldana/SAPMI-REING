<h1>M&oacute;dulo de Mision y Vision </h1>
<h3><cfoutput>Rol: #Session.cbstorage.usuario.rol#</cfoutput></h3>
<p>Acciones:</p>
<cfif ArrayFind(Session.cbstorage.grant,'Planeacion.muestra')>
	<button type="button" class="btn btn-success">Muestra</button>
</cfif>

<cfif ArrayFind(Session.cbstorage.grant,'Planeacion.valida')>
	<button type="button" class="btn btn-danger">Valida</button>
</cfif>
<br>session:
<cfoutput>
	<cfdump var="#Session#">
	<cfdump var="#prc#">
</cfoutput>