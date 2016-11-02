<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${not empty errors}">
    <div id = "erros">
        <div align="left" style="margin-left: 10px; margin-right: 10px">
			<b>Erro!</b>
			<hr id="barraHR">
			<c:forEach var="error" items="${errors.iterator}">
				- ${error.key} <br/>
			</c:forEach>
        </div>
    </div>
</c:if>