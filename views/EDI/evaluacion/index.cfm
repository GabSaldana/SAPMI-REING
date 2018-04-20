<div class="wrapper-content">
	<div id="divBusquedaInvestigadores"></div>
	<div id="divEvaluacionEDI" style="display: none;padding-bottom: 70px;"></div>
</div>

<div class="modal inmodal  fade modal_aviso" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                <h4 class="modal-title">Datos Confidenciales</h4>
            </div>
            <div class="modal-body">
            	<div style="text-align:justify;">
					Los datos personales recabados serán protegidos y serán incorporados y tratados en el Sistema de datos personales denominado "Sistema Institucional de Información de Investigación y Posgrado", con fundamento en el artículo 68 de la Ley General de Transparencia y Acceso a la Información Pública; Decimosexto, Decimoséptimo, Vigésimo séptimo, Vigésimo octavo, Vigésimo noveno, Trigésimo primero, Trigésimo segundo, Trigésimo tercero de los Lineamientos de Protección de Datos Personales. La finalidad de recabar dicha información y datos personales es para dar cumplimiento a la normatividad del Instituto Politécnico Nacional. El Sistema Institucional de Información de Investigación y Posgrado (SIIIP),  queda inscrito en el "Listado de Sistemas de Datos Personales" ante el Instituto Federal de Acceso a la Información y Protección de Datos Personales (www.inai.org.mx) y podrán ser utilizados por instancias correspondientes dentro del Instituto Politécnico Nacional (IPN) con la finalidad de coadyuvar el ejercicio de las facultades propias de la institución, además de otras transmisiones previstas en la Ley. La Unidad responsable del sistema es la Coordinación del Sistema Institucional de Información (CSII) de la Coordinación General de Servicios Informáticos del IPN, y el domicilio donde el interesado podrá ejercer los derechos de acceso y corrección ante la misma es Unidad Profesional "Adolfo López Mateos", Edificio de "Adolfo Ruiz Cortines" (CGFIE-UPDCE), planta baja Av. Wilfrido Massieu s/n Esquina Luis Enrique Erro, Colonia Zacatenco, Delegación Gustavo A. Madero, Ciudad de México, C.P. 07738.
	            	<br>
					Lo anterior se informa en cumplimiento del Decimoséptimo de los Lineamientos de Protección de Datos Personales, publicados en el Diario Oficial de la Federación el 30 de Septiembre de 2005.
				</div>
			</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default btn-lg" data-dismiss="modal"><span class="fa fa-times"></span> Cerrar</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

	$(document).ready(function(){
		getAllInvestigadores();
		$('.modal_aviso').modal('show');
	});

	function getAllInvestigadores(){
		$.post('<cfoutput>#event.buildLink("EDI.evaluacion.getAllInvestigadores")#</cfoutput>',{
		}, function(data){
			$('#divBusquedaInvestigadores').html(data);
		});
	}

	function abrirCerrarEvaluacion(){
		$('#divBusquedaInvestigadores').toggle("slow");
		$('#divEvaluacionEDI').toggle("slow");
	}
</script>