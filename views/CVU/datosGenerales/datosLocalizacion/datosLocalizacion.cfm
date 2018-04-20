<!---
* =========================================================================
* IPN - CSII
* Sistema:			SIIP
* Modulo:				Datos de localizacion del investigador
* Fecha:				Enero de 2018
* Descripcion:	Vista de los datos de localizacion del investigador
* Autor:				Daniel Memije
* =========================================================================
--->

<cfset persona     = #prc.persona#>
<cfset personaSiga = #prc.personaSiga#>
<cfset datosLoc    = #prc.datosLoc#>

<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="datosLocalizacion_js.cfm">
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

<div class="row">	
	<div class="col-md-12">
		<div class="ibox float-e-margins">
			<div class="ibox-title"><h5> DATOS DE LOCALIZACIÓN </h5></div>
			<div class="ibox-content">								
					<div class="guiaDatosLocalizacionIbox">						
						<div class="form-group">
							<div class="row">
								<div class="col-md-4">
									<label class="control-label">Calle</label>
									<p class="form-control disabled">#datosLoc.getCALLE()#</p>									
								</div>
								<div class="col-md-4">
									<label class="control-label">No. Exterior</label>
									<p class="form-control disabled">#datosLoc.getNUMERO_EXT()#</p>
								</div>
								<div class="col-md-4">
									<label class="control-label">No. Interior</label>
									<p class="form-control disabled">#datosLoc.getNUMERO_INT()#</p>
								</div>
							</div>
						</div>											
						<div class="form-group">
							<div class="row">
								<div class="col-md-4">
									<label class="control-label">Colonia</label>
									<cfif isQuery(datosLoc.getDATOS_COLONIA())>
										<cfif datosLoc.getDATOS_COLONIA().recordcount GT 0>
											<cfloop query="#datosLoc.getDATOS_COLONIA()#">
												<cfif #PK_COLONIA# EQ datosLoc.getPK_COLONIA()>
													<p class="form-control disabled">#COLONIA#</p>																					
												</cfif>
											</cfloop>
										<cfelse>
											<p class="form-control disabled"></p>
										</cfif>
									<cfelse>
										<p class="form-control disabled"></p>
									</cfif>
								</div>
								<div class="col-md-4">
									<label class="control-label">Delegación / Municipio</label>
									<cfif isQuery(datosLoc.getDATOS_COLONIA())>
										<cfif datosLoc.getDATOS_COLONIA().recordcount GT 0>
											<cfloop query="#datosLoc.getDATOS_COLONIA()#">
												<cfif #PK_COLONIA# EQ datosLoc.getPK_COLONIA()>
													<p class="form-control disabled">#DELMUNICIPIO#</p>									
												</cfif>
											</cfloop>
										<cfelse>	
											<p class="form-control disabled"></p>
										</cfif>
									<cfelse>
											<p class="form-control disabled"></p>										
									</cfif>
								</div>
								<div class="col-md-4">
									<label class="control-label">Código Postal</label>
									<p class="form-control disabled">#datosLoc.getCP()#</p>
								</div>
							</div>
						</div>											
						<div class="form-group">
							<div class="row">								
								<div class="col-md-4">
									<label class="control-label">Localidad / Sección</label>
									<p class="form-control disabled">#datosLoc.getLOCALIDAD_SECCION()#</p>
								</div>
								<div class="col-md-4">
									<label class="control-label">Entidad Federativa</label>
									<cfif isQuery(datosLoc.getDATOS_COLONIA())>
										<cfif datosLoc.getDATOS_COLONIA().recordcount GT 0>
											<cfloop query="#datosLoc.getDATOS_COLONIA()#">
												<cfif #PK_COLONIA# EQ datosLoc.getPK_COLONIA()>
													<p class="form-control disabled">#ESTADO#</p>									
												</cfif>
											</cfloop>
											<cfelse>
												<p class="form-control disabled"></p>
										</cfif>
									<cfelse>
										<p class="form-control disabled"></p>
									</cfif>
								</div>
							</div>
						</div>	
					</div>					
					<div class="hr-line-dashed"></div>						
					<div class="form-group">
						<div class="row">														
							<div class="col-md-12">
								<h2>Correo Electrónico</h2>
								<form id="formDireccion">
								<div class="col-md-6 guiaCorreosIbox">
									<div class="row">
										<div class="col-md-12">
											<label for="in_corr_inst" class="control-label"><span class="requerido">*</span>Correo Electrónico Institucional</label>
											<input id="in_corr_inst" name="in_corr_inst" type="text" class="form-control correo" value="#persona.getCORREO_IPN()#">	
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<label for="in_corr_alt" class="control-label"><span class="requerido">*</span>Correo Electrónico Alterno</label>
											<input id="in_corr_alt" name="in_corr_alt" type="text" class="form-control correo" value="#persona.getCORREO_ALTERNO()#">					
										</div>
									</div>
									<div class="row">
										&nbsp;
									</div>
									<div class="row">
										<div class="col-md-12">
											<button type="button" class="btn btn-primary btn-rounded pull-right" disabled><i class="fa fa-save"></i><span id="lbl_guardaCorreo" style="display: none;">&nbsp;&nbsp; GUARDAR</span></button>		
										</div>
									</div>																
								</div>
								</form>														
								<div class="col-md-6 border-left guiaTelefonosIbox">
									<div id="telefonosContainer">
									</div>								
								</div>
							</div>
						</div>
					</div>					
					<!--- <div class="hr-line-dashed"></div>	
					<div class="form-group">
						<div class="row">							
							<div class="col-md-6">
								<label for="" class="control-label"><span class="requerido">*</span>Correo Electrónico Institucional</label>
								<input id="" name="" type="text" class="form-control" >								
							</div>							
							<div class="col-md-6">								
								<label for="" class="control-label"><span class="requerido">*</span>Correo Electrónico Alterno</label>
								<input id="" name="" type="text" class="form-control" >								
							</div>							
						</div>				
					</div> --->				
			</div>
		</div>		
	</div>
</div>

</cfoutput>
