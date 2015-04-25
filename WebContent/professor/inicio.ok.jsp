<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="model.Problema"%>
<html>

<head>

	<title>CenAS: Cenários de Aprendizagem</title>
	<link rel="stylesheet" href="css/internas.css" />
	<link rel="stylesheet" href="css/displaytag.css"/>
	<script src="js/confirm.js"></script>
</head>

<body>
        <%@ include file ="../cabecalho_disciplinas.jsp" %>
 	<div id="corpo"> 
		<%@ include file ="cabecalho_local_prof.jsp" %>
		<div id="conteudo">			
		
		<%@ include file="menuProfessor.jsp" %>

			<display:table name="${problemas}" id="problema" cellpadding="1" cellspacing="1">
				<display:column title="Equipe" property="equipe.nome"/>
				
				<display:column property="disciplina.nome" title="Disciplina" style="width: 180px"/>
				
				<display:column title="Problema" style="width:380px">
					<a href="relatorio.inicio.logic?problema.idProblema=${problema.idProblema}">${problema.titulo}</a>
				</display:column>

				<display:column title="A&ccedil;&otilde;es"	style="width: 190px; text-align: center;">
					<a href="professor.editarProblema.logic?problema.idProblema=${problema.idProblema}"><img src="images/editar.gif" /></a>
					<a href="#" target="_self" onclick="conf('professor.removerProblema.logic?problema.idProblema=${problema.idProblema}', '${problema.titulo}');"><img src="images/remover.gif" /></a>
					<c:if test="${problema.aberto == 0}">
						<a href="professor.formularioFecharProblema.logic?problema.idProblema=${problema.idProblema}"><img src="images/fechar.gif" title="Fechar"/></a>	
					</c:if>
					<c:if test="${problema.aberto == 1}">
						<a href="professor.formularioFecharProblema.logic?problema.idProblema=${problema.idProblema}"><img src="images/abrir.gif" title="Abrir"/></a>
					</c:if> 
					<a href="avaliacao.notasEquipe.logic?equipe.id=${problema.equipe.id}"><img src="images/avaliar.png"/></a>
				</display:column>
			</display:table>
		</div>
		<%@ include file ="../rodape.jsp" %>
	</div>
</body>
</html>
