<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>MemberAuth.jsp</title>
		<%--
			날짜 : 2022/10/28
			이름 : 서정현
			내용 : MVC 패턴을 통한 회원인증용 메뉴 화면
		--%>
	</head>
	<body>
		<h2>MVC 패턴으로 회원인증하기</h2>
		<p>
			<strong>${ authMessage }</strong>
			<br/>
			<a href="./MemberAuth.mvc?id=nakja&pass=1234">회원인증(관리자)</a> &nbsp;&nbsp;
			<a href="./MemberAuth.mvc?id=musthave&pass=1234">회원인증(회원)</a> &nbsp;&nbsp;
			<a href="./MemberAuth.mvc?id=stranger&pass=1234">회원인증(비회원)</a>
		</p>
		
	</body>
</html>