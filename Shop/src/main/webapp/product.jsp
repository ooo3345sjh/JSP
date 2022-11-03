<%@page import="bean.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.CustomerBean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="DB.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// product 정보를 가져오는 코드
	List<ProductBean> products = null;
	
	//데이터베이스 작업
	try{
		// 1, 2단계 - DB 접속	
		Connection con = DBCP.getConnection();
		
		// 3단계 - SQL실행 객체 생성
		Statement stmt = con.createStatement();
		
		// 4단계 - SQL실행
		ResultSet rs = stmt.executeQuery("SELECT * FROM `product`");
		
		// 상품정보들을 저장하기위한 List 객체 생성
		products = new ArrayList<>();
		
		// 5단계 - SQL결과 처리
		while(rs.next()){
			ProductBean pb = new ProductBean();
			pb.setProdNo(rs.getInt(1));
			pb.setProdName(rs.getString(2));
			pb.setStock(rs.getInt(3));
			pb.setPrice(rs.getInt(4));
			pb.setCompany(rs.getString(5));
			
			products.add(pb);	
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
		<title>Shop::product</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script>
		$(function () {
			
			// 주문 버튼을 누르면
			$('.btnOrder').click(function() {  
				let prodNum = $(this).val(); // 상품 번호 
				$('section').show().find('input[name=prodNo]').val(prodNum); // 주문창 숨기고, 상품번호 입력 
			});
			
			// 닫기 버튼을 누르면
			$('input[name=btnClose]').click(function() {
				$('section').hide();  // 주문창 숨기기
			});
			
			$(document).on('click', 'input[type=submit]', function (e) {
				e.preventDefault(); // 원래 이벤트 기능을 제거
				
				// input에 입력된 값을 가져온다.
				let prodNo = $('input[name=prodNo]').val();
				let orderCount = $('input[name=orderCount]').val();
				let custId = $('input[name=custId]').val();
				
				// json 형태로 변환한다.
				let jsonData = {
						"prodNo":prodNo,
						"orderCount":orderCount,
						"custId":custId
				}
				
				// AJAX를 이용해 비동기 방식으로 orderProc으로 JSON데이터를 전송한다.
				$.ajax({ 
					url: './orderProc.jsp',
					method: 'post',
					data:jsonData,
					dataType:'json',
					success: function (data) {
						
						if(data.result == 1){
							alert('주문완료!');
							location.href = '/Shop/order.jsp';
						} else {
							alert('주문실패!');
						}
					}
				});
			});
		});
	</script>
	</head>
	<body>
		<h3>상품 목록</h3>
		<nav>
			<a href="./customer.jsp">고객목록</a>
			<a href="./order.jsp">주문목록</a>
			<a href="./product.jsp">상품목록</a>
		</nav>
		<table border="1">
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>재고량</th>
				<th>가격</th>
				<th>제조사</th>
				<th>주문</th>
			</tr>
			<%
				for(ProductBean pb : products){
			%>
			<tr>
				<td><%= pb.getProdNo() %></td>
				<td><%= pb.getProdName() %></td>
				<td><%= pb.getStock() %></td>
				<td><%= pb.getPrice() %></td>
				<td><%= pb.getCompany() %></td>
				<td><button class="btnOrder" value="<%= pb.getProdNo() %>">주문</button> </td>
			</tr>
			<%
				}
			%>			
		</table>
		<br/>
		
		
		<!-- 주문 창 -->
		<section style="display: none;">
				<table border='1'>
					<tr>
						<td>상품번호</td>
						<td><input type='text' name='prodNo'></td>
					</tr>
						<tr>
						<td>수량</td>
						<td><input type='text' name='orderCount'></td>
					</tr>
					<tr>
						<td>주문자</td>
						<td><input type='text' name='custId'></td>
					</tr>
					<tr>
						<td colspan='2' align='right'>
							<input type="button" name="btnClose" value="닫기"/>
							<input type='submit' value='주문하기'>
						</td>
						
					</tr>
			    </table>
				
		</section>
		
	</body>
</html>