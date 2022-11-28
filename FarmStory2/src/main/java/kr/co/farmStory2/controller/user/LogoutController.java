package kr.co.farmStory2.controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.farmStory2.service.user.UserService;

@WebServlet("/user/logout.do")
public class LogoutController  extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String uid = req.getParameter("uid");
		
		// 모든 쿠키 삭제
		Cookie[] cookies = req.getCookies();
		
		for(Cookie cookie : cookies) {
			String key = cookie.getName();
			
			Cookie removeCookie = new Cookie(key, "");
			removeCookie.setPath(req.getContextPath());
			removeCookie.setMaxAge(0);
			
			resp.addCookie(removeCookie);
		}
		
		// 모든 세션 삭제
		HttpSession sess = req.getSession(false);
		sess.removeAttribute("sessUser"); // 회원정보 세션 제거
		sess.invalidate(); // 모든 세션 제거
		
		
		// 데이터베이스 사용자 sessId update
		service.updateUserForSessionOut(uid);
		
		resp.sendRedirect(req.getContextPath() + "/user/login.do"); // 로그인 뷰를 보여준다.
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

}
