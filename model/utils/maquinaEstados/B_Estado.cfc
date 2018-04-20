<cfcomponent accessors="true"  >
    <cfproperty name="ESTILO_ESTADO">
    <cfproperty name="PK_ESTADO">
    <cfproperty name="NUM_EDO">
    <cfproperty name="NOMB_EDO">
    <cfproperty name="CAMBIOS" type="array">
    <cfproperty name="LINKS" type="array">

    <cffunction name="init">
        <cfscript>
            var ArrayCambios = []; 
            this.setCAMBIOS(ArrayCambios);
            this.setLINKS(ArrayCambios);
            return this;
        </cfscript>
    </cffunction>   

    <cffunction name="setCambio">
        <cfargument name="cambio">
        <cfscript>
           arrayAppend(this.getCAMBIOS(),cambio);
        </cfscript>
    </cffunction>

    <cffunction name="setCambioLkn">
        <cfargument name="cambio">
        <cfscript>
           arrayAppend(this.getLINKS(),cambio);
        </cfscript>
    </cffunction>

</cfcomponent>