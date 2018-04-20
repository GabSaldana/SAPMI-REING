<cfprocessingdirective pageEncoding="utf-8">
<cfoutput>
<div class="row">
	<div class="col-md-12">
		<label class="control-label">¿Solicitó ingreso en el mismo periodo al Programa de Estímulos al Desempeño Docente(EDD)?</label><br>
	    <div class="radio radio-info radio-inline">
	        <input type="radio" name="inEDD" id="opSi" value="0" <cfif prc.edd.solicitud eq 0> checked </cfif>>
	        <label for="opSi">
	            <h4>Sí</h4>
	        </label>
	    </div>
	    <div class="radio radio-info radio-inline">
	        <input type="radio" name="inEDD" id="opNo" value="2" <cfif prc.edd.solicitud eq 2> checked </cfif>>
	        <label for="opNo">
	            <h4>No</h4>
	        </label>
	    </div>
	</div>
	<div class="col-md-12" id="solicitudSiEDD" style="display: none">
		<div class="alert alert-danger">
		    De acuerdo con la información ingresada, usted <b>solicitó</b> en este periodo el Estímulo al Desempeño Docente.<br>
		    No puede participar en el programa.
		</div>
	</div>
	<div class="col-md-12"  id="solicitudNoEDD" style="display: none">
		<div class="alert alert-success">
		    Usted <strong>No</strong> solicito en este periodo el Estímulo al Desempeño Docente.
		</div>
	</div>
	<div class="col-md-12">
		<cfif prc.edd.consuta eq 2>
			<div class="alert alert-success">
				De acuerdo con la información ingresada en el Apartado de CVU, usted <strong>No</strong> cuenta con el Estímulo al Desempeño Docente.
			</div>
		<cfelse>
			<div class="alert alert-danger">
			    De acuerdo con la información ingresada en el Apartado de CVU, usted <b>cuenta</b> con el Estímulo al Desempeño Docente.<br>
			    No puede participar en el programa.
			</div>
		</cfif>
		
	</div>
</div>
</cfoutput>

<script type="text/javascript">
	$(document).ready(function() {
		if($('[name=inEDD]:checked').val() == 0){         	
			$('#solicitudSiEDD').toggle("slow");
			$('#solicitudNoEDD').hide();
		} else{
			$('#solicitudNoEDD').toggle("slow");
			$('#solicitudSiEDD').hide();
		}

	});

	$('body').undelegate('[name=inEDD]', 'click');
	$('body').on('click', '[name=inEDD]', function(){
		$.post('<cfoutput>#event.buildLink("EDI.solicitud.addAspiranteRequisito")#</cfoutput>', {
			pkAspirante:	$('#pkAspirante').val(),
			pkRequisito:	<cfoutput>#prc.edd.requisito#</cfoutput>,
			pkEstado:		$('[name=inEDD]:checked').val()
		}, function(data){
			if(data > 0){
				if($('[name=inEDD]:checked').val() == 0){
					$('#solicitudSiEDD').toggle("slow");
					$('#solicitudNoEDD').hide();
				} else{
					$('#solicitudNoEDD').toggle("slow");
					$('#solicitudSiEDD').hide();
				}					
			}
		});
	});
</script>