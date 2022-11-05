package kr.co.jboard1.db;

public class Sql {
	
	// user
	public static final String INSERT_USER = "INSERT INTO `board_user` SET "
											+ "`uid`=?,"
											+ "`pass`=SHA2(?, 256),"
											+ "`name`=?,"
											+ "`nick`=?,"
											+ "`email`=?,"
											+ "`hp`=?,"
											+ "`zip`=?,"
											+ "`addr1`=?,"
											+ "`addr2`=?,"
											+ "`regip`=?,"
											+ "`rdate`= NOW()";
	
	public static final String SELECT_TERMS = "SELECT * FROM `board_terms`";
	public static final String SELECT_USER = "SELECT * FROM `board_user` WHERE `uid`= ? and `pass`= SHA2(?, 256)";
	public static final String SELECT_COUNT_UID = "SELECT COUNT(`uid`) FROM `board_user` WHERE `uid`=?";
	public static final String SELECT_COUNT_NICK = "SELECT COUNT(`nick`) FROM `board_user` WHERE `nick`=?";
	
	// board
	public static final String INSERT_ARTICLE = "INSERT INTO `board_article` SET "
												+ "`title`=?,"
												+ "`content`=?,"
												+ "`file`=?,"
												+ "`uid`=?,"
												+ "`regip`=?,"
												+ "`rdate`=NOW()";

	public static final String INSERT_FILE = "INSERT INTO `board_file` SET "
			+ "`parent`=?,"
			+ "`newName`=?,"
			+ "`oriName`=?";

	public static final String SELECT_MAX_NO = "SELECT MAX(`no`) FROM `board_article`";
	public static final String SELECT_COUNT_TOTAL = "SELECT COUNT(`no`) FROM `board_article`";
	public static final String SELECT_ARTICLES = "SELECT a.*, nick FROM `board_article` a JOIN "
											  + " `board_user` u on a.uid = u.uid order by a.no DESC"
											  + " LIMIT ?, 10";
	
	public static final String SELECT_ARTICLE = "SELECT a.*, f.fno, f.parent AS pno, f.newName, f.oriName, f.download "
											  + " FROM `board_article` a LEFT JOIN `board_file` f "
											  + " ON a.no = f.parent "
			                                  + " WHERE a.`no`= ?";
	
	public static final String SELECT_FILE = "SELECT * FROM `board_file` WHERE `parent`=?";
	public static final String SELECT_FILE_IMG = "SELECT * FROM `board_file` WHERE `parent`=? and `oriName`='삽입 이미지'";
	
	public static final String UPDATE_ARTICLE_HIT = "UPDATE `board_article` SET `hit` = `hit`+ 1 WHERE `no` = ?"; 
	public static final String UPDATE_FILE_DOWNLOAD = "UPDATE `board_file` SET `download` = `download`+ 1 WHERE `fno` = ?"; 
	public static final String UPDATE_ARTICLE_COMMENT_PLUSE = "UPDATE `board_article` SET `comment` = `comment`+ 1 WHERE `no`= ?";
	public static final String UPDATE_ARTICLE_COMMENT_MINUS = "UPDATE `board_article` SET `comment` = `comment`- 1 WHERE `no`= ?";
	public static final String UPDATE_ARTICLE = "UPDATE `board_article` SET "
											 + " `title`=?,"
											 + " `content`=?,"
											 + " `rdate`=NOW() "
											 + " WHERE `no`=?";
	
	// comment
	public static final String UPDATE_COMMENT = "UPDATE `board_comment` SET `comment`=? WHERE `no`=?";
	public static final String DELETE_COMMENT = "DELETE FROM `board_comment` WHERE `no`= ? ";
	public static final String SELECT_COMMENTS = "SELECT * FROM `board_comment` WHERE `parent`=?";
	public static final String SELECT_NO = "SELECT MAX(`no`) FROM `board_comment`";
	public static final String INSERT_COMMENT = "INSERT INTO `board_comment` SET "
											   + " `parent`= ?, "
											   + " `comment`= ?, "
											   + " `uid`= ?, "
											   + " `nick`= ?, "
											   + " `regip`= ?, "
											   + " `rdate`= ?";
	public static final String DELETE_ARTICLE_FILE = "DELETE a.*, f.* FROM " 
												   + " `board_article` AS a "
												   + " LEFT JOIN " 
												   + "`board_file` AS f "
												   + " ON a.no = f.parent "
												   + " WHERE a.`no`= ?  OR a.`parent`= ?";
}
