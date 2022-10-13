package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyDB {
	
	private static MyDB instance = new MyDB();
	public static MyDB getInstance() {
		return instance;
	}
	private MyDB() {}
	
	// 데이터베이스 정보
	private final String HOST_M = "jdbc:mysql://127.0.0.1:3307/java2db";
	private final String HOST_S = "jdbc:mysql://127.0.0.1:3307/java2_college";
	private final String USER = "root";
	private final String PW = "1234";
	
	public Connection getConnection(int num) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		if(num == 1) {
			conn = DriverManager.getConnection(HOST_M, USER, PW);			
		} else {
			conn = DriverManager.getConnection(HOST_S, USER, PW);						
		}
		return conn;
	}
}
