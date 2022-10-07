<%@page import="common.Person"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("pageInteger", 1000);
	pageContext.setAttribute("pageString", "페이지 영역의 문자열");
	pageContext.setAttribute("pagePerson", new Person("한석봉", 99));
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>page 영역</title>
		<!-- 
			날짜 : 2022/10/07
			이름 : 서정현
			내용 : page 영역에 속성값 저장하고 불러오기
		-->
	</head>
	<body>
		<h2>page 영역의 속성값 읽기</h2>
		<%
			int pInteger = (Integer)(pageContext.getAttribute("pageInteger"));
			String pString = pageContext.getAttribute("pageString").toString();
			Person pPerson = (Person)(pageContext.getAttribute("pagePerson"));
		%>
		
		<ul>
			<li>Integer 객체 : <%= pInteger %></li>
			<li>String 객체 : <%= pString %></li>
			<li>Person 객체 : <%= pPerson.getName() %>, <%= pPerson.getAge() %></li>
		</ul>
		
		<h2>include된 파일에서 page 영역 읽어오기</h2>
		<%@ include file="P121.jsp" %>		
		
		<h2>페이지 이동 후 page 영역 읽어오기</h2>
		<a href="P123.jsp">P123.jsp 바로가기</a>
	</body>
</html>