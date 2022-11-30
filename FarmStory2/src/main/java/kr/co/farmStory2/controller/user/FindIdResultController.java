package kr.co.farmStory2.controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmStory2.service.user.UserService;
import kr.co.farmStory2.utils.JSFunction;
import kr.co.farmStory2.vo.UserVO;

@WebServlet("/user/findIdResult.do")
public class FindIdResultController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE; 
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("FindIdResultController doGet...");
		JSFunction.alertBack(resp, "비정상적인 접근입니다.");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("FindIdResultController doPost...");
	
		String email = req.getParameter("email");			  // 입력한 이메일
		String name = req.getParameter("name");				  // 입력한 이름
		UserVO vo = service.selectUserForFindId(name, email); // 입력한 이메일과 이름에 해당하는 회원정보를 반환 
		
		req.setAttribute("user", vo);
		
		req.getRequestDispatcher("/board/user/findIdResult.jsp").forward(req, resp);
	}

}
