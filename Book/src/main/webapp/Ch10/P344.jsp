<%@page import="common.Person"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>표현 언어(EL) - 객체 매개변수</title>
		<%-- 
			날짜 : 2022/10/23
			이름 : 서정현
			내용 : 객체 전달
		--%>
	</head>
	<body>
		<%
			request.setAttribute("personObj", new Person("홍길동", 33));
			request.setAttribute("stringObj", "나는 문자열");
			request.setAttribute("integerObj", new Integer(99));
		%>
		<jsp:forward page="P345.jsp">
			<jsp:param value="10" name="firstNum"/>
			<jsp:param value="20" name="secondNum"/>
		</jsp:forward>
		
	</body>
</html>