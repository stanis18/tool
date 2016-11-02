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

				<h4>Planejamento | Refer&ecirc;ncias Iniciais</h4>
				
				<form name="atualizar" action="relatorio.formularioReferenciasIniciais.logic" method="post">
					<div style="margin:25px;">
					
						<c:if test="${problema.aberto == 0}">
							<c:if test="${mt:temPermicaoParaEditar(usuario)}">
								<p>
									<input type="submit" value="Adicionar Refer&ecirc;ncia" class="button" name="salvar"/>
								</p>
							</c:if>
						</c:if>

						<c:if test="${empty problema.referenciasInicial}">
							
							 <table class="dados" align="center">
					  			<tr>
	  				  				<td class="content1">
	  				  					Itens ainda não inseridos na referência bibliográfica.
										<c:if test="${problema.aberto == 0}">
											<br>Para iniciar a edição, clique no bot&atilde;o Adicionar Refer&ecirc;ncia.
										</c:if>
									</td>
								</tr>
							</table>
							
						</c:if>
	
						<c:if test="${not empty problema.referenciasInicial}">
							
							<c:forEach var="referencia" items="${problema.referenciasInicial}">
								<table class="dados">
									<tr>
										<td class="title">T&iacute;tulo</td>
										<td class="content1">${referencia.titulo}</td>
										<c:if test="${problema.aberto == 0}">
   											<td width="24" style='border-top:none;border-left:none;
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
                                                        <c:if test="${mt:temPermicaoParaEditar(usuario)}">
                                                        	<a href="relatorio.editarReferenciasIniciais.logic?referenciaInicial.id=${referencia.id}"><img border="0" src="images/editar.gif" alt="Editar"></a>
                                                        </c:if>
											</td>
											<td width="24" style='border-top:none;border-left:none; 
                                                        border-bottom:solid #A2C8C8 1.0pt;border-right:none;'>
                                                        <c:if test="${mt:temPermicaoParaEditar(usuario)}">
                                                        	<a href="#" target="_self" onclick="conf('relatorio.removerReferenciasIniciais.logic?referenciaInicial.id=${referencia.id}', '${referencia.titulo}');"><img border="0" src="images/remover.gif" alt="Excluir"></a>
                                                        </c:if>
											</td>
										</c:if>
									</tr>
									<tr>
										<td class="title">Autores</td>
										<td class="content1">${referencia.autor}</td>	
									</tr>
									<tr>
										<td class="title">Descri&ccedil;&atilde;o</td>
										<td class="content1">${m:formatarString(referencia.descricao)}</td>	
									</tr>
									<tr>
										<td class="title">Editora</td>
										<td class="content1">${referencia.editora}</td>	
									</tr>
									<tr>
										<td class="title">Ano | Edi&ccedil;&atilde;o</td>
										<td class="content1">${referencia.ano} | ${referencia.edicao}</td>	
									</tr>
									<tr>
										<td class="title">URL</td>
										<td class="content1">${referencia.url}</td>	
									</tr>
									<tr>
										<td class="title">Acesso</td>
										<td class="content1">${referencia.dataAcesso}</td>	
									</tr>
								</table>
							</c:forEach>
						</c:if>
						
						<c:if test="${problema.aberto == 0}">
							<p/><c:if test="${mt:temPermicaoParaEditar(usuario)}"><input type="submit" value="Adicionar Refer&ecirc;ncia" class="button" name="salvar"/></c:if>
						</c:if>
					</div>
				</form>
			</div>
			
		</div>
			<%@ include file ="../rodape.jsp" %>
	    </div>
</body>
</html>