package kr.co.jboard1.dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard1.bean.ArticleBean;
import kr.co.jboard1.bean.FileBean;
import kr.co.jboard1.db.DBHelper;
import kr.co.jboard1.db.Sql;

// DAO(Data Access Object) : 데이터베이스 처리 클래스
public class ArticleDAO extends DBHelper {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private static ArticleDAO instance = new ArticleDAO();
	
	public static ArticleDAO getInstance() {
		return instance;
	}
	
	private ArticleDAO() {}
	
	// 기본 CRUD
	public int insertArticle(ArticleBean ab) {
		
		int parent = 0;
		try{
			logger.info("insertArticle");
			// 트랜잭션 시작
			con = getConnection();
			con.setAutoCommit(false);
			psmt = con.prepareStatement(Sql.INSERT_ARTICLE);
			stmt = con.createStatement();
			
			psmt.setString(1, ab.getTitle());
			psmt.setString(2, ab.getContent());
			psmt.setInt(3, ab.getFname() == null ? 0 : 1);
			psmt.setString(4, ab.getUid());
			psmt.setString(5, ab.getRegip());
			
			psmt.executeUpdate();
			rs = stmt.executeQuery(Sql.SELECT_MAX_NO);
			
			con.commit(); // 작업 확정
			// 트랜잭션 종료
			
			if(rs.next()){
				parent = rs.getInt(1);
			}
			
			close();
			
		}catch(Exception e){
			e.printStackTrace();	
			logger.error(e.getMessage());
		}
		return parent;
	}
	
	public void insertFile(int parent, String newName, String fname) {
		
		try{
			logger.info("insertFile");
			con = getConnection();
			psmt = con.prepareStatement(Sql.INSERT_FILE);
			psmt.setInt(1, parent);
			psmt.setString(2, newName);
			psmt.setString(3, fname);
			
			psmt.executeUpdate();
			
			close();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public void insertFiles(int parent, String[] fNames) {
		
		try{
			logger.info("insertFiles");
			con = getConnection();
			String sql = "INSERT INTO `board_file` (`parent`, `newName`, `oriName`)"
					+ " VALUES ";
			for(int i=0; i<fNames.length; i++) {
				if(i == fNames.length-1) {
					sql += " (?,?,'삽입 이미지'); ";
				} else {
					sql += " (?,?,'삽입 이미지'), ";
				}
			}
			
			psmt = con.prepareStatement(sql);
			int num = 1;
			for(int i=0; i<fNames.length; i++) {
				psmt.setInt(num++, parent);
				psmt.setString(num++, fNames[i]);
			}
			
			psmt.executeUpdate();
			
			close();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	
	public ArticleBean insertComment(ArticleBean comment) {
		
		ArticleBean article = null;
		
		try{
			logger.info("insertComment");
			con = getConnection();
	 		con.setAutoCommit(false);
	 		
	 		PreparedStatement updatePsmt = con.prepareStatement(Sql.UPDATE_COMMENT_PlUS);
	 		psmt = con.prepareStatement(Sql.INSERT_COMMENT);
	 		stmt = con.createStatement();
	 		
	 		updatePsmt.setInt(1, comment.getParent());
	 		
	 		psmt.setInt(1, comment.getParent());
	 		psmt.setString(2, comment.getContent());
	 		psmt.setString(3, comment.getUid());
	 		psmt.setString(4, comment.getRegip());
	 		
	 		updatePsmt.executeUpdate();
	 		psmt.executeUpdate();
	 		rs = stmt.executeQuery(Sql.SELECT_COMMENT_LATEST);
	 		
	 		con.commit();
	 		
	 		if(rs.next()) {
	 			article = new ArticleBean();
	 			article.setNo(rs.getInt(1));
	 			article.setContent(rs.getString(6));
	 			article.setRdate(rs.getString(11));
	 			article.setNick(rs.getString(12));
	 		}
	 		
	 		close();
	 	}catch(Exception e){
	 		e.printStackTrace();
	 		logger.error(e.getMessage());
	 	}
		
		return article;
	}
	
	public ArticleBean selectArticle(String no) {
		
		ArticleBean ab = null;
		try{
			logger.info("selectArticle");
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_ARTICLE);
			psmt.setString(1, no);
			
			rs = psmt.executeQuery();
			
			if(rs.next()){
				ab = new ArticleBean();
				ab.setNo(rs.getInt(1));
				ab.setParent(rs.getInt(2));
				ab.setComment(rs.getInt(3));
				ab.setCate(rs.getString(4));
				ab.setTitle(rs.getString(5));
				ab.setContent(rs.getString(6));
				ab.setFile(rs.getInt(7));
				ab.setHit(rs.getInt(8));
				ab.setUid(rs.getString(9));
				ab.setRegip(rs.getString(10));
				ab.setRdate(rs.getString(11));
				
				ab.setFno(rs.getInt(12));
				ab.setPno(rs.getInt(13));
				ab.setNewName(rs.getString(14));
				ab.setOriName(rs.getString(15));
				ab.setDownload(rs.getInt(16));
			}
			
			close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return ab;
	}
	
	// 모든 게시물의 수를 가져오는 메서드
	public int selectCountTotal() {

		int total = 0;
		try{
			logger.info("selectCountTotal");
			con = getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(Sql.SELECT_COUNT_TOTAL);
			
			if(rs.next()){
				total = rs.getInt(1);
			}
			
			close();
			
		} catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return total;
	}
	
	// 모든 게시물을 가져오는 메서드
	public List<ArticleBean> selectArticles(int limitStart) {
		
		List<ArticleBean> articles = null;
		
		try{
			logger.info("selectArticles");
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setInt(1,  limitStart);
			rs = psmt.executeQuery();
			
			articles = new ArrayList<>();
			
			while(rs.next()){
				ArticleBean ab = new ArticleBean();
				ab.setNo(rs.getInt("no"));
				ab.setParent(rs.getInt("parent"));
				ab.setComment(rs.getInt("comment"));
				ab.setCate(rs.getString("cate"));
				ab.setContent(rs.getString("content"));
				ab.setTitle(rs.getString("title"));
				ab.setUid(rs.getString("uid"));
				ab.setRdate(rs.getString("rdate"));
				ab.setHit(rs.getInt("hit"));
				ab.setFile(rs.getInt("file"));
				ab.setRegip(rs.getString("regip"));
				ab.setNick(rs.getString("nick"));
				
				
				articles.add(ab);			
			}
			
			close();
			
		} catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		return articles;
	}
	
	public List<FileBean> selectFile(String parent) {
		
		List<FileBean> files = null;
		
		try{
			logger.info("selectFile");
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_FILE);
			psmt.setString(1, parent);
			
			rs = psmt.executeQuery();
			
			files = new ArrayList<>();
			
			while(rs.next()){
				FileBean fb = new FileBean();
				fb.setFno(rs.getInt(1));
				fb.setParent(rs.getInt(2));
				fb.setNewName(rs.getString(3));
				fb.setOriName(rs.getString(4));
				fb.setDownload(rs.getInt(5));
				
				files.add(fb);
			}
			
			close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return files;
	}
	
	
	public List<ArticleBean> selectComments(String parent) {
		List<ArticleBean> comments = new ArrayList<>();
		try {
			logger.info("selectComments");
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_COMMENTS);
			psmt.setString(1, parent);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleBean ab = new ArticleBean();
				ab.setNo(rs.getInt("no"));
				ab.setParent(rs.getInt("parent"));
				ab.setComment(rs.getInt("comment"));
				ab.setCate(rs.getString("cate"));
				ab.setContent(rs.getString("content"));
				ab.setTitle(rs.getString("title"));
				ab.setUid(rs.getString("uid"));
				ab.setRdate(rs.getString("rdate"));
				ab.setHit(rs.getInt("hit"));
				ab.setFile(rs.getInt("file"));
				ab.setRegip(rs.getString("regip"));
				ab.setNick(rs.getString("nick"));
				
				comments.add(ab);
			}
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return comments;
	}
	
	public int updateArticle(String no, String title, String content) {
		
		int result = 0;
		
		try{
			logger.info("updateArticle");
			con = getConnection();
			psmt = con.prepareStatement(Sql.UPDATE_ARTICLE);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, no);
			
			psmt.executeUpdate();
			
			close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return result;
	}
	
	public void updateArticleHit(String no) {
		
		try {
			logger.info("updateArticleHit");
			con = getConnection();
		    psmt = con.prepareStatement(Sql.UPDATE_ARTICLE_HIT);
		    psmt.setString(1, no);
		    
		    psmt.executeUpdate();
		    
		    close();
		    
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
	}
	
	public void updateFileDownload(int fno) {
		
		try {
			logger.info("updateFileDownload");
			con = getConnection();
		    psmt = con.prepareStatement(Sql.UPDATE_FILE_DOWNLOAD);
		    psmt.setInt(1, fno);
		    
		    psmt.executeUpdate();
		    
		    close();
		    
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public int updateComment(String content, String no, String rdate) {
		int result = 0;
		try {
			logger.info("updateComment");
			con = getConnection();
			psmt = con.prepareStatement(Sql.UPDATE_COMMENT);
			psmt.setString(1, content);
			psmt.setString(2, rdate);
			psmt.setString(3, no);
			
		    result = psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return result;
	}

	public int deleteComment(String no) {
		int result = 0;
		
		try {
			logger.info("deleteComment");
			con = getConnection();
			
			con.setAutoCommit(false);
			
			PreparedStatement deletePsmt = con.prepareStatement(Sql.UPDATE_COMMENT_MINUS);
			psmt = con.prepareStatement(Sql.DELETE_COMMENT);
			
			deletePsmt.setString(1, no);
			psmt.setString(1, no);
			
			deletePsmt.executeUpdate();
		    result = psmt.executeUpdate();
			
		    con.commit();
		    
			close();
			deletePsmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return result;
	}
	
	public String deleteFile(String no) {
		
		String newName = null;
		
		try {
			logger.info("deleteFile");
			con = getConnection();
			con.setAutoCommit(false);
			
			PreparedStatement psmt1 = con.prepareStatement(Sql.SELECT_FILE);
			PreparedStatement psmt2 = con.prepareStatement(Sql.DELETE_FILE);
			
			psmt1.setString(1, no);
			psmt2.setString(1, no);
			
		    rs = psmt1.executeQuery();
		    psmt2.executeUpdate();
		    
		    con.commit();
			
		    if(rs.next()) {
		    	newName = rs.getString(3);
		    }
			
		    close();
		    psmt1.close();
		    psmt2.close();
		    
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return newName;
	}
	
	public void deleteArticle(String no) {
		
		try {
			logger.info("deleteArticle");
			con = getConnection();
			psmt = con.prepareStatement(Sql.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			
		    psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	// 게시글, 댓글 , 파일 데이터 삭제
	public void deleteArticleFile(String no) {
		
		try {
			logger.info("deleteArticleFile");
			con = getConnection();
			psmt = con.prepareStatement(Sql.DELETE_ARTICLE_FILE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			
			psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public void deleteAllImg(String no) {
		
		try {
			logger.info("deleteImg");
			con = getConnection();
			
			String sql = "DELETE FROM `board_file` WHERE `parent`=? and `oriName`= '삽입 이미지'";
			
			PreparedStatement psmt = con.prepareStatement(sql);
			psmt.setString(1, no);
			
			psmt.executeUpdate();
		 
			close();
		    
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public void deleteSelectedImg(String no, String[] fileNames) {
		try {
			logger.info("deleteSelectedImg");
			con = getConnection();
			
			String sql = "DELETE FROM `board_file` WHERE `parent`=? and `oriName`= '삽입 이미지'"
					   + " and `newName` NOT IN (";
			
			for(int i=0; i<fileNames.length; i++) {
				if(i == fileNames.length-1) {
					sql += "?)";
					break;
				}
				sql += "?,";
			}
			
			PreparedStatement psmt = con.prepareStatement(sql);
			
			psmt.setString(1, no);
			
			int num = 2;
			for(int i=0; i<fileNames.length; i++) {
				psmt.setString(num++, fileNames[i]);
			}
			
			psmt.executeUpdate();
			
		    close();
		    
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public List<FileBean> selectImg(String parent) {
		
		List<FileBean> files = null;
		
		try{
			logger.info("selectImg");
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_FILE_IMG);
			psmt.setString(1, parent);
			
			rs = psmt.executeQuery();
			
			files = new ArrayList<>();
			
			while(rs.next()){
				FileBean fb = new FileBean();
				fb.setFno(rs.getInt(1));
				fb.setParent(rs.getInt(2));
				fb.setNewName(rs.getString(3));
				fb.setOriName(rs.getString(4));
				fb.setDownload(rs.getInt(5));
				
				files.add(fb);
			}
			
			close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return files;
	}
}
