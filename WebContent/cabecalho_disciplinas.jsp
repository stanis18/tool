<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page import="model.Usuario"%>
<%@page import="model.Professor"%>
<%@page import="model.Tutor"%>
<%@page import="model.Aluno"%>
<link rel="shortcut icon" href="/images/icone.png" />
<link rel="shortcut icon" href="../images/icone.png" />

<div id="topo">
	<img src="images/topoFonteRodrigo2BorboletasAlinhadas.png" width="778" height="107"
	alt="CenAS: Cenários de Aprendizagem - Curso Médico Online" style="margin: 1px;" /></div>
<div id="menu_sup">
	<%  Usuario usuario = (Usuario) request.getSession().getAttribute("usuario"); 
	String alterarSenha = "#";
	String voltar = "#";
	String ajuda = "#";
	boolean questionarioTutor = false;
	boolean questionarioAluno = false;
	if(usuario instanceof Professor) {
		alterarSenha = "professor.formularioAlterarSenha.logic";
		voltar = "professor.inicio.logic";
		ajuda = "professor.ajuda.logic";
	} else if (usuario instanceof Tutor) { 
		alterarSenha = "tutor.formularioAlterarSenha.logic";
		voltar = "tutor.inicio.logic";
		ajuda = "tutor.ajuda.logic";
		questionarioTutor = true;
	} else if (usuario instanceof Aluno) {
		alterarSenha = "aluno.formularioAlterarSenha.logic";
		voltar = "aluno.inicio.logic";
		ajuda = "aluno.ajuda.logic";
		questionarioAluno = true;
	} else if (usuario instanceof Usuario) {
		alterarSenha = "admin.formularioAlterarSenha.logic";
		voltar = "admin.inicio.logic";
		ajuda = "admin.ajuda.logic";
	}
	%>

	<c:if test="<%= questionarioAluno %>">			
	<input type="button" value="Questionário Aluno" class="button" onClick="javascript:window.open('https://docs.google.com/spreadsheet/viewform?formkey=dDREM2JJeEhldWVVSkw3UU4yWWloZmc6MA', '_blank');"  />
	</c:if>

	<c:if test="<%= questionarioTutor %>">
	<input type="button" value="Questionário Tutor" class="button" onClick="javascript:window.open('https://docs.google.com/spreadsheet/viewform?formkey=dHZrMzdTUVBXLXNkS3BXRGJWZ2p1ZGc6MA', '_blank');" />
	</c:if>


	<input type="button" value="Alterar Senha" class="button" onClick="javascript:window.open('<%= alterarSenha %>', '_self');" /> 
	<input type="button" value="Voltar" class="button" onClick="javascript:window.open('<%= voltar %>', '_self');" /> 
	<input type="button" value="Ajuda"  class="button" onClick="javascript:window.open('ajuda/ajuda.htm', '_blank');" /> 
	<input type="button" value="Sair" class="button" onclick="javascript:window.open('cconhecimento.logout.logic', '_self');" />



&nbsp;</div>




