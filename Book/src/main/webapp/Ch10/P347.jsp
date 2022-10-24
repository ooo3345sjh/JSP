<%@page import="utils.CookieManager"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	CookieManager.makeCookie(response, "ELCookie", "EL좋아요", 10);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>표현 언어(EL) - 그 외 내장 객체</title>
		<%--
			날짜 : 2022/10/23
			이름 : 서정현
			내용 : 쿠키, HTTP 헤더, 컨텍스트 초기화 매개변수 출력하기
		--%>
	</head>
	<body>
		<h3>쿠키값 읽기</h3>
		<p>ELCookie 값 : ${ cookie.ELCookie.value }</p>
		
		<h3>HTTP 헤더 읽기</h3>
		<ul>
			<li>host : ${ header.host }</li>
			<li>user-agent : ${ header['user-agent'] }</li>
			<li>cookie : ${ header.cookie }</li>
		</ul>
		<h3>컨텍스트 초기화 매개변수 읽기</h3>
		<p>mysqlDriver : ${ initParam.MysqlDriver }</p>
		
		<h3>컨텍스트 루트 경로 읽기</h3>
		<p>${ pageContext.request.contextPath }</p>
	</body>
</html>