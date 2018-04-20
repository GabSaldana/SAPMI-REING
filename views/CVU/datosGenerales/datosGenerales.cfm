<!---
* =========================================================================
* IPN - CSII
* Sistema:		SIIP
* Modulo:		Datos generales del investigador
* Fecha:		Octubre de 2017
* Descripcion:	Vista de los datos generales del investigador
* Autor:		Roberto Cadena
* =========================================================================
--->
<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="datosGenerales_js.cfm">
<style type="text/css">
	.content{
		height: 75vh !important;
		overflow: auto !important;
	}
	.tabcontrol > .content > .body {
		width: 100%;
	}
</style>
<div class="row wrapper border-bottom white-bg page-heading">
	<div class="col-lg-10">
		<h2>Datos Generales</h2>
		<ol class="breadcrumb">
			<cfoutput>
			<li>
				<a href="#event.buildLink('inicio')#">Inicio</a>
			</li>
			<li class="active">
				<strong>Datos Generales</strong>
			</li>
			</cfoutput>
		</ol>
	</div>

	<input type="hidden" id="pkPersona" value="<cfoutput>#prc.pkPersona.pkPersona[1]#</cfoutput>">

	<div id="wizard">
		<h1><div class="guia-General">Información General</div></h1>
		<div class="row">
			<div class="col-md-12" id="informacionGeneralContent"></div>
		</div>

		<h1><div class="guia-DatosLocalizacion">Datos de Localización</div></h1>
		<div class="row">
			<div class="col-md-12" id="datosLocalizacionContent"></div>
		</div>

		<h1><div class="guia-Adscripcion">Trayectoria IPN</div></h1>
		<div class="row">
			<div class="col-md-12" id="trayectoriaIpnContent"></div>
		</div>

		<h1><div class="guia-Escolaridad">Formación Académica</div></h1>
		<div class="row">
			<div class="col-md-12" id="escolaridadContent"></div>
		</div>

		<h1><div class="guia-SNI">SNI</div></h1>
		<div class="row">
			<div class="col-md-12" id="sniContent"></div>
		</div>

		<h1><div class="guia-Empleos">Empleos</div></h1>
		<div class="row">
			<div class="col-md-12" id="empleosContent"></div>
		</div>

		<h1><div  class="guia-Becas">Becas</div></h1>
		<div class="row">
			<div class="col-md-12" id="becasContent"></div>
		</div>
	</div>

</div>



<ul id="tlyPageGuide" data-tourtitle="Consulta">

	<li class="tlypageguide_right" data-tourtarget=".guia-General">
		<div>Información General.<br>
			En esta pestaña podremos encontrar datos personales y datos de localización.			
			</br><a class="fa fa-warning"></a> Es importante que verifique que su información sea correcta, ya que sera utilizada en la aplicación al estimulo de EDI.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guia-Adscripcion">
		<div>De clic para ver la información relacionada con su Trayectoria en el IPN.<br>
			En este apartado encontraremos datos de la adscripción laboral, plazas y nombramientos.
			</br><a class="fa fa-warning"></a> Es importante que verifique que su información sea correcta, ya que sera utilizada en la aplicación al estimulo de EDI.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guia-Escolaridad">
		<div>De clic para ver la información relacionada con su Formación académica.<br>
			En esta sección se administra el historial de escolaridad.
			</br><a class="fa fa-warning"></a> Es importante que verifique que su información sea correcta, ya que sera utilizada en la aplicación al estimulo de EDI.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guia-SNI">
		<div>De clic para ver la información relacionada con su nivel de SNI.<br>
			En esta sección se administra el historial de nombramientos de SNI, así como el estatus en la red de investigadores o expertos.
			</br><a class="fa fa-warning"></a> Es importante que verifique que su información sea correcta, ya que sera utilizada en la aplicación al estimulo de EDI.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guia-Empleos">
		<div>De clic para ver la información relacionada con los Empleos.<br>
			En esta sección se administra el historial de empleos.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guia-Becas">
		<div>De clic para ver las Becas capturadas.<br>
			En esta sección se administra el historial de la becas que se han disfrutado (EDD, COFFA).
			</br><a class="fa fa-warning"></a> Es importante que verifique que su información sea correcta, ya que sera utilizada en la aplicación al estimulo de EDI.
		</div>
	</li>

	<!---******************  GUIA DE INFORMACION GENERAL *************--->
	<li class="tlypageguide_left" data-tourtarget=".guiaDatosPersonalesIbox">
		<div>Datos Personales.<br>
			En este apartado tenemos la información personal.
		</div>
	</li>
	<li class="tlypageguide_left" data-tourtarget=".guiaDocumentosComprobatoriosIbox">
		<div>Documentos Comprobatorios.<br>
			Aquí se pueden cargar los documentos comprobatorios según sea el caso.
		</div>
	</li>	
	<li class="tlypageguide_left" data-tourtarget=".guiaDatosLocalizacionIbox">
		<div>Datos de Localización.<br>
			En esta sección se pueden consultar y modificar los datos de localización.			
		</div>
	</li>			
	<li class="tlypageguide_top" data-tourtarget=".guiaCorreosIbox">
		<div>Correo Electrónico.<br>
			En este apartado se pueden consultar y capturar tanto el correo del IPN como un correo Alternativo.
		</div>
	</li>		
	<li class="tlypageguide_top" data-tourtarget=".guiaTelefonosIbox">
		<div>Teléfonos Registrados.<br>
			Se muestran los números telefónicos registrados.<br>			
			Para capturar un nuevo numero telefónico, basta con hacer click en <div class="btn btn-primary btn-xs btn-rounded"><i class="fa fa-plus"></i>&nbsp;&nbsp; AGREGAR TELÉFONO</div>
		</div>
	</li>		
	<li class="tlypageguide_top" data-tourtarget="#btn_save_infoGeneral">
		<div>Guardar.<br>
			Para guardar los datos de localización y la información de correos electrónicos, debe hacer click en <button class="btn btn-xs btn-circle btn-info" data-toggle="tooltip" title="" data-original-title="Guardar Información">
			<i class="fa fa-save"></i>
		</button>		
		</div>
	</li>			

<!---******************  GUIA DE BECAS *************--->

	<li class="tlypageguide_right" data-tourtarget=".guiaAddBecas">
		<div>Agregar un registro al Historial de Becas.<br>
			Al hacer clic se abre un formulario en el cual puede ingresar el historial que ha tenido en el Becas.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaEliminarBecas">
		<div>Eliminar registro del Historial de Becas.<br>
			Al hacer clic se puede eliminar el registro seleccionado.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaEditarBecas">
		<div>Editar registro de Becas.<br>
			Al hacer clic se abre un formulario en el cual puede editar el registro del historial de Becas.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaCerrarBecas">
		<div>Cerrar formulario.<br>
			Al hacer clic se cierra el formulario.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaTipoBeca">
		<div>Tipo de beca.<br>
			Al hacer clic se muestra las becas existentes.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaNivelBecas">
		<div>Nivel de Becas.<br>
			Al hacer clic nos muestra los niveles existentes de la Beca seleccionada.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaInicioBeca">
		<div>Inicio Becas.<br>
			Ingresar la fecha donde empezó el periodo de Beca.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaFinBeca">
		<div>Fin de Becas.<br>
			Ingresar la fecha donde terminó el periodo de Beca.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaGuardarBeca">
		<div>Guardar.<br>
			Al hacer clic guarda los datos del nuevo registro de Becas.
		</div>
	</li>
<!---******************  GUIA DE ESCOLARIDAD *************--->
	<li class="tlypageguide_right" data-tourtarget=".guiaAddEscolaridad">
		<div>Agregar un registro al Historial de Escolaridad.<br>
			Al hacer clic se abre un formulario en el cual puede registrar la escolaridad que ha tenido.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaEliminarEscolaridad">
		<div>Eliminar registro del Historial de Escolaridad.<br>
			Al hacer clic se puede eliminar el registro seleccionado.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaVerDocEscolaridad">
		<div>Mostrar el documento del registro del historial de Escolaridad.<br>
			Al hacer clic se mostrar mostrar el documento del registro seleccionado.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaEditarEscolaridad">
		<div>Editar registro de Escolaridad.<br>
			Al hacer clic se abre un formulario en el cual puede editar el registro del historial de Escolaridad.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaCerrarEscolaridad">
		<div>Cerrar formulario.<br>
			Al hacer clic se cierra el formulario.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaNivelEscolaridad">
		<div>Nivel de Escolaridad.<br>
			Al hacer clic nos muestra los niveles existentes en Escolaridad.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaPaisEscolaridad">
		<div>Países.<br>
			Al hacer clic nos muestra los países existentes donde estudió.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaPNPCEscolaridad">
		<div>PNPC.<br>
			Seleccione en caso de haber pertenecido al Programa Nacional de Posgrados de Calidad - Conacyt.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaCedulaEscolaridad">
		<div>Cédula Profesional.<br>
			Ingresar cédula profesional.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaInicioEscolaridad">
		<div>Inicio Escolaridad.<br>
			Ingresar la fecha donde empezó el periodo de Escolaridad.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaFinEscolaridad">
		<div>Fin de Escolaridad.<br>
			Ingresar la fecha donde terminó el periodo de Escolaridad.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaObtencionEscolaridad">
		<div>Obtención de Escolaridad.<br>
			Ingresar la fecha donde se obtuvo la Escolaridad.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guardarEscolaridad">
		<div>Guardar.<br>
			Al hacer clic guarda los datos del nuevo registro de Escolaridad.
		</div>
	</li>

<!---******************  GUIA DE EMPLEO *************--->

	<li class="tlypageguide_right" data-tourtarget=".guiaAddEmpleo">
		<div>Agregar un registro al Historial de Empleo.<br>
			Al hacer clic se abre un formulario en el cual puede ingresar el historial que ha tenido de Empleos.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaEliminarEmpleo">
		<div>Eliminar registro del Historial de Empleo.<br>
			Al hacer clic se puede eliminar el registro seleccionado.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaEditarEmpleo">
		<div>Editar registro de Empleo.<br>
			Al hacer clic se abre un formulario en el cual puede editar el registro del historial de Empleo.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaCerrarEmpleo">
		<div>Cerrar formulario.<br>
			Al hacer clic se cierra el formulario.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaLugarEmpleo">
		<div>Lugar de Empleo.<br>
			Ingresar lugar donde se desempeñó en ese Empleo.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaPuestoEmpleo">
		<div>Puesto de  Empleo.<br>
			Ingresar el puesto en el que ejerció.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".inInicioEmpleo">
		<div>Inicio Empleo.<br>
			Ingresar la fecha donde empezó el periodo de ese Empleo.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaFinEmpleo">
		<div>Fin de Empleo.<br>
			Ingresar la fecha donde terminó el periodo de ese Empleo.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guardarEmpleo">
		<div>Guardar.<br>
			Al hacer clic guarda los datos del nuevo registro de Empleo.
		</div>
	</li>

<!---******************  GUIA DE SNI *************--->

	<li class="tlypageguide_right" data-tourtarget=".guiaAddSNI">
		<div>Agregar un registro al Historial de SNI.<br>
			Al hacer clic se abre un formulario en el cual puede ingresar el historial que ha tenido en el SNI.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaEliminarSNI">
		<div>Eliminar registro del Historial de SNI.<br>
			Al hacer clic se puede eliminar el registro seleccionado.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaVerDocSNI">
		<div>Mostrar el documento del registro del historial de SNI.<br>
			Al hacer clic se mostrar mostrar el documento del registro seleccionado.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaEditarSNI">
		<div>Editar registro de SNI.<br>
			Al hacer clic se abre un formulario en el cual puede editar el registro del historial de SNI.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaCerrarSNI">
		<div>Cerrar formulario.<br>
			Al hacer clic se cierra el formulario.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaNivelSNI">
		<div>Nivel de SNI.<br>
			Al hacer clic nos muestra los niveles existentes en SNI.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaInicioSNI">
		<div>Inicio SNI.<br>
			Ingresar la fecha donde empezó el periodo de SNI.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guiaFinSNI">
		<div>Fin de SNI.<br>
			Ingresar la fecha donde terminó el periodo de SNI.
		</div>
	</li>
	<li class="tlypageguide_right" data-tourtarget=".guardarSNI">
		<div>Guardar.<br>
			Al hacer clic guarda los datos del nuevo registro de SNI.
		</div>
	</li>

</ul>
