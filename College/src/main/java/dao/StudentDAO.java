package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBCP;
import db.DBHelper;
import db.Sql;
import dto.LectureDTO;
import dto.RegisterDTO;
import dto.StudentDTO;

public class StudentDAO extends DBHelper {
	
	private static StudentDAO instance = new StudentDAO();
	
	public static StudentDAO getInstance() {
		return instance;
	}
	
	private StudentDAO () {}
	
	public List<StudentDTO> selectStudents() {
		List<StudentDTO> lists = null;
		try{
			con = DBCP.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(Sql.SELECT_STUDENTS);
			lists = new ArrayList<>();
			
			while(rs.next()) {
				StudentDTO dto = new StudentDTO();
				dto.setStdNo(rs.getString(1));
				dto.setStdName(rs.getString(2));
				dto.setStdHp(rs.getString(3));
				dto.setStdYear(rs.getInt(4));
				dto.setStdAddress(rs.getString(5));
				
				lists.add(dto);
			}
			
			close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return lists;
	}
	
	public int insertStudent(StudentDTO dto) {
		int result = 0;
		
		try {
			con = DBCP.getConnection();
			psmt = con.prepareStatement(Sql.INSERT_STUDENT);
			psmt.setString(1, dto.getStdNo());
			psmt.setString(2, dto.getStdName());
			psmt.setString(3, dto.getStdHp());
			psmt.setInt(4, dto.getStdYear());
			psmt.setString(5, dto.getStdAddress());
			result = psmt.executeUpdate();
			
			close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
