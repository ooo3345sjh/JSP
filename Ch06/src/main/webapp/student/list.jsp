<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="bean.StudentBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DB"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<StudentBean> students = null;

	// 데이터베이스 작업
	try{
		Connection conn = DB.getInstance().getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `student`");
		students = new ArrayList<>();
		
		while(rs.next()){
			StudentBean sb = new StudentBean();
			sb.setStdNo(rs.getString(1));
			sb.setStdname(rs.getString(2));
			sb.setStdHp(rs.getString(3));
			sb.setStdYear(rs.getInt(4));
			sb.setStdAddress(rs.getString(5));
				
			students.add(sb);
		}
		
		conn.close();
		stmt.close();
		rs.close();
	}catch(Exception e){
		e.printStackTrace();		
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>student::list</title>
	</head>
	<body>
	<h3>student 목록</h3>
		<a href="./register.jsp">student 등록</a>
		
		<table border="1">
			<tr>
				<td>학번</td>
				<td>이름</td>
				<td>휴대폰</td>
				<td>학년</td>
				<td>주소</td>
			</tr>
			<%
				for(StudentBean sb : students){
			%>
			<tr>
				<td><%= sb.getStdNo() %></td>
				<td><%= sb.getStdname() %></td>
				<td><%= sb.getStdHp() %></td>
				<td><%= sb.getStdYear() %></td>
				<td><%= sb.getStdAddress() %></td>
				<td>
					<a href="./modify.jsp?stdNo=<%= sb.getStdNo()%>">수정</a>
					<a href="./delete.jsp?stdNo=<%= sb.getStdNo()%>">삭제</a>
				</td>
			</tr>
			<%} %>
		</table>
		
	</body>
</html>