package model1.member;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class MemberDAO extends JDBConnect {
	
	public MemberDAO(ServletContext application) {
		super(application);
	}
	
	public MemberDTO readMember(String id, String pass) {
		MemberDTO dto = null;
		
		try {
			// 3단계 - SQL실행 객체 생성
			String sql = "SELECT * FROM `member` WHERE `id`=? and `pass`=?";
			psmt = con.prepareStatement(sql);
			
			// 4단계 - SQL실행
			psmt.setString(1, id);
			psmt.setString(2, pass);
			rs = psmt.executeQuery();
			
			// 5단계 - SQL결과 처리
			if(rs.next()){
				dto = new MemberDTO();
				
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
			}
			
			// 6단계 - 연결 해제
			super.close();
			
		} catch (Exception e) {
			System.out.println("로그인 회원 정보 확인 중 예외 발생");
			e.printStackTrace();
		}
		
		return dto;
	}
}
