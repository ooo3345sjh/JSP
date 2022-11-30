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
import kr.co.farmStory2.utils.JSFunction;

@WebServlet("/user/findPwChange.do")
public class FindPwChangeController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("FindPwChangeController doGet...");
		
		String requestUrl = req.getHeader("referer");  // 요청하는 uri
		if(requestUrl == null) { 					   // 주소창에 직접 입력한 경우
			JSFunction.alertBack(resp, "비정상적인 접근입니다.");
			return;
		} else {
			if(requestUrl.contains("findPw.do")) { // 요청해온 url가 findPw.do일 경우에만 접근 가능
				String uid = req.getParameter("uid");
				req.setAttribute("uid", uid);
				
				req.getRequestDispatcher("/board/user/findPwChange.jsp").forward(req, resp);
			} else {
				JSFunction.alertBack(resp, "비정상적인 접근입니다.");
				return;
			}
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("FindPwChangeController doPost...");
		
		String uid = req.getParameter("uid");	 // 입력한 ID
		String pass = req.getParameter("pass1"); // 입력한 PW
		
		
		int result = service.updateUserPw(uid, pass); // 입력한 ID에 해당하는 회원의 PW를 변경하는 서비스
		
		// JSON 출력
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}

}
