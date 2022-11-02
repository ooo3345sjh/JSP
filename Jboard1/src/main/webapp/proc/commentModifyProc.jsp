<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String content = request.getParameter("content");//replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
	Date now = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	String rdate = sdf.format(now);
	int result = ArticleDAO.getInstance().updateComment(content, no, rdate);
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	json.addProperty("rdate", rdate);
	
	out.print(json.toString());

%>