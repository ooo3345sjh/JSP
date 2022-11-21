<%@page import="kr.co.FarmStory1.utils.JSFunction"%>
<%@page import="kr.co.FarmStory1.dao.UserDAO"%>
<%@page import="kr.co.FarmStory1.vo.UserVO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	String pass = request.getParameter("pass");
	
	UserVO user = new UserDAO().selectUser(uid, pass);

	if(user != null){
		session.setAttribute("user", user);
	} else {
		JSFunction.alertLocation("등록되지 않은 아이디입니다.", "/FarmStory1/user/login.jsp", out);
		return;
	}
	
	response.sendRedirect("/FarmStory1/index.jsp");
%>