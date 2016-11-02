<%@ page pageEncoding="ISO-8859-1" %>
<html>

<head>
<title>CenAS: Cenários de Aprendizagem</title>
<link rel="stylesheet" href="css/internas.css" />

</head>

<body>

<%@ include file="../cabecalho_disciplinas.jsp"%>
<div id="corpo"><%@ include file="cabecalho_local_admin.jsp"%>

<div id="conteudo">

<div id="menu"><%@ include file="menu_admin.jsp"%>
</div>

<div id="miolo">
<h1>Novo Professor</h1>
<p style="text-align: center;"><span style="font-weight: bold;">Professor
cadastrado/editado com sucesso!</span> <br>
<br>
Dados cadastrados:<br>
<br>
	Nome: ${professor.nome} <br>
	CPF: ${professor.CPF} <br>
	Login: ${professor.login} <br>
	Senha: ${professor.senha} (Gerada automaticamente pelo sistema)<br>
	Email: ${professor.email} <br>
<br>

<br>
<input class="button" value="Voltar"
	onclick="javascript:window.open('admin.listarProfessores.logic','_self');"
	type="button"> <br>


</p>


</div>




</div>
<%@ include file="../rodape.jsp"%></div>

</body>
</html>
