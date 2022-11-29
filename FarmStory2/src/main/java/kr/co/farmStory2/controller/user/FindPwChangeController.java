package kr.co.farmStory2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.farmStory2.service.user.UserService;
import kr.co.farmStory2.utils.JSFunction;

@WebServlet("/user/findPwChange.do")
public class FindPwChangeController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String requestUrl = req.getHeader("referer");
		if(requestUrl == null) { // 주소창에 직접 입력한 경우
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
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass1");
		
		
		int result = service.updateUserPw(uid, pass);
		
		// JSON 출력
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}

}
