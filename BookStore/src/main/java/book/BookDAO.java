package book;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import config.DBCP;

public class BookDAO {
	Connection con = null;
	PreparedStatement psmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	// 모든 게시물을 조회하는 메서드
	public List<BookDTO> selectList() {
		List<BookDTO> customers = null;
		
		
		try {
			// 1, 2단계 - DB 접속
			con = DBCP.getConnection();
			
			// 3단계 - SQL실행 객체 생성
			stmt = con.createStatement();
			
			// 4단계 - SQL실행
			String sql = "SELECT * FROM `book`";
			rs = stmt.executeQuery(sql);
			
			customers = new ArrayList<>();
			
			// 5단계 - SQL결과 처리
			while(rs.next()) {
				BookDTO dto = new BookDTO();
				
				dto.setBookId(rs.getInt(1));
				dto.setBookName(rs.getString(2));
				dto.setPublisher(rs.getString(3));
				dto.setPrice(rs.getInt(4));
				
				customers.add(dto);
			}
			
			// 6단계 - 연결 해제
			close();
			
		} catch (Exception e) {
			System.out.println("모든 도서정보 조회중 에러 발생");
			e.printStackTrace(); 
		}
		
		
		return customers;
	}
	
	// 조건에 맞는 고객을 조회하는 메서드
	public BookDTO selectBook(String bookId) {
		BookDTO dto = null;
		
		try {
			// 1, 2단계 - DB 접속
			con = DBCP.getConnection();
			
			// 3단계 - SQL실행 객체 생성
			String sql = "SELECT * FROM `book` WHERE `bookId`=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, bookId);
			
			// 4단계 - SQL실행
			rs = psmt.executeQuery();
			
			// 5단계 - SQL결과 처리
			if(rs.next()) {
				dto = new BookDTO();
				
				dto.setBookId(rs.getInt(1));
				dto.setBookName(rs.getString(2));
				dto.setPublisher(rs.getString(3));
				dto.setPrice(rs.getInt(4));
			}
			
			// 6단계 - 연결 해제
			close();
			
			
		} catch (Exception e) {
			System.out.println("조건에 맞는 도서정보 조회중 에러 발생");
			e.printStackTrace(); 
		}
		
		// 조회된 고객 정보 반환
		return dto; 
	}
	
	// 고객 정보를 수정하는 메서드
	public void updateBook(BookDTO dto) {
		try {
			// 1, 2단계 - DB 접속
			con = DBCP.getConnection();
			
			// 3단계 - SQL실행 객체 생성
			String sql = "UPDATE `book` SET `bookname`=?, `publisher`=?, `price`=? WHERE `bookId`=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getBookName());
			psmt.setString(2, dto.getPublisher());
			psmt.setInt(3, dto.getPrice());
			psmt.setInt(4, dto.getBookId());
			
			// 4단계 - SQL실행
			psmt.executeUpdate();
			
			// 5단계 - SQL결과 처리
			
			// 6단계 - 연결 해제
			close();
			
			
		} catch (Exception e) {
			System.out.println("도서정보 수정중 에러 발생");
			e.printStackTrace(); 
		}
	}
	
	// 조건에 맞는 도서 정보를 삭제하는 메서드
	public void deleteBook(String bookId) {
		try {
			// 1, 2단계 - DB 접속
			con = DBCP.getConnection();
			
			// 3단계 - SQL실행 객체 생성
			String sql = "DELETE FROM `book` WHERE `bookId`=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, bookId);
			
			// 4단계 - SQL실행
			psmt.executeUpdate();
			
			// 5단계 - SQL결과 처리
			
			// 6단계 - 연결 해제
			close();
			
			
		} catch (Exception e) {
			System.out.println("도서정보 삭제중 에러 발생");
			e.printStackTrace(); 
		}
	}
	
	// 고객 정보를 추가하는 메서드
	public void insertBook(BookDTO dto) {
		try {
			// 1, 2단계 - DB 접속
			con = DBCP.getConnection();
			
			// 3단계 - SQL실행 객체 생성
			String sql = "INSERT INTO `book`(`bookname`, `publisher`, `price`)"
					   + "VALUES(?,?,?)";
					
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getBookName());
			psmt.setString(2, dto.getPublisher());
			psmt.setInt(3, dto.getPrice());
			
			// 4단계 - SQL실행
			psmt.executeUpdate();
			
			// 5단계 - SQL결과 처리
			
			// 6단계 - 연결 해제
			close();
			
			
		} catch (Exception e) {
			System.out.println("도서정보 등록중 에러 발생");
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
