<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>page 지시어 - errorPage, isErrorPage 속성</title>
		<%--
			날짜 : 2022/10/05
			이름 : 서정현
			내용 : 에러 발생 페이지
		 --%>
	</head>
	<body>
		<%
			int myAge = Integer.parseInt(request.getParameter("age")) + 10; // 에러 발생
			out.println("10년 후 당신의 나이는 " + myAge + "입니다."); // 실행되지 않음
		%>
	</body>
</html>