<%@ page pageEncoding="ISO-8859-1" %>
<html>
	
	<head>
		<title>CenAS: Cenários de Aprendizagem</title>
		<link rel="stylesheet" href="css/internas.css" />

	</head>

	<body>
	
	<%@ include file ="../cabecalho.jsp" %>
		<form name="novo" action="relatorio.cadastrarPalavraChaveProblema.logic" method="post">
		<div id="corpo">
			<%@ include file ="local.jsp" %>
			<div id="conteudo">
	  		       
				<div id="menu">
					<%@ include file="menu.jsp" %>
				</div>
				<div id="miolo">
					<h1>Problema: ${problema.titulo}</h1>

					<h4>Planejamento | Descritor</h4>
					
					<div style="margin:25px;">
						
						<input type="hidden" name="palavraChave.problema.idProblema" value="${problema.idProblema}">
						<input type="hidden" name="palavraChave.idPalavraChave" value="${palavraChave.idPalavraChave}">

						<table class="dados">
							<tr>
								<td class="title">Descritor</td>
								<td class="content3">
									<input type="text" name="palavraChave.palavra" value="${palavraChave.palavra}"/>
								</td>
							</tr>
							<tr>
								<td class="actions" colspan="2">
									<input type="submit" value="Salvar" class="button" name="salvar">&nbsp;
									<input type="button" value="Cancelar" onclick="javascript:window.open('relatorio.exibirPalavraChave.logic','_self');" class="button" />&nbsp;
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
