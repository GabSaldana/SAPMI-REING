<h1>M&oacute;dulo de Planeaci&oacute;n</h1>
<h3><cfoutput>Rol: #Session.cbstorage.usuario.rol#</cfoutput></h3>
<p>Acciones:</p>
<cfif ArrayFind(Session.cbstorage.grant,'Planeacion.muestra')>
	<button type="button" class="btn btn-success">Muestra</button>
</cfif>

<cfif ArrayFind(Session.cbstorage.grant,'Planeacion.valida')>
	<button type="button" class="btn btn-danger">Valida</button>
</cfif>

<cfif ArrayFind(Session.cbstorage.grant,'Planeacion.captura')>
	<button type="button" class="btn btn-danger">Captura <i class="fa fa-thumbs-o-up "></i></button>
</cfif>
<br>session:
<cfoutput>
	<cfdump var="#Session#">
</cfoutput>
