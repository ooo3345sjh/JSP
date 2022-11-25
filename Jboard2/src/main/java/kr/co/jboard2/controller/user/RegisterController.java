package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.service.user.UserService;
import kr.co.jboard2.utils.JSFunction;
import kr.co.jboard2.vo.UserVO;

@WebServlet("/user/register.do")
public class RegisterController extends HttpServlet {
	
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
			if(requestUrl.contains("terms.do")) {
				req.getRequestDispatcher("/user/register.jsp").forward(req, resp);
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
		String name = req.getParameter("name");
		String nick = req.getParameter("nick");
		String email = req.getParameter("email");
		String hp = req.getParameter("hp");
		String zip = req.getParameter("zip");
		String addr1 = req.getParameter("addr1");
		String addr2 = req.getParameter("addr2");
		String regip = req.getRemoteAddr();
		
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
		
		service.insertUser(vo);
		
		resp.sendRedirect(req.getContextPath() + "/user/login.do");
		
	}

}
