package kr.co.jboard2.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.service.board.ArticleService;
import kr.co.jboard2.service.user.UserService;
import kr.co.jboard2.utils.JSFunction;
import kr.co.jboard2.vo.ArticlesVO;

@WebServlet("/list.do")
public class ListController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("ListController...");
		// 뷰에 전달할 매개변수 저장용 맵 생성
		Map<String, Object> map = new HashMap<>();
		
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		
		map.put("searchField", searchField);
		map.put("searchWord", searchWord);
		
		// 페이징 처리 Start
		int totalCount  = service.countArticles(map); // 전체 게시물 개수 
		int pageSize    = 10; // 페이지당 출력할 페이지 개수
		int lastPageNum = (int)Math.ceil(totalCount / 10.0); // 마지막 페이지 번호 계산
		int currentPage = 1;  // 기본값
		int limitStart  = 0;  // 현재 페이지에서 시작하는 게시물 시작값
		
		int pageGroupCurrent = 1; // 그룹 번호
		int pageGroupStart   = 1; // 그룹에서 첫 페이지
		int pageGroupEnd     = 0; // 그룹에서 마지막 페이지
		int pageStartNum     = 0; // 게시물의 번호 정렬
		
		if(req.getParameter("pageNum") != null && !req.getParameter("pageNum").equals("")) {
			currentPage = Integer.parseInt(req.getParameter("pageNum"));
		}
		
		// 현재 페이지 기준 DB상의 첫번째 게시물의 번호 - limit 시작값 계산
		limitStart = (currentPage - 1) * pageSize;
		map.put("limitStart", limitStart);
		
		// 페이지 그룹 계산
		pageGroupCurrent = (int)Math.ceil(currentPage / 10.0);
		pageGroupStart = (pageGroupCurrent - 1) * pageSize + 1;
		pageGroupEnd = pageGroupCurrent * pageSize;
		
		// 마지막 페이지보다 그룹 마지막 페이지가 클 경우
		if(pageGroupEnd > lastPageNum) pageGroupEnd = lastPageNum;
		
		// 게시판에 표시할 시작 번호 계산
		pageStartNum = totalCount - limitStart;
		
		/* 페이지 처리 end */
		
		map = service.selectListPage(map);
		
		/* 페이지 태그 가져오기 start */
		map.put("pageGroupStart", pageGroupStart);
		map.put("pageGroupEnd", pageGroupEnd);
		map.put("pageGroupCurrent", pageGroupCurrent);
		map.put("currentPage", currentPage);
		map.put("lastPageNum", lastPageNum);
		map.put("request", req);
		map.put("pageStartNum", pageStartNum);
		
		String pageTags = service.getPageTags(map);
		map.put("pageTags", pageTags);
		
		/* 페이지 태그 가져오기 End */
		req.setAttribute("map", map);
		req.getRequestDispatcher("/list.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
