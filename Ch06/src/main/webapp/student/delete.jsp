<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DB"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String stdNo = request.getParameter("stdNo");
	try{
		Connection conn = DB.getInstance().getConnection();
		String sql = "DELETE FROM `student` WHERE `stdNo`=?;";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, stdNo);
		psmt.executeUpdate();
		
		conn.close();
		psmt.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>
