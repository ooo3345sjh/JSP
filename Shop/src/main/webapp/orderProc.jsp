<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="DB.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//produc.jsp로 부터 전송받은 데이터 수신 
	request.setCharacterEncoding("utf-8");
	String custId = request.getParameter("custId");
	String orderProduct = request.getParameter("prodNo");
	String orderCount = request.getParameter("orderCount");

	// 전송 결과 성공/실패 유무를 알기위한 변수 생성
	int result = 1;

	// 데이터베이스 작업	
	try{
		// 1, 2단계 - DB 접속
		Connection con = DBCP.getConnection();
		con.setAutoCommit(false); // 트랜잭션 시작
		
		String sql = "INSERT INTO `order` (`orderId`, `orderProduct`, `orderCount`, `orderDate`) "
		       	   + " VALUES(?,?,?,NOW())";
		
		// 주문한 수량을 재고량에 빼주는 쿼리
		String update_sql = "UPDATE `product` SET " 
						  + "`stock`=`stock`- (SELECT `orderCount` FROM `order` ORDER BY orderDate DESC LIMIT 1)"
						  + "WHERE `prodNo`= ?";       	   
		
		// 3단계 - SQL실행 객체 생성
		PreparedStatement psmt1 = con.prepareStatement(sql);
		psmt1.setString(1, custId);
		psmt1.setString(2, orderProduct);
		psmt1.setString(3, orderCount);
		
		PreparedStatement psmt2 = con.prepareStatement(update_sql);
		psmt2.setString(1, orderProduct);
		
		// 4단계 - SQL실행
		psmt1.executeUpdate();
		result = psmt2.executeUpdate();
		
		con.commit(); // 트랜잭션 종료
		
		// 6단계 - 연결 해제
		con.close();
		psmt1.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	
	// JSON데이터로 변환하여 product.jsp로 반환한다.
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	String jsonData = json.toString();

	out.print(jsonData);
%>