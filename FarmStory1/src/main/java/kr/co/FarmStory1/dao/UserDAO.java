package kr.co.FarmStory1.dao;

import java.util.HashMap;
import java.util.Map;

import kr.co.FarmStory1.db.DBHelper;
import kr.co.FarmStory1.vo.UserVO;

public class UserDAO extends DBHelper {
	
	private static UserDAO instance = new UserDAO();
	public static UserDAO getInstance() {
		return instance;
	}
	private UserDAO() {}
	
	
	public UserVO selectUser(String uid, String pass) {
		UserVO vo = null;	
		try {
			con = getConnection();
			String sql = "SELECT * FROM `board_user` WHERE `uid`=? and `pass`=SHA2(?, 256)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, uid);
			psmt.setString(2, pass);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new UserVO();
				vo.setUid(rs.getString(1));
				vo.setPass(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setNick(rs.getString(4));
				vo.setEmail(rs.getString(5));
				vo.setHp(rs.getString(6));
				vo.setZip(rs.getString(7));
				vo.setAddr1(rs.getString(8));
				vo.setAddr2(rs.getString(9));
				vo.setRegip(rs.getString(10));
				vo.setRdate(rs.getString(11));
			}
			
			close();
			
		} catch (Exception e) {
			System.out.println("조건에 맞는 회원 조회 중에 에러발생");
			e.printStackTrace();
		}
		return vo;
	}
	public void selectUsers() {}
	public void insertUser(UserVO vo) {
		try {
			con = getConnection();
			String sql = "INSERT INTO `board_user` SET "
					   + " `uid`=?, "
					   + " `pass`=SHA2(?, 256), "
					   + " `name`=?, "
					   + " `nick`=?, "
					   + " `email`=?, "
					   + " `hp`=?, "
					   + " `zip`=?, "
					   + " `addr1`=?, "
					   + " `addr2`=?, "
					   + " `regip`=?, "
					   + " `rdate`=NOW() ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, vo.getUid());
			psmt.setString(2, vo.getPass());
			psmt.setString(3, vo.getName());
			psmt.setString(4, vo.getNick());
			psmt.setString(5, vo.getEmail());
			psmt.setString(6, vo.getHp());
			psmt.setString(7, vo.getZip());
			psmt.setString(8, vo.getAddr1());
			psmt.setString(9, vo.getAddr2());
			psmt.setString(10, vo.getRegip());
			
			psmt.executeUpdate();
			
			close();
		} catch (Exception e) {
			System.out.println("User등록 중에 에러발생");
			e.printStackTrace();
		}
	}
	
	public Map<String, Object> selectTerms() {
		Map<String, Object> map = null;
		
		try {
			con = getConnection();
			stmt = con.createStatement();
			String sql = "SELECT * FROM `board_terms`";
			rs = stmt.executeQuery(sql);
			map = new HashMap<>();
			if(rs.next()) {
				map.put("terms", rs.getString(1));
				map.put("privacy", rs.getString(2));
			}
			
			close();
			
		} catch (Exception e) {
			System.out.println("약관동의를 불러오는 중에 에러 발생");
			e.printStackTrace();
		}
		
		return map;
	}
	
	public void deleteUser() {}
	public void updateUser() {}
	
	

}
