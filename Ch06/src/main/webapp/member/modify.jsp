<%@page import="bean.MemberBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String uid =  request.getParameter("uid");
	
	//데이터 베이스 작업
	String host = "jdbc:mysql://127.0.0.1:3306/java2db";
	String user = "root";
	String pw = "1234";
	MemberBean mb = null;
	
	try{
		// 1단계
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		// 2단계
		Connection conn = DriverManager.getConnection(host, user, pw);
		
		// 3단계
		String sql = "SELECT * FROM `member` WHERE `uid` = ?;";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, uid);
		
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			mb = new MemberBean();
			mb.setUid(rs.getString(1));
			mb.setName(rs.getString(2));
			mb.setHp(rs.getString(3));
			mb.setPos(rs.getString(4));
			mb.setDep(rs.getInt(5));
			mb.setRdate(rs.getDate(6));
		}
		
		conn.close();
		psmt.close();
		rs.close();
	}catch(Exception e){
		e.printStackTrace();
	}

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user::register</title>
	</head>
	<body>
		<h3>member 등록</h3>
		<a href="../1_JDBCTest.jsp">처음으로</a>
		<a href="./list.jsp">member 목록</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="uid" value="<%= mb.getUid()%>"> </td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%= mb.getName()%>"> </td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="hp" value="<%= mb.getHp()%>"> </td>
				</tr>
				<tr>
					<td>직급</td>
					<td>
						<select name="pos">
							<option>사원</option>
							<option>대리</option>
							<option>과장</option>
							<option>차장</option>
							<option>부장</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>부서</td>
					<td>
						<select name="dep">
							<option value="101">영업1부</option>
							<option value="102">영업2부</option>
							<option value="103">영업3부</option>
							<option value="104">인사부</option>
							<option value="105">영업지원부</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="수정하기">
					</td>
				</tr>
			</table>
		</form>
		
	</body>
</html>