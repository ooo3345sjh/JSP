<%@page import="utils.JSFunction"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<%
	if(session.getAttribute("id") == null){
		JSFunction.alertLocation("로그인 후 이용해주십시오", "./loginForm.jsp", out);
		
		return;
	}
%>