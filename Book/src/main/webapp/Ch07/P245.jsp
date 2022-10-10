<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>액션태그 - UseBean</title>
		<%--
			날짜 : 2022/10/10
			이름 : 서정현
			내용 : 폼값을 전송하는 페이지
		--%>
		<style>
			ul, ol {list-style: none;}
		</style>
	</head>
	<body>
		<h2>액션 태그로 폼값 한 번에 받기</h2>
		<form action="P246.jsp" method="post">
			<ul>
				<li>
					<label>이름 : <input type="text" name="name"/></label>				
				</li>
				<li>
					<label>나이 : <input type="text" name="age"/></label>
				</li>
				<li>
					<input type="submit" value="폼값 전송">
				</li>		
			</ul>
		</form>
	</body>
</html>