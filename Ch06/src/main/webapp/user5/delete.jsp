<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 처리	
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	
	// 데이터베이스 작업
	try{
		// 1, 2단계 - 데이터베이스 접속 
		Connection conn = DBCP.getConnection();
		
		// 3단계 - SQL실행 객체 생성
		String sql = "DELETE FROM `user5` WHERE `uid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		// 4단계 - SQL실행
		psmt.setString(1, uid);
		
		psmt.executeUpdate();
		
		//5단계 - 연결 해제
		conn.close();
		psmt.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// 리다이렉트
	response.sendRedirect("./list.jsp");
%>