package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import vo.User3VO;

public class User3DAO extends DBHelper {
	
	public void insertUser3() {}
	public void selectUser3() {}
	public void selectUser3s() {
		
		List<User3VO> users = null;
		
		try {
			con = getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM `user3`");
			
			users = new ArrayList<>();
			
			while(rs.next()) {
				User3VO vo = new User3VO();
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void updateUser3() {}
	public void deleteUser3() {}

}
