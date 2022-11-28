package kr.co.jboard2.controller.comment;

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

import kr.co.jboard2.service.board.CommentService;
import kr.co.jboard2.utils.JSFunction;
import kr.co.jboard2.vo.ArticleVO;

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
		JSFunction.alertBack(resp, "비정상적인 접근입니다.");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		String uid = req.getParameter("uid");
		String comment = req.getParameter("comment");
		String regip = req.getRemoteAddr();
		
		ArticleVO vo = new ArticleVO();
		vo.setNo(no);
		vo.setUid(uid);
		vo.setContent(comment);
		vo.setRegip(regip);
		
		Map<String, Object> map = service.insertComment(vo);
		
		JsonObject json = new JsonObject();
		json.addProperty("result", (int)map.get("result"));
		json.addProperty("no", (int)map.get("no"));
		json.addProperty("rdate", (String)map.get("rdate"));
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
}
