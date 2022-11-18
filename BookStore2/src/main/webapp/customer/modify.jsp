<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Customer::modify</title>
	</head>
	<body>
		<h3>고객수정</h3>
		<a href="../index.jsp">처음으로</a>	
		<a href="./list.do">고객목록</a>
		<form action="./modify.do" method="post">
			<table border="1">
				<tr>
					<th>고객번호</th>
					<td>
						<input type="text" readonly name="custID" value="${ cust.custID }">
					</td>
				</tr>
				<tr>
					<th>고객명</th>
					<td>
						<input type="text" name="name" value="${ cust.name }">
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<input type="text" name="address" value="${ cust.address }">
					</td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td>
						<input type="text" name="phone" value="${ cust.phone }">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<button type="submit">수정</button>
					</td>
				</tr>
			</table>	
		</form>
	</body>
</html>