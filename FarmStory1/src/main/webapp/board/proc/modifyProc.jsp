<%@page import="kr.co.FarmStory1.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String pg = request.getParameter("pg");
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String title = request.getParameter("title");
	String content = request.getParameter("editorTxt");
	String no = request.getParameter("no");
	
	BoardDAO.getInstance().updateArticle(no, title, content);
	
	response.sendRedirect("/FarmStory1/board/view.jsp?group=" + group + "&cate=" + cate
			+ "&pg=" + pg + "&no=" + no);
%>