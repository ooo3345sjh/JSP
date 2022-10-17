<%@page import="java.util.List"%>
<%@page import="customer.CustomerDAO"%>
<%@page import="customer.CustomerDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	CustomerDTO dto = new CustomerDTO();
	CustomerDAO dao = new CustomerDAO();
	List<CustomerDTO> customers = dao.selectList();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>customer::list</title>
	</head>
	<body>
		<h3>고객 목록</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="register.jsp">고객 등록</a>
		<table border="1">
			<tr>
				<th>고객번호</th>
				<th>고객명</th>
				<th>주소</th>
				<th>휴대폰</th>
				<th>관리</th>
			</tr>
			<% for(CustomerDTO c : customers){ %>
			<tr>
				<td><%= c.getCustId() %></td>
				<td><%= c.getName() %></td>
				<td><%= c.getAddress() %></td>
				<td><%= c.getPhone() %></td>
				<td>
					<a href="modify.jsp?custId=<%= c.getCustId()%>">수정</a>
					<a href="delete.jsp?custId=<%= c.getCustId()%>">삭제</a>
				</td>
			</tr>
			<%
				}
			%>
		</table>
	</body>
</html>