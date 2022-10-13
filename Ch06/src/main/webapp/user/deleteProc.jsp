<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	
	// 데이터 베이스 작업
	String host = "jdbc:mysql://127.0.0.1:3306/java2db";
	String user = "root";
	String pw = "1234";
	
	
	try{
		
		// 1단계
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		// 2단계
		Connection conn = DriverManager.getConnection(host, user, pw);
		
		// 3단계
		String sql = "DELETE FROM `user3` WHERE `uid` = ?";
			   
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		psmt.setString(1, uid);
		
		// 4단계
		psmt.executeUpdate();
		
		// 5단계
		// 6단계
		conn.close();
		psmt.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
		   
	// 리다이렉트
	response.sendRedirect("./list.jsp");


%>