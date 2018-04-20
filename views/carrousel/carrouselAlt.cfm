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
<cfoutput><cfinclude template="carrouselAlt_JS.cfm"></cfoutput>
<div class="col-md-3"></div>
<div id="accordion" style="display: none;"  class="col-xs-12 col-md-6 col-sm-12" >
	<div class ="row" id="accdiv" style="margin:0;" >
		<!---Aqui se cargan los elementos dinamicamente--->
		<div id="tablaAcciones" class="col-xs-12 col-md-12 col-sm-12">
			<!--- Titulo --->
			<div class="row" style="border:1px solid #720030;color:#720030;background-color:white;">
				<div class="col-xs-12 col-sm-12 col-md-12 ">
					<center><p id="th_acciones" style="font-size: 2.3vw;">Titulo</p></center>
				</div>
			</div>
			<!--- Registros de acciones --->
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 " id="tr_acciones" >
				</div>
			</div>
		</div>
	</div>
	<div class ="row" style="margin:0;">
		<div class="ct  col-12 " style=" border-radius: 0px 0px 5px 5px;  padding-bottom: 25px !important; margin-top:0px !important; ">
			<center>
				<cfoutput><a href="#event.buildLink("ejes/ejes")#" style="font-size:4vm;text-decoration: none;" ></cfoutput>
		    	Regresar
		    	<span class="fa-layers fa-fw" >
					<i class="fas fa-arrow-left fa-w-10 fa-1x"></i>
				</span>
		  		</a>
			</center>
		</div>
	</div>
</div>
<div class="col-md-3"></div>
</div>
</div>