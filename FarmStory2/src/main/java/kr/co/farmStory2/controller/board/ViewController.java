package kr.co.farmStory2.controller.board;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.farmStory2.service.board.ArticleService;


@WebServlet("/board/view.do")
public class ViewController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int no = Integer.parseInt(req.getParameter("no"));
		Map<String, Object> map = service.selectArticle(no);
		service.plusHit(no);
		
		req.setAttribute("no", no);
		req.setAttribute("searchField", req.getParameter("searchField"));
		req.setAttribute("searchWord", req.getParameter("searchWord"));
		req.setAttribute("pageNum", req.getParameter("pageNum"));
		req.setAttribute("map", map);
		req.getRequestDispatcher("/board/view.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
