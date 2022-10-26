<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedList"%>
<%@page import="common.Person"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JSTL - forEach 2</title>
		<%--
			날짜 : 2022/10/26
			이름 : 서정현
			내용 : 향상된 for문 형태로 사용하기 2
		--%>
		<style>
			*{padding: 0px; margin: 1px;}
		</style>
	</head>
	<body>
		<h4>List 컬렉션 사용하기</h4>
		<%
			List<Person> lists = new LinkedList<>();
			lists.add(new Person("맹사성", 34));
			lists.add(new Person("장영실", 44));
			lists.add(new Person("신숙주", 54));
		%>
		<c:set var="lists" value="<%= lists %>" />
		<c:forEach items="${ lists }" var="list">
		<ul>
			<li>이름 : ${ list.name }, 나이 : ${ list.age }</li>
		</ul>
		</c:forEach>
		
		<h4>Map 컬렉션 사용하기</h4>
		<%
			Map<String, Person> maps = new HashMap<>();
			maps.put("1st", new Person("맹사성", 34));
			maps.put("2nd", new Person("장영실", 44));
			maps.put("3rd", new Person("신숙주", 54));
		%>
		<c:set var="maps" value="<%= maps %>" />
		<c:forEach items="${ maps }" var="map">
			<ul>
				<li>Key => ${ map.key }</li>
				<li>Value => 이름 : ${ map.value.name }, 나이 : ${ map.value.age }</li>
			</ul>
		</c:forEach>
				
	</body>
</html>