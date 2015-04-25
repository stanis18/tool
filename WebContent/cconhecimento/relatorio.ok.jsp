<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/formatarString.tld" prefix="fs"%>
<html>

<head>

	<title>CenAS: Cenários de Aprendizagem</title>
	<link rel="stylesheet" href="css/internas2.css" />
	<link rel="stylesheet" href="css/displaytag.css"/>
	
	<script language="Javascript" type="text/javascript">
		function Data() {
			var hoje = new Date();
			var dia = hoje.getDate();
			var mes = hoje.getMonth() + 1;
			var ano = hoje.getYear();

			if(ano < 2009) ano = ano + 1900;
			
			return ( dia + '/' + mes + '/' + ano);
		}
	</script>
	
</head>

<body>
    <%@ include file ="../cabecalho2.jsp" %>
 	<div id="corpo"> 
		
		<div id="conteudo">			
			<br/>
			
			<p align="center" style="font-size: 16pt;"><b>${problema.titulo}</b></p>
			<div id="participantes" align="center">
				${fs:listarNomes(problema.equipe.alunos)}
				<c:if test="${not empty problema.equipe.tutor}">
					${problema.equipe.tutor.nome}
				</c:if><br/><br/><br/><br/>	 
			</div>
			<div align="center">
	       		Universidade Federal de Pernambuco<br/>
    	    	Curso de Medicina<br/>
				${problema.disciplina.nome}
			</div>
			
			<div id="data" align="right">Data: <script language="javascript" type="text/javascript"> document.write(Data()); </script></div>
			
			<br/>
			
			<h1>Resumo</h1>
			
			<p align="justify">
				${fs:formatarString(problema.resumo)} 
			</p>
			
			<br/>
			
			<h1>Descritores</h1>
			<p align="justify">
			<c:if test="${not empty problema.palavrasChave}">${fs:listarPalavras(problema.palavrasChave)}</c:if>
			</p>
            
            <h1>Cenário</h1>
			<p align="justify">
				${fs:formatarString(problema.cenario)}
			</p>
                        
			<h1>Objetivos</h1>
            <p align="justify">
				${fs:formatarString(problema.objetivos)}		
			</p>

			<h1>Justificativa</h1>
            <p align="justify">
				${fs:formatarString(problema.justificativa)}		
			</p>

            <h1>Desenvolvimento</h1>
			
			<p align="justify">
				${fs:formatarString(problema.descricao)}
			</p>
			
			<c:forEach var="materialGrafico" items="${problema.materiaisGrafico}">
				<p align="center">
					<img class="material-grafico" src="cconhecimento.mostraImagem.logic?materialGrafico.idMaterialGrafico=${materialGrafico.idMaterialGrafico}" /><br/>
					<span style="text-align:center;">
						<b>Figura:</b> ${fs:retirarTags(materialGrafico.legenda)}
					</span>
					<br/>
					<br/>
				</p>
			</c:forEach>
		 
			<h1>Recomendações</h1>
          	<p align="justify">
				${fs:formatarString(problema.recomendacoes)}
			</p>
			
			<h1>Conclusão</h1>
			
			<p align="justify">
				${fs:formatarString(problema.conclusaoAvaliacao)}
			</p>
			                      
			<h1>Glossário</h1>
			
			<ul>
				<c:forEach var="glossario" items="${problema.glossarios}">
					<li> <b>${glossario.termo}:</b> ${glossario.descricao}  </li>
				</c:forEach>
			</ul>

			<br>

			<h1>Referências Bibliográficas</h1>
			<p>
				<c:forEach var="referenciaBibliografica" items="${problema.referenciasBibliografica}">
					<ul>
						<li><b>Titulo: </b>${referenciaBibliografica.titulo}. 
						<br/><b>Autor(es):</b> ${referenciaBibliografica.autor}. 
						<br/><b>Descrição: </b>${fs:formatarString(referenciaBibliografica.descricao)}. 
						<br/><b>Editora: </b>${referenciaBibliografica.editora}. 
						<br/><b>Ano: </b>${referenciaBibliografica.ano}. 
						<br/><b>Edição: </b>${referenciaBibliografica.edicao}. 
						<br/><b>Url: </b>${referenciaBibliografica.url} 
						<br/><b>Data de Acesso: </b>${referenciaBibliografica.dataAcesso}</li>
					</ul>
				</c:forEach>
			</p>
			<br>
		
			
			
			<input class="button" type="button" title="Voltar" value="Voltar" onclick="javascript:window.open('cconhecimento.acessoLivre.logic', '_self');"/>
		</div>
		<%@ include file ="../rodape.jsp" %>
	</div>
</body>
</html>