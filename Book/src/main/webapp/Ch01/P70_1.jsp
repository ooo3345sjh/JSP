<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" errorPage="P70_2.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>errorPage 속성으로 에러 페이지 지정</title>
		<!-- 
			날짜 : 2022/10/05
			이름 : 서정현
			내용 : errorPage 속성으로 에러 페이지 지정
		 -->
	</head>
	<body>
		<%
			int myAge = Integer.parseInt(request.getParameter("age")) + 10; // 에러 발생
			out.println("10년 후 당신의 나이는 " + myAge + "입니다."); // 실행되지 않음
		%>
	</body>
</html>