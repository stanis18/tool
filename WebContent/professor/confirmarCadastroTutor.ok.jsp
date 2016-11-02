<%@ page pageEncoding="ISO-8859-1" %>
<html>

<head>
	<title>CenAS: Cenários de Aprendizagem</title>
	<link rel="stylesheet" href="css/internas.css" />

</head>

  <script type="text/javascript" src="js/menu_editar_tutor.js"></script>

<body>
       
    <%@ include file ="../cabecalho_disciplinas.jsp" %>
    <div id="corpo">
    
    <%@ include file ="cabecalho_local_prof.jsp" %>
        
	    <div id="conteudo">
        
		<%@ include file="menuTutor.jsp" %>
        
        <div >
                
            <p style="text-align: center;"><span style="font-weight: bold;">Tutor cadastrado/alterado com sucesso!</span>
        <br>
        <br>
        Dados cadastrados:<br/><br/>
        Nome: ${tutor.nome} <br/>
        CPF: ${tutor.CPF} <br/>
        Senha: ${tutor.senha} (Gerada automaticamente pelo sistema)<br/>
        Login: ${tutor.login} <br/>
        Email: ${tutor.email} <br/><br/>
        
        
        <br>
        <input class="button" value="Voltar"  onclick="javascript:window.open('professor.listarTutor.logic','_self');"  type="button">
        <br>
        
    
    </p>
            
            
        </div>       
            
            
             
            
        </div>
        <%@ include file ="../rodape.jsp" %>
        
    </div>

</body>
</html>
