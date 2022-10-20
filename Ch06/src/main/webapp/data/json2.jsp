<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="bean.UserBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DBCP"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<UserBean> users = new ArrayList<>();
	try{
		Connection con = DBCP.getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `user2`");
		
		while(rs.next()){
			UserBean ub = new UserBean();
			ub.setUid(rs.getString(1));
			ub.setName(rs.getString(2));
			ub.setHp(rs.getString(3));
			ub.setAge(rs.getInt(4));
			
			users.add(ub);
		}
		
		con.close();
		rs.close();
		stmt.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// List를 JSON 변환
	Gson gson = new Gson();
	String jsonData = gson.toJson(users);
	
	// JSON 출력
	out.print(jsonData);

%>