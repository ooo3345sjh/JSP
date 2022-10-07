<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
		<%
			ArrayList<String> lists = new ArrayList<>();
			lists.add("리스트");
			lists.add("컬렉션");
			session.setAttribute("lists", lists);
		%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>session 영역</title>
		<!-- 
			날짜 : 2022/10/07
			이름 : 서정현
			내용 : 최초 페이지(session 영역 동작 확인용)
		-->
	</head>
	<body>
		<h2>페이지 이동 후 session 영역의 속성 읽기</h2>
		<a href="P129_2.jsp">P129_2 바로가기</a>
	</body>
</html>