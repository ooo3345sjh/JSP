package kr.co.jboard2.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.service.user.UserService;
import kr.co.jboard2.vo.UserVO;

public class AutoLoginFilter implements Filter {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	private UserService service = UserService.INSTANCE;
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		logger.info("AutoLoginFilter...");
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		HttpSession sess1 = req.getSession(false);
		
		/****** 로그인 여부 확인 ******/
		if(sess1 != null) { 
			UserVO sessUser = (UserVO)sess1.getAttribute("sessUser"); // 로그인 회원정보를 가져온다.
			
			if(sessUser != null) { 				   // 로그인 회원정보가 있다면?(이미 로그인되어있는 상태)
				chain.doFilter(request, response); // 다음 필터 실행 
				return;
			}
		}
		
		
		/****** 세션에 회원정보가 없는 경우(로그인이 되어있지 않은 경우) ******/
		
		Cookie[] cookies = req.getCookies(); // 쿠키 정보 얻기
		
		if(cookies != null) { 				 // 쿠키가 있다면
			
			for(Cookie cookie : cookies) {
				String key = cookie.getName();
				String value = cookie.getValue();
				
				if(key.equals("SESSID")) {   // 쿠키에 key 값이 'SESSID'가 있다면
					UserVO vo = service.selectUserBySessId(value); // 자동 로그인 회원정보를 가져온다.
					
					if(vo != null) { // 회원정보가 있다면
						HttpSession sess2 = req.getSession(true); // 세션 생성
						sess2.setAttribute("sessUser", vo); 	  // 세션에 회원정보 추가
						
						cookie.setMaxAge(60*60*24*3); // 쿠키 저장 시간 3일 연장
						resp.addCookie(cookie);       // 응답 객체에 추가
						service.updateUserForSessLimitDate(value); // 데이터 베이스 sessId 만료일 3일 연장
					}
				}
				
			} // for문 종료
		}
		
		// 다음 필터 실행 
		chain.doFilter(request, response);
	
	} // do Filter 종료
}
