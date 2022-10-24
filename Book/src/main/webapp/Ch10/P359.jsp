<%@page import="el.MyELClass"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="mytag" uri="/WEB-INF/MyTagLib.tld" %>
<%
	MyELClass myClass = new MyELClass(); // 객체 생성
	pageContext.setAttribute("myClass", myClass); // page 영역에 저장
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>표현 언어(EL) - 메서드 호출</title>
		<%--
			날짜 : 2022/10/23
			이름 : 서정현
			내용 : EL에서 메서드 호출하기
		--%>
	</head>
	<body>
		<h3>영역에 저장 후 메서드 호출하기</h3>
		<ul>
			<li>001225-3000000 => ${ myClass.getGender("001225-3000000") }</li>
			<li>001225-2000000 => ${ myClass.getGender("001225-2000000") }</li>
			<li>001225-9000000 => ${ myClass.getGender("001225-9000000") }</li>
		</ul>
		
		<!-- 클래스명을 통한 정적 메서드 호출(P361) -->
		<h3>클래스명을 통해 정적 메서드 호출하기</h3>
		<ul>
			<li>${ MyELClass.showGugudan(7) }</li>
		</ul>
		
		<!-- TLD를 이용한 정적 메서드 호출(P368) -->
		<h3>TLD 파일 등록 후 정적 메서드 호출하기</h3>
		<ul>
			<li>mytag:isNumber("100") => ${ mytag:isNumber("100") }</li>
			<li>mytag:isNumber("이백") => ${ mytag:isNumber("이백") }</li>
		</ul>
	</body>
</html>