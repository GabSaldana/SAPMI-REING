<!---
* ========================================================================
* IPN - CSII
* Sistema:  	SIIE 
* Modulo:   	Asignación de Responsables
* Fecha:		Marzo de 2017
* Descripcion:  Tabla para la asignación de analistas(Dependencia).
* Autor: 		Roberto Cadena
* ========================================================================
--->
<cfinclude template="administradorAnalistas_js.cfm">
<div class="form-group">
	<table>
		<tr>
			<td>
				<label id="labelVerDatos" style="margin-left: 20px;">Mostrar unicamente los formatos sin asignar:</label>
			</td>
			<td>
				<div id="guiaVerDatos" class="onoffswitch" style="margin-left: 20px;">
					<input type="checkbox" class="onoffswitch-checkbox" id="sinAsignar"
					<cfif prc.relacion.checkbox eq 1 > checked="checked" </cfif>
					>
					<label class="onoffswitch-label" for="sinAsignar">
						<span class="onoffswitch-inner"></span>
						<span class="onoffswitch-switch"></span>
					</label>
				</div>
			</td>
		</tr>
	</table>
	<div id="Formato">
		<table id="tblFomato" class="table table-striped table-responsive" data-page-size="16" data-pagination="true" 
			data-search="true" data-search-accent-neutralise="true" data-fixed-columns="true" data-fixed-number="3">
			<cfoutput>
				<thead>
					<tr>
						<th class="text-center" colspan="3" data-field="Formato">Formato</th>
						<th class="text-center" colspan="#prc.relacion.analistas.recordcount#" data-field="Analistas">Analistas</th>
					</tr>
					<tr>
						<th class="text-center col-md-4" data-field="Nombre">Nombre</th>
						<th class="text-center col-md-2" data-field="Clave">Clave</th>
						<th class="text-center col-md-3" data-field="Dependencia">Dependencia</th>
						<cfloop index="y" from="1" to="#prc.relacion.analistas.recordcount#">
							<th class="text-center guia-Select" title="Asignar todos los formatos a #prc.relacion.analistas.USUARIO[y]#">
								<input type="checkbox" class="checkAll" idanalista="#prc.relacion.analistas.PKUSUARIO[y]#"
									title="Asignar todos los formatos a #prc.relacion.analistas.USUARIO[y]#"
									idDependencia="#PRC.relacion.Dependencia#" usuario="#prc.relacion.analistas.USUARIO[y]#"
									<cfif #prc.relacion.analistaCheck[y][2]# neq 0> checked </cfif>	/>
								<br>
								#prc.relacion.analistas.USUARIO[y]# 
							</th>
						</cfloop>
					</tr>
				</thead>
				<tbody>
					<cfloop index="y" from="1" to="#prc.relacion.FORMATO.recordcount#">
						<tr>
							<td class="text-left col-md-4" idFormato="#prc.relacion.Formato.PKFORMATO[y]#" 
								title="#prc.relacion.Formato.FORMATO[y]#" >
								<cfif len(prc.relacion.Formato.FORMATO[y]) gte 40 >
									#mid(prc.relacion.Formato.FORMATO[y],1,40)#...
								<cfelse>
									#prc.relacion.Formato.FORMATO[y]# 
								</cfif>
							</td> 
							<td class="text-left col-md-2" title="#prc.relacion.Formato.CLAVEFORMATO[y]#" >
								#mid(prc.relacion.Formato.CLAVEFORMATO[y],8, 60)#
							</td>
							<td class="text-left col-md-3" title="#prc.relacion.Formato.DEPENDENCIA[y]#">
								#prc.relacion.Formato.SIGLASDEPENDENCIA[y]#
							</td>
							<cfloop index="x" from="1" to="#prc.relacion.analistas.recordcount#">
								<td class="text-center">
									<input title="Asignar el formato #prc.relacion.Formato.FORMATO[y]# a #prc.relacion.analistas.USUARIO[x]#" 
										type="checkbox" class="relacion #prc.relacion.analistas.PKUSUARIO[x]# guia-Select-single" 
										idformato="#prc.relacion.Formato.PKFORMATO[y]#" idanalista="#prc.relacion.analistas.PKUSUARIO[x]#"
										<cfloop index="z" from="1" to="#prc.relacion.usrFor.recordcount#">
											<cfif prc.relacion.usrFor.PKFORMATO[z] eq prc.relacion.Formato.PKFORMATO[y] and 
												PRC.RELACION.usrFor.PKUSUARIO[z] eq prc.relacion.analistas.PKUSUARIO[x]> checked
											</cfif>
										</cfloop> >
									</input>
								</td>
							</cfloop>
						</tr>
					</cfloop>
				</tbody>
			</cfoutput>
		</table>
	</div>
	<div id="FormatoNull">
		<table id="tblFormatoNull" class="table table-striped table-responsive" data-page-size="16" data-pagination="true" 
			data-search="true" data-search-accent-neutralise="true" data-fixed-columns="true" data-fixed-number="3">
			<cfoutput>
				<thead>
					<tr>
						<th class="text-center" colspan="3" data-field="Formato">Formato</th>
						<th class="text-center" colspan="#prc.relacion.analistas.recordcount#" data-field="Analistas">Analistas</th>
					</tr>
					<tr>
						<th class="text-center col-md-4" data-field="Nombre">Nombre</th>
						<th class="text-center col-md-2" data-field="Clave">Clave</th>
						<th class="text-center col-md-3" data-field="Dependencia">Dependencia</th>
						<cfloop index="y" from="1" to="#prc.relacion.analistas.recordcount#">
							<th class="text-center guia-Select" title="Asignar todos los formatos a #prc.relacion.analistas.USUARIO[y]#">
								<input type="checkbox" class="checkAllNull" idanalista="#prc.relacion.analistas.PKUSUARIO[y]#"
									title="Asignar todos los formatos a #prc.relacion.analistas.USUARIO[y]#"
									idDependencia="#PRC.relacion.Dependencia#" usuario="#prc.relacion.analistas.USUARIO[y]#"/>
								<br>
								#prc.relacion.analistas.USUARIO[y]# 
							</th>
						</cfloop>
					</tr>
				</thead>
				<tbody>
				<cfloop index="y" from="1" to="#prc.relacion.formatosNull.recordcount#">
					<tr>
						<td class="text-left col-md-4" idFormato="#prc.relacion.formatosNull.PKFORMATO[y]#" 
							title="#prc.relacion.formatosNull.FORMATO[y]#" >
							<cfif len(prc.relacion.formatosNull.FORMATO[y]) gte 40 >
								#mid(prc.relacion.formatosNull.FORMATO[y],1,40)#...
							<cfelse>
								#prc.relacion.formatosNull.FORMATO[y]# 
							</cfif>
						</td> 
						<td class="text-left col-md-2" title="#prc.relacion.formatosNull.CLAVEFORMATO[y]#" >
							#mid(prc.relacion.formatosNull.CLAVEFORMATO[y],8, 60)#
						</td>
						<td class="text-left col-md-3" title="#prc.relacion.formatosNull.DEPENDENCIA[y]#">
							#prc.relacion.formatosNull.SIGLASDEPENDENCIA[y]#
						</td>
						<cfloop index="x" from="1" to="#prc.relacion.analistas.recordcount#">
							<td class="text-center">
								<input title="Asignar el formato #prc.relacion.formatosNull.FORMATO[y]# a #prc.relacion.analistas.USUARIO[x]#" 
									type="checkbox" class="relacion #prc.relacion.analistas.PKUSUARIO[x]# guia-Select-single" 
									idformato="#prc.relacion.formatosNull.PKFORMATO[y]#" idanalista="#prc.relacion.analistas.PKUSUARIO[x]#"
									>
								</input>
							</td>
						</cfloop>
					</tr>
				</cfloop>
				</tbody>
			</cfoutput>
		</table>
	</div>
</div>
<script type="text/javascript">
	if(<cfoutput>#PRC.RELACION.checkbox#</cfoutput> == 1){
		$("#sinAsignar").prop('checked')
		$('#Formato').hide();
		$('#FormatoNull').show(); 
	}
	else{
		$('#Formato').show();
		$('#FormatoNull').hide();
	} 
</script>