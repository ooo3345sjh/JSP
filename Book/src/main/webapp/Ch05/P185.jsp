<%@page import="common.DBConnPool"%>
<%@page import="common.JDBConnect"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JDBC</title>
		<!-- 
			날짜 : 2022/10/09
			이름 : 서정현
			내용 : JDBC 연결 테스트
		-->
	</head>
	<body>
		<h2>JDBC 테스트 1</h2>
		<%
			JDBConnect jdbc1 = new JDBConnect();
			jdbc1.close();
		%>
		
		<!-- P187 두 번째 생성자 테스트 코드 추가 -->
		<h2>JDBC 테스트 2</h2>
		<%
			String driver = application.getInitParameter("MysqlDriver");
			String url = application.getInitParameter("MysqlURL");
			String id = application.getInitParameter("MysqlId");
			String pwd = application.getInitParameter("MysqlPwd");
			JDBConnect jdbc2 = new JDBConnect(driver, url, id, pwd);
			jdbc2.close();
		%>
		
		<!-- P189 세 번째 생성자 테스트 코드 추가 -->
		<h2>JDBC 테스트 3</h2>
		<%
			JDBConnect jdbc3 = new JDBConnect(application);
			jdbc3.close();
		%>
		
		<!-- P199 커넥션 풀 테스트 코드 추가 -->
		<h2>커넥션 풀 테스트</h2>
		<%
			DBConnPool pool = new DBConnPool();
			pool.close();
		%>
		
	</body>
</html>