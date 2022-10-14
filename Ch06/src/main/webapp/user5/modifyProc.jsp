<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	String age = request.getParameter("age");
	String addr = request.getParameter("addr");
	String hp = request.getParameter("hp");

	// 데이터베이스 작업
	try{
		// 1단계 - JNDI 서비스 객체생성
		Context initCtx = new InitialContext();
		Context ctx = (Context)initCtx.lookup("java:comp/env"); // JNDI 기본 환경 이름
		
		// 2단계 - 커넥션 풀에서 커넥션 가져오기
		DataSource ds = (DataSource)ctx.lookup("dbcp_java2db"); // 커넥션 풀 얻기
		Connection conn = ds.getConnection(); // 커넥션 풀에서 커넥션 얻기
		
		// 3단계 - SQL실행 객체 생성
		String sql = "UPDATE `user5` SET `name`=?,`birth`=?,`gender`=?,`age`=?, `address`=?, `hp`=?";
			   sql += "WHERE `uid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		// 4단계 - SQL실행
		psmt.setString(1, name);
		psmt.setString(2, birth);
		psmt.setString(3, gender);
		psmt.setString(4, age);
		psmt.setString(5, addr);
		psmt.setString(6, hp);
		psmt.setString(7, uid);
		
		psmt.executeUpdate();
		
		// 5단계 - 연결해제 
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// 리다이렉트
	response.sendRedirect("./list.jsp");

%>