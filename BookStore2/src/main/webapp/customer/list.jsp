<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Customer::list</title>
	</head>
	<body>
		<h3>고객목록</h3>
		<a href="/BookStore2/index.jsp">처음으로</a>	
		<a href="./register.do">고객등록</a>
		<table border="1">
			<tr>
				<th>고객번호</th>
				<th>고객명</th>
				<th>주소</th>
				<th>휴대폰</th>
				<th>관리</th>
			</tr>
			<c:forEach var="cust" items="${ customers }">
				<tr>
					<td align="center">${ cust.custID }</td>
					<td>${ cust.name }</td>
					<td>${ cust.address }</td>
					<td>${ cust.phone }</td>
					<td>
						<a href="./modify.do?custID=${ cust.custID }">수정</a>
						<a href="./delete.do?custID=${ cust.custID }">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</table>	
	</body>
</html>