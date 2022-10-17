<%@page import="book.BookDAO"%>
<%@page import="book.BookDTO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	BookDTO dto = new BookDTO();
	BookDAO dao = new BookDAO();
	List<BookDTO> books = dao.selectList();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>book::list</title>
		
	</head>
	<body>
		<h3>도서 목록</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="register.jsp">도서 등록</a>
		<table border="1">
			<tr>
				<th>도서번호</th>
				<th>도서명</th>
				<th>출판사</th>
				<th>가격</th>
				<th>관리</th>
			</tr>
			<% for(BookDTO b : books){ %>
			<tr>
				<td><%= b.getBookId() %></td>
				<td><%= b.getBookName() %></td>
				<td><%= b.getPublisher() %></td>
				<td><%= b.getPrice() %></td>
				<td>
					<a href="modify.jsp?bookId=<%= b.getBookId()%>">수정</a>
					<a href="delete.jsp?bookId=<%= b.getBookId()%>">삭제</a>
				</td>
			</tr>
			<%
				}
			%>
			<tr>
				<td colspan="5" align="right">
					<button type="button" onclick="location.href='register.jsp'">등록</button>
				</td> 
			</tr>
		</table>
	</body>
</html>