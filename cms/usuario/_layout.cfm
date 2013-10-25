<html>
<head>
<title>
    <cfoutput>#objetoPage.title#</cfoutput>
</title>
<!-- JAVASCRIPT --> 
<cfloop list="#objetoPage.javascript#" index="js">
	<cfoutput>
		<script type="text/javascript" src="#trim(js)#.js" charset="utf-8"></script>#chr(13)# 
	</cfoutput>
</cfloop>


<!-- ESTILO -->
<cfloop list="#objetoPage.stylesheet#" index="css">
	<cfoutput>
		<link href="#trim(css)#.css" rel="stylesheet">#chr(13)#
	</cfoutput>
</cfloop>

 <style>
    #content {
        width: 100%;
        border: 1px solid #ccc;
    }
</style>

</head>

 
<body class="<cfoutput>#objetoPage.class#</cfoutput>">
 
<div id="content">
    
        <cfinclude template = "#objetoPage.page#">  
 

</div>

</body>

</html>