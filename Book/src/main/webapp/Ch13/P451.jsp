<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>HelloServelt.jsp</title>
		<%--
			날짜 : 2022/10/28
			이름 : 서정현
			내용 : web.xml을 이용한 매핑
		--%>
	</head>
	<body>
		<h2>web.xml에서 매핑 후 JSP에서 출력하기</h2>
		<p>
			<strong><%= request.getAttribute("message") %></strong>
			<br/>
			<a href="./HelloServlet.do">바로가기</a>
		</p>	
	</body>
</html>