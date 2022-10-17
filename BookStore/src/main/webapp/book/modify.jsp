<%@page import="book.BookDTO"%>
<%@page import="book.BookDAO"%>
<%@page import="customer.CustomerDAO"%>
<%@page import="customer.CustomerDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String bookId = request.getParameter("bookId");
	
	// 고객 정보 조회
	BookDAO dao = new BookDAO();
	BookDTO dto = dao.selectBook(bookId);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>book::modify</title>
	</head>
	<body>
		<h3>고객 수정</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="list.jsp">도서목록</a>
		<form action="modifyProc.jsp">
			<table border="1">
				<tr>
					<th>도서번호</th>
					<td><input type="text" name="bookId" readonly value="<%= dto.getBookId()%>"> </td>
				</tr>
				<tr>
					<th>도서명</th>
					<td><input type="text" name="bookName" value="<%= dto.getBookName()%>"> </td>
				</tr>
				<tr>
					<th>출판사</th>
					<td><input type="text" name="publisher" value="<%= dto.getPublisher()%>"> </td>
				</tr>
				<tr>
					<th>가격</th>
					<td><input type="text" name="price" value="<%= dto.getPrice()%>"> </td>
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