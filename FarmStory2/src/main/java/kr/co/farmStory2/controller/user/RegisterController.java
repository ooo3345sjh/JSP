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

@WebServlet("/user/register.do")
public class RegisterController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("RegisterController doGet...");
		String requestUrl = req.getHeader("referer");
		
		if(requestUrl == null) { // 주소창에 직접 입력한 경우
			JSFunction.alertBack(resp, "비정상적인 접근입니다.");
			return;
		} else {
			if(requestUrl.contains("terms.do")) { // 요청 uri이 terms.do 인경우에만 실행
				req.getRequestDispatcher("/board/user/register.jsp").forward(req, resp);
			} else {
				JSFunction.alertBack(resp, "비정상적인 접근입니다.");
				return;
			}
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("RegisterController doPost...");
		
		String uid = req.getParameter("uid");		// 입력한 ID
		String pass = req.getParameter("pass1");	// 입력한 PW
		String name = req.getParameter("name");		// 입력한 name
		String nick = req.getParameter("nick");		// 입력한 nick
		String email = req.getParameter("email");	// 입력한 email
		String hp = req.getParameter("hp");			// 입력한 hp
		String zip = req.getParameter("zip");		// 입력한 우편번호
		String addr1 = req.getParameter("addr1");	// 입력한 주소1
		String addr2 = req.getParameter("addr2");	// 입력한 주소2
		String regip = req.getRemoteAddr();			// 회원가입하는 유저의 IP
		
		UserVO vo = new UserVO();
		vo.setUid(uid);
		vo.setPass(pass);
		vo.setName(name);
		vo.setNick(nick);
		vo.setEmail(email);
		vo.setHp(hp);
		vo.setZip(zip);
		vo.setAddr1(addr1);
		vo.setAddr2(addr2);
		vo.setRegip(regip);
		
		service.insertUser(vo); // 회원 등록
		
		resp.sendRedirect(req.getContextPath() + "/user/login.do");
		
	}

}
