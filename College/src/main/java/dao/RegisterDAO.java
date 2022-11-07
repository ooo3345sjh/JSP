package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBCP;
import db.DBHelper;
import db.Sql;
import dto.LectureDTO;
import dto.RegisterDTO;

public class RegisterDAO extends DBHelper {
	
	private static RegisterDAO instance = new RegisterDAO();
	
	public static RegisterDAO getInstance() {
		return instance;
	}
	
	private RegisterDAO () {}
	
	public List<RegisterDTO> selectRegisters() {
		List<RegisterDTO> lists = null;
		try{
			con = DBCP.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(Sql.SELECT_REGISTERS);
			lists = new ArrayList<>();
			
			while(rs.next()) {
				RegisterDTO dto = new RegisterDTO();
				dto.setRegStdNo(rs.getString(1)); 
				dto.setRegLecNo(rs.getInt(2)); 
				dto.setRegMidScore(rs.getInt(3)); 
				dto.setRegFinalScore(rs.getInt(4)); 
				dto.setRegTotalScore(rs.getInt(5));
				dto.setRegGrade(rs.getString(6));
				dto.setStdName(rs.getString(7));
				dto.setLecName(rs.getString(8));
				
				lists.add(dto);
			}
			
			close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return lists;
	}
	
	public List<RegisterDTO> selectRegister(String search) {
		List<RegisterDTO> lists = null;
		try{
			con = DBCP.getConnection();
			psmt = con.prepareStatement(Sql.SELECT_REGISTER);
			psmt.setString(1, search);
			rs = psmt.executeQuery();
			lists = new ArrayList<>();
			
			while(rs.next()) {
				RegisterDTO dto = new RegisterDTO();
				dto.setRegStdNo(rs.getString(1)); 
				dto.setRegLecNo(rs.getInt(2)); 
				dto.setRegMidScore(rs.getInt(3)); 
				dto.setRegFinalScore(rs.getInt(4)); 
				dto.setRegTotalScore(rs.getInt(5));
				dto.setRegGrade(rs.getString(6));
				dto.setStdName(rs.getString(7));
				dto.setLecName(rs.getString(8));
				
				lists.add(dto);
			}
			
			close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return lists;
	}
	
	public int insertRegister(RegisterDTO dto) {
		int result = 0;
		
		try {
			con = DBCP.getConnection();
			psmt = con.prepareStatement(Sql.INSERT_REGISTER);
			psmt.setString(1, dto.getRegStdNo());
			psmt.setInt(2, dto.getRegLecNo());
			
			result = psmt.executeUpdate();
			
			close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}