package kr.co.jboard2.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
import kr.co.jboard2.service.board.ArticleService;
import kr.co.jboard2.service.user.UserService;
import kr.co.jboard2.utils.JSFunction;
import kr.co.jboard2.vo.ArticleVO;

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
		
		//map.put("isSearch", req.getParameter("isSearch"));       
		map.put("searchField", req.getParameter("searchField"));
		map.put("searchWord", req.getParameter("searchWord"));
		map.put("response", resp);
		map.put("request", req); // request 객체 추가
		
		map = service.paging(map);  			    // 페이징처리
		map.put("pageTags", service.getPageTags(map)); // 페이지 버튼을 출력하는 pageTags 문자열 추가 
		
		
		req.setAttribute("queryString", req.getQueryString());
		req.setAttribute("map", map);
		req.getRequestDispatcher("/list.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
