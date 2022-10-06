<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="P76_1.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>include 지시어</title>
		<%--
			날짜 : 2022/10/05
			이름 : 서정현
			내용 : 다른 JSP파일을 포함하는 JSP 파일
		--%>
	</head>
	<body>
		<%
			out.println("오늘 날짜  " + today);
			out.println("<br/>");
			out.println("내일 날짜  " + tomorrow);
		
		%>
	</body>
</html>