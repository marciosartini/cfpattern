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
	<cfset controller = application.factory.getInstance('controllerPedidos').init()> 
    <!--- <cfset objetoPage = loadView(objeto)> --->

	 
	
	<cfswitch expression="#application.methodController#">

		<cfcase value="edita">
			<cfset resposta = controller.edita().acao>
 			<cfset objeto.resposta = resposta>
			<cfinclude template="#objetoPage.layout#"> 
		</cfcase>
		
		<cfcase value="relatorio">
			<cfset resposta = controller.relatorio()>
 			<cfset objeto.resposta = resposta.titulo>
			<cfinclude template="#objetoPage.layout#"> 
		</cfcase>
		
		<cfcase value="novo">
			<cfset resposta = controller.salva()>
 			<cfset objeto.resposta = resposta.titulo>
			<cfinclude template="#objetoPage.layout#"> 
		</cfcase>

	</cfswitch>
	 
	
	<!--- Criar instancia para controller, pegar a pasta do contexto e criar a instancia a partir dela, 
	Ex.:  www.sistema.com.br/usuarios/edita/index.cfm
	Criar class usuarios.cfc com todos os métodos que julgar necessários, neste caso usuário está passando [ edita ] como método do controller
	
	Então será instanciado: controller = application.factory.getInstance('controllerPedidos').init()>
	Caminho do componente controller será a pasta de {controller/controle chamado/controllerChamado.cfc]#application.rootApplicationContext#.controller.#application.calledController#.#application.calledController#
	
	 --->



</cfoutput>
 