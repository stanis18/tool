<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/formatarString.tld" prefix="m" %>
<html>

<head> 
	<title>CenAS: Cenários de Aprendizagem</title>
	<link rel="stylesheet" href="css/internas.css" />
</head>
<body>

<%@ include file ="../cabecalho.jsp" %>

	<div id="corpo">
                <%@  include file ="local.jsp" %>
		<div id="conteudo">
				
			<div id="menu">
				<%@ include file="menu.jsp" %>
			</div>
			<div id="miolo">

				<h1>Problema: ${problema.titulo}</h1>

				<h4>Planejamento | Coment&aacute;rio</h4>
				
				<form name="atualizar" action="relatorio.formularioComentario.logic" method="post">
					<div style="margin:25px;">
					
						<c:if test="${problema.aberto == 0}">
							<p>
								<input type="submit" value="Adicionar Coment&aacute;rio" class="button" name="salvar"/>
							</p>
						</c:if>

						<c:if test="${empty problema.comentarios}">
							
							 <table class="dados" align="center">
					  			<tr>
	  				  				<td class="content1">
	  				  					Nenhum coment&aacute;rio foi inserido.
										<c:if test="${problema.aberto == 0}">
											<br>Para iniciar a edição, clique no botão Adicionar Coment&aacute;rio.
										</c:if>
									</td>
								</tr>
							</table>
							
						</c:if>
	
						<c:if test="${not empty problema.comentarios}">
							
							<c:forEach var="comentario" items="${problema.comentarios}">
								<table class="dados">
									<tr>
										<td class="title">Data do Coment&aacute;rio</td>
										<td class="content1">${comentario.dataComentario}</td>
										<c:if test="${problema.aberto == 0}">
   											<td width="24" style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
                                                        <a href="relatorio.editarComentario.logic?comentario.idComentario=${comentario.idComentario}"><img border="0" src="images/editar.gif" alt="Editar"></a>
											</td>
											<td width="24" style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
                                                        <a href="relatorio.removerComentario.logic?comentario.idComentario=${comentario.idComentario}"><img border="0" src="images/remover.gif" alt="Excluir"></a>
											</td>
										</c:if>
									</tr>
									<tr>
										<td class="title">Seção:</td>
										<td class="content1">
											<c:if test="${comentario.identificadorSecao == 1}">Relatório de Atividades</c:if>
											<c:if test="${comentario.identificadorSecao == 3}">Recomendações</c:if>
											<c:if test="${comentario.identificadorSecao == 2}">Conclusões</c:if>
											<c:if test="${comentario.identificadorSecao == 4}">Resumo</c:if>
										</td>
									</tr>
									<tr>
											<td class="title">Descri&ccedil;&atilde;o</td>
											<td class="content1">${m:formatarString(comentario.descricao)}</td>
											<td width="24" style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
											</td>
											<td width="24" style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
											</td>
									</tr>
								</table>
							</c:forEach>
						</c:if>
						
						<c:if test="${problema.aberto == 0}">
							<p/><input type="submit" value="Adicionar Coment&aacute;rio" class="button" name="salvar"/>
						</c:if>
					</div>
				</form>
			</div>
			
		</div>
			<%@ include file ="../rodape.jsp" %>
	    </div>
</body>
</html>