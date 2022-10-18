package config;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBCP {
	
	public static DataSource ds = null;
	
	public static Connection getConnection() throws NamingException, SQLException {
		ds = (DataSource) new InitialContext().lookup("java:comp/env/dbcp_mysql");
		
		return ds.getConnection();
	}

}
