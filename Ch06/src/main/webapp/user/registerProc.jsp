<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.mysql.cj.PreparedQuery"%>
<%@page import="com.mysql.cj.xdevapi.PreparableStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String age = request.getParameter("age");
	
	// 데이터 베이스 처리
	String host = "jdbc:mysql://127.0.0.1:3306/java2db";
	String user = "root";
	String pw = "1234";
	
	try{
		// 1단계
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		// 2단계
		Connection conn = DriverManager.getConnection(host, user, pw); 
		
		// 3단계
		String sql = "INSERT INTO `user3` VALUES(?,?,?,?);";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, uid);
		psmt.setString(2, name);
		psmt.setString(3, hp);
		psmt.setString(4, age);
		
		// 4단계
		psmt.executeUpdate();
		
		// 5단계
		// 6단계
		psmt.close();
		conn.close();
			
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// 리다이렉트
	response.sendRedirect("./list.jsp");


%>