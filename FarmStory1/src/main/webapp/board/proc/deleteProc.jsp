<%@page import="kr.co.FarmStory1.dao.BoardDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String no = request.getParameter("no");
	
	BoardDAO.getInstance().deleteArticle(no);
	
	response.sendRedirect("/FarmStory1/board/list.jsp?group=" + group + "&cate=" + cate);
%>