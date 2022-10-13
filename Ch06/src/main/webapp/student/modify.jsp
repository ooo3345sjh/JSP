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
	StudentBean sb = null;
	
	try{
	 	Connection conn = DB.getInstance().getConnection();
		String sql = "SELECT * FROM `student` WHERE `stdNo`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		psmt.setString(1, stdNo);
		
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			sb = new StudentBean();
			sb.setStdNo(rs.getString(1));
			sb.setStdname(rs.getString(2));
			sb.setStdHp(rs.getString(3));
			sb.setStdYear(rs.getInt(4));
			sb.setStdAddress(rs.getString(5));
		}
		
		conn.close();
		rs.close();
		psmt.close();
			
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>student::modify</title>
	</head>
	<body>
	<h3>member 등록</h3>
		<a href="../1_JDBCTest.jsp">처음으로</a>
		<a href="./list.jsp">member 목록</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>학번</td>
					<td><input type="text" name="stdNo" value="<%= sb.getStdNo()%>"> </td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%= sb.getStdname()%>"> </td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="hp" value="<%= sb.getStdHp()%>"> </td>
				</tr>
				<tr>
					<td>학번</td>
					<td><input type="text" name="year" value="<%= sb.getStdYear()%>"> </td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" value="<%= sb.getStdAddress()%>"> </td>
				</tr>
				
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="등록하기">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>