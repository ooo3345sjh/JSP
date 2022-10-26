<%@page import="common.Person"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JSTL - set 1</title>
		<%--
			날짜 : 2022/10/25
			이름 : 서정현
			내용 : <c:set>태그로 변수와 자바빈즈 사용하기
		--%>
	</head>
	<body>
		<!-- 변수 선언 -->
		<c:set var="directVar" value="109"/>	
		<c:set var="elVar" value="${ directVar mod 5 }"/>	
		<c:set var="expVar" value="new Date()"/>	
		<c:set var="betweenVar">변수값 요렇게 설정</c:set>
		
		<h4>EL을 이용해 변수 출력</h4>
		<ul>
			<li>directVar : ${ pageScope.directVar }</li>
			<li>elVar : ${ elVar }</li>
			<li>expVar : ${ expVar }</li>
			<li>betweenVar : ${ betweenVar }</li>
		</ul>
		
		<h4>자바빈즈 생성 1 - 생성자 사용</h4>
		<c:set var="personVar1" value='<%= new Person("박문수", 50) %>' 
		scope="request"/>
		
		<ul>
			<li>이름 : ${ requestScope.personVar1.name } </li>
			<li>나이 : ${ personVar1.age } </li>
		</ul>
		
		<h4>자바빈즈 생성 2 - target, property 사용</h4>
		<c:set var="personVar2" value='<%= new Person() %>' scope="request"/>
		<c:set target="${ personVar2 }" property="name" value="정약용"/>
		<c:set target="${ personVar2 }" property="age" value="60"/>

		<ul>
			<li>이름 : ${ personVar2.name }</li>
			<li>나이 : ${ requestScope.personVar2.age }</li>
		</ul>
	</body>
</html>