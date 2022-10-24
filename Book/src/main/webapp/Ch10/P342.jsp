<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>표현 언어(EL) - 폼값 처리</title>
		<%--
			날짜 : 2022/10/23
			이름 : 서정현
			내용 : 폼값 전송용 개인정보 입력폼
		--%>
	</head>
	<body>
		<h2>폼값 전송하기</h2>
		<form action="P343.jsp" method="post" name="frm">
			<label>이름 : <input type="text" name="name"/></label><br/>
			성별 :
			<label><input type="radio" name="gender" value="Man"/>남자</label>
			<label><input type="radio" name="gender" value="Woman"/>여자</label><br/>
			학력 :
			<select name="grade">
				<option value="ele">초딩</option>
				<option value="mid">중딩</option>
				<option value="high">고딩</option>
				<option value="uni">대딩</option>
			</select><br/>
			관심사항 :
			<label><input type="checkbox" name="inter" value="pol">정치</label>
			<label><input type="checkbox" name="inter" value="eco">경제</label>
			<label><input type="checkbox" name="inter" value="ent">연예</label>
			<label><input type="checkbox" name="inter" value="spo">운동</label><br/>
			<input type="submit" value="전송하기">
		</form>
	</body>
</html>