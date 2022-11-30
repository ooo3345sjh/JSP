package kr.co.farmStory2.controller.board;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmStory2.service.board.ArticleService;
import kr.co.farmStory2.utils.JSFunction;


@WebServlet("/board/delete.do")
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
		
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		
		int no = Integer.parseInt(req.getParameter("no"));   // 게시물 번호
		Map<String, Object> map = service.deleteArticle(no); // 게시물 삭제 서비스
		int result = (int)map.get("result");
		String newName = (String)map.get("newName");
		
		if(result > 0) { // 게시물 삭제 성공
			
			if(newName != null) { // 파일이 있다면
				service.deleteFile(req, "/file", newName);
			}
			
			resp.sendRedirect(req.getContextPath() + "/board/list.do?group=" + group + "&cate" + cate);
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

