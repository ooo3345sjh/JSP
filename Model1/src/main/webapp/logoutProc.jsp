<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	session.invalidate(); // 모든 세션 삭제
	
	// 자동로그인 쿠키삭제
	Cookie cookie = new Cookie("id", "");
	cookie.setMaxAge(0);
	response.addCookie(cookie);
	
	response.sendRedirect("login.jsp");
%>