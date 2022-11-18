package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DBHelper {
	protected PreparedStatement psmt = null;
	protected Statement stmt = null;
	protected ResultSet rs = null;
	protected Connection con = null;
	
	public Logger logger = LoggerFactory.getLogger(this.getClass()); 
	
	public Connection getConnection() {
		try {
			logger.info("getConnection...");
			DataSource ds = (DataSource) new InitialContext().lookup("java:comp/env/dbcp_java2_bookstore");
			con = ds.getConnection();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("con : " + con);
		return con;
	}
	
	public void close() {
		try {
			logger.info("close...");
			if(con != null) con.close();
			if(psmt != null) psmt.close();
			if(stmt != null) stmt.close();
			if(rs != null) rs.close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
	

}
