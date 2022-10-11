<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("UTF-8");

	//String name = request.getParameter("name");
	//String age = request.getParameter("age");
	//String hp = request.getParameter("hp");
	//String addr = request.getParameter("addr");
%>
<!-- Bean을 활용해서 데이터 수신 -->
<jsp:useBean id="pb" class="bean.PersonBean">
	<jsp:setProperty name="pb" property="name"/>
	<jsp:setProperty name="pb" property="age"/>
	<jsp:setProperty name="pb" property="hp"/>
	<jsp:setProperty name="pb" property="addr"/>
</jsp:useBean>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>addPerson</title>
	</head>
	<body>
		<h3>전송 데이터 출력</h3>
		<p>
			이름 : <%= pb.getName() %><br/>
			나이 : <%= pb.getAge() %><br/>
			휴대폰 : <%= pb.getHp() %><br/>
			주소 : <%= pb.getAddr() %><br/>
		</p>
		<a href="../3_useBean 액션태그.jsp">뒤로가기</a>
	</body>
</html>