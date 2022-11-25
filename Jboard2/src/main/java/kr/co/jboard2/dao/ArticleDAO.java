package kr.co.jboard2.dao;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.db.DBHelper;

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
	
	public void selectArticles() {};
	public void selectArticle() {};
	public void insertArticle() {};
	public void updateArticle() {};
	public void deleteArticle() {};
}
