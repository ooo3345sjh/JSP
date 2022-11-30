package kr.co.farmStory2.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.farmStory2.utils.JSFunction;

@WebServlet("/index.do")
public class IndexController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String fromUrl = req.getHeader("referer"); // 요청을 하는 uri
		String toUrl = req.getRequestURI(); 	   // 요청을 받는 uri 
		
		if(fromUrl != null && fromUrl.contains("login.do") && toUrl.contains("index.do")) { 
			if(req.getSession(false) == null) {
				JSFunction.alertBack(resp, "현재 사용하시는 인터넷 브라우저의 쿠키 설정이 차단되어 로그인이 되지 않았습니다. 설정 변경 후 다시 로그인해 주세요.");
				return;
			}
		}
		
		req.getRequestDispatcher("./index.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
