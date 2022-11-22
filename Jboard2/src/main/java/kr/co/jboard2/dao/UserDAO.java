package kr.co.jboard2.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBHelper;
import kr.co.jboard2.db.Sql;
import kr.co.jboard2.vo.TermsVO;
import kr.co.jboard2.vo.userVO;

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
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result : " + result);
		return result;
	}
	public void insertUser(userVO vo) {
		
		try {
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_TERMS);
			pmst.set
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	
	
	public void selectUsers() {}
	public void updateUser() {}
	public void deleteUser() {}
}
