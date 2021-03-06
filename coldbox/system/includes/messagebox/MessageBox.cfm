﻿<cfsetting enablecfoutputonly=true>
<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Template :  MessageBox.cfm
Author 	 :	Luis Majano
Date     :	October 10, 2005
Description :
	This is the display of the frameworks MessageBox.
	You can customize this as you want via your own css and the
	messagebox_style_override setting flag in your configuration file.

----------------------------------------------------------------------->
<!--- Set the css class --->
<cfif msgStruct.type eq "error">
	<cfset msgClass = "cbox_messagebox_error">
<cfelseif msgStruct.type eq "error2">
	<cfset msgClass = "error">    
<cfelseif msgStruct.type eq "warning">
	<cfset msgClass = "cbox_messagebox_warning">
<cfelse>
	<cfset msgClass = "cbox_messagebox_info">
</cfif>
<cfoutput>
<cfif NOT settingExists("messagebox_style_override") OR NOT getSetting('messagebox_style_override')>
<cfsavecontent variable="mbstyle">
<!--- Style Declaration --->
<style type="text/css">
.cbox_messagebox{
	font-size: 13px;
	font-weight: bold;
	margin: 10px;
}
.cbox_messagebox_info{
	background: ##D1E6EF url(/coldbox/system/includes/images/cmsg.gif) no-repeat scroll .5em 50%;
	border: 1px solid ##2580B2;
	margin: 0.3em;
	padding: 0pt 1em 0pt 3.5em;
}
.cbox_messagebox_warning{
	background: ##FFF2CF url(/coldbox/system/includes/images/wmsg.gif) no-repeat scroll .5em 50%;
	border: 1px solid ##2580B2;
	margin: 0.3em;
	padding: 0pt 1em 0pt 3.5em;
}
.cbox_messagebox_error{
	background: ##FFFFE0 url(/coldbox/system/includes/images/emsg.gif) no-repeat scroll .5em 50%;
	border: 1px solid ##2580B2;
	margin: 0.3em;
	padding: 0pt 1em 0pt 3.5em;
}
.error{
	background: ##f2dede url(/coldbox/system/includes/images/wmsg.gif) no-repeat scroll .5em 50%;
	border: 1px solid ##eed3d7;
	margin: 0.3em;
	padding: 0pt 1em 0pt 3.5em;
	color: ##b94a48;
    border-radius: 17px;
}

</style>
</cfsavecontent>
<cfhtmlhead text="#mbstyle#">
</cfif>
<div class="#msgClass#"><p class="cbox_messagebox">#msgStruct.message#</p></div>
</cfoutput>
<cfsetting enablecfoutputonly="false">