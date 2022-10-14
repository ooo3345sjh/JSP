<%@page import="config.DBCP"%>
<%@page import="bean.User5Bean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
//데이터베이스 작업
	List<User5Bean> users = null;
	
	try{
		// 1단계 - JNDI 서비스 객체생성
		
		Connection conn = DBCP.getConnection();
		
		// 3단계 - SQL실행 객체 생성
		Statement stmt = conn.createStatement();
		
		// 4단계 - SQL실행 
		String sql = "SELECT * FROM `user5`";
		ResultSet rs = stmt.executeQuery(sql);
		users = new ArrayList<>();
		
		// 5단계 - SQL결과 처리
		while(rs.next()){
			User5Bean ub = new User5Bean();
			ub.setUid(rs.getString(1));
			ub.setName(rs.getString(2));
			ub.setBirth(rs.getString(3));
			ub.setGender(rs.getInt(4));
			ub.setAge(rs.getInt(5));
			ub.setAddress(rs.getString(6));
			ub.setHp(rs.getString(7));
	
			users.add(ub);
		}
		
		conn.close();
		rs.close();
		stmt.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user5::list</title>
	</head>
	<body>
		<h3>user5 목록</h3>
		<a href="../2_DBCPTest.jsp">처음으로</a>
		<a href="./register.jsp">user5 등록</a>
		
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>생년월일</th>
				<th>성별</th>
				<th>나이</th>
				<th>주소</th>
				<th>휴대폰</th>
				<th>관리</th>
			</tr>
			<%
			for(User5Bean ub : users){
			%>
			<tr>
				<td><%= ub.getUid() %></td>
				<td><%= ub.getName() %></td>
				<td><%= ub.getBirth() %></td>
				<td><%= ub.getGender()==1? "남자": "여자" %></td>
				<td><%= ub.getAge() %></td>
				<td><%= ub.getAddress() %></td>
				<td><%= ub.getHp() %></td>
				<td>
					<a href="./modify.jsp?uid=<%=ub.getUid()%>">수정</a>
					<a href="./delete.jsp?uid=<%=ub.getUid()%>">삭제</a>
				</td>
			</tr>
			<%} %>
		</table>
	</body>
</html>