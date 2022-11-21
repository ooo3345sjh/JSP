<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.FarmStory1.vo.ArticleVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.FarmStory1.dao.BoardDAO"%>
<%@ page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cate = request.getParameter("cate");

	List<ArticleVO> latests = new BoardDAO().selectLatests(cate);
	
	Gson gson = new Gson();
	String jsonData = gson.toJson(latests);
	
	out.print(jsonData);

%>