package kr.co.farmStory2.controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmStory2.service.user.UserService;
import kr.co.farmStory2.utils.JSFunction;
import kr.co.farmStory2.vo.UserVO;


@WebServlet("/user/myInfo.do")
public class MyInfoController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("MyInfoController doGet...");
		String fromUrl = req.getHeader("referer");
		if(fromUrl == null || !fromUrl.contains("info.do")) {
			JSFunction.alertBack(resp, "비정상적인 접근입니다.");
			return;
		}
		req.getRequestDispatcher("/board/user/myInfo.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("MyInfoController doPost...");
		String uid = ((UserVO)req.getAttribute("reqUser")).getUid();
		String name = req.getParameter("name");
		String nick = req.getParameter("nick");
		String email = req.getParameter("email");
		String hp = req.getParameter("hp");
		String zip = req.getParameter("zip").equals("") ? null : req.getParameter("zip");
		String addr1 = req.getParameter("addr1").equals("") ? null : req.getParameter("addr1");
		String addr2 = req.getParameter("addr2").equals("") ? null : req.getParameter("addr2");;
		
		// 수정된 회원 정보 세션에 수정 
		HttpSession session = req.getSession(false);
		UserVO sessUser = (UserVO)session.getAttribute("sessUser");
		sessUser.setNick(nick);
		sessUser.setName(name);
		sessUser.setEmail(email);
		session.setAttribute("sessUser", sessUser);
		
		UserVO vo = new UserVO();
		vo.setUid(uid);
		vo.setName(name);
		vo.setNick(nick);
		vo.setEmail(email);
		vo.setHp(hp);
		vo.setZip(zip);
		vo.setAddr1(addr1);
		vo.setAddr2(addr2);
		
		int result = 0;
		result = service.updateUserInfo(vo);
		
		if(result == 1) {
			resp.sendRedirect(req.getContextPath() + "/index.do");
		} else {
			JSFunction.alertBack(resp, "회원 수정에 실패했습니다.");
		}

	}

}
