package kr.co.jboard2.db;

public class Sql {
	
	/*** user ***/
	// terms
	public static final String SELECT_TERMS = "SELECT * FROM `board_terms`";
	
	
	// register
	public static final String CHECK_USER = "SELECT * FROM `board_user` WHERE `uid`= ?";
	public static final String CHECK_NICK = "SELECT * FROM `board_user` WHERE `nick`= ?";
	public static final String INSERT_USER = "SELECT * FROM `board_user` WHERE `nick`= ?";
	
	
	public static final String SELECT_USER = "SELECT * FROM `board_user` WHERE `uid`= ? and `pass`= SHA2(?, 256)";
	
	// board
}
