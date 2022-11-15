package kr.co.FarmStory1.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBHelper {
	protected ResultSet rs;
	protected PreparedStatement psmt;
	protected Statement stmt;
	protected Connection con;
	
	public Connection getConnection() {
		try {
			DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/dbcp_java2_board");
			con = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	
	public void close() {
		try {
			if(con != null)	con.close();
			if(psmt != null) psmt.close();
			if(stmt != null) stmt.close();
			if(rs != null) rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
