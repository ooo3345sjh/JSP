package kr.co.jboard2.service.board;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
		return dao.selectListPage(map);
	}
	/*** 페이지 태그 문자열을 반환하는 메서드  ***/
	public String getPageTags(Map<String, Object> map) {
		int pageGroupStart   = (int)map.get("pageGroupStart");
		int pageGroupEnd     = (int)map.get("pageGroupEnd");
		int pageGroupCurrent = (int)map.get("pageGroupCurrent");
		int currentPage      = (int)map.get("currentPage");
		int lastPageNum      = (int)map.get("lastPageNum");

		StringBuffer pageTags = new StringBuffer(); // 페이지 태그 모음
		int prevPage = pageGroupStart - 1;    // 이전 페이지
		int nextPage = pageGroupEnd + 1;      // 다음 페이지
		String contextPath = ((HttpServletRequest)map.get("request")).getContextPath();
		
		// 이전 페이지 tag 
		if(pageGroupCurrent > 1) {
			
			String uri = "<a href=\"" + contextPath + "\"list.do?pageNum=" 
					   + prevPage + "\">이전페이지</a>&nbsp;";

			pageTags.append(uri);
		}
		
		for(int i=pageGroupStart; i<=pageGroupEnd; i++) {
			if(currentPage == i) { // 현재 페이지와 값이 같다면 링크X
				pageTags.append(String.valueOf(i) + "&nbsp;");
			} else {
				String uri = "<a href=\"" + contextPath + "\"list.do?pageNum=" + i + "\">"
						   + String.valueOf(i) + "</a>$nbsp;"; 
				pageTags.append(uri);
			}
		}
		
		if(pageGroupEnd < lastPageNum) { // 반복문의 마지막이며 마지막 페이지 번호보다 작을 경우
			String uri = "<a href=\"" + contextPath + "\"list.do?pageNum=" 
		               + nextPage + "\">다음페이지</a>";
			
			pageTags.append(uri);
		}
		
		return pageTags.toString();
		
	}
	
	public void selectArticle() {}
	public void selectArticles() {}
	public void insertArticle() {}
	public void updateArticle() {}
	public void deleteArticle() {}
}
