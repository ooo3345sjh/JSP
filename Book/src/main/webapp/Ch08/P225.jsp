<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<table border="1" width="90%">
	<tr>
		<td align="center">
			<!-- 로그인 여부에 따른 메뉴 변화 -->
			<% if(session.getAttribute("id") == null) {%>
				<a href="loginForm.jsp">로그인</a>
			<%} else { %>
				<a href="logout.jsp">로그아웃</a>
			<%} %>
			<!-- 8장과 9장의 회원제 게시판 프로젝트에서 사용할 링크 -->
			&nbsp;&nbsp;&nbsp; <!-- 메뉴 사이의 공백(space) 확보용 특수 문자 -->
			<a href="P273.jsp">게시판(페이징X)</a>
			&nbsp;&nbsp;&nbsp; 
			<a href="#">게시판(페이징o)</a>
		</td>
	</tr>
</table>