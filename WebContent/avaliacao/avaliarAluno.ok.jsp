<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/meutag.tld" prefix="m" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<html>

<head> 
	<title>CenAS: Cenários de Aprendizagem</title>
	<link rel="stylesheet" href="css/internas.css" />
	<link rel="stylesheet" href="css/displaytag.css">
</head>
<body>

<%@ include file="../cabecalho_disciplinas.jsp" %>

	<div id="corpo">
	
		 <%@ include file="cabecalho_local_prof.jsp" %>
                
		<div id="conteudo">
			
			<br/> 
			<span style="font-size: 10pt"><b>Avaliação | ${aluno.nome}</b></span>

			<form name="atualizar" action="avaliacao.formularioAvaliacaoAluno.logic" method="post">

			<input type="hidden" name="aluno.id" value="${aluno.id}"> 			

				<div style="margin:25px;">
					<c:if test="${empty aluno.avaliacoes}">
						<script type="text/javascript">location.reload(true);</script>
					</c:if>
					
					<c:if test="${not empty aluno.avaliacoes}">
						
						<% int index = 1; %>
						<div style="width: 400px">
							
							<display:table name="${aluno.avaliacoes}" id="avaliacao" style="width: 100%;">
								
								<display:column title="Dia"><%= index++ %></display:column>
								
								<display:column property="dominioAcademico" title="Domínio Afetivo"/>
								
								<display:column property="dominioCognitivo" title="Domínio Cognitivo"/>
								
								<display:column title="Média">
									<c:if test="${avaliacao.media == -1}">F</c:if>
									<c:if test="${avaliacao.media > -1}">${avaliacao.media}</c:if>
								</display:column>
								
								<display:column title="A&ccedil;&otilde;es">
									<a href="avaliacao.editarAvaliacao.logic?avaliacao.idAvaliacao=${avaliacao.idAvaliacao}"> <img src="images/editar.gif"/></a>
									<a href="avaliacao.removerAvaliacao.logic?avaliacao.idAvaliacao=${avaliacao.idAvaliacao}"> <img src="images/remover.gif"/></a>
								</display:column>
							</display:table>
							<br />
							
							<c:if test="${m:mediaAsString(aluno.avaliacoes) == ''}">
								<table class="dados" align="center" style="width: 100%;"> 
						  			<tr>
		  				  				<td class="content1">Não há avaliações para este aluno.</td>
									</tr>
								</table>	
							</c:if>
							<c:if test="${m:mediaAsString(aluno.avaliacoes) != ''}">
								<span style="display: block;">MÉDIA FINAL: <c:out value="${m:mediaAsString(aluno.avaliacoes)}"/></span>	
							</c:if>
						</div>
					</c:if>
				
					<!-- INPUT MANTIDO POR SEGURANÇA -->
					<c:if test="${m:podeAvaliar(aluno.avaliacoes)}">
						<br /><input type="submit" value="Adicionar Nota" class="button" name="salvar"/>
					</c:if>	
				</div>
			</form>
	
		</div>
			<%@ include file ="../rodape.jsp" %>
	</div>
</body>
</html>
