<%@page import="sub1.Account"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>4_클래스</title>
		<%-- 
			날짜 : 2022/10/04
			이름 : 서정현
			내용 : JSP 클래스 실습하기	
		--%>
	</head>
	<body>
		<h3>반복문</h3>
		
		<%
			Account kb = new Account("국민은행", "101-11-1001", "김유신", 10000); 
			Account wr = new Account("농협은행", "101-11-1002", "김춘추", 20000);
		
			
			kb.deposit(50000);
			kb.withdraw(5000);
			kb.show(out);
			
			wr.deposit(3000);
			wr.withdraw(15000);
			wr.show(out);
		%>	
	</body>
</html>