<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DB.DBCP"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	
	// 데이터 베이스 처리
	int result = 0;
	
	try{
		Connection con = DBCP.getConnection();
		
		String sql = "SELECT COUNT(`uid`) FROM `board_user` WHERE `uid`=?";
		PreparedStatement psmt = con.prepareStatement(sql);
		psmt.setString(1, uid);
		
		ResultSet rs = psmt.executeQuery() ;
		
		
		if(rs.next()){ 
			result = rs.getInt(1);
		}
		
		rs.close();
		con.close();
		psmt.close();
		
	}catch(Exception e){
		e.printStackTrace();		
	}	
	
	// JSON 출력
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	
	String jsonData = json.toString();
	out.print(jsonData);


%>