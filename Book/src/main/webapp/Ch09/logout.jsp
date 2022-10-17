<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	// 세션 삭제
	session.invalidate();
	
	// 리다이렉트 - 게시판 목록으로
	response.sendRedirect("P273.jsp");

%>