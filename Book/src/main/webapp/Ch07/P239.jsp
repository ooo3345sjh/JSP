<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	pageContext.setAttribute("pAttr", "김유신");
	request.setAttribute("rAttr", "계백");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>액션 태그 - forward</title>
		<%--
			날짜 : 2022/10/10
			이름 : 서정현
			내용 : 시작 페이지(포워드하는 페이지)
		--%>
	</head>
	<body>
		<h2>액션 태그를 이용한한 포워딩</h2>
		<jsp:forward page="P240.jsp"/>
	</body>
</html>