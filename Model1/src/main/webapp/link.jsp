<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<table border="1" class="link">
	<tr>
		<td align="center">
			<% if(session.getAttribute("id") != null){ %>
			<a href="./logoutProc.jsp">로그아웃</a>&emsp;&emsp;&emsp;
			<%
				} else {
			%>
			<a href="./login.jsp">로그인</a>&emsp;&emsp;&emsp;
			<%
				}
			%>
			<a href="#">게시판(페이징X)</a>&emsp;&emsp;&emsp;
			<a href="#">로그인(페이징O)</a>
		</td>
	</tr>
</table>
