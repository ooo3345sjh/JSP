
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>OuterPage</title>
		<%-- 
			날짜 : 2022/10/10
			이름 : 서정현
			내용 : 포함될 외부 JSP 파일2
		--%>
	</head>
	<body>
		<h2>외부 파일 2</h2>
		<%
			String newVar2 = "백제 온조왕";
		%>
		<ul>
			<li>page 영역 속성 : <%= pageContext.getAttribute("pAttr") %></li>
			<li>request 영역 속성 : <%= request.getAttribute("rAttr") %></li>
		</ul>		
	</body>
</html>