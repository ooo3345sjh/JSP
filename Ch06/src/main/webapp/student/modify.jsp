<%@page import="config.MyDB"%>
<%@page import="bean.StudentBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DB"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 처리
	request.setCharacterEncoding("utf-8");
	String stdNo = request.getParameter("stdNo");
	StudentBean sb = null;
	
	// 데이버 베이스 작업
	try{
		
		// 1, 2단계 JDBC 드라이버 로드 및 데이터베이스 접속
	 	Connection conn = MyDB.getInstance().getConnection(2);
		
		// 3단계 SQL실행 객체 생성
		String sql = "SELECT * FROM `student` WHERE `stdNo`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		// 4단계 SQL실행
		psmt.setString(1, stdNo);
		
		ResultSet rs = psmt.executeQuery();
		
		// 5단계 SQL결과 처리
		if(rs.next()){
			sb = new StudentBean();
			sb.setStdNo(rs.getString(1));
			sb.setStdname(rs.getString(2));
			sb.setStdHp(rs.getString(3));
			sb.setStdYear(rs.getInt(4));
			sb.setStdAddress(rs.getString(5));
		}
		
		// 6단계 SQL실행 객체 종료
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
		<script src="../js/jquery-3.6.1.min.js"></script>
		<script>
		
			$(function() {
				$(".stdYear > option").each(function() {
					if($(this).val() == "<%= sb.getStdYear()%>"){
						$(this).attr("selected","selected");					
					}
				});
			})
		</script>
	</head>
	<body>
	<h3>member 등록</h3>
		<a href="../1_JDBCTest.jsp">처음으로</a>
		<a href="./list.jsp">member 목록</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>학번</td>
					<td><input type="text" name="stdNo" readonly value="<%= sb.getStdNo()%>"> </td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="stdName" value="<%= sb.getStdname()%>"> </td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="stdHp" value="<%= sb.getStdHp()%>"> </td>
				</tr>
				<tr>
					<td>학년</td>
					<td>
						<select name="stdYear" class="stdYear">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="stdAddress" value="<%= sb.getStdAddress()%>"> </td>
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