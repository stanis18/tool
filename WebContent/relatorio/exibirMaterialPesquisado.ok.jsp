<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/formatarString.tld" prefix="m" %>
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

				<h4>Apoio | Material Pesquisado</h4>
				
				<form name="atualizar" action="relatorio.formularioMaterialPesquisado.logic" method="post">
					<div style="margin:25px;">
					
						<c:if test="${problema.aberto == 0}">
							<p>
								<input type="submit" value="Adicionar" class="button" name="salvar"/>
							</p>
						</c:if>

						<c:if test="${empty problema.materiaisPesquisado}">
							
							 <table class="dados" align="center">
					  			<tr>
	  				  				<td class="content1">
	  				  					Itens ainda não inseridos.
										<c:if test="${problema.aberto == 0}">
											<br>Para iniciar a edição, clique no botão Adicionar.
										</c:if>
									</td>
								</tr>
							</table>
							
						</c:if>
	
						<c:if test="${not empty problema.materiaisPesquisado}">
							
							<c:forEach var="material" items="${problema.materiaisPesquisado}">
								<table class="dados">
									<tr>
										<td class="title">Link</td>
										<td class="content1">${material.link}</td>
										<c:if test="${problema.aberto == 0}">
   											<td width=24 style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
                                                        <a href="relatorio.editarMaterialPesquisado.logic?materialPesquisado.idMaterialPesquisado=${material.idMaterialPesquisado}"><img border=0 src="images/editar.gif" alt="Editar"></a>
											</td>
											<td width=24 style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
                                                        <a href="#" target="_self" onclick="conf('relatorio.removerMaterialPesquisado.logic?materialPesquisado.idMaterialPesquisado=${material.idMaterialPesquisado}', 'Material Pesquisado');"><img border=0 src="images/remover.gif" alt="Excluir"></a>
											</td>
										</c:if>
									</tr>
									<tr>
											<td class="title">Data de Acesso</td>
											<td class="content1">${material.dataAcesso}</td>
											<td style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
											</td>
											<td style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
											</td>
									</tr>
									<tr>
										<td class="title">Material</td>
										<td class="content1">${m:formatarString(material.material)}</td>
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
							<p/><input type="submit" value="Adicionar" class="button" name="salvar"/>
						</c:if>
					</div>
				</form>
			</div>
			
		</div>
			<%@ include file ="../rodape.jsp" %>
	    </div>
</body>
</html>