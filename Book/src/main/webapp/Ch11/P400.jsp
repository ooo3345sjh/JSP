<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JSTL = redirect</title>
		<%--
			날짜 : 2022/10/27
			이름 : 서정현
			내용 : <c:redirect> 태그 사용하기
		--%>
	</head>
	<body>
	<c:set var="requestVar" value="MustHave" scope="request"/>
	<c:redirect url="P397.jsp">
		<c:param name="user_param1" value="출판사"></c:param>
		<c:param name="user_param2" value="골든래빗"></c:param>
	</c:redirect>
		
	</body>
</html>