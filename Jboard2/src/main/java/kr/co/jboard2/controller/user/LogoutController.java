package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.service.user.UserService;
import kr.co.jboard2.vo.UserVO;

@WebServlet("/user/logout.do")
public class LogoutController  extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 쿠키 삭제
		Cookie cookie = new Cookie("SESSID", "");
		cookie.setPath(req.getContextPath());
		cookie.setMaxAge(0);      
		resp.addCookie(cookie);
		
		req.getSession().removeAttribute("sessUser"); // 회원정보 세션 제거
		req.getSession().invalidate(); // 모든 세션 제거
		resp.sendRedirect(req.getContextPath() + "/user/login.do"); // 로그인 뷰를 보여준다.
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

}
