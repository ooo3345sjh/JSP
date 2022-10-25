<%@page import="bean.OrderBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DB.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="bean.CustomerBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// order 정보를 가져오는 코드
	List<OrderBean> orders = null;
	
	//데이터베이스 작업
	try{
		// 1, 2단계 - DB 접속
		Connection con = DBCP.getConnection();
		
		// 3단계 - SQL실행 객체 생성
		Statement stmt = con.createStatement();
		String sql = "SELECT o.orderNo, c.name, p.prodName, o.orderCount, o.orderDate "
				   + " FROM `order` as o"
				   + " join `customer` as c on o.orderid = c.custid"
				   + " join `product` as p on o.orderProduct = p.prodNo";
		
		// 4단계 - SQL실행
		ResultSet rs = stmt.executeQuery(sql);
		
		// 주문정보들을 저장하기위한 List 객체 생성
		orders = new ArrayList<>();
		
		// 5단계 - SQL결과 처리
		while(rs.next()){
			OrderBean ob = new OrderBean();
			ob.setOrderNo(rs.getInt(1));
			ob.setOrderName(rs.getString(2));
			ob.setOrderProduct(rs.getString(3));
			ob.setOrderCount(rs.getInt(4));
			ob.setOrderDate(rs.getString(5));
			
			orders.add(ob);
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
		<title>Shop::order</title>
	</head>
	<body>
		<h3>주문 목록</h3>
		<nav>
			<a href="./customer.jsp">고객목록</a>
			<a href="./order.jsp">주문목록</a>
			<a href="./product.jsp">상품목록</a>
		</nav>
		<table border="1">
			<tr>
				<th>주문번호</th>
				<th>주문자</th>
				<th>주문상품</th>
				<th>주문수량</th>
				<th>주문일</th>
			</tr>
			<%
				for(OrderBean ob : orders){
			%>
			<tr>
				<td><%= ob.getOrderNo() %></td>
				<td><%= ob.getOrderName() %></td>
				<td><%= ob.getOrderProduct() %></td>
				<td><%= ob.getOrderCount() %></td>
				<td><%= ob.getOrderDate() %></td>
			</tr>
			<%
				}
			%>			
		</table>
		
	</body>
</html>