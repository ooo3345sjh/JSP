<%@page import="java.io.PrintWriter"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	String title = request.getParameter("title");
	String content = request.getParameter("editorTxt");
	
	int result = ArticleDAO.getInstance().updateArticle(no, title, content);
	
	response.sendRedirect("/Jboard1/view.jsp?no=" + no + "&pg=" + pg+"&result=202");
%>
				  
