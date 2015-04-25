<ul> 
	<c:forEach var="error" items="${errors.iterator}">
		<li style="font-family: verdana;color: red; font-size:8pt; font-weight: bold;">${error.key}</li>
	</c:forEach>
</ul>