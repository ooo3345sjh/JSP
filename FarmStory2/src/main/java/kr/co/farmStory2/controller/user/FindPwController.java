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

@WebServlet("/user/findPw.do")
public class FindPwController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("FindPwController doGet...");
		req.getRequestDispatcher("/board/user/findPw.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("FindPwController doPost...");
		
		String uid = req.getParameter("uid");		// 입력한 ID 
		String email = req.getParameter("email");	// 입력한 이메일

		int result = service.selectUserForFindPw(uid, email); // 입력한 ID와 이메일에 해당하는 회원 정보반환
		
		JsonObject json = new JsonObject();
		
		if(result > 0) {
			json.addProperty("result", 1); // 회원 정보가 있으면 1
		} else {
			json.addProperty("result", 0); // 회원 정보가 없으면 0
		}
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());	   // JSON 데이터 전송
	}

}
