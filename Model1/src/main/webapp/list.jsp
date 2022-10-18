<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>list</title>
		<style>
			*{padding: 0; margin: 0;}
			#wrapper{width: 900px; height: auto; margin: auto;}
			table{width: 100%; height: auto;}
		</style>
	</head>
	<body>
		<div id="wrapper">
			<jsp:include page="link.jsp"/>
			<h3>목록 보기</h3>
			<form>
				<table border="1">
					<tr>
						<td align="center">
							<select name="searchField">
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select>
							<input type="text" name="content">
							<input type="submit" value="검색하기">
						</td>
					</tr>
				</table>
			</form>
			<table border="1">
				<tr>
					<th width="10%">번호</th>
					<th width="45%">제목</th>
					<th width="10%">작성자</th>
					<th width="10%">조회수</th>
					<th width="20%">작성일</th>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</div>
	</body>
</html>