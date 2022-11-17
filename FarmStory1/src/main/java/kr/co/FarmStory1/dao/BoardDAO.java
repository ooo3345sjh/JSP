package kr.co.FarmStory1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.FarmStory1.db.DBHelper;
import kr.co.FarmStory1.db.Sql;
import kr.co.FarmStory1.vo.ArticleVO;
import kr.co.FarmStory1.vo.FileVO;

public class BoardDAO extends DBHelper {
	
	private static BoardDAO instance = new BoardDAO();
	
	public static BoardDAO getInstance() {
		return instance;
	}
	private BoardDAO() {}
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public int selectArticleCountTotal(String cate) {
		int total = 0;
		
		try {
			logger.info("selectArticleCountTotal");
			con = getConnection();
			String sql = "SELECT COUNT(`no`) FROM `board_article` "
					   + " WHERE `cate`=? ";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, cate);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("total : " + total);
		return total;
		
	}
	public List<ArticleVO> selectArticles(String cate, int limitStart) {
		List<ArticleVO> articles = null;
		
		try {
			logger.info("selectArticles");
			con = getConnection();
			String sql = "SELECT a.*, u.nick FROM `board_article` a "
					   + " JOIN `board_user` u "
					   + " ON a.uid = u.uid "
					   + " WHERE a.cate=? and a.parent=0 "
					   + " ORDER BY a.`no` desc"
					   + " limit ?, 10 ";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, cate);
			psmt.setInt(2, limitStart);
			rs = psmt.executeQuery();
			articles = new ArrayList<>();
			
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRegip(rs.getString(10));
				vo.setRdate(rs.getString(11));
				vo.setNick(rs.getString(12));
				
				articles.add(vo);
			}
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("articles : " + articles.size());
		return articles;
	}
	
	public ArticleVO selectArticle(String no) {
		
		ArticleVO vo = null;
		try {
			logger.info("selectArticle");
			con = getConnection();
			String sql = "SELECT a.*, f.`oriName`, f.`download` FROM `board_article` a "
				       + "LEFT JOIN `board_file` f "
				       + "ON a.`no`= f.`parent` "
				       + "WHERE `no`=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, no);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRegip(rs.getString(10));
				vo.setRdate(rs.getString(11));
				vo.setFname(rs.getString(12));
				vo.setDownload(rs.getInt(13));
			}
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo : " + vo.toString());
		return vo;
	}
	
	public Map<String, List<ArticleVO>> selectLatests(String cate1, String cate2, String cate3){
		Map<String, List<ArticleVO>> map = new HashMap<>();
		
		List<ArticleVO> latestsGrow = new ArrayList<>();
		List<ArticleVO> latestsSchool = new ArrayList<>();
		List<ArticleVO> latestsStory = new ArrayList<>();
		
		
		try {
			logger.info("selectLatests...");
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_LATESTS);
			psmt.setString(1, cate1);
			psmt.setString(2, cate2);
			psmt.setString(3, cate3);
			
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setRdate(rs.getString(3).substring(2, 10));
				vo.setCate(rs.getString(4));
				
				switch(vo.getCate()) {
					case "grow": latestsGrow.add(vo); break;
					case "school": latestsSchool.add(vo); break;
					case "story": latestsStory.add(vo); break;
				}
			}
			map.put("grow", latestsGrow);
			map.put("school", latestsSchool);
			map.put("story", latestsStory);
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return map;
	}
	
	public synchronized List<ArticleVO> selectLatests(String cate){
		List<ArticleVO> latests = new ArrayList<>();
		
		try {
			logger.info("selectLatests(String)...");
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_LATEST);
			psmt.setString(1, cate);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setRdate(rs.getString(3).substring(2, 10));
				
				latests.add(vo);
			}
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		return latests;
	}
	
	public FileVO selectFile(String parent) {
		FileVO vo = null;
		
		try {
			con = getConnection();
			con.setAutoCommit(false);
			String sql = "SELECT * FROM `board_file` WHERE `parent`=?";
			String updateDownloadCount = "UPDATE `board_file` SET "
									   + " `download` = `download` + 1 "
									   + "WHERE `parent` = ? ";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, parent);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new FileVO();
				vo.setFno(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setNewName(rs.getString(3));
				vo.setOriName(rs.getString(4));
				vo.setDownload(rs.getInt(5));
			}
			PreparedStatement updatePsmt = con.prepareStatement(updateDownloadCount);
			updatePsmt.setString(1, parent);
			updatePsmt.executeUpdate();
			con.commit();
			
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo : " + vo);
		return vo;
	}
	
	public List<ArticleVO> selectComments(String parent) {
		List<ArticleVO> comments = new ArrayList<>();
		try {
			logger.info("selectComments");
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_COMMENTS);
			psmt.setString(1, parent);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticleVO ab = new ArticleVO();
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
	
	public void insertFile(int parent, String newName, String oriName) {
		try {
			logger.info("insertFile");
			con = getConnection();
			String sql = "INSERT INTO `board_file` SET"
					   + "	`parent` = ?, "
					   + "	`newName` = ?, "
					   + "	`oriName` = ?";
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, parent);
			psmt.setString(2, newName);
			psmt.setString(3, oriName);
			
			psmt.executeUpdate();
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
	public int insertArticle(ArticleVO vo) {
		int no = 0;
		
		try {
			logger.info("insertArticle");
			con = getConnection();
			con.setAutoCommit(false);
			String sql = "INSERT INTO `board_article` SET "
					   + " `cate`=?, "
					   + " `title`=?, "
					   + " `content`=?, "
					   + " `uid`=?, "
					   + " `regip`=?, "
					   + " `rdate`=NOW() ";
			
			String MaxNoSql = "SELECT MAX(`no`) FROM `board_article`";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, vo.getCate());
			psmt.setString(2, vo.getTitle());
			psmt.setString(3, vo.getContent());
			psmt.setString(4, vo.getFname() == null ? "0":"1");
			psmt.setString(4, vo.getUid());
			psmt.setString(5, vo.getRegip());
			
			stmt = con.createStatement();
			
			psmt.executeUpdate();
			rs = stmt.executeQuery(MaxNoSql);
			
			con.commit();
			
			if(rs.next()) {
				no = rs.getInt(1);
			}
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("no : " + no);
		return no;
	}
	
	public Map<String, Integer> insertComment(ArticleVO vo) {
		
		logger.info("insertComment");
		
		Map<String, Integer> map = null;
		
		int result = 0; // 업데이트 결과 성공 여부를 전달하는 변수 성공 : 1 / 실패 : 0
		
		try{
			// 1, 2단계 - DB 접속
			Connection con = getConnection();
			
			/*** 트랜잭션 시작 ***/
			con.setAutoCommit(false);
			
			// 3단계 - SQL실행 객체 생성
			PreparedStatement updatePsmt = con.prepareStatement(Sql.UPDATE_ARTICLE_COMMENT_PLUSE);
			updatePsmt.setInt(1, vo.getParent());
			
			PreparedStatement insertPsmt = con.prepareStatement(Sql.INSERT_COMMENT);
			insertPsmt.setInt(1, vo.getParent());
			insertPsmt.setString(2, vo.getContent());
			insertPsmt.setString(3, vo.getUid());
			insertPsmt.setString(4, vo.getRegip());
			
			Statement selectPsmt = con.createStatement();
				
			// 4단계 - SQL실행
			updatePsmt.executeUpdate();
			result = insertPsmt.executeUpdate();
			ResultSet rs = selectPsmt.executeQuery(Sql.SELECT_NO);
			
			map = new HashMap<>();
			
			if(rs.next()) {
				map.put("no", rs.getInt(1));
			}
			
			con.commit(); 
			/*** 트랜잭션 종료 ***/
			
			// 5단계 - 연결 해제
			con.close();
			insertPsmt.close();
			updatePsmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		map.put("result", result);
	
		return map;
	}
	
	public void deleteArticle(String no) {
		try {
			logger.info("deleteArticle");
			con = getConnection();
			String sql = "DELETE a.*, f.* FROM `board_article` a "
					   + "LEFT JOIN `board_file` f "
					   + "ON a.`no` = f.`parent` "
					   + "WHERE a.`no`=? or a.`parent`=? ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, no);
			psmt.setString(2, no);
			
			psmt.executeUpdate();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
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
	public void updateArticle(String no, String title, String content) {
		
		try {
			con = getConnection();
			String sql = "UPDATE `board_article` SET "
						+ " `title`=?,"
						+ " `content`=?"
						+ "WHERE `no`=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, no);
			
			psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
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
	
	public int updateComment(String content, String no) {
		int result = 0;
		try {
			logger.info("updateComment");
			con = getConnection();
			psmt = con.prepareStatement(Sql.UPDATE_COMMENT);
			psmt.setString(1, content);
			psmt.setString(2, no);
			
		    result = psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
		
		return result;
	}
}
