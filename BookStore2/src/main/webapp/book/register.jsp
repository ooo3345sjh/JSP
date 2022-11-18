<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Book::register</title>
	</head>
	<body>
		<h3>도서수정</h3>
		<a href="./index.jsp">처음으로</a>	
		<a href="./list.do">도서목록</a>
		<form action="./register.do" method="post">
			<table border="1">
				<tr>
					<th>도서번호</th>
					<td>
						<input type="text" name="bookID">
					</td>
				</tr>
				<tr>
					<th>도서명</th>
					<td>
						<input type="text" name="bookName">
					</td>
				</tr>
				<tr>
					<th>출판사</th>
					<td>
						<input type="text" name="publisher">
					</td>
				</tr>
				<tr>
					<th>가격</th>
					<td>
						<input type="text" name="price">
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