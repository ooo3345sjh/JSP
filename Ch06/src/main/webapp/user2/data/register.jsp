<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="bean.UserBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String age = request.getParameter("age");
	int result = 0;
	
	
	try{
		Connection con = DBCP.getConnection();
		String sql = "INSERT INTO `user2` VALUES(?,?,?,?)";
		PreparedStatement psmt = con.prepareStatement(sql);
		psmt.setString(1, uid);
		psmt.setString(2, name);
		psmt.setString(3, hp);
		psmt.setString(4, age);
		
		result = psmt.executeUpdate();
		
		con.close();
		psmt.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	//String jsonData = "{\"result\":" + result + "}";
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	
	String jsonData = json.toString();

	out.print(jsonData);

%>