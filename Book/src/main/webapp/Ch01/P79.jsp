<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%!
	public int add(int num1, int num2){
		return num1 + num2;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>스크립트 요소</title>
		<%--
			날짜 : 2022/10/05
			이름 : 서정현
			내용 : 스크립트 요소 활용		
		--%>
	</head>
	<body>
	
		<%
			int result = add(10, 20);
		%>
		덧셈 결과 1 : <%= result %> <br/> <!-- 표현식(변수) -->
		덧셈 결과 2 : <%= add(30, 40) %> <!-- 표현식(메서드 호출) -->
		
	</body>
</html>