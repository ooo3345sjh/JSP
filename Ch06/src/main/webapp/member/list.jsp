<%@page import="config.MyDB"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.MemberBean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	// 데이터 베이스 작업
	List<MemberBean> members = null; 
	
	try{
		// 1, 2단계 JDBC 드라이버 로드 및 데이터베이스 접속
		Connection conn = MyDB.getInstance().getConnection(1);
		
		// 3단계
		String sql = "SELECT * FROM `member`;";
		Statement smt = conn.createStatement();
			
		ResultSet rs = smt.executeQuery(sql);
		members = new ArrayList<>();
		
		while(rs.next()){
			MemberBean mb = new MemberBean();
			mb.setUid(rs.getString(1));
			mb.setName(rs.getString(2));
			mb.setHp(rs.getString(3));
			mb.setPos(rs.getString(4));
			mb.setDep(rs.getInt(5));
			mb.setRdate(rs.getString(6));
			members.add(mb);
		}
		
		conn.close();
		smt.close();
		rs.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>member::list</title>
	</head>
	<body>
		<h3>member 목록</h3>
		<a href="../1_JDBCTest.jsp">처음으로</a>
		<a href="./register.jsp">member 등록</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>휴대폰</th>
					<th>직급</th>
					<th>부서</th>
					<th>입사일</th>
					<th>관리</th>
				</tr>
				
				<% for(MemberBean mb : members){ %>
				<tr>
					<td><%= mb.getUid()%></td>
					<td><%= mb.getName()%></td>
					<td><%= mb.getHp()%></td>
					<td><%= mb.getPos()%></td>
					<td>
						<%
							int dep = mb.getDep();
							switch(dep){
								case 101: out.println("영업1부"); break;
								case 102: out.println("영업2부"); break;
								case 103: out.println("영업3부"); break;
								case 104: out.println("인사부"); break;
								case 105: out.println("영업지원부"); break;
							}
						%>
					</td>
					<td>
						<%
							String rdate = mb.getRdate(); 
							out.println(rdate.substring(2));
						%>
					</td>
					<td>
						<a href="./modify.jsp?uid=<%=mb.getUid()%>">수정</a>
						<a href="./delete.jsp?uid=<%=mb.getUid()%>">삭제</a>
					</td>
				</tr>
				<%} %>
			</table>
		</form>
	</body>
</html>