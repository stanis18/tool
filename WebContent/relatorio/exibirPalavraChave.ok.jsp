<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/formatarString.tld" prefix="m" %>
<%@ taglib uri="/WEB-INF/meutag.tld" prefix="p" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<html>

<head> 
	<title>CenAS: Cenários de Aprendizagem</title>
	<link rel="stylesheet" href="css/internas.css" />
	<link rel="stylesheet" href="css/displaytag.css" />
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

				<h4>Planejamento | Descritor</h4>
				
				<form name="atualizar" action="relatorio.formularioPalavraChave.logic" method="post">
					<div style="margin:25px;">
						<c:if test="${empty problema.palavrasChave}">
							
							 <table class="dados" align="center">
					  			<tr>
	  				  				<td class="content1">
	  				  					Nenhum descritor foi inserid. 
										
										<c:if test="${problema.aberto == 0}">
											<br>Para adicionar um descritor, clique em Adicionar.
										</c:if>
									</td>
								</tr>
							</table>
							
						</c:if>
						<c:if test="${not empty problema.palavrasChave}">
							
							<display:table id="palavraChave" name="${problema.palavrasChave}">
								<display:column title="Descritor" property="palavra" style="width: 350px;"/>
								<c:if test="${p:temPermicaoParaEditar(usuario)}">
									<display:column title="A&ccedil;&otilde;es">
										<a href="relatorio.editarPalavraChave.logic?palavraChave.idPalavraChave=${palavraChave.idPalavraChave}"><img src="images/editar.gif"/></a>
										<a href="#"  target="_self" onclick="conf('relatorio.removerPalavraChave.logic?palavraChave.idPalavraChave=${palavraChave.idPalavraChave}', '${palavraChave.palavra}');">
										<img src="images/remover.gif"/></a>
										
										
									</display:column>
								</c:if>
							</display:table>				

						</c:if>
						
						<c:if test="${problema.aberto == 0}">
						<p/>
							<c:if test="${p:podeInserirPalavra(problema.palavrasChave)}">
								<c:if test="${p:temPermicaoParaEditar(usuario)}"><input type="submit" value="Adicionar" class="button" name="salvar"/></c:if>
							</c:if>
						</c:if>
					</div>
				</form>
			</div>
			
		</div>
			<%@ include file ="../rodape.jsp" %>
	    </div>

</body>
</html>
