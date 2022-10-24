<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	// 예시에서 사용할 변수 선언
	pageContext.setAttribute("num1", 9);
	pageContext.setAttribute("num2", "10");
	
	pageContext.setAttribute("nullStr", null);
	pageContext.setAttribute("emptyStr", "");
	pageContext.setAttribute("lengthZero", new Integer[0]);
	pageContext.setAttribute("sizeZero", new ArrayList<String>());
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>표현 언어(EL) - 연산자</title>
		<%--
			날짜 : 2022/10/23
			이름 : 서정현
			내용 : 각종 연산자 사용 예2
		--%>
	</head>
		<h3>empty 연산자</h3>
		<ul>
			<li>empty nullStr : ${ empty nullStr }</li>
			<li>empty emptyStr : ${ empty emptyStr }</li>
			<li>empty lengthZero : ${ empty lengthZero }</li>
			<li>empty sizeZero : ${ empty sizeZero }</li>
		</ul>
	
		<h3>삼항 연산자</h3>
		<ul>
			<li>num1 gt num2 ? "참" : "거짓" => ${ num1 gt num2? "num1이 크다" : "num2가 크다" }</li>
		</ul>
	
		<h3>null 연산자</h3>
		<ul>
			<!-- <li>null + 10 : ${ null + 10}</li>  -->
			<li>nullStr + 10 : ${ nullStr + 10 }</li>
			<li>param.noVar > 10 : ${ param.noVar > 10 }</li>
		</ul>
		
	<body>
		
	</body>
</html>