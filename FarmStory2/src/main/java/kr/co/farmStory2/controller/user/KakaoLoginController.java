package kr.co.farmStory2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;

import kr.co.farmStory2.service.user.UserService;
import kr.co.farmStory2.utils.JSFunction;
import kr.co.farmStory2.vo.UserVO;

@WebServlet("/user/kakaoLogin.do")
public class KakaoLoginController  extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		JSFunction.alertBack(resp, "비정상적인 접근입니다.");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("KakaoLoginController doPost...");
		
		String uid = req.getParameter("uid"); 		 // 회원 아이디
		String pass = req.getParameter("pass"); 	 // 회원 패스워드
		UserVO vo = service.selectUser(uid, pass);	 // DB에서 입력한 로그인 정보와 일치하는 회원 정보를 가져온다.
		
		if(vo == null) {
			String nick = req.getParameter("nick"); 	 // 회원 닉네임
			String name = req.getParameter("name"); 	 // 회원 이름
			String email = req.getParameter("email"); 	 // 회원 이메일
			
			UserVO user = new UserVO();
			user.setUid(uid);
			user.setName(name);
			user.setPass(pass);
			user.setNick(nick);
			user.setEmail(email);
			user.setRegip(req.getRemoteAddr());
			vo = service.insert_select_User(user);
		}
		
		HttpSession sess = req.getSession(true); // 세션 객체 가져오기
		sess.setAttribute("sessUser", vo); 	     // 세션에 회원 정보 저장
		
		Gson gson = new Gson();
		
		resp.setContentType("json/application;charset=UTF-8");
		PrintWriter writer = resp.getWriter();
		writer.print(gson.toJson(vo));
		
	}

}
