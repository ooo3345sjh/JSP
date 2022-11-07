package dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.DBCP;
import db.DBHelper;
import db.Sql;
import dto.LectureDTO;
import dto.RegisterDTO;

public class LectureDAO extends DBHelper {
	
	private static LectureDAO instance = new LectureDAO();
	
	public static LectureDAO getInstance() {
		return instance;
	}
	
	private LectureDAO () {}
	
	
	public List<LectureDTO> selectLectures() {
		List<LectureDTO> lists = null;
		try{
			con = DBCP.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(Sql.SELECT_LECTURES);
			lists = new ArrayList<>();
			
			while(rs.next()) {
				LectureDTO dto = new LectureDTO();
				dto.setLecNo(rs.getInt(1)); 
				dto.setLecName(rs.getString(2)); 
				dto.setLecCredit(rs.getInt(3)); 
				dto.setLecTime(rs.getInt(4)); 
				dto.setLecClass(rs.getString(5));
				
				lists.add(dto);
			}
			
			close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return lists;
	}
	
	public int insertLecture(LectureDTO dto) {
		int result = 0;
		
		try {
			con = DBCP.getConnection();
			psmt = con.prepareStatement(Sql.INSERT_LECTURE);
			psmt.setInt(1, dto.getLecNo());
			psmt.setString(2, dto.getLecName());
			psmt.setInt(3, dto.getLecCredit());
			psmt.setInt(4, dto.getLecTime());
			psmt.setString(5, dto.getLecClass());
			
			
			result = psmt.executeUpdate();
			
			close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
