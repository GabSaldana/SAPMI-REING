<!---
* =========================================================================
* IPN - CSII
* Sistema:			SIIP
* Modulo:				Datos generales del investigador
* Fecha:				Octubre de 2017
* Descripcion:	Vista de la informacion del investigador
* Autor:				Daniel Memije
* =========================================================================
--->

<cfset persona     = #prc.persona#>
<cfset personaSiga = #prc.personaSiga#>
<cfset datosLoc    = #prc.datosLoc#>

<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="informacionGeneral_js.cfm">
<style type="text/css">	
	.disabled{
		background-color: #eee;
		cursor: not-allowed;
	}
	#informacionGeneralContent .row{
		padding: 2px 0px;
	}
	.hr-line-dashed{
		border-top: 1px dashed #337ab7;
	}
	.correo{
		text-transform: none !important;
	}
	.select2-container--default .select2-selection--single,
		.select2-container--default .select2-selection--multiple {
		  border-color: #e7eaec;
		}
		.select2-container--default.select2-container--focus .select2-selection--single,
		.select2-container--default.select2-container--focus .select2-selection--multiple {
		  border-color: #1ab394;
		}
		.select2-container--default .select2-results__option--highlighted[aria-selected] {
		  background-color: #1ab394;
		}
		.select2-container--default .select2-search--dropdown .select2-search__field {
		  border-color: #e7eaec;
		}
		.select2-dropdown {
		  border-color: #e7eaec;
		}
		.select2-dropdown input:focus {
		  outline: none;
		}
		.select2-selection {
		  outline: none;
		}
		.ui-select-container.ui-select-bootstrap .ui-select-choices-row.active > a {
		  background-color: #1ab394;
		}
		.select2-selection{
			border-radius: 1px !important;
			border: 1px solid #e5e6e7 !important;		
			height: 100% !important;
		}
		.select2-container--default .select2-selection--single .select2-selection__rendered {
    	color: #444;
    	line-height: 1.42857143 !important;
		}
</style>

<cfoutput>
<!---<div class="row">
	<div class="col-md-12 alert alert-warning">
		<p class="text-center"><strong>Si usted observa que es necesaria la actualización de sus datos, diríjase al Departamento de Capital Humano de su unidad académica.</strong></p>
	</div>
</div>--->
<div class="form-group">
	<div class="row">
		<div class="col-md-8">
			<div class="ibox">
				<div class="ibox-title">
					<h5>DATOS PERSONALES</h5>		
				</div>
				<div class="ibox-content guiaDatosPersonalesIbox">	
					<div class="row">
						<div class="col-md-2">
							<img class="img-responsive" src="http://via.placeholder.com/500x500">		
						</div>			
						<div class="col-md-10">
							<div class="row">
								<div class="col-md-12">
									<label class="control-label text-right">Nombre</label>
									<p class="form-control disabled">#persona.getNombreCompleto()#</p>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<label class="control-label">Identificación Oficial</label>								
									<p class="form-control disabled">#personaSiga.getNUM_IFE()#</p>								
								</div>
							</div>												
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<label class="control-label">Género</label>
							<p class="form-control disabled">#persona.getGENERO()#</p>
						</div>			
						<div class="col-md-4">
							<label class="control-label">País de Nacimiento</label>
							<p class="form-control disabled">#personaSiga.getPAIS_NAC()#</p>
						</div>			
						<div class="col-md-4">
							<label class="control-label">Lugar de Nacimiento</label>
							<p class="form-control disabled">#personaSiga.getESTADO()#</p>
						</div>			
					</div>
					<div class="row">
						<div class="col-md-4">
							<label class="control-label">Nacionalidad</label>
							<p class="form-control disabled">#personaSiga.getNACIONALIDAD()#</p>
						</div>			
						<div class="col-md-4">
							<label class="control-label">Fecha de Nacimiento</label>
							<p class="form-control disabled">#dateFormat(personaSiga.getFECHA_NAC(),'dd/mm/yyyy')#</p>
						</div>			
						<div class="col-md-4">
							<label class="control-label">Edad</label>
							<p class="form-control disabled">#personaSiga.getEDADCALC()# años</p>
						</div>			
					</div>
					<div class="row">
						<div class="col-md-4">
							<label class="control-label">Estado Civil</label>
							<p class="form-control disabled">#personaSiga.getESTADO_CIVIL()#</p>
						</div>			
						<div class="col-md-4">
							<label class="control-label">RFC</label>
							<p class="form-control disabled">#persona.getRFC()#</p>
						</div>			
						<div class="col-md-4">
							<label class="control-label">CURP</label>
							<p class="form-control disabled">#persona.getCURP()#</p>
						</div>			
					</div>
					<!--- <div class="row">
						<div class="col-md-4">
							<label class="control-label">No. ISSSTE</label>
							<p class="form-control disabled">#personaSiga.getNO_ISSSTE()#</p>
						</div>			
						<div class="col-md-4">
							<label class="control-label">No. SS</label>
							<p class="form-control disabled">#personaSiga.getNO_SEGUROSOCIAL()#</p>
						</div>			
						<div class="col-md-4">
							<label class="control-label">Cuenta SAR</label>
							<p class="form-control disabled">#personaSiga.getCUENTA_SAR()#</p>
						</div>			
					</div>	 --->			
				</div>	
			</div>
		</div>
		<div class="col-md-4">
			<div class="ibox">
				<div class="ibox-title">
					<h5>DOCUMENTOS COMPROBATORIOS</h5>		
				</div>
				<div class="ibox-content guiaDocumentosComprobatoriosIbox">
					<div class="row">			
						<div class="col-md-12">
							<div id="doc_actaNacimiento"></div>							
						</div>
					</div>
					<div class="row">			
						<div class="col-md-12">
							<div id="doc_curp"></div>
						</div>
					</div>
					<div class="row">			
						<div class="col-md-12">
							<div id="doc_idOficial"></div>
						</div>
					</div>
					<!--- <div class="row">
						<img src="/includes/img/login/migdocs.jpg" width="300" height="300" class="img-responsive center-block"/><br>
						<h3 class="text-center" style="color:red">AVISO IMPORTANTE</h3>
						<h3 class="text-center">Los documentos que se adjuntaron en convocatorias anteriores aún están en proceso de migración. Podrá consultarlos en su totalidad a más tardar el próximo viernes 15 de diciembre.</h3>
					</div> --->
				</div>
			</div>
		</div>
	</div>
</div>

</cfoutput>
