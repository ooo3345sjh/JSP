package kr.co.farmStory2.service.board;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmStory2.dao.CommentDAO;
import kr.co.farmStory2.vo.ArticleVO;

public enum CommentService {
	INSTANCE;
	private CommentDAO dao;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private CommentService() {
		dao = new CommentDAO();
	}
	
	public Map<String, Object> insertComment(ArticleVO vo) {
		logger.info("insertComment...");
		return dao.insertComment(vo);
	}
	
	public int deleteComment(String no) {
		logger.info("deleteComment...");
		return dao.deleteComment(no);
	}
	
	public int updateComment(String no, String comment) {
		logger.info("updateComment...");
		return dao.updateComment(no, comment);
	}
	
	
	
	
}
