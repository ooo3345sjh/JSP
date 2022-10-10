<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	// 포워드하는 페이지에 한글을 전달할 때에는 UTF-8로 인코딩할 필요가 있다.
	request.setCharacterEncoding("UTF-8"); // web.xml에서 설정했기 때문에 생략가능
	String pValue = "방랑시인";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>액션 태그 - param</title>
		<%--
			날짜 : 2022/10/10
			이름 : 서정현
			내용 : 메인 페이지(포워드하는 페이지)
		--%>
	</head>
	<body>
		<jsp:useBean id="person" class="common.Person" scope="request"/>
		<jsp:setProperty name="person" property="name" value="감삿갓"/>
		<jsp:setProperty name="person" property="age" value="56"/>
		<jsp:forward page="P250.jsp?param1=김병연">
			<jsp:param name="param2" value="경기도 양주"/>
			<jsp:param name="param3" value="<%= pValue %>"/>
		</jsp:forward>
	</body>
</html>