<!---
* ========================================================================
* IPN - CSII
* Sistema:  	SIIE 
* Modulo:   	Asignación de Responsables
* Fecha:		Marzo de 2017
* Descripcion:  Tabla para la asignación de responsables(Dependencia).
* Autor: 		Roberto Cadena
* ========================================================================
--->
<cfinclude template="administradorResponsables_js.cfm">
<cfprocessingdirective pageEncoding="utf-8">
<div class="ibox-content">
	<cfif PRC.RELACION.FLAG neq 0>
		<h4>Seleccionar responsables.</h4>
		<cfset t =1>
		<ul class="sortable-list connectList agile-list ui-sortable">
			<cfoutput query="PRC.RELACION.usuariosUnicos">
				<li class="list-group-item guia-Select" title="Asignar todos los formatos a #USUARIO#"
					style="background-color:###formatBaseN(290-45*t, 16)##formatBaseN(285-30*t, 16)##formatBaseN(260-5*t, 16)#;">
					<cfset t = t+1>
					<input class="checkAll"	type="checkbox"	idDependencia="#PRC.RELACION.DEPENDENCIA#" idAnalista="#PKUSUARIO#" 
						<cfloop index="y" from="1" to="#ArrayLen(PRC.RELACION.usuarioCheck)#">
							<cfif PRC.RELACION.usuarioCheck[y][1] eq PKUSUARIO and 
							PRC.RELACION.usuarioCheck[y][2] eq 1 > checked </cfif>
						</cfloop> usuario="#USUARIO#">
					</input>	
					#USUARIO#
				</li>
			</cfoutput>
		</ul>
	<cfelse>
		<h4>No existen responsables para esta dependencia.</h4>
	</cfif>
</div>
<div class="ibox-content">
<table id="tblFomato" class="table table-responsive" data-page-size="4" data-pagination="true" 
	data-search="true" data-search-accent-neutralise="true" >
	<thead>
		<tr>
			<th class="text-center col-md-3" data-sortable="true" data-field="Formato">Formato</th>
			<th class="text-center col-md-2" data-sortable="true" data-field="Clave">Clave</th>
			<th class="text-center col-md-2" data-sortable="true" data-field="Dependencia">Dependencia</th>
			<th class="text-center col-md-2" data-sortable="true" data-field="Usuarios">Usuarios</th>
		</tr>
	</thead>
	<tbody>
		<cfoutput query="PRC.RELACION.formatos">
			<tr>
				<td class="text-left" data-sortable="true" title="#FORMATO#">
					#FORMATO#
				</td>
				<td class="text-center" data-sortable="true" title="#CLAVEFORMATO#">
					#mid(CLAVEFORMATO,8, 60)#
				</td>
				<td class="text-center" data-sortable="true" title="#DEPENDENCIA#">
					#SIGLASDEPENDENCIA#
					<input type="hidden" data-sortable="true" value="#DEPENDENCIA#">
				</td>
				<td class="text-left" data-sortable="true">
					<ul class="sortable-list agile-list connectList ui-sortable">
						<cfset t =1>
						<cfloop index="x" from="1" to="#PRC.RELACION.USUARIOS.recordcount#">
							<cfif PRC.RELACION.USUARIOS.PKFORMATO[x] eq PKFORMATO >
								<li class="list-group-item"  title="Asignar el formato #FORMATO# a #PRC.RELACION.USUARIOS.USUARIO[x]#"
									style="background-color:###formatBaseN(290-45*t, 16)##formatBaseN(285-30*t, 16)##formatBaseN(260-5*t, 16)#;">
									<cfset t = t+1>
									<input class="relacion #PRC.RELACION.USUARIOS.PKUSUARIO[x]# guia-Select-single" 
										type="checkbox"	idformato="#PKFORMATO#" idanalista="#PRC.RELACION.USUARIOS.PKUSUARIO[x]#"
										<cfloop index="y" from="1" to="#PRC.RELACION.usrFor.recordcount#">
											<cfif PRC.RELACION.usrFor.PKFORMATO[y] eq PKFORMATO and 
												PRC.RELACION.usrFor.PKUSUARIO[y] eq PRC.RELACION.USUARIOS.PKUSUARIO[x] > checked
											</cfif>
										</cfloop> >
									</input>
									#PRC.RELACION.USUARIOS.usuario[x]#
								</li>
							</cfif>
						</cfloop>
					</ul>
				</td>
			</tr>
		</cfoutput>
	</tbody>
</table>
</div>