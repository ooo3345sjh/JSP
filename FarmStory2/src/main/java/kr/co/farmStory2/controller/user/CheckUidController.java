package kr.co.farmStory2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.JsonObject;

import kr.co.farmStory2.service.user.UserService;


@WebServlet("/user/checkUid.do")
public class CheckUidController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private UserService service = UserService.INSTANCE;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("CheckUidController doGet...");
		
		String uid = req.getParameter("uid"); // 입력한 ID
		int result = service.checkUser(uid);  // DB에서 입력한 ID와 일치하는 회원 ID가 있는지 확인하는 서비스 (중복되는 회원이 있으면 1을 반환)
		
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());			// JSON 데이터 전송
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
