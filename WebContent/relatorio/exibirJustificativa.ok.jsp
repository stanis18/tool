<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/formatarString.tld" prefix="m" %>
<%@ taglib uri="/WEB-INF/meutag.tld" prefix="mt" %>

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

				<h4>Planejamento | Justificativa</h4>
				
				<form name="atualizar" action="relatorio.formularioJustificativa.logic" method="post">
					<div style="margin:25px;">
						<c:if test="${empty problema.justificativa}">
							
							 <table class="dados" align="center">
					  			<tr>
	  				  				<td class="content1">
	  				  					Este campo ainda n&atilde;o foi editado por nenhum integrante da equipe. 
										
										<c:if test="${problema.aberto == 0}">
											<br>Para iniciar a edi&ccedil;&atilde;o, clique em editar.
										</c:if>
									</td>
								</tr>
							</table>
							
						</c:if>
						<c:if test="${not empty problema.justificativa}">
							${m:formatarString(problema.justificativa)}
						</c:if>
						
						<c:if test="${problema.aberto == 0}">
						<p/><c:if test="${mt:temPermicaoParaEditar(usuario)}"><input type="submit" value="Editar" class="button" name="salvar"/></c:if>
						</c:if>
					</div>
				</form>
			</div>
			
		</div>
			<%@ include file ="../rodape.jsp" %>
	    </div>
</body>
</html>
