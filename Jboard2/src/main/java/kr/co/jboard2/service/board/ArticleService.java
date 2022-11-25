package kr.co.jboard2.service.board;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.dao.ArticleDAO;

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
	
	public void selectArticle() {}
	public void selectArticles() {}
	public void insertArticle() {}
	public void updateArticle() {}
	public void deleteArticle() {}
}
