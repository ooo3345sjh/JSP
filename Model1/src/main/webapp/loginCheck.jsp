<%@page import="util.JSFunction"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%

	if(session.getAttribute("id") == null){
		JSFunction.alertLocationn("로그인 후 이용해주세요.", "./login.jsp", out);
		return;
	};

%>