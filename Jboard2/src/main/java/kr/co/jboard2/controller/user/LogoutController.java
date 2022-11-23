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
		Cookie[] cookies = req.getCookies(); // 쿠키 정보 얻기
		if(cookies.length != 0) { // 쿠키가 있다면
			for(Cookie cookie : cookies) {
				String key = cookie.getName();
				if(key.equals("autoLogin")) { // 쿠키에 key 값이 'autoLogin'가 있다면
					Cookie deleteCookie = new Cookie(key, "");
					deleteCookie.setMaxAge(0);      // 쿠키 삭제
					deleteCookie.setPath(req.getContextPath());
					resp.addCookie(deleteCookie);
				}
			}
		}
		
		req.getSession().invalidate(); // 세션 제거
		resp.sendRedirect(req.getContextPath() + "/user/login.do"); // 로그인 뷰를 보여준다.
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

}
