<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>customer::register</title>
	</head>
	<body>
		<h3>고객등록</h3>
		<a href="/BookStore2/index.jsp">처음으로</a>	
		<a href="./list.do">고객목록</a>
		<form action="./register.do" method="post">
			<table border="1">
				<tr>
					<th>고객명</th>
					<td>
						<input type="text" name="name">
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<input type="text" name="address">
					</td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td>
						<input type="text" name="phone">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<button type="submit">등록</button>
					</td>
				</tr>
			</table>	
		</form>
	</body>
</html>