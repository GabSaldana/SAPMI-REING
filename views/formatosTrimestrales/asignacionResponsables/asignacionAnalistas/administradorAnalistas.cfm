<!---
* =========================================================================
* IPN - CSII
* Sistema:  	SIIE 
* Modulo:   	Asignación de Responsables
* Fecha:		Marzo de 2017
* Descripcion:  Asignación de analistas.
* Autor: 		Roberto Cadena
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="administradorAnalistas_js.cfm">
<script src="/includes/bootstrap/bootstrap-table/fixed-columns/fixed-columns.js"></script>
<link rel="stylesheet" type="text/css" href="/views/formatosTrimestrales/formatosTrimestrales.css">
<link rel="stylesheet" type="text/css" href="/includes/bootstrap/bootstrap-table/fixed-columns/fixed-columns.css">
<style type="text/css">
	.table{
		white-space: nowrap;
		word-wrap: break-word;
	}
	thead th {
		background-color:#F9F9F9;
	}
</style>
<div class="container">
	<div class="ibox col-md-12" id="cont-Allreportes">
		<div class="ibox-title">
			<h4>Asignación de Analistas</h4>
		</div>
		<div class="ibox-content">
			<form role="form" id="form-accion" class="form-horizontal">
				<div class="form-group" id="filtrarPeriodo">
					<label class="control-label col-sm-2">Selección por Dependencia:</label>
					<div class="col-sm-6">
						<select class="form-control selectpicker guia-combo" data-live-search="true" data-style="btn-primary btn-outline" id="dependencia" onchange="obtenerFormatos(0)">
							<option disabled selected>Seleccionar una dependencia</option>
							<option title="Seleccionar todas las dependencias" value="todos"> TODAS LAS DEPENDENCIAS</option>
							<cfloop index="x" from="1" to="#PRC.RELACION.dependencia.recordcount#">
								<cfoutput>
									<option value="#PRC.RELACION.dependencia.PKDEPENDENCIA[x]#" title="#PRC.RELACION.dependencia.DEPENDENCIA[x]#">
										#PRC.RELACION.dependencia.SIGLASDEPENDENCIA[x]# &nbsp; - &nbsp; #PRC.RELACION.dependencia.DEPENDENCIA[x]#
									</option>
								</cfoutput>
							</cfloop>
						</select>
					</div>
				</div>
			</form>
			<div class="form-group" id="Formatos"></div>
		</div>
	</div>
</div>

<!--- Guia --->
<ul id="tlyPageGuide" data-tourtitle="Asignación de analistas.">
	<li class="tlypageguide_left" data-tourtarget=".guia-combo">
		<div>
			Seleccione una dependencia para asignar analistas a los formatos.
		</div>
	</li>
	<li class="tlypageguide_left" data-tourtarget=".guia-Select">
		<div>
			Hacer clic en el check-box  <input type="checkbox" checked> para seleccionar todos los formatos para el analista correspondiente.
		</div>
	</li>
	<li class="tlypageguide_left" data-tourtarget=".guia-Select-single">
		<div>
			Hacer clic en el check-box  <input type="checkbox" checked> para seleccionar un formatos para un analista.
		</div>
	</li>
</ul>