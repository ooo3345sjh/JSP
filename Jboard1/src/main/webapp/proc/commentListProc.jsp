<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String parent = request.getParameter("parent");
	
	List<ArticleBean> comments = ArticleDAO.getInstance().selectComments(parent);

	Gson gson = new Gson();
	String jsonData = gson.toJson(comments);
	
	out.print(jsonData);
%>