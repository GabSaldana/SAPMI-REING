<script>
	<!--- Funciones de validacion de los campos del formulario --->
	numericoUno = /^\d{1}/;
	
	numericoUno = /^(null|\d{0,1})$/;
	numericoUnorequerido = /^(null|\d{0,1})$/;
	numericoCinco = /^(null|\d{0,5}$)/;
	numericoCincoRequerido = /^(null|\d{0,5}$)/;
	numericoDoce= /^(null|\d{0,12}$)/;
	numericoDoceRequerido = /^(null|\d{0,12}$)/;

	numericoDocePN= /^(null|-?\d{0,12}$)/;
  	numericoDoceRequeridoPN = /^(null|-?\d{0,12}$)/;
	numericoDosDecimalesPN = /^(null|-?\d{0,12}.\d{0,2})$/;
  	numericoDosDecimalesRequeridoPN = /^(null|-?\d{0,12}.\d{0,2})$/;

	numericoDosDecimales = /^(null|\d{0,12}.\d{0,2})$/;
	numericoDosDecimalesRequerido= /^(null|\d{0,12}.\d{0,2})$/;
	numericoTresDecimales= /^(null|\d{0,12}.\d{0,3})$/;
	numericoTresDecimalesRequerido= /^(null|\d{0,12}.\d{0,3})$/;

	cadenaDiez = function (value) {
		if (value.toString().length > 10){
			return false;
		} else {
			return true;
		}
	}

	cadenaDiezRequerida = function (value) {
		if (value.toString().length > 10  ){
			return false;
		} else {
			return true;
		}
	}

	cadenaCincuenta = function (value) {
		if (value.toString().length > 50){
			return false;
		} else {
			return true;
		}
	}

	cadenaCincuentaRequerida = function (value) {
		if (value.toString().length > 50  ){
			return false;
		} else {
			return true;
		}
	}

	cadenaDosCincuenta = function (value) {
		if (value.toString().length > 250){
			return false;
		} else {
			return true;
		}
	}

	cadenaDosCincuentaRequerida = function (value, callback) {
		if (value.toString().length > 250 ){
			return false;
		} else {
			return true;
		}
	}

	cadenaMil = function (value) {
		if (value.toString().length > 1000){
			return false;
		} else {
			return true;
		}
	}

	cadenaMilRequerida = function (value) {
		if (value.toString().length > 1000  ){
			return false;
		} else {
			return true;
		}
	}

	fechaNoRequerida = function (value) {
		return true;
  	}

  	fechaRequerida = function (value) {
  		return true;
  	}
  	
  	catalogoNoRequerido = function (value) {
		return true;
  	}

  	catalogoRequerido = function (value) {
  		return true;		
  	}

  	cadenaCuatroMilRequerida = function (value) {
		if (value.toString().length > 4000 ){
			return false;
		} else {
			return true;
		}
	}

	seleccionMultiple = function (value) {
		return true;
	}

	seleccionUnica = function (value) {
		return true;
	}

	listaReordenable = function (value) {
		return true;
	}

	seleccionArchivo = function (value) {
		return true;
	}

	archivoRequerido = function (value) {
		return true;
	}

	noValidator = function (value) {
			return true;
	}

	<!--- Catalogo de las celdas para precargar campos del formulario --->
	catalogoPrecargados = [
		"113", "128", "365", "386", "409", "432",	"736",	<!--- ISSN de la revista --->
   		"108", "123", "356", "377", "400", "423",	"732",	<!--- ISSN Anio de la revita--->
   		"111", "126", "366", "387", "410", "433",	"722",	<!--- ISSN Pais de la revista --->
   		"112", "127", "370", "391", "414", "437",	"731"	<!--- ISSN Nombre de la revista --->
	];
</script>