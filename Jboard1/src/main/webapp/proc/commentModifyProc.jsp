<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String content = request.getParameter("content").replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
	
	int result = ArticleDAO.getInstance().updateComment(content, no);
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	
	out.print(json.toString());

%>