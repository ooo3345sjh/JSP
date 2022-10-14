<%@page import="bean.User5Bean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 처리
	request.setCharacterEncoding("utf-8");
	String uid = request.getParameter("uid");
	User5Bean ub = null;
	
	// 데이터베이스 작업
	try{
		// 1, 2단계 - 데이터베이스 접속 
		Connection conn =  DBCP.getConnection(); 
		
		// 3단계 - SQL실행 객체 생성
		String sql = "SELECT * FROM `user5` WHERE `uid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		// 4단계 - SQL실행
		psmt.setString(1, uid);
		
		ResultSet rs = psmt.executeQuery();
		
		// 5단계 - SQL결과 처리
		if(rs.next()){
			ub = new User5Bean();
			ub.setUid(rs.getString(1));
			ub.setName(rs.getString(2));
			ub.setBirth(rs.getString(3));
			ub.setGender(rs.getInt(4));
			ub.setAge(rs.getInt(5));
			ub.setAddress(rs.getString(6));
			ub.setHp(rs.getString(7));
		}
		
		// 6단계 - 연결해제
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
		<title>user5::modify</title>
		<script src="../js/jquery-3.6.1.min.js"></script>
		<script>
			$(function() {
				$(".gender input").each(function() {
					if($(this).val() == <%=ub.getGender()%>){
						$(this).attr({'checked' : 'checked'});
					}
				})
			})
		</script>
	</head>
	<body>
	<h3>user5 등록</h3>
		<a href="../2_DBCPTest.jsp">처음으로</a>
		<a href="./list.jsp">user5 목록</a>
	
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="uid" readonly value="<%= ub.getUid()%>"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%= ub.getName()%>"></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><input type="date" name="birth" value="<%= ub.getBirth()%>"></td>
				</tr>
				<tr>
					<td>성별</td>
					<td class="gender">
						<label><input type="radio" name="gender" value="1">남</label> 
						<label><input type="radio" name="gender" value="2">여</label> 
					</td>
				</tr>
				<tr>
					<td>나이</td>
					<td><input type="text" name="age" value="<%= ub.getAge()%>"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" value="<%= ub.getAddress()%>"></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="hp" value="<%= ub.getHp()%>"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="등록"/></td>
				</tr>
			</table>
		</form>	
		
	</body>
</html>