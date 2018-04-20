<!----
* ================================
* IPN – CSII
* Sistema:     DIRECCION DE INVESTIGACION
* Modulo:      Convenios
* Sub modulo:  Convenios
* Fecha:       14 de Noviembre del 2017
* Descripcion: Vista general de datos del investigador
* Autor:       Alejandro tovar
* ================================
---->

<cfprocessingdirective pageEncoding="utf-8">

<style type="text/css">	
	.disabled{
		background-color: #eee;
		cursor: not-allowed;
	}
</style>

<cfset usuario = deserializeJSON(prc.usuario)>

<cfoutput>
	<div class="form-group">
		<div class="row">
			<div class="ibox">
				<div class="ibox-title">
					<h5>DATOS PERSONALES</h5>
				</div>
				<div class="ibox-content">
					<div class="row">
						<div class="col-md-4">
							<label class="control-label text-right">Nombre</label>
							<p class="form-control disabled">#usuario["NOMBRE"]# #usuario["PRIMER APELLIDO"]# #usuario["SEGUNDO APELLIDO"]#</p>
						</div>
						<div class="col-md-4">
							<label class="control-label">RFC</label>
							<p class="form-control disabled">#usuario["RFC"]#</p>
						</div>
						<div class="col-md-4">
							<label class="control-label">CURP</label>
							<p class="form-control disabled">#usuario["CURP"]#</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<label class="control-label">Número de empleado</label>
							<p class="form-control disabled">#usuario["NO. EMPLEADO"]#</p>
						</div>
						<div class="col-md-4">
							<label class="control-label">Género</label>
							<p class="form-control disabled">#usuario["GÉNERO"]#</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<label class="control-label">Grado académico</label>
							<p class="form-control disabled">#usuario["GRADO ACADÉMICO"]#</p>
						</div>
						<div class="col-md-4">
							<label class="control-label">Rol del investigador</label>
							<p class="form-control disabled">#usuario["ROL USUARIO CAI"]#</p>
						</div>
						<div class="col-md-4">
							<label class="control-label">ECU</label>
							<p class="form-control disabled">#usuario["ECU"]#</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<label class="control-label">Teléfono</label>
							<p class="form-control disabled">#usuario["TEL"]#</p>
						</div>
						<div class="col-md-4">
							<label class="control-label">Extensión</label>
							<p class="form-control disabled">#usuario["EXT"]#</p>
						</div>
						<div class="col-md-4">
							<label class="control-label">Celular</label>
							<p class="form-control disabled">#usuario["EXT"]#</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</cfoutput>
