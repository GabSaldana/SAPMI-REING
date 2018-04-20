<!---
    * Fecha : 06 de mayo de 2016
    * @author : Alberto Mendoza
---> 
<cfprocessingdirective pageEncoding="utf-8">
<cfinclude template="admonGral_js.cfm">
    <cfoutput query="prc.recuadros">
    	  
        <div class="col-sm-5">
        <label class ="incheckbox">#ROL# :  
            <input class ="selectVisibles" type="checkbox" value="#ROL#" name="#ROL#" 
            <cfif #NUMEROACCIONES# neq 0 >checked="checked"</cfif>
            >
         </div>
                  
    </cfoutput>

<script type="text/javascript">
    $(document).ready(function(){

});

</script>  