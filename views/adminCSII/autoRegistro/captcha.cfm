<cfoutput>
    <cfset result="">
    <cfset i=0>

    <cfloop index="i" from="1" to="5">
        <cfset result=result&Chr(RandRange(65, 90))>
    </cfloop>

    <cfset funcimg1 = ImageCreateCaptcha(35,400,result,"low")> 
    <cfimage action="writetoBrowser" source="#funcimg1#">

	<input id="capOriginal" name="capOriginal" type="hidden" class="form-control" value="#result#"/>
    	
</cfoutput>
