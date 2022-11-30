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

@WebServlet("/comment/modify.do")
public class ModifyController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private CommentService service = CommentService.INSTANCE;
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("ModifyController doGet...");
		JSFunction.alertBack(resp, "비정상적인 접근입니다.");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("ModifyController doPost...");
		
		String no = req.getParameter("commentNo");			// 댓글 번호
		String comment = req.getParameter("comment");		// 댓글 내용
		int result = service.updateComment(no, comment);	// 댓글 내용을 수정하는 서비스
		
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());						// JSON 데이터 전송
	}
}
