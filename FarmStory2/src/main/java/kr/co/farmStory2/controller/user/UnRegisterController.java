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

@WebServlet("/user/unregister.do")
public class UnRegisterController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("UnRegisterController...");
		String uid = ((UserVO)req.getAttribute("reqUser")).getUid();
		int result = service.deleteUser(uid);
		
		resp.setContentType("json/application;charset=UTF-8");
		PrintWriter writer = resp.getWriter();
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		writer.print(json.toString());
	}

}
