package kr.co.jboard2.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBHelper;
import kr.co.jboard2.vo.ArticlesVO;

public class ArticleDAO extends DBHelper {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/*** 게시판 리스트 ***/
	public int countArticles(Map<String, Object> map) {
		
		int totalCount = 0; // 전체 게시물 저장 변수 
		String searchField = (String)map.get("searchField");
		String searchWord = (String)map.get("searchWord");
	
		String sql = "SELECT COUNT(`no`) FROM `board_article` ";
		
		if(searchWord != null) {
			sql += "WHERE `" + searchField  + "` "
				+  "LIKE '%" + searchWord   + "%'";  
		}
				
		try {
			con = getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				totalCount = rs.getInt(1);
			}
			
			close();
		
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("totalCount : " + totalCount);
		return totalCount;
	};
	
	/*** 검색 조건에 맞는 게시물 목록을 반환  ***/
	public Map<String, Object> selectListPage(Map<String, Object> map){
		List<ArticlesVO> lists = null;
		
		String sql = "SELECT a.*, u.`nick` FROM `board_article` a JOIN "
				   + "`board_user` u ON a.`uid` = u.`uid` ";
		
		// 검색 조건이 있다면 WHERE절 추가
		if(map.get("searchField") != null) {
			sql += "WHERE `" + map.get("searchField") + "` LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		sql += "ORDER BY `no` desc  LIMIT ?, 10";
		
		try {
			logger.info("selectListPage...");
			con = getConnection();
			psmt = con.prepareStatement(sql);
			psmt.setString(1, (String)map.get("limitStart"));
			lists = new ArrayList<>();
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ArticlesVO vo = new ArticlesVO();
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
	
	public void selectArticles() {};
	public void selectArticle() {};
	public void insertArticle() {};
	public void updateArticle() {};
	public void deleteArticle() {};
}
