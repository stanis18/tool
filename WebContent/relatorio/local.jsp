<%@ page pageEncoding="ISO-8859-1" %>

<%@page import="model.Usuario"%>
<%@page import="model.Professor"%>
<%@page import="model.Tutor"%>
<%@page import="model.Aluno"%>
<%@page import="model.Periodo"%><html>
<body>
<%
	Usuario user = (Usuario) request.getSession().getAttribute("usuario"); 

	String modo = "";

	if(user instanceof Professor) {
		modo = "Professor";
	} else if (user instanceof Tutor) { 
		modo = "Tutor";
	} else if (user instanceof Aluno) {
		modo = "Aluno";
	}
	 
%>
    <div id="local">		        
		<p>Modo <%= modo %></p>
	</div>
	<div id="aluno">
		<p><b><%=modo + "(a): " %></b> <%=user.getNome()%> | ${periodo.periodo} </p>
	</div>
</body>
</html>


