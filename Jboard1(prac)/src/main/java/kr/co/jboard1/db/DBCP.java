package kr.co.jboard1.db;
import java.sql.Connection;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBCP {
	
	private static DataSource ds = null;
	
	public static Connection getConnection() throws Exception {
		if(ds == null) {
			ds = (DataSource) new InitialContext().lookup("java:comp/env/dbcp_java2_board");
		}
		
		return ds.getConnection();
	}

}
