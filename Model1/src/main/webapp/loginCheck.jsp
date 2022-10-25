<%@page import="util.JSFunction"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		for(Cookie c : cookies){
			if(c.getName().equals("id")){
				session.setAttribute("id", c.getValue());	
			};
		}
	}

	if(session.getAttribute("id") == null){
		JSFunction.alertLocationn("로그인 후 이용해주세요.", "./login.jsp", out);
		return;
	};

%>