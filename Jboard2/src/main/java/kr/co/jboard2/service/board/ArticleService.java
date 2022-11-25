package kr.co.jboard2.service.board;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.vo.ArticlesVO;

public enum ArticleService {
	INSTANCE;
	private ArticleDAO dao;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private ArticleService() {
		dao = new ArticleDAO();
	}
	
	/*** 게시판 리스트 ***/
	public int countArticles(Map<String, Object> map) {
		return dao.countArticles(map);
	}
	
	/*** 검색 조건에 맞는 게시물 목록을 반환한다.  ***/
	public Map<String, Object> selectListPage(Map<String, Object> map){
		List<ArticlesVO> articles = new ArrayList<>();
		
		String sql = "SELECT * FROM `board_article` a JOIN "
				   + "`board_user` u ON a.`uid` = u.`uid` ";
		
		// 검색 조건이 있다면 WHERE절 추가
		if(map.get("searchField") != null) {
			sql += "WHERE " + map.get("searchField");
		}
				
		return map;
	}
	
	public void selectArticle() {}
	public void selectArticles() {}
	public void insertArticle() {}
	public void updateArticle() {}
	public void deleteArticle() {}
}
