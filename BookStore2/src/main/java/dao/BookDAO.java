package dao;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import db.DBHelper;
import vo.BookVO;

public class BookDAO extends DBHelper {
	
	private static BookDAO instance = new BookDAO();
	
	public static BookDAO getInstance () {
		return instance;
	}
	private BookDAO () {}
	
	public List<BookVO> selectBooks() {
		List<BookVO> lists = null;
		
		try {
			logger.info("selectBookStores...");
			con = getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM `book`");
			
			lists = new ArrayList<>();
			
			while(rs.next()) {
				BookVO vo = new BookVO();
				vo.setBookID(rs.getInt(1));
				vo.setBookName(rs.getString(2));
				vo.setPublisher(rs.getString(3));
				vo.setPrice(rs.getInt(4));
				
				lists.add(vo);
			}
			
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("lists : " + lists);
		return lists;
	}
	
	public BookVO selectBook(String bookID) {
		BookVO vo = null;
		
		try {
			logger.info("selectBookStore...");
			con = getConnection();
			psmt = con.prepareStatement("SELECT * FROM `book` WHERE `bookid`=?");
			psmt.setString(1, bookID);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new BookVO();
				vo.setBookID(rs.getInt(1));
				vo.setBookName(rs.getString(2));
				vo.setPublisher(rs.getString(3));
				vo.setPrice(rs.getInt(4));
			}
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo : " + vo);
		return vo;
	}
	public void updateBook(BookVO vo) {
		try {
			logger.info("updateBook...");
			con = getConnection();
			String sql = "UPDATE `book` SET "
					   + " `bookName`=?,"
					   + " `publisher`=?,"
					   + " `price`=? "
					   + " WHERE `bookID`=? ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, vo.getBookName());
			psmt.setString(2, vo.getPublisher());
			psmt.setInt(3, vo.getPrice());
			psmt.setInt(4, vo.getBookID());
			
			psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
	public void insertBook(BookVO vo) {
		try {
			logger.info("insertBook...");
			con = getConnection();
			String sql = "INSERT INTO `book` SET "
					   + " `bookID`=?, "
					   + " `bookName`=?,"
					   + " `publisher`=?,"
					   + " `price`=? ";
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, vo.getBookID());
			psmt.setString(2, vo.getBookName());
			psmt.setString(3, vo.getPublisher());
			psmt.setInt(4, vo.getPrice());
			
			psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public void deleteBook(String bookID) {
		try {
			logger.info("deleteBook...");
			con = getConnection();
			psmt = con.prepareStatement("DELETE FROM `book` WHERE `bookid`=?");
			psmt.setString(1, bookID);
			
			psmt.executeUpdate();
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
}
