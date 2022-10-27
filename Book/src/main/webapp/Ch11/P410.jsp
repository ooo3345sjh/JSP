<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JSTL - fmt2</title>
		<%--
			날짜 : 2022/10/27
			이름 : 서정현
			내용 : 날짜 포맷 및 타임존 태그 사용하기
		--%>
	</head>
	<body>
		<c:set var="today" value="<%= new Date() %>"/>
		
		<h4>날짜 포맷</h4>
		full : <fmt:formatDate value="${ today }" type="date" dateStyle="full"/>
		short : <fmt:formatDate value="${ today }" type="date" dateStyle="short"/>
		long : <fmt:formatDate value="${ today }" type="date" dateStyle="long"/>
		default : <fmt:formatDate value="${ today }" type="date" dateStyle="default"/>
		
		<h4>시간 포맷</h4>
		full : <fmt:formatDate value="${ today }" type="time" timeStyle="full"/>
		short : <fmt:formatDate value="${ today }" type="time" timeStyle="short"/>
		long : <fmt:formatDate value="${ today }" type="time" timeStyle="long"/>
		default : <fmt:formatDate value="${ today }" type="time" timeStyle="default"/>
		
		<h4>날짜/시간 표시</h4>
		<fmt:formatDate value="${ today }" type="both" dateStyle="full" timeStyle="full"/><br/>
		<fmt:formatDate value="${ today }" type="both" pattern="yyyy-MM-dd hh:mm:ss"/><br/>
		
		<h4>타임존 설정</h4>
		<fmt:timeZone value="GMT">
			<fmt:formatDate value="${ today }" type="both" dateStyle="full" timeStyle="full"/><br/>
		</fmt:timeZone>
		<fmt:timeZone value="America/Chicago">
			<fmt:formatDate value="${ today }" type="both" dateStyle="full" timeStyle="full"/><br/>
		</fmt:timeZone>
	</body>
</html>