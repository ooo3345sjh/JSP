package kr.co.jboard1.dao;

public class UserDAO {
	
	public static UserDAO instance = new UserDAO();
	
	public UserDAO getInstance() {
		return instance;
	}
	
	private UserDAO() {}
	
	// 기본 CRUD
	public void insertUserDAO() {}
	public void selectUserDAO() {}
	public void selectUsersDAO() {}
	public void updateUserDAO() {}
	public void deleteUserDAO() {}

}
