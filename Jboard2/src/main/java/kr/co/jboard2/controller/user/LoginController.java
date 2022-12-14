package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.service.user.UserService;
import kr.co.jboard2.utils.JSFunction;
import kr.co.jboard2.vo.UserVO;

@WebServlet("/user/login.do")
public class LoginController  extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/user/login.jsp").forward(req, resp); // 로그인 뷰를 보여준다.
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("LoginController...");
		String uid = req.getParameter("uid"); 		 // 회원 아이디
		String pass = req.getParameter("pass"); 	 // 회원 패스워드
		String auto = req.getParameter("auto"); 	 // 자동 로그인 체크 여부
		UserVO vo = service.selectUser(uid, pass);	 // DB에서 입력한 로그인 정보와 일치하는 회원 정보를 가져온다.
		
		if(vo != null) { // 로그인 입력한 정보와 일치한 회원이 있으면
			
			if(vo.getGrade() == 0 ) {
				JSFunction.alertLocation(resp, "입력하신 정보는 탈퇴한 회원입니다.", req.getContextPath() + "/user/login.do"); // 로그인 뷰로 이동
				return;
			} 
			
			// 회원이 맞을 경우
			HttpSession sess = req.getSession(true); // 세션 객체 가져오기
			
			sess.setAttribute("sessUser", vo); 	     // 세션에 회원 정보 저장
			
			if(auto != null) { // 자동 로그인 체크가 되어있으면
				String sessId = sess.getId();
				
				Cookie cookie = new Cookie("SESSID", sessId); // 쿠키 생성
				cookie.setPath(req.getContextPath()); // 쿠키 경로
				cookie.setMaxAge(60*60*24*3); 		  // 쿠키 저장 시간 3일
				resp.addCookie(cookie);               // 응답 객체에 추가
				
				// sessId 데이터베이스 저장
				service.updateUserForSession(uid, sessId);
			}
			
			resp.sendRedirect(req.getContextPath() + "/list.do"); // 게시판 리스트 뷰로 이동
		} else { // 입력한 정보와 일치하는 회원이 없으면
			JSFunction.alertLocation(resp, "입력한 정보와 일치하는 회원이 없습니다. 확인후 다시 시도해주세요.", req.getContextPath() + "/user/login.do"); // 로그인 뷰로 이동
		}
		
	}

}
