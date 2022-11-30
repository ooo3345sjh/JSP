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
import kr.co.farmStory2.vo.ArticleVO;

@WebServlet("/comment/write.do")
public class WriteController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private CommentService service = CommentService.INSTANCE;
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("WriteController doGet...");
		JSFunction.alertBack(resp, "비정상적인 접근입니다.");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("WriteController doPost...");
		
		String no = req.getParameter("no"); 			// 게시글 번호
		String uid = req.getParameter("uid");			// 회원 ID
		String comment = req.getParameter("comment");  	// 댓글 내용
		String regip = req.getRemoteAddr();				// 회원 IP
		
		ArticleVO vo = new ArticleVO();
		vo.setNo(no);
		vo.setUid(uid);
		vo.setContent(comment);
		vo.setRegip(regip);
		
		Map<String, Object> map = service.insertComment(vo); // 댓글을 DB에 등록하는 서비스
		service.plusComment(no);							 // 댓글 갯수 +1
		
		JsonObject json = new JsonObject();
		json.addProperty("result", (int)map.get("result"));	 // 등록 결과 성공 유무 결과값 전송(1:성공 0:실패)
		json.addProperty("no", (int)map.get("no"));			 // 댓글 번호
		json.addProperty("rdate", (String)map.get("rdate")); // 댓글 등록 날짜
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());						 // JSON 데이터 전송
	}
}
