<%@ page pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
	
	<head>
	
		<title>CenAS: Cenários de Aprendizagem</title>
		<link rel="stylesheet" href="css/internas.css" />
	
	<SCRIPT LANGUAGE="JavaScript">

	function insertOption(){
        var select1 = document.getElementById("select1");
        var select2 = document.getElementById("select2");
        
        var i = 0;
        while(select1.selectedIndex >= 0){
            var novo_option = document.createElement('option');
            novo_option.text = select1.options[select1.selectedIndex].text;
            novo_option.value = select1.options[select1.selectedIndex].value;
           
            try{
                select2.add(novo_option, null); // standards compliant
                select1.remove(select1.selectedIndex);
            }
            catch(ex){
                select2.add(novo_option); // IE only
                select1.remove(select1.selectedIndex);
            }
        
        }
            
    }

	function removeOption(){
        var select1 = document.getElementById("select2");
        var select2 = document.getElementById("select1");
        
        var i = 0;
        while(select1.selectedIndex >= 0){
            var novo_option = document.createElement('option');
            novo_option.text = select1.options[select1.selectedIndex].text;
            novo_option.value = select1.options[select1.selectedIndex].value;
           
            try{
                select2.add(novo_option, null); // standards compliant
                select1.remove(select1.selectedIndex);
            }
            catch(ex){
                select2.add(novo_option); // IE only
                select1.remove(select1.selectedIndex);
            }

       }
            
    }
	
	function insertAllOption(){
        var select1 = document.getElementById("select1");
        var select2 = document.getElementById("select2");

        for(var i = 0; i < select1.options.length; i++ )   {
  	    	select1.options[i].selected = true;
  	  	}
        
        var i = 0;
        while(select1.length >= 0){
            var novo_option = document.createElement('option');
            novo_option.text = select1.options[select1.selectedIndex].text;
            novo_option.value = select1.options[select1.selectedIndex].value;
           
            try{
                select2.add(novo_option, null); // standards compliant
                select1.remove(select1.selectedIndex);
            }
            catch(ex){
                select2.add(novo_option); // IE only
                select1.remove(select1.selectedIndex);
            }  
        }
            
    }

	function removeAllOption(){
        var select1 = document.getElementById("select2");
        var select2 = document.getElementById("select1");

        for(var i = 0; i < select1.options.length; i++ )   {
  	    	select1.options[i].selected = true;
  	  	}
        
        var i = 0;
        while(select1.length >= 0){
            var novo_option = document.createElement('option');
            novo_option.text = select1.options[select1.selectedIndex].text;
            novo_option.value = select1.options[select1.selectedIndex].value;
           
            try{
                select2.add(novo_option, null); // standards compliant
                select1.remove(select1.selectedIndex);
            }
            catch(ex){
                select2.add(novo_option); // IE only
                select1.remove(select1.selectedIndex);
            }  
        }
	}

	// Garante que todos alunos serão cadastrados no problema
	function selecionarTodos() {
	  var select2 = document.getElementById("select2");
      for( var i = 0; i < select2.options.length; i++ )   {
	    select2.options[i].selected = true;
	  }
	  return;
	}
	
	</SCRIPT>
	
	</head>
	
	<link rel="stylesheet" href="css/internas.css" />
	
	<body>
	
	<form name="form1" method="post" action="professor.cadastrarEquipe.logic">
		
		<input type="hidden" name="equipe.id" value="${equipe.id}"/>

		<%@ include file="../cabecalho_disciplinas.jsp"%>
		
		<div id="corpo">
			
			<%@ include file ="cabecalho_local_prof.jsp" %>
				
			<div id="conteudo">
				<p>
					<b>Disciplina:</b> 
					<input type="text" name="equipe.disciplina.nome" value="${equipe.disciplina.nome}" disabled="disabled" style="width: 100%;" />
					<input type="hidden" name="equipe.disciplina.id" value="${equipe.disciplina.id}"/>
				</p>
				<script type="text/javascript">
					function alterarCampos(idw,eq){
						if(idw != null && idw != ""){
							window.location= "professor.formularioEquipe.logic?disciplina.id=" +idw+ "&&equipe.id=" + ;
						}
					}
				</script>
				<b>Nome da equipe:</b> <br />
				
				<input type="text" style="width: 100%;" name="equipe.nome" value="${equipe.nome}" /> 
			
				<br/>
				
				<br/>
				
				<b>Per&iacute;odo:</b> <br />
				<input size="7" name="equipe.periodo" type="text" value="${equipe.periodo}" /> (Ex: "2009.1") <br />
				
					<br/>
					
					<b>Tutores dispon&iacute;veis:</b> 
					
					<br/>
					
					<select name="equipe.tutor.id" id="tutor" >
						<c:forEach var="tut" items="${tutores}">
							<option value="${tut.id}" <c:if test="${equipe.tutor.id == tut.id}">selected="true"</c:if>>${tut.nome}</option>
						</c:forEach>		
					</select> 
				
					<br/>
					
					<br/>
				
				<table summary="" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<b>Alunos dispon&iacute;veis:</b><br />
							
							<select multiple style="height:200px; width: 100px;" name="listLeft" id="select1">
								<c:if test="${not empty alunos}">
									<c:forEach var="aluno" items="${alunos}">
										<option value="${aluno.id}">${aluno.nome}</option>
									</c:forEach>
								</c:if>
							</select>
						</td>
							
							<td class="buttons">&nbsp; <input type="button" value="Adicionar" class="nov_pro_but" onclick="insertOption()" />
							&nbsp; <br /> &nbsp; 
							<input type="button" value="Remover" class="nov_pro_but"	onclick="removeOption()" />
							&nbsp; <br /> &nbsp; 
							<input type="button" value="Adicionar Todos" class="nov_pro_but" onclick="insertAllOption()" />
							&nbsp; <br /> &nbsp; 
							<input type="button" value="Remover Todos" class="nov_pro_but" onclick="removeAllOption()" />
							&nbsp;
						
						</td>
			
						<td>

							<b>Alunos envolvidos no problema:</b>
						
							<br />
			
							<select multiple="multiple" style="width:250px; height:200px;" name="equipe.alunos.id" id="select2">
								<c:if test="${not empty equipe.alunos}">
									<c:forEach var="aluno" items="${equipe.alunos}">
										<option value="${aluno.id}">${aluno.nome}</option>
									</c:forEach>
								</c:if>
							</select>
							
						</td>

					</tr>

				</table>

				<div style="margin-top:20px;">

					<input type="submit" class="button" value="Salvar" onclick="selecionarTodos()" /> &nbsp; 

				</div>

			</div>

			<%@ include file="../rodape.jsp"%>

		</div>

	</form>
	
	</body>

</html>