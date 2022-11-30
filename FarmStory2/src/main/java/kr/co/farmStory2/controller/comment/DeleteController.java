package kr.co.farmStory2.controller.comment;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.JsonObject;

import kr.co.farmStory2.service.board.CommentService;
import kr.co.farmStory2.utils.JSFunction;

@WebServlet("/comment/delete.do")
public class DeleteController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private CommentService service = CommentService.INSTANCE;
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		JSFunction.alertBack(resp, "비정상적인 접근입니다.");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("DeleteController...");
		String no = req.getParameter("commentNo");	// 댓글 번호
		service.minusComment(no);					// 댓글 갯수 -1
		int result = service.deleteComment(no);		// 댓글 삭제하는 서비스
		
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());				// JSON 데이터 전송
	}
}
