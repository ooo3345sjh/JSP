<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>page 지시어 - errorPage, isErrorPage 속성</title>
		<!-- 
			날짜 : 2022/10/05
			이름 : 서정현
			내용 :try/catch 구문으로 직접 처리
		-->
	</head>
	<body>
		<%
			try { // 에외 발생 부분을 try/catch로 감싼다.
				int myAge = Integer.parseInt(request.getParameter("age")) + 10;
					out.println("10년 후 당신의 나이는 " + myAge + "입니다.");
				
			} catch(Exception e){
				out.println("예외 발생 : 매개 변수 age가 null입니다.");				
			}
		%>
	</body>
</html>