<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JSTL - fmt 3</title>
		<%--
			날짜 : 2022/10/27
			이름 : 서정현
			내용 : 로케일 태그 사용하기
		--%>
	</head>
	<body>
		<h4>로케일 설정</h4>
		<c:set var="today" value="<%= new Date() %>"/>
		
		한글로 설정 : <fmt:setLocale value="ko_kr"/>
		<fmt:formatNumber value="10000" type="currency"/> /
		<fmt:formatDate value="${ today }"/><br/>
		
		일어로 설정 : <fmt:setLocale value="ja_jp"/>
		<fmt:formatNumber value="10000" type="currency"/> /
		<fmt:formatDate value="${ today }"/><br/>
	
		영어로 설정 : <fmt:setLocale value="en_US"/>
		<fmt:formatNumber value="10000" type="currency"/> /
		<fmt:formatDate value="${ today }"/><br/>
		
	</body>
</html>