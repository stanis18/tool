<%@ page pageEncoding="ISO-8859-1" %>
<html>

<head>
	<link rel="stylesheet" href="css/internas.css" />
	<title>CenAS: Cenários de Aprendizagem</title>
</head>

<body>

<%@ include file="../cabecalho_disciplinas.jsp"%>

<div id="corpo">
	<%@ include file="cabecalho_local_admin.jsp"%>
<div id="conteudo">
<div id="menu">
	<%@ include file="menu_admin.jsp"%>
</div>
<div id="miolo">

<%@ include file="../erros.jsp" %>

<h1>Nova Disciplina</h1>

<p/>

<form name="form" action="admin.cadastrarDisciplina.logic" method="post">
<input type="hidden" name="disciplina.id" value="${disciplina.id}" />
<table id="dados" style="text-align: left;" class="dados" align="center">
	<tr>
		<td class="title">Nome:</td>
		<td class="content3"><input name="disciplina.nome" size="50"
			value="${disciplina.nome}" /></td>
	</tr>

	<tr>
		<td class="title">Chave Sig@:</td>
		<td class="content3"><input name="disciplina.chaveSiga" size="20"
			value="${disciplina.chaveSiga}" /></td>
	</tr>
	<tr>
		<td class="title">Departamento:</td>
		<td class="content3"><input name="disciplina.departamento"
			size="40" value="${disciplina.departamento}" /></td>
	</tr>
	<tr>
		<td class="title">Carga hor&aacute;ria te&oacute;rica:</td>
		<td class="content3"><input name="disciplina.chTeorica" size="10"
			value="${disciplina.chTeorica}" /></td>
	</tr>
	<tr>
		<td class="title">Carga hor&aacute;ria pr&aacute;tica:</td>
		<td class="content3"><input name="disciplina.chPratica" size="10"
			value="${disciplina.chPratica}" /></td>
	</tr>
	<tr>
		<td class="title">Número de cr&eacute;ditos:</td>
		<td class="content3"><input name="disciplina.credito" size="10"
			value="${disciplina.credito}" /></td>
	</tr>
	<tr>
		<td class="title">Avalia&ccedil;&atilde;o:</td>
		<td class="content3"><textarea cols="73" rows="5"
			name="disciplina.avaliacao">${disciplina.avaliacao}</textarea></td>
	</tr>
	<tr>
		<td class="title">Objetivo:</td>
		<td class="content3"><textarea cols="73" rows="5"
			name="disciplina.objetivo">${disciplina.objetivo}</textarea></td>
	</tr>
	<tr>
		<td class="actions" colspan="2"><input type="submit"
			value="Salvar" class="button" /> <input type="button"
			value="Cancelar" onclick="admin.inicio.logic" class="button" /></td>
	</tr>
</table>

</form>

</div>



</div>
<%@ include file="../rodape.jsp"%></div>

</body>

</html>
