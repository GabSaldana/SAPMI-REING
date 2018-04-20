<script type="text/javascript">
<!--
	$(document).ready(function(e) {
		$(".header").remove();
		$(".footer").remove();
		$(".IND h1:first").remove();
		$(".IND p:first").remove();
		$('meta').each(function(index, element) {
			$(this).remove();
		});
	});
-->
</script>

<cfoutput>
	#prc.contenido#
</cfoutput>