<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Session</title>
		<!-- 
			날짜 : 2022/10/09
			이름 : 서정현
			내용 : 로그인 폼
		-->
		<style>
			#wrapper {width: 500px; height: auto;}
		</style>
	</head>
	<body>
	<div id="wrapper">
		<% pageContext.include("P225.jsp"); %>
		<h2>로그인 페이지</h2>
		<span style="color: red; font-size: 1.2em">
			<%= request.getAttribute("LoginErrMsg") == null ?
					"" : request.getAttribute("LoginErrMsg") %>
		</span>
		<%
			if(session.getAttribute("UserId") == null){ // 로그인 상태 확인
				// 로그아웃 상태
		%>
		<script>
			function validateForm(form) {
				if(!form.user_id.value){
					alert("아이디를 입력하세요.");
					return false;
				}
				if(form.user_pw.value == ""){
					alert("패스워드를 입력하세요.");
					return false;
				}
			}
		</script>
		<form action="P222.jsp" method="post" name="loginFrm" onsubmit="return validateForm(this)">
			<label>아이디 : <input type="text" name="user_id"/></label><br/>
			<label>패스워드 : <input type="password" name="user_pw"/></label><br/>
			<input type="submit" value="로그인하기"/>
		</form>
		<%
			} else { //로그인된 상태
		%>
		
		<p><%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다.</p><br/>
		<a href="P224.jsp">[로그아웃]</a>
		
		<%
			}
		%>
	</div>
		
	</body>
</html>