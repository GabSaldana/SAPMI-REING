<!---
============================================================================================
* IPN - CSII
* Sistema: SIIIS
* Modulo: utilidades
* Fecha: agosoto/2016
* Descripcion: componente de negocio con funciones utilizadas comunmente
* Autor: 
============================================================================================
--->

<cfcomponent accessors="true" singleton>
    
    <cfproperty name="populator" inject="wirebox:populator">
    <cfproperty name="wirebox" inject="wirebox">
    <cfproperty name="cache" inject="cachebox:default">
    
    <cffunction name="init">
        <cfscript>
            return this;
        </cfscript>
    </cffunction>

    <cffunction name="queryToArray" returntype="array" output="No" access="remote"> 
        <cfargument name="q" required="Yes" type="query">
         <cfset var aTmp = arraynew(1)> 
        <cfif q.recordcount> 
          <cfloop query="q"> 
            <cfset stTmp = structNew()> 
            <cfloop list="#q.columnlist#" index="col"> 
              <cfset stTmp[col] = q[col][currentRow]> 
            </cfloop> 
            <cfset arrayAppend(aTmp,stTmp)> 
          </cfloop>
        </cfif> 
        <cfreturn aTmp> 
    </cffunction>

    <cffunction name="queryToStruct" returntype="struct" output="No" access="remote"> 
        <cfargument name="q" required="Yes" type="query">
        <cfset var stTmp = structnew()>
        <cfif q.recordcount eq 1> 
            <cfloop query="q"> 
                <cfloop list="#q.columnlist#" index="col"> 
                    <cfset stTmp[col] = q[col][currentRow]> 
                </cfloop> 
            </cfloop> 
        </cfif> 
        <cfreturn stTmp> 
    </cffunction>
  
    <cffunction name="queryToString"  returntype="string" output="No" access="remote"> 
        <cfargument name="q" required="Yes" type="query">
        <cfset var strTmp = ""> 
        <cfif q.recordcount eq 1> 
            <cfloop query="q"> 
                <cfloop list="#q.columnlist#" index="col"> 
                    <cfset strTmp = q[col][currentRow]> 
                </cfloop> 
            </cfloop> 
        <cfelse>
            <cfreturn "">
        </cfif> 
        <cfreturn strTmp> 
    </cffunction>

    <cffunction name="queryToNumber"  returntype="numeric" output="No" access="remote"> 
        <cfargument name="q" required="Yes" type="query">
        <cfset var numTmp = 0> 
        <cfif q.recordcount eq 1> 
            <cfloop query="q"> 
                <cfloop list="#q.columnlist#" index="col"> 
                    <cfset numTmp = q[col][currentRow]> 
                </cfloop> 
            </cfloop> 
        <cfelse>
            <cfreturn 0>
        </cfif> 
        <cfreturn numTmp> 
    </cffunction>

    <cffunction name="queryToArraySinStruct" returntype="array" output="No" access="remote"> 
        <cfargument name="q" required="Yes" type="query">
         <cfset var aTmp = arraynew(1)> 
        <cfif q.recordcount> 
          <cfloop query="q">
            <cfloop list="#q.columnlist#" index="col"> 
              <cfset tmp = q[col][currentRow]> 
            </cfloop> 
            <cfset arrayAppend(aTmp,tmp)> 
          </cfloop>
        </cfif> 
        <cfreturn aTmp> 
    </cffunction>

</cfcomponent>