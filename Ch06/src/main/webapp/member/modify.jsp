<%@page import="config.DB"%>
<%@page import="config.MyDB"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="bean.MemberBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 처리
	request.setCharacterEncoding("utf-8");
	String uid =  request.getParameter("uid");
	
	//데이터 베이스 작업
	MemberBean mb = null;
	
	try{
		// 1, 2단계 JDBC 드라이버 로드 및 데이터베이스 접속
		Connection conn = MyDB.getInstance().getConnection(1);
		
		// 3단계 SQL실행 객체 생성
		String sql = "SELECT * FROM `member` WHERE `uid` = ?;";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		// 4단계 SQL실행
		psmt.setString(1, uid);
		
		ResultSet rs = psmt.executeQuery();
		
		// 5단계 SELECT 결과처리
		if(rs.next()){
			mb = new MemberBean();
			mb.setUid(rs.getString(1));
			mb.setName(rs.getString(2));
			mb.setHp(rs.getString(3));
			mb.setPos(rs.getString(4));
			mb.setDep(rs.getInt(5));
			mb.setRdate(rs.getString(6));
		}
		
		// 6단계 SQL실행 객체 종료
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
		<title>user::modify</title>
		<script src="../js/jquery-3.6.1.min.js"></script>
		<script>
			// Member의 직급를 수정하기전의 값으로 선택처리하기위한 함수 
			$(function() {
				$(".pos > option").each(function () {
					if($(this).val() == "<%= mb.getPos()%>"){
						$(this).attr({'selected' : 'selected'});
					}
				});
				
			// Member의 부서를 수정하기전의 값으로 선택처리하기위한 함수 
				$(".dep > option").each(function () {
					if($(this).val() == "<%= mb.getDep()%>"){
						$(this).attr({'selected' : 'selected'});
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
					<td>아이디</td>
					<td><input type="text" readonly name="uid" value="<%= mb.getUid()%>"> </td>
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
						<select name="pos" class="pos">
							<option value="사원">사원</option>
							<option value="대리">대리</option>
							<option value="과장">과장</option>
							<option value="차장">차장</option>
							<option value="부장">부장</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>부서</td>
					<td>
						<select name="dep" class="dep">
							<option value="101">영업1부</option>
							<option value="102">영업2부</option>
							<option value="103">영업3부</option>
							<option value="104">인사부</option>
							<option value="105">영업지원부</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>입사일</td>
					<td><!-- yyyy-MM-dd HH:mm:ss 입력 형식 -->
						<input type="datetime-local" name="rdate" step="1" value="<%= mb.getRdate() %>"/>
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