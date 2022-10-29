<%@page import="kr.co.jboard1.dao.CommentDAO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.jboard1.bean.CommentBean"%>
<%@page import="java.util.List"%>
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
	String parent = request.getParameter("no");
	
	// 데이터베이스 작업
	CommentDAO dao = CommentDAO.getInstance();
	List<CommentBean> comments = dao.selectComments(parent);
	
	Gson gson = new Gson();
	String json = gson.toJson(comments);
	out.print(json);
%>