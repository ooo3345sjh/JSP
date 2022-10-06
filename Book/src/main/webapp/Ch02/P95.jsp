<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내장 객체 - response</title>
		<!-- 
			날짜 : 2022/10/06
			이름 : 서정현
			내용 : 로그인 폼과 응답헤더 설정 페이지
		-->
	</head>
	<body>
		<h2>1. 로그인 폼</h2>
		<%
			String loginErr = request.getParameter("loginErr");
			if(loginErr != null) out.print("로그인 실패");
		%>
		<form action="P97.jsp" method="post">
			<label>아이디 : <input type="text" name="user_id"/></label><br/>
			<label>패스워드 : <input type="password" name="user_pwd"/></label><br/>
			<input type="submit" value="로그인"/>
		</form>
		
		<h2>2. HTTP 응답 헤더 설정하기</h2>
		<form action="P99.jsp" method="get">
			<label>날짜 형식 : <input type="text" name="add_date" value="2021-10-25"/></label><br/>
			<label>숫자 형식 : <input type="text" name="add_int" value="8282"/></label><br/>
			<label>문자 형식 : <input type="text" name="add_str" value="홍길동"/></label><br/>
			<input type="submit" value="응답 헤더 설정 & 출력"/>
		</form>
		
	</body>
</html>