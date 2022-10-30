package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

/*
 * 날짜 : 2022/10/30
 * 이름 : 서정현
 * 내용 : 서블릿 클래스(컨트롤러)
 */

public class ListController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// DAO 생성
		MVCboardDAO dao = new MVCboardDAO();
		
		// 뷰에 전달할 매개변수 저장용 맵 생성
		Map<String , Object> map = new HashMap<>(); 
		
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		
		// 1단계 : 검색 버튼을 누르면 null이 아님 -> 2단계 : 검색 내용 O - true / 검색 내용 X - false  
		String check = req.getParameter("check"); 
		
		// 세션 생성
		HttpSession session = req.getSession();
		
		if(check != null) { // 검색 버튼을 눌렀다면
			if(check.equals("true")) { // 검색 내용이 있다면
				session.setAttribute("searchField", searchField);
				session.setAttribute("searchWord", searchWord);
			} else { // 검색 내용이 없다면
				session.removeAttribute("searchField");
				session.removeAttribute("searchWord");
			}
		}

		map.put("searchField", session.getAttribute("searchField"));
		map.put("searchWord", session.getAttribute("searchWord"));
		
		/* 페이지 처리 start */
		int totalCount = dao.select(map); // 게시물 개수
		int pageSize = 10; // 페이지당 출력할 페이지 개수
		int lastPageNum = (int)Math.ceil(totalCount / 10.0); // 마지막 페이지 번호 계산
		int currentPage = 1; // 기본값
		int limitStart = 0; // 현재 페이지에서 시작하는 게시물 시작값
		
		int pageGroupCurrent = 1; // 그룹 번호
		int pageGroupStart = 1; // 그룹에서 첫 페이지
		int pageGroupEnd = 0; // 그룹에서 마지막 페이지
		int pageStartNum = 0; // 게시물의 번호 정렬
		
		// 현재 페이지값을 가져온다.
		if(req.getParameter("pageNum") != null && !req.getParameter("pageNum").equals("")) {
			currentPage = Integer.parseInt(req.getParameter("pageNum"));
		}
		
		// 현재 페이지기준 DB상의 첫번째 게시물의 번호 - limit 시작값 계산
		limitStart = (currentPage -1) * pageSize; 
		map.put("limitStart", limitStart);
		
		// 페이지 그룹 계산
		pageGroupCurrent = (int)Math.ceil(currentPage / 10.0); 
		pageGroupStart = (pageGroupCurrent - 1) * pageSize + 1; 
		pageGroupEnd = pageGroupCurrent * pageSize;
		
		if(pageGroupEnd > lastPageNum) { // 마지막 페이지보다 그룹 마지막 페이지가 클 경우
			pageGroupEnd = lastPageNum;
		}
		
		// 게시판에 표시할 페이지 시작 번호 계산
		pageStartNum = totalCount - limitStart; 
		
		/* 페이지 처리 end */
		
		List<MVCBoardDTO> boards = dao.slectListPage(map); // 현재 페이지 게시물 가져오기
		dao.close();
		
		/* 페이지 태그 가져오기 start */
		map.put("pageGroupStart", pageGroupStart);
		map.put("pageGroupEnd", pageGroupEnd);
		map.put("pageGroupCurrent", pageGroupCurrent);
		map.put("currentPage", currentPage);
		map.put("lastPageNum", lastPageNum);
		
		String pageTags = BoardPage.getPageTags(map);
		/* 페이지 태그 가져오기 end */
		
	
		/* 전달할 데이터를 request 영역에 저장 후 List.jsp로 포워드 */
		map.put("pageStartNum", pageStartNum);
		map.put("pageTags", pageTags);
		map.put("boards", boards);
		
		req.setAttribute("map", map);
		req.getRequestDispatcher("/Ch14/P494.jsp").forward(req, resp);
		
	}
}
