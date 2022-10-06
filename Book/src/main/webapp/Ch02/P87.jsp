<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내장 객체 - request</title>
		<!-- 
			날짜 : 2022/10/06
			이름 : 서정현
			내용 : 요청 페이지
		-->
	</head>
	<body>
		<h2>1. 클라이언트와 서버의 환경정보 읽기</h2>
		<a href="P89.jsp?eng=Hello&han=안녕">
			GET 방식 전송
		</a>
		<br/>
		<form action="P89.jsp" method="post">
			<label>영어 : <input type="text" name="eng" value="Bye"/></label><br/>
			<label>한글 : <input type="text" name="han" value="잘 가"/></label><br/>
			<input type="submit" value="POST 방식 전송"/>
		</form>
		
		<h2>2. 클라이언트의 요청 매개변수 읽기</h2>
		<form action="P91.jsp" method="post">
			<label>아이디 : <input type="text" name="id" value=""/> </label><br/>
			성별 : 
			<label><input type="radio" name="sex" value="man"/>남자</label>
			<label><input type="radio" name="sex" value="woman"/>여자</label>
			<br/>
			관심사항 : 
			<label><input type="checkbox" name="favo" value="eco"/>경제</label>
			<label><input type="checkbox" name="favo" value="pol" checked="checked"/>정치</label>
			<label><input type="checkbox" name="favo" value="ent"/>연예</label>
			<br/>
			자기소개 :
			<textarea name="intro" rows="4" cols="30"></textarea>
			<br/>
			<input type="submit" value="전송하기">
			<br/>
		</form>
		
		<h2>3. HTTP 요청 헤더 정보 읽기</h2>
		<a href="P93.jsp">
			요청 헤더 정보 읽기
		</a>		
	</body>
</html>