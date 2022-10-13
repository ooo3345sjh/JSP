<%@page import="config.MyDB"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.mysql.cj.xdevapi.PreparableStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 처리
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	
	try{
		
		// 1, 2단계 JDBC 드라이버 로드 및 데이터베이스 접속
		Connection conn = MyDB.getInstance().getConnection(1);
		
		// 3단계 SQL실행 객체 생성
		String sql = "DELETE FROM `member` WHERE `uid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		// 4단계 SQL실행
		psmt.setString(1, uid);
		psmt.executeUpdate();
		
		//5단계 SQL실행 객체 종료
		conn.close();
		psmt.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>