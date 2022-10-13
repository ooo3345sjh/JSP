<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.mysql.cj.xdevapi.PreparableStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	
	// 데이터 베이스 작업
	String host = "jdbc:mysql://127.0.0.1:3306/java2db";
	String user = "root";
	String pw = "1234";
	try{
		Connection conn = DriverManager.getConnection(host, user, pw);
		String sql = "DELETE FROM `member` WHERE `uid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, uid);
		psmt.executeUpdate();
		
		conn.close();
		psmt.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");


%>