<%@page import="bean.StudentBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DB"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String stdNo = request.getParameter("stdNo");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String year = request.getParameter("year");
	String addr = request.getParameter("addr");
	
	try{
	 	Connection conn = DB.getInstance().getConnection();
		String sql = "UPDATE `student` SET `stdname`=?, `stdHp`=?, `stdYear`=?, `stdAddress`=? WHERE `stdNo`=?;";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		psmt.setString(1, name);
		psmt.setString(2, hp);
		psmt.setString(3, year);
		psmt.setString(4, addr);
		psmt.setString(5, stdNo);
		
		psmt.executeUpdate();
		
		conn.close();
		psmt.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>