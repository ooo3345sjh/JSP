package kr.co.jboard2.dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.util.buf.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBHelper;
import kr.co.jboard2.db.Sql;
import kr.co.jboard2.vo.ArticleVO;
import kr.co.jboard2.vo.FileVO;

public class ArticleDAO extends DBHelper {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	//====== list ======//
	/*** 검색 조건에 해당하는 게시판 전체 개수 구하는 메서드 ***/
	public int countArticles(Map<String, Object> map) {
		int totalCount = 0; // 전체 게시물 저장 변수 
		
		try {
			
			logger.info("countArticles...");
			
			String searchField = (String)map.get("searchField");
			String searchWord = (String)map.get("searchWord");
		
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(a.`no`) FROM `board_article` a JOIN `board_user` u "
						+ "ON a.`uid` = u.`uid` "
						+ "WHERE `parent` = 0 ");
			if(searchWord != null) {                                // 검색 단어가 있을 경우
				if("nick".equals(searchField)) { 					// 검색 필드가 nick인 경우
					sql.append("AND u.`" + searchField  + "` ");
				} else {											// 검색 필드가 title, content인 경우
					sql.append("AND a.`" + searchField  + "` ");
				}
				
				sql.append("LIKE '%" + searchWord   + "%'");  
			}
				
		
			con = getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql.toString());
			if(rs.next()) {
				totalCount = rs.getInt(1);
			}
			
			close();
		
		} catch (Exception e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		}
		logger.debug("totalCount : " + totalCount);
		return totalCount;
	};
	
	/*** 검색 조건에 맞는 게시물 목록을 반환하는 메서드 ***/
	public Map<String, Object> selectListPage(Map<String, Object> map){
		List<ArticleVO> lists = null;
		
		String sql = "SELECT a.*, u.`nick` FROM `board_article` a JOIN "
				   + "`board_user` u ON a.`uid` = u.`uid` "
				   + "WHERE `parent`=0 ";
		
		// 검색 조건이 있다면 WHERE절 추가
		if(map.get("searchField") != null) {
			sql += "AND `" + map.get("searchField") + "` LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		sql += "ORDER BY `no` desc  LIMIT ?, 10";
		
		try {
			logger.info("selectListPage...");
			con = getConnection();
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, (int)map.get("limitStart"));
			lists = new ArrayList<>();
			
			rs = psmt.executeQuery();
			
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
				vo.setRdate(rs.getString(11).substring(2, 10));
				vo.setNick(rs.getString(12));
				
				lists.add(vo);
			}
			
			map.put("articles", lists);
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
				
		logger.debug("map : " + map);
		return map;
	}
	
	//====== write ======//
	/*** 글을 등록하는 메서드 ***/
	public int insertArticleAndFile(ArticleVO aVo, FileVO fVo) {
		int result = 0;
		try {
			logger.info("insertArticle");
			con = getConnection();
			
			con.setAutoCommit(false);
			psmt = con.prepareStatement(Sql.INSERT_ARTICLE);
			psmt.setString(1, aVo.getTitle());
			psmt.setString(2, aVo.getContent());
			psmt.setInt(3, aVo.getFile());
			psmt.setString(4, aVo.getUid());
			psmt.setString(5, aVo.getRegip());
			
			result = psmt.executeUpdate();
			
			PreparedStatement insertFilePsmt = null;
			if(fVo != null) {
				insertFilePsmt = con.prepareStatement(Sql.INSERT_FILE);
				insertFilePsmt.setString(1, fVo.getNewName());
				insertFilePsmt.setString(2, fVo.getOriName());
				result = insertFilePsmt.executeUpdate();
			}
			
			con.commit();
			
			insertFilePsmt.close();
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		
		logger.debug("result : " + result);
		return result;
	};
	
	/*** 파일을 등록하는 메서드 ***/
	/*public int insertFile(FileVO vo) {
		int result = 0;
		try {
			logger.info("insertFile...");
			con = getConnection();
			psmt = con.prepareStatement(Sql.INSERT_FILE);
			psmt.setInt(1, vo.getParent());
			psmt.setString(2, vo.getNewName());
			psmt.setString(3, vo.getOriName());
			
			result = psmt.executeUpdate();
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("result : " + result);
		return result;
	};*/
	
	
	//====== view ======//
	/*** 조건에 해당하는 게시물을 가져오는 메서드 ***/
	public Map<String, Object> selectArticle(int no) {
		Map<String, Object> map = null;
		List<ArticleVO> comments = null;
		ArticleVO vo = null;
		try {
			logger.info("selectArticle...");
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_ARTICLE);
			psmt.setInt(1, no);
			psmt.setInt(2, no);
			rs = psmt.executeQuery();
			comments = new ArrayList<>();
			map = new HashMap<>();
			
			while(rs.next()) {
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
				vo.setRdate(rs.getString(11).substring(2, 10));
				vo.setFileName(rs.getString(12));
				vo.setDownload(rs.getInt(13));
				vo.setNick(rs.getString(14));
				if(vo.getNo() == no) {
					map.put("board", vo);
					logger.debug("board : " + vo);
				} else if(vo.getParent() != 0) {
					comments.add(vo);
				}
			}
			
			map.put("comments", comments);
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		logger.debug("map : " + map);
		logger.debug("comments : " + comments);
		return map;
	};
	
	/*** 조건에 해당하는 게시물 조회수를 올리는 메서드 ***/
	public void plusHit(int no) {
		try {
			logger.info("plusHit...");
			con = getConnection();
			psmt = con.prepareStatement(Sql.PLUS_HIT);
			psmt.setInt(1, no);
			psmt.executeUpdate();
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	//====== view - download ======//
	/*** 조건에 해당하는 파일을 가져오는 메서드 ***/
	public FileVO selectFile(int no) {
		FileVO vo = null;
		
		try {
			logger.info("selectFile...");
			con = getConnection();
			psmt = con.prepareStatement(Sql.SELECT_FILE);
			psmt.setInt(1, no);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new FileVO();
				vo.setFno(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setNewName(rs.getString(3));
				vo.setOriName(rs.getString(4));
				vo.setDownload(rs.getInt(5));
			}
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo : " + vo);
		return vo;
	}
	
	/*** 파일 다운로드 수 +1 ***/
	public void plusDownload(int no) {
		try {
			logger.info("plusDownload...");
			con = getConnection();
			psmt = con.prepareStatement(Sql.PLUS_DOWNLOAD);
			psmt.setInt(1, no);
			
			psmt.executeUpdate();
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	//====== delelte ======//
	/*** 조건에 해당하는 게시판 및 관련 파일, 댓글을 삭제하는 메서드 ***/
	public Map<String, Object> deleteArticle(int no) {
		Map<String, Object> map = null;
 		int result = 0;
 		String newName = null;
 		
		try {
			logger.info("deleteArticle...");
			
			con = getConnection();
			con.setAutoCommit(false);
			
			PreparedStatement selectPsmt = con.prepareStatement(Sql.SELECT_FILE);
			selectPsmt.setInt(1, no);
			
			rs = selectPsmt.executeQuery();
			if(rs.next()) {
				newName = rs.getString("newName");
			}
				
			psmt = con.prepareStatement(Sql.DELETE_ARTICLE);
			psmt.setInt(1, no);
			psmt.setInt(2, no);
			
			result = psmt.executeUpdate();
			
			con.commit();
			
			map = new HashMap<>();
			map.put("newName", newName);
			map.put("result", result);
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("map : " + map);
		return map;
	};
	
	//====== update ======//
	// 조건에 해당하는 게시물 수정
	/*** 글을 수정하는 메서드 ***/
	public int updateArticleAndFile(ArticleVO aVo, FileVO fVo, boolean newSave) {
		int result = 0;
		try {
			logger.info("updateArticleAndFile...");
			con = getConnection();
			
			con.setAutoCommit(false);
			String sql = "UPDATE `board_article` SET `title`=?, `content`=?, `rdate`=NOW() ";
			if(newSave) {
				sql += ", `file`=1 ";
			}
			sql += "WHERE `no`=? ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, aVo.getTitle());
			psmt.setString(2, aVo.getContent());
			psmt.setInt(3, aVo.getNo());
			
			result = psmt.executeUpdate();
			
			PreparedStatement updateFilePsmt = null;
			PreparedStatement insertFilePsmt = null;
			if(fVo != null) {
				if(!newSave) {
					updateFilePsmt = con.prepareStatement(Sql.UPDATE_FILE);
					updateFilePsmt.setString(1, fVo.getNewName());
					updateFilePsmt.setString(2, fVo.getOriName());
					updateFilePsmt.setInt(3, aVo.getNo());
					result = updateFilePsmt.executeUpdate();
					
				} else {
					insertFilePsmt = con.prepareStatement(Sql.UPDATE_ADD_FILE);
					insertFilePsmt.setInt(1, aVo.getNo());
					insertFilePsmt.setString(2, fVo.getNewName());
					insertFilePsmt.setString(3, fVo.getOriName());
					result = insertFilePsmt.executeUpdate();
				}
			}
			
			con.commit();
			
			updateFilePsmt.close();
			insertFilePsmt.close();
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		
		logger.debug("result : " + result);
		return result;
	};
	/*
	// 조건에 해당하는 파일 삭제
	public Map<String, Object> deleteFile(int parent) {
		Map<String, Object> map = null;
		int result = 0;
		String newName = null;
		try {
			logger.info("deleteFile...");
			con = getConnection();
			con.setAutoCommit(false);
			
			PreparedStatement selectPsmt = con.prepareStatement(Sql.SELECT_FILE);
			selectPsmt.setInt(1, parent);
			
			rs = selectPsmt.executeQuery();
			if(rs.next()) {
				newName = rs.getString("newName");
			}
			
			psmt = con.prepareStatement(Sql.DELETE_FILE);
			psmt.setInt(1, parent);
			result = psmt.executeUpdate();
			
			con.commit();
			map = new HashMap<>();
			map.put("result", result);
			map.put("newName", newName);
			
			selectPsmt.close();
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("map : " + map);
		return map;
	};*/
	public void selectArticle() {};
}
