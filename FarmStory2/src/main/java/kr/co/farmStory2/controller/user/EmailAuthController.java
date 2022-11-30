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

@WebServlet("/user/emailAuth.do")
public class EmailAuthController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("EmailAuthController doGet...");
		
		String email = req.getParameter("email");			// 입력한 이메일 
		String findId_Pw = req.getParameter("findId_Pw");	// 
		
		int checkEmail = service.checkEmail(email);
		int[] result = null;
		
		// 회원가입시 실행(중복확인 후 중복되는 이메일이 없으면 실행)
		if(checkEmail != 1) {						
			result = service.sendEmailCode(email);
		}
		
		// 아이디 및 비밀번호 찾기시 실행
		if("true".equals(findId_Pw)) {
			result = service.sendEmailCode(email);
		}
		
		// JSON 출력
		JsonObject json = new JsonObject();
		if(result != null) {
			json.addProperty("status", result[0]);
			json.addProperty("code", result[1]);
		} else {
			json.addProperty("status", 0);
		}
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());			// JSON 데이터 전송
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
