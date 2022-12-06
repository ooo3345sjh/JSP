package kr.co.farmStory2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.JsonObject;

import kr.co.farmStory2.service.user.UserService;
import kr.co.farmStory2.utils.JSFunction;
import kr.co.farmStory2.vo.UserVO;

@WebServlet("/user/info.do")
public class InfoController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("InfoController doGet...");
		String fromUrl = req.getHeader("referer");
		System.out.println(fromUrl);
		if(fromUrl == null || !fromUrl.contains("index.do")) {
			JSFunction.alertBack(resp, "비정상적인 접근입니다.");
			return;
		}
		req.getRequestDispatcher("/board/user/info.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("InfoController doPost...");
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass");
		
		UserVO vo = null; 
		vo = service.selectUser(uid, pass);
		int result = 0;
		
		if(vo != null) {
			result = 1;
		}
		
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		resp.setContentType("json/application;charset=UTF-8");
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	
	}

}
