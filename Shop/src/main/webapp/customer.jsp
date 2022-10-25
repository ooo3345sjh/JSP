<%@page import="java.util.ArrayList"%>
<%@page import="bean.CustomerBean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="DB.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 고객 정보를 가져오는 코드
	
	List<CustomerBean> customers = null;
	
	//데이터베이스 작업
	try{
		// 1, 2단계 - DB 접속
		Connection con = DBCP.getConnection();
		
		// 3단계 - SQL실행 객체 생성
		Statement stmt = con.createStatement();
		
		// 4단계 - SQL실행
		ResultSet rs = stmt.executeQuery("SELECT * FROM `customer`");
		
		// 고객들을 저장하기위한 List 객체 생성
		customers = new ArrayList<>();
		
		// 5단계 - SQL결과 처리
		while(rs.next()){
			CustomerBean cb = new CustomerBean();
			cb.setCustId(rs.getString(1));
			cb.setName(rs.getString(2));
			cb.setHp(rs.getString(3));
			cb.setAddr(rs.getString(4));
			cb.setRdate(rs.getString(5));
			
			customers.add(cb);	
		}
		
		// 6단계 - 연결 해제
		con.close();
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
		<title>Shop::customer</title>
	</head>
	<body>
		<h3>고객 목록</h3>
		<nav>
			<a href="./customer.jsp">고객목록</a>
			<a href="./order.jsp">주문목록</a>
			<a href="./product.jsp">상품목록</a>
		</nav>
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>주소</th>
				<th>가입일</th>
			</tr>
			<%
				for(CustomerBean cb : customers){
			%>
			<tr>
				<td><%= cb.getCustId() %></td>
				<td><%= cb.getName() %></td>
				<td><%= cb.getHp() %></td>
				<td><%= cb.getAddr() %></td>
				<td><%= cb.getRdate() %></td>
			</tr>
			<%
				}
			%>			
		</table>
		
	</body>
</html>