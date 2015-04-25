<%@ page pageEncoding="ISO-8859-1" %>
<html>

<head>
<title>CenAS: Cenários de Aprendizagem</title>
<link rel="stylesheet" href="internas.css" />

</head>

<meta name="description" lang="pt-br"
	content="Sistema eletrônico de segunda opinião em saúde" />
<meta name="keywords" lang="pt-br"
	content="saúde, health, segunda opinião, medicina" />
<meta name="robots" content="ALL" />	
<meta name="rating" content="General" />
<meta name="author" lang="pt-br" content="José Pirauá" />
<meta name="generator" content="AceHTML 5 Freeware" />
<meta name="language" content="pt-br" />
<link rel="author" href="josepiraua@hotmail.com" />
<link rel="stylesheet" href="css/internas.css" />

<body>

<%@ include file="../cabecalho_disciplinas.jsp"%>
<div id="corpo"><%@ include file="cabecalho_local_admin.jsp"%>

<div id="conteudo">

<div id="menu"><%@ include file="menu_admin.jsp"%>
</div>

<div id="miolo">
<h1>Novo Aluno</h1>
<p style="text-align: center;"><span style="font-weight: bold;">Aluno
cadastrado/editado com sucesso!</span> <br>
<br>
Dados cadastrados:<br>
<br>
Nome: ${aluno.nome} <br>
CPF: ${aluno.CPF} <br>
Login: ${aluno.login} <br>
Senha: ${aluno.senha} (Gerada automaticamente pelo sistema)<br>
Per&iacute;odo: ${aluno.periodo} <br>
Email: ${aluno.email} <br>
<br>

<br>
<input class="button" value="Voltar"
	onclick="javascript:window.open('admin.inicio.logic', '_self');"
	type="button"> <br>


</p>


</div>




</div>
<%@ include file="../rodape.jsp"%></div>

</body>
</html>
