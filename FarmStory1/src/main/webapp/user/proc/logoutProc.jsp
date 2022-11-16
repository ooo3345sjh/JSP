<%@page import="kr.co.FarmStory1.utils.JSFunction"%>
<%@page import="kr.co.FarmStory1.dao.UserDAO"%>
<%@page import="kr.co.FarmStory1.vo.UserVO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate();
	response.sendRedirect("/FarmStory1/");
%>