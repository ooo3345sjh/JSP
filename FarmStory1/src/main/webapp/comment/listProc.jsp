<%@page import="kr.co.FarmStory1.vo.ArticleVO"%>
<%@page import="kr.co.FarmStory1.dao.BoardDAO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인 여부 체크
	
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String parent = request.getParameter("no");
	
	// 데이터베이스 작업
	BoardDAO dao = new BoardDAO();
	List<ArticleVO> comments = dao.selectComments(parent);
	
	Gson gson = new Gson();
	String json = gson.toJson(comments);
	out.print(json);
%>