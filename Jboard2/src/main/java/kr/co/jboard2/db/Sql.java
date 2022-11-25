package kr.co.jboard2.db;

public class Sql {
	
	/*** user ***/
	// terms
	public static final String SELECT_TERMS = "SELECT * FROM `board_terms`";
	
	
	// register
	public static final String CHECK_USER = "SELECT * FROM `board_user` WHERE `uid`= ?";
	public static final String CHECK_NICK = "SELECT * FROM `board_user` WHERE `nick`= ?";
	public static final String CHECK_EMAIL = "SELECT * FROM `board_user` WHERE `email` = ?";
	public static final String INSERT_USER = "INSERT INTO `board_user` SET "
			                               + " `uid`=?, "
			                               + " `pass`=SHA2(?, 256), "
			                               + " `name`=?, "
			                               + " `nick`=?, "
			                               + " `email`=?, "
			                               + " `hp`=?, "
			                               + " `zip`=?, "
			                               + " `addr1`=?, "
			                               + " `addr2`=?, "
			                               + " `regip`=?, "
			                               + " `rdate`=NOW() ";
	
	// login
	public static final String SELECT_USER = "SELECT * FROM `board_user` WHERE `uid`= ? and `pass`= SHA2(?, 256)";
	public static final String SELECT_USER_BY_SESSID = "SELECT * FROM `board_user` WHERE `sessId`=? AND `sessLimitDate` > NOW()";
	public static final String UPDATE_USER_FOR_SESSION = "UPDATE `board_user` SET `sessId`=?, `sessLimitDate` = DATE_ADD(NOW(),INTERVAL 3 DAY) WHERE `uid`= ?";
	public static final String UPDATE_USER_FOR_SESS_LIMIT_DATE = "UPDATE `board_user` SET `sessLimitDate` = DATE_ADD(NOW(),INTERVAL 3 DAY) WHERE `sessId`= ?";
	
	// logout
	public static final String UPDATE_USER_FOR_SESSION_OUT = "UPDATE `board_user` SET `sessId`= null, `sessLimitDate` = null WHERE `uid`=?";
	
	// 아이디 찾기
	public static final String SELECT_USER_FOR_FIND_ID = "SELECT * FROM `board_user` WHERE `name`= ? and `email` = ?";
	
	// 비밀번호 찾기
	public static final String SELECT_USER_FOR_FIND_PW = "SELECT * FROM `board_user` WHERE `uid`= ? and `email` = ?";
	
	// 비밀번호 변경
	public static final String UPDATE_USER_PW = "UPDATE `board_user` SET `pass`=SHA2(?, 256) WHERE `uid`=?";
											  
	
	// board
}
