<cfprocessingdirective pageEncoding="utf-8"/>
<script type="text/javascript">

	/*Constantes para los nombres de los subtemas*/
	/*var NE1 = "Eje Fundamental 1: Calidad y pertinencia educativa";
	var FE1 = "1.1 Modelo Educativo Institucional| 1.2 Pertinencia de los programas acad\u00E9micos| 1.3 Aseguramiento de la calidad educativa|1.4 Cultura y deporte| 1.5 Personal docente, de apoyo a la educaci\u00F3n y directivo|1.6 ";
	var NE2 = "Eje Fundamental 2: Cobertura";
	var FE2 = "2.1 Consolidaci\u00F3n de espacios educativos| 2.2 Nuevos programas acad\u00E9micos| 2.3 Articulaci\u00F3n entre tipos y niveles educativos| 2.4 Educaci\u00F3n virtual y a distancia| 2.5 Equidad en el acceso y trayectoria escolar";
	var NE3 = "Eje Fundamental 3: Conocimiento para la soluci\u00F3n de problemas nacionales";
	var FE3 =  "3.1 Investigaci\u00F3n y desarrollo tecnol\u00F3gico| 3.2 Innovaci\u00F3n tecnol\u00F3gica|.|.|.";
	var NE4 = "Eje Fundamental 4: Cumplimiento del compromiso social";
	var FE4 = "4.1 Relaci\u00F3n con el sector productivo y social| 4.2 Instituci\u00F3n con impacto social| 4.3 Movilidad e internacionalizaci\u00F3n|.|.";
	var NE5 = "Eje Fundamental 5: Gobernanza y gesti\u00F3n institucional";
	var FE5 = "5.1 Planeaci\u00F3n Estrat\u00E9gica a corto, mediano y largo plazo|.|.|.|.";
	var NET1 = "Eje Trasversal 1: Sustentabilidad";
	var FET1 = "T1.1 Modelo de sustentabilidad|.|.|.|.";
	var NET2 = "Eje Trasversal 2: Perspectiva de g\u00E9nero";
	var FET2 = "T2.1 Acciones afirmativas| T2.2 Fortalecimiento de la divulgaci\u00F3n|.|.|.";*/
	var NE1 = "Eje Fundamental 1: Calidad y Pertinencia Educativa";
	var FE1 = "Proyecto Especial 1 - Evaluaci\u00F3n del Modelo Educativo| Proyecto Especial 2 - Operaci\u00F3n del Sistema Institucional de Evaluaci\u00F3n de la Calidad Educativa de las Unidades Acad\u00E9micas| Proyecto Especial 3 - Dise\u00F1o de programas acad\u00E9micos| Proyecto Especial 4 - Redise\u00F1o de los programas acad\u00E9micos| Proyecto Especial 5 - Propociar ambientes innovadores de aprendizaje| Proyecto Especial 6 - Las lenguas extranjeras como apoyo para promover una formaci\u00F3n de calidad en los estudiantes| Proyecto Especial 7 - Desarrollo y fomento deportivo como actividades complementarias de la comunidad polit\u00E9cnica| Proyecto Especial 8 - Implementaci\u00F3n del Programa de Formaci\u00F3n y Actualizaci\u00F3n del Personal Acad\u00E9mico| Proyecto Especial 9 - Programa de renovaci\u00F3n de la planta y de apoyo y asistencia a la educaci\u00F3n| Proyecto Especial 10 - Implementaci\u00F3n del Sistema Institucional del Personal de Apoyo y Asistencia a la Educaci\u00F3n";
	var NE2 = "Eje Fundamental 2: Cobertura y Atenci\u00F3n Estudiantil";
	var FE2 = ".|.|.|.|.|.|.|.|.|.|Proyecto Especial 11 - Operar un plan maestro de infraestructura f\u00EDsica institucional| Proyecto Especial 12 - Fortalecimiento de la infraestructura de talleres y laboratorios de las unidades acad\u00E9micas| Proyecto Especial 13 - Fortalecimiento de la trayectoria escolar de la comunidad estudiantil| Proyecto Especial 14 - Apoyos para la permanencia y formaci\u00F3n de los estudiantes| Proyecto Especial 15 - Vinculaci\u00F3n entre tipos y niveles educativos| Proyecto Especial 16 - Fortalecimiento de la educaci\u00F3n a distancia (modalidades no escolarizada y mixta)";
	var NE3 = "Eje Fundamental 3: Conocimiento para la Soluci\u00F3n de Problemas Nacionales";
	var FE3 =  ".|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|Proyecto Especial 17 - Impulso a la investigaci\u00F3n que genere productos de alto impacto para el desarrollo del pa\u00EDs| Proyecto Especial 18 - Fortalecimiento del desarrollo tecnol\u00F3gico e innovador del IPN| Proyecto Especial 19 - Fortalecimiento y creaci\u00F3n de redes de investigaci\u00F3n";
	var NE4 = "Eje Fundamental 4: Cumplimiento del Compromiso Social";
	var FE4 = ".|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|Proyecto Especial 20 Transferencia de tecnolog\u00EDa del conocimiento de las dependencias polit\u00E9cnicas a los sectores productivo y social| Proyecto Especial 21 - Impulsar la cultura emprendedora y la creaci\u00F3n de empresas polit\u00E9cnicas de base tecnol\u00F3gica| Proyecto Especial 22 - Fortalecimiento del Observatorio Tecnol\u00F3gico| Proyecto Especial 23 - Difusi\u00F3n de las actividades art\u00EDstico-culturales, deportivas, resultados de investigaci\u00F3n y divulgaci\u00F3n de la cultura cient\u00EDfica y tecnol\u00F3gica| Proyecto Especial 24 - Consolidaci\u00F3n de la pol\u00EDtica institucional para la generaci\u00F3n de la obra editorial| Proyecto Especial 25 Impacto del servicio social| Proyecto Especial 26 - Fortalecimiento de la cooperaci\u00F3n acad\u00E9mica y de la internacionalizaci\u00F3n del Instituto| Proyecto Especial 27 - Impulso al impacto social del Canal Once de televisi\u00F3n y Radio Polit\u00E9cnico";
	var NE5 = "Eje Fundamental 5: Gobernanza y Gesti\u00F3n Institucional";
	var FE5 = ".|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|Proyecto Especial 28 - Propuesta de un nuevo modelo de desarrollo organizacional del IPN| Proyecto Especial 29 - Gesti\u00F3n y optimizaci\u00F3n de recursos presupuestarios para el desarrollo de las finalidades y funciones institucionales| Proyecto Especial 30 - Operaci\u00F3n de esquemas innovadores para formentar la transparencia institucional| Proyecto Especial 31 - Impulsar el Programa Institucional para Inhibir la Corrupci\u00F3n| Proyecto Especial 32 - Modernizaci\u00F3n de los procesos de gesti\u00F3n institucional e implementaci\u00F3n y actualizaci\u00F3n de soluciones tecnol\u00F3gicas| Proyecto Especial 33 - Implementaci\u00F3n del Sistema Institucional de Prevenci\u00F3n y Atenci\u00F3n a las Necesidades de la Comunidad Polit\u00E9cnica| Proyecto Especial 34 - Ejercicio de una gobernanza democr\u00E1tica en el IPN| Proyecto Especial 35 - Realizaci\u00F3n del Congreso Nacional Polit\u00E9cnico| Proyecto Especial 36 - Transformaci\u00F3n de la cultura institucional de los derechos individuales y colectivos de la comunidad| Proyecto Especial 37 - Operaci\u00F3n de la estrategia institucional de la Comunicaci\u00F3n Social| Proyecto Especial 38 - Operaci\u00F3n del Sistema de evaluaci\u00F3n de la gesti\u00F3n de los directores del IPN";
	var NET1 = "Eje Trasversal 1: Sustentabilidad";
	var FET1 = ".|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|Proyecto Especial 39 - Implementar un Plan Institucional hacia la Sustentabilidad| Proyecto Especial 40 - Consolidar el plan para el manejo adecuado de los residuos s\u00F3lidos y peligrosos que se generen en el IPN| Proyecto Especial 41 - Establecer programas de responsabilidad social";
	var NET2 = "Eje Trasversal 2: Perspectiva de G\u00E9nero";
	var FET2 = ".|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|Proyecto Especial 42 - Evaluar los actuales protocolos para la detecci\u00F3n y denuncia de acciones de violencia de g\u00E9nero| Proyecto Especial 43 - Transversalizaci\u00F3n de la perspectiva de g\u00E9nero en el IPN";
	
	$(document).ready(function(){
		
		/*Listeners*/
		$(".menu-it").click(function(){
			var id = $(this).attr('id');
			//var tmpTitle = $(this).attr('name');
			localStorage.setItem('eje',id);
			/*localStorage.setItem('accion',1);
			localStorage.setItem('NombreAccion',tmpTitle);*/
			if(id == 'E1'){
				localStorage.setItem('NombreEje',NE1);
				localStorage.setItem('Frase',FE1);
			}else if(id == 'E2'){
				localStorage.setItem('NombreEje',NE2);
				localStorage.setItem('Frase',FE2);
			}else if(id == 'E3'){
				localStorage.setItem('NombreEje',NE3);
				localStorage.setItem('Frase',FE3);
			}else if(id == 'E4'){
				localStorage.setItem('NombreEje',NE4);
				localStorage.setItem('Frase',FE4);
			}else if(id == 'E5'){
				localStorage.setItem('NombreEje',NE5);
				localStorage.setItem('Frase',FE5);
			}else if(id == 'ET1'){
				localStorage.setItem('NombreEje',NET1);
				localStorage.setItem('Frase',FET1);
			}else{
				localStorage.setItem('NombreEje',NET2);
				localStorage.setItem('Frase',FET2);
			}
			setTimeout(gotoCarrousel, 1000);
		});

		function gotoCarrousel() {
    		location.assign('<cfoutput>#event.buildLink("carrousel/carrousel")#</cfoutput>');
  		}
	});
</script>