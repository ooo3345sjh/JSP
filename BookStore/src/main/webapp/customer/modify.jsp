<%@page import="customer.CustomerDAO"%>
<%@page import="customer.CustomerDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String custId = request.getParameter("custId");
	
	// 고객 정보 조회
	CustomerDAO dao = new CustomerDAO();
	CustomerDTO dto = dao.selectCustomer(custId);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>customer::modify</title>
	</head>
	<body>
		<h3>고객 수정</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="list.jsp">고객목록</a>
		<form action="modifyProc.jsp">
			<table border="1">
				<tr>
					<th>고객번호</th>
					<td><input type="text" name="custId" readonly value="<%= dto.getCustId()%>"> </td>
				</tr>
				<tr>
					<th>고객명</th>
					<td><input type="text" name="name" value="<%= dto.getName()%>"> </td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" name="address" value="<%= dto.getAddress()%>"> </td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td><input type="text" name="phone" value="<%= dto.getPhone()%>"> </td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="수정">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>