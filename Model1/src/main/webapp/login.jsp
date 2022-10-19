<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		for(Cookie c : cookies){
			if(c.getName().equals("id")){
				session.setAttribute("id", c.getValue());	
			};
		}
	}
	
	String id = (String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인 폼</title>
		<link rel="stylesheet" href="./css/style.css">
		<script>
			function vaildateForm(Form) {
				if(Form.id.value == ""){
					alert("아이디를 입력해주세요.");
					return false;
				}
				if(Form.pw.value == ""){
					alert("패스워드를 입력해주세요.");
					return false;
				}
			}
		</script>
	</head>
	<body>
		<div id="wrapper">
			<%@ include file="./link.jsp" %>
			<h3>로그인 페이지</h3>
			<% 
				if(request.getAttribute("loginErorr") != null && id == null){
					out.println(request.getAttribute("loginErorr"));		
				}
			%>
			<%
				if(id == null){
			%>
			<form action="./loginProc.jsp" onsubmit="return vaildateForm(this)">
				<table border="0">
					<tr>
						<td>아이디</td>
						<td><input type="text" name="id" placeholder="아이디를 입력해주세요."></td>
					</tr>
					<tr>
						<td>패스워드</td>
						<td><input type="password" name="pw" placeholder="패스워드를 입력해주세요."></td>
					</tr>
					<tr>
						<td colspan="2" align="right">
							<label><input type="checkbox" name="auto">자동로그인</label> 
							<input type="submit" value="로그인">
						</td>
					</tr>
				</table>
			</form>
			<%
				} else {
			%>
			<p><%= id %>님, 환영합니다.</p>
			<a href="logoutProc.jsp">로그아웃</a>
			<%
				}
			%>
		</div>
	</body>
</html>