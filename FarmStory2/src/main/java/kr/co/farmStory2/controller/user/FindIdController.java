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
import kr.co.farmStory2.vo.UserVO;

@WebServlet("/user/findId.do")
public class FindIdController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("FindIdController doGet...");
		req.getRequestDispatcher("/board/user/findId.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("FindIdController doPost...");
		
		String name = req.getParameter("name");		// 회원 이름
		String email = req.getParameter("email");	// 회원 이메일
		
		UserVO vo = service.selectUserForFindId(name, email); // 이름과 이메일이 일치하는 회원정보 반환
		
		JsonObject json = new JsonObject();
		
		if(vo != null) {
			json.addProperty("result", 1); // 회원정보가 있으면 1
		} else {
			json.addProperty("result", 0); // 회원정보가 없으면 0
		}
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());	   // JSON 데이터 전송
	
	}

}
