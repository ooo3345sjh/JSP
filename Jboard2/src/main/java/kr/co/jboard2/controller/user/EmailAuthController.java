package kr.co.jboard2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.jboard2.service.user.UserService;

@WebServlet("/user/emailAuth.do")
public class EmailAuthController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	
	@Override
	public void init() throws ServletException {}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		String findId_Pw = req.getParameter("findId_Pw");
		
		int checkEmail = service.checkEmail(email);
		int[] result = null;
		
		if(checkEmail != 1) {
			result = service.sendEmailCode(email);
		}
		
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
		writer.print(json.toString());
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
