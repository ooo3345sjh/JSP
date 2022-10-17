<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	String LoginErrMsg = (String)request.getAttribute("LoginErrMsg"); 
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인 폼</title>
		<%--
			날짜 : 2022/10/16
			이름 : 서정현
			내용 : 로그인 폼
		--%>
		<style>
		 	*{padding: 0; margin:0;}
		 	#wrapper{ width: 900px; height: auto; margin: auto; }
		 	.error {color: red; font-size: 16px; font-weight: bold}
		 </style>
		 <script>
		 	function validateForm(form) {
		 		if(form.id.value == ""){
		 			alert("아이디를 입력해주세요.");
		 			return false;
		 		}
		 		if(form.pass.value == ""){
		 			alert("패스워드를 입력해주세요.");
		 			return false;
		 		}
		 		return true;
			}
		 </script>
	</head>
	<body>
		<div id="wrapper">
			<%@ include file="P225.jsp" %>
			<h3>로그인페이지</h3>
			<% if(session.getAttribute("id") == null){ %>
			<% 
				if(LoginErrMsg != null){
			%>
					<p class="error"><%= LoginErrMsg %></p>
			<%
				}
			%>
			<form action="loginProc.jsp" onsubmit="return validateForm(this)">
				<table>
					<tr>
						<td>아이디 : </td>
						<td><input type="text" name="id"></td>
					</tr>
					<tr>
						<td>패스워드 : </td>
						<td><input type="password" name="pass"></td>
					</tr>
					<tr>
						<td><input type="submit" value="로그인하기"></td>
					</tr>
				</table>
			</form>
			<%} else {%>
			<p><%= session.getAttribute("id") %> 회원님, 로그인하셨습니다.</p>
			<%} %>
		</div>
	</body>
</html>