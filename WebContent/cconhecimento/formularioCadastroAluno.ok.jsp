<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/meutag.tld" prefix="m" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>CenAS: Cenários de Aprendizagem</title>
<link rel="stylesheet" href="css/index.css" />
<link rel="shortcut icon" href="images/icone.png" />

</head>
<body>



<div id="topo"><img src="images/topoFonteRodrigo2BorboletasAlinhadas.png" width="778" height="107"
	alt="Intarmed - Curso Médico Online" style="margin: 1px;" /></div>
<div id="branco">
<div id="texto">

	<%@ include file="../erros.jsp" %>
<p>
<h4><p align="left" style="color: black; align: left;">Dados para Cadastro</p></h4>
<form name="form" action="cconhecimento.cadastrarAluno.logic" method="post"
	onsubmit="return confirma(this)" style="text-align:center; ">

    <input type="hidden" name="aluno.id" value="${aluno.id}" /> 

    <input type="hidden" name="aluno.senha" value="${aluno.senha}" />


<table id="dados" style="text-align: left;" class="dados" align="left">
	<tr>
		<td class="title">Nome</td>
		<td class="content3"><input name="aluno.nome"
			value="${aluno.nome}" size="60" /></td>
	</tr>
	<tr>
		<td class="title">CPF:</td>
		<td class="content3"><input name="aluno.CPF" value="${aluno.CPF}"
			size="20" /></td>
	</tr>

	<tr>
		<td class="title">Login:</td>
		<td class="content3"><input name="aluno.login"
			value="${aluno.login}" size="10" /></td>
	</tr>
	<tr>
		<td class="title">Per&iacute;odo:</td>
		<td class="content3"><input name="aluno.periodo"
			value="${aluno.periodo}" size="5" /></td>
	</tr>
	<tr>
		<td class="title">Email:</td>
		<td class="content3"><input size="30" name="aluno.email"
			value="${aluno.email}" /></td>
	</tr>
	<tr>
		<td class="title">Disciplina(s):</td>
		<td class="content3">
			
			<c:forEach var="disciplina" items="${disciplinas}">
					<input type="checkbox" id="checkBox" name="aluno.disciplinas.id" value="${disciplina.id}"
					<c:if test="${m:contains(aluno.disciplinas, disciplina)}">checked="true"</c:if>/>${disciplina.nome}<br/>
			</c:forEach>
			
		</td>
	</tr>	
	<tr>
		<td class="actions" colspan="2"><input type="submit"
			value="Cadastrar" class="button" />&nbsp; <!--onclick="confirmBox()"-->
		<input type="button" value="Voltar" onClick="javascript:window.location.href = 'index.jsp';"
			class="button" /></td>
	</tr>
</table>
</form>
</p>

</div>

<%@ include file="../rodape.jsp"%></div>
</body>
</html>
