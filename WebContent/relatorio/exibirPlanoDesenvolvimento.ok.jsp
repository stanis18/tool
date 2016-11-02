<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/formatarString.tld" prefix="m" %>
<%@ taglib uri="/WEB-INF/meutag.tld" prefix="mt" %>
<html>

<head> 
	<title>CenAS: Cenários de Aprendizagem</title>
	<link rel="stylesheet" href="css/internas.css" />
	<script src="js/confirm.js">
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

				<h4>Planejamento | Plano de Desenvolvimento</h4>
				
				<form name="atualizar" action="relatorio.formularioPlanoDesenvolvimento.logic" method="post">
					<div style="margin:25px;">
					
						<c:if test="${problema.aberto == 0}">
							<c:if test="${mt:temPermicaoParaEditar(usuario)}">
								<p>
									<input type="submit" value="Adicionar Plano" class="button" name="salvar"/>
								</p>
							</c:if>
						</c:if>

						<c:if test="${empty problema.planosDesenvolvimento}">
							
							 <table class="dados" align="center">
					  			<tr>
	  				  				<td class="content1">
	  				  					Plano de desenvolvimento ainda não traçado.
										<c:if test="${problema.aberto == 0}">
											<br>Para iniciar a edição, clique no botão Adicionar Plano.
										</c:if>
									</td>
								</tr>
							</table>
							
						</c:if>
	
						<c:if test="${not empty problema.planosDesenvolvimento}">
							
							<c:forEach var="plano" items="${problema.planosDesenvolvimento}">
								<table class="dados">
									<tr>
										<td class="title">Data</td>
										<td class="content1">${plano.dataPrevistaFormatada}</td>
										<c:if test="${problema.aberto == 0}">
   											<td width="24" style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
												<c:if test="${mt:temPermicaoParaEditar(usuario)}"> 
													<a href="relatorio.editarPlanoDesenvolvimento.logic?planoDesenvolvimento.idPlanoDesenvolvimento=${plano.idPlanoDesenvolvimento}">
														<img border="0" src="images/editar.gif" alt="Editar">
													</a>
												</c:if>
											</td>
											<td width="24" style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
												<c:if test="${mt:temPermicaoParaEditar(usuario)}"> 
													<a href="#" target="_self" onclick="conf('relatorio.removerPlanoDesenvolvimento.logic?planoDesenvolvimento.idPlanoDesenvolvimento=${plano.idPlanoDesenvolvimento}', 'Plano de Desenvolvimento');">
														<img border="0" src="images/remover.gif" alt="Excluir">
													</a>
												</c:if>
											</td>
										</c:if>
									</tr>
									<tr>
										<td class="title">Localiza&ccedil;&atilde;o</td>
										<td class="content1">${m:formatarString(plano.localizacao)}</td>
											<td style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
											</td>
											<td style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
											</td>
									</tr>
									<tr>
										<td class="title">Atividade</td>
										<td class="content1">${m:formatarString(plano.atividade)}</td>
											<td style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
											</td>
											<td style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
											</td>
									</tr>
								</table>
							</c:forEach>
						</c:if>
						
						<c:if test="${problema.aberto == 0}">
							<p/><c:if test="${mt:temPermicaoParaEditar(usuario)}"><input type="submit" value="Adicionar Plano" class="button" name="salvar"/></c:if>
						</c:if>
					</div>
				</form>
			</div>
			
		</div>
			<%@ include file ="../rodape.jsp" %>
	    </div>
</body>
</html>