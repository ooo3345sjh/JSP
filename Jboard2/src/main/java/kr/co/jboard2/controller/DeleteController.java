package kr.co.jboard2.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.service.board.ArticleService;
import kr.co.jboard2.utils.JSFunction;

@WebServlet("/delete.do")
public class DeleteController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private ArticleService service = ArticleService.INSTANCE;

	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("DeleteController doGet...");
		
		/*** 필터링 start ***/
		String fromUrl = req.getHeader("referer"); // 요청을 하는 uri
		
		if(fromUrl == null || !fromUrl.contains("view.do")) { 
			JSFunction.alertBack(resp, "비정상적인 접근입니다.");
			return;
		}
		/*** 필터링 end ***/
		
		int no = Integer.parseInt(req.getParameter("no"));   // 게시물 번호
		Map<String, Object> map = service.deleteArticle(no); // 게시물 삭제 서비스
		int result = (int)map.get("result");
		String newName = (String)map.get("newName");
		
		if(result > 0) { // 게시물 삭제 성공
			if(newName != null) {
				service.deleteFile(req, "/file", newName);
			}
			resp.sendRedirect(req.getContextPath() + "/list.do");
			return;
			
		} else { 		  // 게시물 삭제 실패
			JSFunction.alertBack(resp, "게시물 삭제에 실패 했습니다. 잠시 후 다시 시도 해주세요.");
			return;
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
