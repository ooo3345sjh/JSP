package kr.co.jboard2.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBHelper;
import kr.co.jboard2.db.Sql;
import kr.co.jboard2.vo.TermsVO;
import kr.co.jboard2.vo.UserVO;

public class UserDAO extends DBHelper {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// terms
	public TermsVO selectTerms() {
		TermsVO vo = null;
		try {
			logger.info("selectTerms...");
			
			con = getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(Sql.SELECT_TERMS);
			
			if(rs.next()) {
				vo = new TermsVO();
				vo.setTerms(rs.getString(1));
				vo.setPrivacy(rs.getString(2));
			}
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		return vo;
	}
	
	// register
	public int checkUser(String uid) {
		int result = 0;
		
		try {
			logger.info("checkUser...");
			con = getConnection();
			psmt = con.prepareStatement(Sql.CHECK_USER);
			psmt.setString(1, uid);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) result = 1;
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result : " + result);
		return result;
	}
	public int checkNick(String nick) {
		int result = 0;
		
		try {
			logger.info("checkNick...");
			con = getConnection();
			psmt = con.prepareStatement(Sql.CHECK_NICK);
			psmt.setString(1, nick);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) result = 1;
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result : " + result);
		return result;
	}
	public void insertUser(UserVO vo) {
		
		try {
			logger.info("insertUser...");
			con = getConnection();
			psmt = con.prepareStatement(Sql.INSERT_USER);
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
			logger.error(e.getMessage());
		}
	}
	
	
	// login
	public UserVO selectUser(String uid, String pass) {
		UserVO vo = null;
		
		try {
			logger.info("selectUser...");
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_USER);
			psmt.setString(1, uid);
			psmt.setString(2, pass);
			
			rs = psmt.executeQuery();
			vo = new UserVO();
			
			if(rs.next()) {
				vo.setUid(rs.getString(1));
				vo.setPass(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setNick(rs.getString(4));
				vo.setEmail(rs.getString(5));
				vo.setHp(rs.getString(6));
				vo.setGrade(rs.getInt(7));
				vo.setZip(rs.getString(8));
				vo.setAddr1(rs.getString(9));
				vo.setAddr2(rs.getString(10));
				vo.setRegip(rs.getString(11));
				vo.setRdate(rs.getString(12));
			}
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo : " + vo);
		return vo;
	}
	
	// 자동 로그인 시 회원정보 가져오는 메서드
	public UserVO selectUser(String uid) {
		UserVO vo = null;
		
		try {
			logger.info("selectUser...");
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_USER);
			psmt.setString(1, uid);
			
			rs = psmt.executeQuery();
			vo = new UserVO();
			
			if(rs.next()) {
				vo.setUid(rs.getString(1));
				vo.setPass(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setNick(rs.getString(4));
				vo.setEmail(rs.getString(5));
				vo.setHp(rs.getString(6));
				vo.setGrade(rs.getInt(7));
				vo.setZip(rs.getString(8));
				vo.setAddr1(rs.getString(9));
				vo.setAddr2(rs.getString(10));
				vo.setRegip(rs.getString(11));
				vo.setRdate(rs.getString(12));
			}
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo : " + vo);
		return vo;
	}
	
	
	
	
	public void selectUsers() {}
	public void updateUser() {}
	public void deleteUser() {}
}
