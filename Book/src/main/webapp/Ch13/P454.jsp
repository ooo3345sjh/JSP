<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>AnnoMapping.jsp</title>
		<%-- 
			날짜 : 2022/10/28
			이름 : 서정현
			내용 : 애너테이션을 이용한 매핑
		--%>
	</head>
	<body>
		<h2>애너테이션으로 매핑하기</h2>
		<p>
			<strong>${ message }</strong>
			<br/>
			<a href="<%= request.getContextPath() %>/Ch13/AnnoMapping.do">바로가기</a>
		</p>
	</body>
</html>