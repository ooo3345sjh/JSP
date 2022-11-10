<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user1::list</title>
	</head>
	<body>
		<h3>user1 목록</h3>
		<a href="#">처음으로</a>
		<a href="/Ch09/user1/register.do">user 등록</a>
		
		<table border="1">
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>휴대폰</td>
				<td>나이</td>
				<td>관리</td>
			</tr>
			<tr>
				<td>a101</td>
				<td>홍길동</td>
				<td>010-1234-1001</td>
				<td>17</td>
				<td>
					<a href="/Ch09/user1/modify.do">수정</a>
					<a href="#">삭제</a>
				</td>
			</tr>
		</table>
	</body>
</html>