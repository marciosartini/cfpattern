<cfset objeto = {}>
<cfset objeto.title = "Usu‡rios">
<cfset objeto.javascript = "js/vendo/jquery, js/vendor/backbone, js/vendor/require">
<cfset objeto.stylesheet = "css/style, css/core">
<cfset objeto.layout = "layoutPedidos">
<cfset objeto.view = "index">
<cfset objeto.class = "usuario">

<cfset objetoPage = application.factory.getInstance('UDF').loadView(objeto)>  

<cfinclude template="#objetoPage.layout#"> 