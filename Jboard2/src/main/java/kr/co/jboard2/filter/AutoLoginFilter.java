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
		
		Cookie[] cookies = req.getCookies(); // 쿠키 정보 얻기
		if(cookies != null) { 				 // 쿠키가 있다면
			for(Cookie cookie : cookies) {
				String key = cookie.getName();
				String value = cookie.getValue();
				
				if(key.equals("SESSID")) {   // 쿠키에 key 값이 'SESSID'가 있다면
					UserVO vo= service.selectUserBySessId(value); // 자동 로그인 회원정보를 가져온다.
					HttpSession sess = req.getSession(true);
					
					if(vo != null) {         // 회원정보가 있다면
						
						if(sess.getId() != value) {       // 현재 세션ID와 쿠키의 세션ID가 동일하지 않다면
							cookie.setMaxAge(60*60*24*3); // 쿠키 저장 시간 3일 갱신
							resp.addCookie(cookie);       // 응답 객체에 추가
							service.updateUserForSessLimitDate(value); // 데이터 베이스 sessId 만료일 연장
						}
					}
				}
			}
		}
		
		// 다음 필터 실행 
		chain.doFilter(request, response);
	}
}
