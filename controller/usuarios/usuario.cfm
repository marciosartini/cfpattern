﻿<cfoutput>
    <cfset objeto = {}>
    <cfset objeto.title = "Usuários">
    <cfset objeto.javascript = "js/vendo/jquery, js/vendor/backbone, js/vendor/require">
    <cfset objeto.stylesheet = "css/style, css/core">
    <cfset objeto.layout = "">
    <cfset objeto.view = "index">
    <cfset objeto.class = "usuario">


    <!--- <cfset objeto.objPost = objPost> --->

    <cfset usuario = {}>
    <cfset usuario.nome = 'Jose'>
    <cfset usuario.chapa = '534543'>
    <cfset usuario.salario = '2345'>

    <cfset objeto.usuario = usuario>
 

  	<cfset objetoPage = application.factory.getInstance('UDF').loadView(objeto)>  
 
	<!--- Chamando a rotina acima --->
    <!--- <cfset objetoPage = loadView(objeto)> --->
 

 
  
 
 <cfinclude template="#objetoPage.layout#"> 




</cfoutput>