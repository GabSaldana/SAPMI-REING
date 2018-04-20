<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="solicitud_js.cfm">
<style type="text/css">
.wizard .content{
	height: 60vh !important;
	overflow: auto !important;

}
/*.wizard > .content > .body {
    width: 100%;
    height: auto;
    padding: 15px;
    position: relative;
	background-color:#ffffff ;
}*/
.wizard > .content{
	background-color:#ffffff ;
}
.element1 {float:left;}
.element2 {/*padding-right : 20px;*/float:right;}

</style>
<div class="row  wrapper border-bottom white-bg page-heading">
	<div class="row">
		<div class="col-md-4">
			<h3>Requisitos para: <span style="color:red;"><cfoutput>#prc.pestanias[1].getMOVIMIENTO()# </cfoutput></span></h3>
		</div>
		<div id="ayudaInvt">
			<div class="col-md-6">
				<!--- <div class="element1"> --->
					<i class="fa fa-square" style="color:#C1F1B2;"></i> Producto seleccionado para EDI   <i class="fa fa-square" style="color:#FDFEB9;"></i> Producto disponible para seleccionar en la solicitud  <i class="fa fa-square" style="color:#F7B8B8;"></i> Producto con campos requeridos incompletos
				<!--- </div> --->
			</div>	
			<div class="col-md-2">
				<font size="3">Productos seleccionados: </font><font class="contProductos" size="4" style="color: red;">100</font><!--- <font size="3"> productos</font> --->
			</div>
		</div>
	</div>
	
	<input type="hidden" id="pkAspirante" value="<cfoutput>#prc.solicitud#</cfoutput>">
	<div id="divClasificacion" >
		<div id="steps-solicitud">
			<input type="hidden" id="numPestanias" value="<cfoutput>#arrayLen(prc.pestanias)#</cfoutput>">
			<cfset i = 0>
			<cfloop array="#prc.pestanias#" index='pestania'>
				<h3><cfoutput>#pestania.getNombre()# </cfoutput></h3>
				<section class="stepT<cfoutput>#i#</cfoutput>" clave= '<cfoutput>#pestania.getClave()#</cfoutput>'> <div id="div<cfoutput>#pestania.getClave()#</cfoutput>"><cfoutput>#pestania.getClave()#</cfoutput></div> </section>
				<cfset i = i+1>
			</cfloop>
			<!--- <h3>Resumen</h3> --->
			<!--- <section  style="width:100%;"> <div id="divResumen"></div></section> --->
		</div>
	</div>	
</div>
<div id="divResumen" style="visible:none;">