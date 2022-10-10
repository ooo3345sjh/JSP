<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>액션 태그 - param</title>
		<%--
			날짜 : 2022/10/10
			이름 : 서정현
			내용 : 인클루드하는 페이지로 매개변수 전달
		--%>
	</head>
	<body>
		<jsp:include page="P253.jsp">
			<jsp:param name="loc1" value="강원도 영월"/>
			<jsp:param name="loc2" value="김삿갓면"/>
		</jsp:include>
	</body>
</html>