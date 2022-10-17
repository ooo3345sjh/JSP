<%@page import="customer.CustomerDAO"%>
<%@page import="customer.CustomerDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>customer::register</title>
	</head>
	<body>
		<h3>고객 등록</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="list.jsp">고객목록</a>
		<form action="registerProc.jsp">
			<table border="1">
				<tr>
					<th>고객명</th>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" name="address"></td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td><input type="text" name="phone"></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="등록">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>