<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate(); // 로그인 회원 정보 삭제
	
	response.sendRedirect("/Jboard1/user/login.jsp");
%>