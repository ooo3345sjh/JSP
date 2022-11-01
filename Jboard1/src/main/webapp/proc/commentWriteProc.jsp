<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	request.setCharacterEncoding("utf-8");
 	String no = request.getParameter("no");
 	String pg = request.getParameter("pg");
 	String content = request.getParameter("content").replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
 	String uid = request.getParameter("uid");
	String regip = request.getRemoteAddr(); 	
 	
	ArticleBean comment = new ArticleBean();
	comment.setParent(no);
	comment.setContent(content);
	comment.setUid(uid);
	comment.setRegip(regip);
	
	ArticleBean article = ArticleDAO.getInstance().insertComment(comment);
	
	JsonObject json = new JsonObject();
	json.addProperty("result", 1);
	json.addProperty("nick", article.getNick());
	json.addProperty("date", article.getRdate());
	json.addProperty("content", article.getContent());
	json.addProperty("no", article.getNo());
	
	String jsonData = json.toString();
	out.print(jsonData);

	// response.sendRedirect("/Jboard1/view.jsp?no="+ no + "&pg=" + pg);


%>