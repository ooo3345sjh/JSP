package kr.co.FarmStory1.dao;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.FarmStory1.db.DBHelper;
import kr.co.FarmStory1.db.Sql;
import kr.co.FarmStory1.vo.UserVO;
/*
 * class -> enum으로 바꾸고 INSTANCE; 를 선언하면 싱글톤패턴이 됨.
 */
public class UserDAO extends DBHelper {
	
	private static UserDAO instance = new UserDAO();
	public static UserDAO getInstance() {
		return instance;
	}
	private UserDAO() {}
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public UserVO selectUser(String uid, String pass) {
		UserVO vo = null;	
		try {
			logger.info("selectUser...");
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_USER);
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
	
	public Map<String, Object> selectTerms() {
		Map<String, Object> map = null;
		
		try {
			logger.info("selectTerms...");
			con = getConnection();
			stmt = con.createStatement();
			String sql = "SELECT * FROM `board_terms`";
			rs = stmt.executeQuery(Sql.SELECT_TERMS);
			
			map = new HashMap<>() {
				private static final long serialVersionUID = 1L;

				@Override
				public String toString() {
					return "terms : 사이트 이용약관, privacy : 개인정보 취급방침";
				}
			};
			
			if(rs.next()) {
				map.put("terms", rs.getString(1));
				map.put("privacy", rs.getString(2));
			}
			
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("map : " + map.toString());
		return map;
	}
	
	public int selectCountNick(String nick) {
		int result = 0;
		
		try{
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_COUNT_NICK);
			psmt.setString(1, nick);
			
			rs = psmt.executeQuery() ;
			
			
			if(rs.next()){ 
				result = rs.getInt(1);
			}
			
			close();
			
		}catch(Exception e){
			e.printStackTrace();		
		}	
		
		return result;
	}
	
	public int selectCountUid(String uid) {
		
		int result = 0;
		
		try{
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_COUNT_UID);
			psmt.setString(1, uid);
			
			rs = psmt.executeQuery() ;
			
			
			if(rs.next()){ 
				result = rs.getInt(1);
			}
			
			close();
		}catch(Exception e){
			e.printStackTrace();		
		}	
		
		return result;
	}
}
