<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JSTL - forTokens</title>
		<%--
			날짜 : 2022/10/26
			이름 : 서정현
			내용 : <c:forTokens> 사용하기
		--%>
	</head>
	<body>
		<%
		String rgba = "Red,Green,Blue,Black";
		%>
		<h4>JSTL의 forTokens 태그 사용</h4>
		<c:forTokens items="<%= rgba %>" delims="," var="color">
			<span style="color:${ color };">${ color }</span><br/>
		</c:forTokens>
	</body>
</html>