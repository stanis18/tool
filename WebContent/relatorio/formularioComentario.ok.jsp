<%@ page pageEncoding="ISO-8859-1" %>
<html>
	
	<head>
		<title>CenAS: Cenários de Aprendizagem</title>
		<link rel="stylesheet" href="css/internas.css" />

	</head>

	<body>
	
	<%@ include file ="../cabecalho.jsp" %>
		<form name="novo" action="relatorio.cadastrarComentarioProblema.logic" method="post">
		<div id="corpo">
			<%@ include file ="local.jsp" %>
			<div id="conteudo">
	  		       
				<div id="menu">
					<%@ include file="menu.jsp" %>
				</div>
				<div id="miolo">
					<h1>Problema: ${problema.titulo}</h1>

					<h4>Desenvolvimento | Coment&aacute;rio</h4>
					
					<div style="margin:25px;">
						
						<input type="hidden" name="comentario.problema.idProblema" value="${problema.idProblema}">
						<input type="hidden" name="comentario.idComentario" value="${comentario.idComentario}">

						<table class="dados">
							<tr>
								<td class="title">Descri&ccedil;&atilde;o</td>
								<td class="content3">
									<textarea cols="73" rows="10" name="comentario.descricao">${comentario.descricao}</textarea>
								</td>
							</tr>
							<tr>
								<td class="actions" colspan="2">
									<% String secao = request.getParameter("idCom"); %>
									<input type="hidden" name="comentario.identificadorSecao" value="<%= secao %>">
									<input type="submit" value="Salvar" class="button" name="salvar">&nbsp;
									<input type="button" value="Cancelar" onclick="javascript:window.open('relatorio.exibirComentario.logic','_self');" class="button" />&nbsp;
								</td>
							</tr>											
						</table>
					</div>
				</div>		    
			</div>
			</form>
			<%@ include file ="../rodape.jsp" %>
						
			</div>
	</body>
</html>
