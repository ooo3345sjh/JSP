<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내장 객체 - Response</title>
		<!-- 
			날짜 : 2022/10/06
			이름 : 서정현
			내용 : 로그인 처리하기
			참고 사이트 : https://ninetynine-2026.tistory.com/174
		-->
	</head>
	<body>
		<%
			String id = request.getParameter("user_id");
			String pwd = request.getParameter("user_pwd");
			if(id.equalsIgnoreCase("must") && pwd.equalsIgnoreCase("1234")){
				response.sendRedirect("P98.jsp");
			}
			else {
				
				//forward 방법1 - 서블릿과 JSP 둘다 사용가능
				//request.getRequestDispatcher("P95.jsp?loginErr=1")
				//.forward(request, response);
		%>		
				<!-- forward 방법2 - 서블릿과 JSP 둘다 사용가능 -->
				<jsp:forward page = "P95.jsp?loginErr=1"/>;
		<%		
				//forward 방법3 - JSP에서만 사용가능
				//pageContext.forward("P95.jsp?loginErr=1");
				
			}
	
	
		%>
		
	</body>
</html>