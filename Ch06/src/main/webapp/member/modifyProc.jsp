<%@page import="config.MyDB"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 처리
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String pos = request.getParameter("pos");
	String dep = request.getParameter("dep");
	String rdate = request.getParameter("rdate");

	try{
		// 1, 2단계 JDBC 드라이버 로드 및 데이터베이스 접속
		Connection conn = MyDB.getInstance().getConnection(1);
		
		// 3단계 SQL실행 객체 생성
		String sql = "UPDATE `member` SET `name` = ?, `hp`=?, `pos`=?, `dep`=?, `rdate`=?  WHERE `uid` = ?;";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, name);
		psmt.setString(2, hp);
		psmt.setString(3, pos);
		psmt.setString(4, dep);
		psmt.setString(5, rdate);
		psmt.setString(6, uid);
		
		// 4단계 SQL 실행
		psmt.executeUpdate();
		
		// 5단계 실행 객체 종료
		conn.close();
		psmt.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>
