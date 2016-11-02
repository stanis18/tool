<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="/WEB-INF/formatarString.tld" prefix="fs"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>

<head>
	<title>CenAS: Cenários de Aprendizagem</title>
	<link rel="author" href="josepiraua@hotmail.com" />
	<link rel="stylesheet" media="screen" href="css/relatorio.css" />
	<link rel="stylesheet" media="print" href="css/relatorio2.css" />	
	
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

<div id="content">
	<div id="imprimir">
		<p>
			<input type="button" class="button" value="Imprimir" onclick="window.print()" />&nbsp;
			<input type="button" class="button" value="Fechar" onclick="window.close()" />
		</p>
	</div>
	<div id="inner">
		<h1><p align="center">${problema.titulo}</p></h1>
		<div id="participantes" align="center">
			${fs:listarNomes(problema.equipe.alunos)}
			<c:if test="${not empty problema.equipe.tutor}">
				${problema.equipe.tutor.nome}
			</c:if><br/><br/>	 
		</div>
		<div align="center">
	       	Universidade Federal de Pernambuco<br/>
    	    Curso de Medicina<br/>
			${problema.disciplina.nome}
		</div>
		<div id="data">Data: <script language="javascript" type="text/javascript"> document.write(Data()); </script></div>
		
		<div id="miolo">
			
			<h5>Resumo</h5>
			<p align="justify">
				${fs:formatarString(problema.resumo)} 
			</p>
			
			<br/>
			
			<b>Descritores: </b><c:if test="${not empty problema.palavrasChave}">${fs:listarPalavras(problema.palavrasChave)}</c:if>

            <p class="quebra"/>

			<h5>Cenário</h5>
			<p align="justify">
				${fs:formatarString(problema.cenario)}
			</p>
                        
            <p class="quebra"/>

			<h5>Objetivos</h5>
            <p align="justify">
				${fs:formatarString(problema.objetivos)}		
			</p>

            <p class="quebra"/>

			<h5>Justificativa</h5>
            <p align="justify">
				${fs:formatarString(problema.justificativa)}		
			</p>

            <p class="quebra">
			
			<h5>Desenvolvimento</h5>
			
			<p align="justify">
				${fs:formatarString(problema.descricao)}
			</p>

			<br/>
			
			<c:forEach var="materialGrafico" items="${problema.materiaisGrafico}">
				<p align="center">
					<img class="material-grafico" src="relatorio.mostraImagem.logic?materialGrafico.idMaterialGrafico=${materialGrafico.idMaterialGrafico}"/><br/>
					<span style="text-align:center;">
						<b>Figura:</b>  ${fs:retirarTags(materialGrafico.legenda)}
					</span>
					<br/>
					<br/>
				</p>
			</c:forEach>
			
   
			<p class="quebra"/>
           
			<h5>Recomendações</h5>
          	<p align="justify">
				${fs:formatarString(problema.recomendacoes)}
			</p>
			
			<p class="quebra"/>
           
			<h5>Conclusão</h5>
			
			<p align="justify">
				${fs:formatarString(problema.conclusaoAvaliacao)}
			</p>
			
			<br/>

			<p class="quebra"/>
                      
			<h5>Glossário</h5>
			
			<p align="justify">
				<ul>
					<c:forEach var="glossario" items="${problema.glossarios}">
						<li> <b>${glossario.termo}:</b> ${glossario.descricao}  </li>
					</c:forEach>
				</ul>
			</p>

			<br>

			<p class="quebra"/>

			<h5>Referências Bibliográficas</h5>
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
			
		</div>
	</div>
</div>
</body>
</html>
