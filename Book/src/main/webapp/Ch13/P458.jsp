<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>DirectServletPrint.jsp</title>
		<%--
			날짜 : 2022/10/28
			이름 : 서정현
			내용 : 서블릿에서 직접 응답 출력하기
		--%>
	</head>
	<body>
		<h2>web.xml에서 매핑 후 Servlet에서 직접 출력하기</h2>
		<form action="../Ch13/DirectServletPrint.do" method="post">
			<input type="submit" value="바로가기">
		</form>		
	</body>
</html>