package db;

public class Sql {
	
	public static final String SELECT_LECTURES = "SELECT * FROM `lecture`";
	public static final String SELECT_STUDENTS = "SELECT * FROM `student`";
	public static final String SELECT_REGISTERS = "SELECT r.*, s.`stdName`, l.`lecname` FROM `register` r join"
												+ " `student` s ON r.`regStdNo` = s.`stdNo` JOIN "
												+ " `lecture` l ON r.regLecNo = l.lecNo";
	public static final String SELECT_REGISTER = "SELECT r.*, s.`stdName`, l.`lecname` FROM `register` r join"
												+ " `student` s ON r.`regStdNo` = s.`stdNo` JOIN "
												+ " `lecture` l ON r.regLecNo = l.lecNo"
												+ " WHERE r.`regStdNo` = ?";
	public static final String INSERT_LECTURE = "INSERT INTO `lecture` SET "
											   + " `lecNo`=?, "
											   + " `lecname`=?, "
											   + " `lecCredit`=?, "
											   + " `lecTime`=?, "
											   + " `lecClass`=? ";
	
	public static final String INSERT_REGISTER = "INSERT INTO `register` SET "
												+ " `regStdNo`=?, "
												+ " `regLecNo`=? ";
	
	public static final String INSERT_STUDENT = "INSERT INTO `student` SET "
											  + " `stdNo`=?,"
											  + " `stdName`=?,"
											  + " `stdHp`=?,"
											  + " `stdYear`=?,"
											  + " `stdAddress`=?";

}
