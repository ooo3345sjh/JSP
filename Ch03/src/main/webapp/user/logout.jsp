<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 세션종료
	session.invalidate();
	
	// 로그인 페이지 이동
	response.sendRedirect("../6_session.jsp");

%>