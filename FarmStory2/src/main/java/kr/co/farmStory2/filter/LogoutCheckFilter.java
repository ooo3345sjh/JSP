package kr.co.farmStory2.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmStory2.utils.JSFunction;
import kr.co.farmStory2.vo.UserVO;

public class LogoutCheckFilter implements Filter {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		logger.info("LogoutCheckFilter doFilter...");
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		String uri = req.getRequestURI();
		
		if(!uri.contains("logout.do")) {
			UserVO vo = (UserVO)req.getAttribute("reqUser");
			if(vo != null) {
				JSFunction.alertBack(resp, "이미 로그인 되어 있습니다.");
				return;
			}
		}
		// 다음 필터 실행 
		chain.doFilter(request, response);
	}
}
