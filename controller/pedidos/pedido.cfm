<cfoutput>



 


    <cfset objeto = {}>
    <cfset objeto.title = "Pedidos">
    <cfset objeto.javascript = "js/vendo/jquery, js/vendor/backbone, js/vendor/require">
    <cfset objeto.stylesheet = "css/style, css/core">
    <cfset objeto.layout = "layout">
    <cfset objeto.view = "index">
    <cfset objeto.class = "pedido">


    <!--- <cfset objeto.objPost = objPost> --->

    <cfset usuario = {}>
    <cfset usuario.nome = 'Jose'>
    <cfset usuario.chapa = '534543'>
    <cfset usuario.salario = '2345'>

    <cfset objeto.usuario = usuario>
	 
	 
 	

	<!--- Popula todas as variaveis tanto da url como de formularios ---> 
	<cfset objeto.post = application.factory.getInstance('UDF').populate()>  
	<!--- <cfset objeto.post = populate()> --->
 
 
	<cfset objetoPage = application.factory.getInstance('UDF').loadView(objeto)>  
    <!--- <cfset objetoPage = loadView(objeto)> --->

	<cfset method="">
	<cfif application.methodController NEQ "">
		<cfset method = #evaluate(application.methodController)#>
	</cfif>
	
	<cfif application.methodController EQ "edita">
		<cfoutput>#method(objeto.post)#</cfoutput>
	</cfif>
	
	<cfif application.methodController EQ "novo">
		<cfoutput>#method(objeto.post)#</cfoutput>
	</cfif>
	
	 
 

 	<cfinclude template="#objetoPage.layout#"> 





</cfoutput>


<!--- MƒTODOS DO CONTROLLER --->
<cffunction name="novo" returntype="string">
	<cfargument name="objeto" type="any" required="false">
	<!--- Neste caso o usuario esta passando os dados pela url --->
	<!--- Ainda pode ser passado par‰metro pelo form e pela url --->
	<cfif isDefined("objeto.url.nome")>
		<cfreturn "Incluindo um registro: " & objeto.url.nome & "------url=" & objeto.form.nome />
	<cfelse>
		<cfreturn "Par‰metro inv‡lido" />
	</cfif>
	
</cffunction>

<cffunction name="edita" returntype="string">
	<cfargument name="objeto" type="any" required="false">
	<!--- Neste caso o usuario esta passando os dados pelo form, Ž validado, se estiver vindo pela url somente, devolve o erro  --->
	<cfif isDefined("objeto.form.nome")>
		<cfreturn "Editando um registro: " & objeto.form.nome  />
	<cfelse>
		<cfreturn "Par‰metro inv‡lido" />
	</cfif>
	
</cffunction>
