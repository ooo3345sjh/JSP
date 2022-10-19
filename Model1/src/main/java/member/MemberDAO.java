package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Map;

import config.DBCP;

public class MemberDAO {
	private PreparedStatement psmt;
	private Statement stmt;
	private Connection con;
	private ResultSet rs;
	
	public MemberDAO() {
		try {
			con = DBCP.getConnection();
		} catch (Exception e) {
			System.out.println("DB 접속 중 에러 발생");
			e.printStackTrace();
		}
	}
	
	// 조건에 해당하는 멤버를 반환하는 함수
	public MemberDTO selectMember(Map<String, String> map) {
		MemberDTO dto = null;
		
		// 데이터 베이스 작업
		try {
			// SQL실행 객체 생성
			String sql = "SELECT * FROM `member` WHERE `id`=? and `pass`=?";
			psmt = con.prepareStatement(sql);
			
			// SQL 실행
			psmt.setString(1, map.get("id"));
			psmt.setString(2, map.get("pw"));
			
			rs = psmt.executeQuery();
			
			// SQL 결과 처리
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
			}
			
			close();
		} catch (Exception e) {
			System.out.println("조회중 에러 발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 연결을 해제하는 메서드
	public void close() {
		try {
			if(con != null) con.close();
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(psmt != null) psmt.close();
			
		} catch (Exception e) {
			System.out.println("연결 해제중 에러 발생");
			e.printStackTrace();
		}
		System.out.println("연결 해제 완료");
		System.out.println("연결 해제 완료");
	}
	
	
}
