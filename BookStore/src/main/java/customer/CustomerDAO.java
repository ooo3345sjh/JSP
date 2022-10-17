package customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import book.BookDTO;
import config.DBCP;

public class CustomerDAO {
	Connection con = null;
	PreparedStatement psmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	// 모든 게시물을 조회하는 메서드
	public List<CustomerDTO> selectList() {
		List<CustomerDTO> customers = null;
		
		
		try {
			// 1, 2단계 - DB 접속
			con = DBCP.getConnection();
			
			// 3단계 - SQL실행 객체 생성
			stmt = con.createStatement();
			
			// 4단계 - SQL실행
			String sql = "SELECT * FROM `customer`";
			rs = stmt.executeQuery(sql);
			
			customers = new ArrayList<>();
			
			// 5단계 - SQL결과 처리
			while(rs.next()) {
				CustomerDTO dto = new CustomerDTO();
				
				dto.setCustId(rs.getInt(1));
				dto.setName(rs.getString(2));
				dto.setAddress(rs.getString(3));
				dto.setPhone(rs.getString(4));
				
				customers.add(dto);
			}
			
			// 6단계 - 연결 해제
			close();
			
		} catch (Exception e) {
			System.out.println("모든 고객정보 조회중 에러 발생");
			e.printStackTrace(); 
		}
		
		
		return customers;
	}
	
	// 조건에 맞는 고객을 조회하는 메서드
	public CustomerDTO selectCustomer(String custId) {
		CustomerDTO dto = null;
		
		try {
			// 1, 2단계 - DB 접속
			con = DBCP.getConnection();
			
			// 3단계 - SQL실행 객체 생성
			String sql = "SELECT * FROM `customer` WHERE `custId`=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, custId);
			
			// 4단계 - SQL실행
			rs = psmt.executeQuery();
			
			// 5단계 - SQL결과 처리
			if(rs.next()) {
				dto = new CustomerDTO();
				
				dto.setCustId(rs.getInt(1));
				dto.setName(rs.getString("name"));
				dto.setAddress(rs.getString("address"));
				dto.setPhone(rs.getString("phone"));
			}
			
			// 6단계 - 연결 해제
			close();
			
			
		} catch (Exception e) {
			System.out.println("조건에 맞는 고객정보 조회중 에러 발생");
			e.printStackTrace(); 
		}
		
		// 조회된 고객 정보 반환
		return dto; 
	}
	
	// 고객 정보를 수정하는 메서드
	public void updateCustomer(CustomerDTO dto) {
		try {
			// 1, 2단계 - DB 접속
			con = DBCP.getConnection();
			
			// 3단계 - SQL실행 객체 생성
			String sql = "UPDATE `customer` SET `name`=?, `address`=?, `phone`=? WHERE `custId`=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getAddress());
			psmt.setString(3, dto.getPhone());
			psmt.setInt(4, dto.getCustId());
			
			// 4단계 - SQL실행
			psmt.executeUpdate();
			
			// 5단계 - SQL결과 처리
			
			// 6단계 - 연결 해제
			close();
			
			
		} catch (Exception e) {
			System.out.println("고객정보 수정중 에러 발생");
			e.printStackTrace(); 
		}
	}
	
	// 조건에 맞는 고객 정보를 삭제하는 메서드
	public void deleteCustomer(String custId) {
		try {
			// 1, 2단계 - DB 접속
			con = DBCP.getConnection();
			
			// 3단계 - SQL실행 객체 생성
			String sql = "DELETE FROM `customer` WHERE `custId`=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, custId);
			
			// 4단계 - SQL실행
			psmt.executeUpdate();
			
			// 5단계 - SQL결과 처리
			
			// 6단계 - 연결 해제
			close();
			
			
		} catch (Exception e) {
			System.out.println("고객정보 삭제중 에러 발생");
			e.printStackTrace(); 
		}
	}
	
	// 고객 정보를 추가하는 메서드
		public void insertCustomer(CustomerDTO dto) {
			try {
				// 1, 2단계 - DB 접속
				con = DBCP.getConnection();
				
				// 3단계 - SQL실행 객체 생성
				String sql = "INSERT INTO `customer`(`name`, `address`, `phone`)"
						   + "VALUES(?,?,?)";
						
				psmt = con.prepareStatement(sql);
				psmt.setString(1, dto.getName());
				psmt.setString(2, dto.getAddress());
				psmt.setString(3, dto.getPhone());
				
				// 4단계 - SQL실행
				psmt.executeUpdate();
				
				// 5단계 - SQL결과 처리
				
				// 6단계 - 연결 해제
				close();
				
				
			} catch (Exception e) {
				System.out.println("고객정보 등록중 에러 발생");
				e.printStackTrace(); 
			}
		}
	
	// 연결 해제하는 메서드
	public void close() throws SQLException {
		if(rs != null) {
			rs.close();
		} 
		if(stmt != null) {
			stmt.close();
		}
		if(psmt != null) {
			psmt.close();
		}
		if(con != null) {
			con.close();
		}
	}

}
