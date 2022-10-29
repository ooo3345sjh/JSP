<%@page import="kr.co.jboard1.dao.CommentDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.bean.UserBean"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인 여부 체크
	UserBean ub = (UserBean)session.getAttribute("sessUser"); // 로그인 회원 정보 가져오기
	if(ub == null){ 
		response.sendRedirect("/Jboard1/user/login.jsp?success=101");
		return;
	}

	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no"); // 게시글 번호
	String commentNo = request.getParameter("commentNo"); // 댓글 번호
	
	// 데이터베이스 작업
	CommentDAO dao = CommentDAO.getInstance();
	int result = dao.deleteComment(no, commentNo);
	
	// JOSN 데이터 변환 및 전송
	JsonObject jsonData = new JsonObject();
	jsonData.addProperty("result", result);
	String data = jsonData.toString();
	
	out.print(data);
%>