<%@page import="kr.co.FarmStory1.dao.BoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인 여부 체크

	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String commentNo = request.getParameter("commentNo"); // 댓글 번호
	
	// 데이터베이스 작업
	BoardDAO dao = BoardDAO.getInstance();
	int result = dao.deleteComment(commentNo);
	
	// JOSN 데이터 변환 및 전송
	JsonObject jsonData = new JsonObject();
	jsonData.addProperty("result", result);
	String data = jsonData.toString();
	
	out.print(data);
%>