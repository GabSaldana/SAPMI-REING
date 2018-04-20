<!---
========================================================================
* IPN - CSII
* Portal: Planeación 2018
* Modulo: Vista del menu secundario.
* Sub modulo: -
* Fecha: Febrero 2018
* Descripcion: Vista
* Autor: GSA
=========================================================================
--->
<cfoutput><cfinclude template="carrousel_JS.cfm"></cfoutput>
<style>
	#divAvisoSinAcciones{
		position:relative;
		display:none;
		top:140px;
		width:600px;
		font-size:1.9em;
		margin:5px;
		border-radius: 9px 9px 9px 9px;
		-moz-border-radius: 9px 9px 9px 9px;
		-webkit-border-radius: 9px 9px 9px 9px;
		background-color:#EFEFEF;
		-webkit-box-shadow: 5px 5px 5px 5px rgba(0,0,0,0.75);
		-moz-box-shadow: 5px 5px 5px 5px rgba(0,0,0,0.75);
		box-shadow: 5px 5px 5px 5px rgba(0,0,0,0.75);
	}
</style>
<div id="dcss"></div>
<div id="divAvisoSinAcciones" style="margin-left:auto;margin-right:auto;">
	<p align="center">Lo sentimos, el eje seleccionado no est&aacute; disponible para el perfil ingresado.</p>
	<center>
		<cfoutput><a href="#event.buildLink("ejes/ejes")#" style="text-decoration: none;" title="Regresar"></cfoutput>
		<span class="fa-layers fa-fw" >
			<i class="fas fa-arrow-left fa-w-10 fa-1x"></i>
		</span>
		</a>
	</center>
</div>
<div id="accordion" style="display: none;">
    <div class="ct p-2" >
		<center><p id="tituloAcordeon"><p></center>
	</div>
	<div id="accdiv" style="border-right: 1px solid #720030; border-left: 1px solid #720030;">
		<ul id="accul">
			<!---Aqui se cargan los elementos dinamicamente--->
		</ul>
	</div>
	<div class="ct" style="margin-top: 0px !important; border-radius: 0px 0px 5px 5px;">
		<center>
			<cfoutput><a href="#event.buildLink("ejes/ejes")#" style="text-decoration: none; "></cfoutput>
		    Regresar
		    <span class="fa-layers fa-fw" >
				<i class="fas fa-arrow-left fa-w-10 fa-1x"></i>
			</span>
		  </a>
		</center>
	</div>
</div>