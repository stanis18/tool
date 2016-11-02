<%@ page pageEncoding="ISO-8859-1" %>

<%@page import="model.Usuario"%>
<%@page import="model.Professor"%>
<%@page import="model.Tutor"%><div id="local">
<p>Modo Avaliação</p>
</div>
<div id="aluno">
<p>
<%
	Usuario user = (Usuario) request.getSession().getAttribute("usuario");
	String retorno = "";
	if( user instanceof Professor) {
		retorno = "Professor";
	} else if( user instanceof Tutor) {
		retorno = "Tutor";
	}
%>
<b><%= retorno %>(a):</b> ${usuario.nome} | ${periodo.periodo}</p>
</div>