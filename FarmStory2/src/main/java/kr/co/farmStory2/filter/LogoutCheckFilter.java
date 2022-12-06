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
	private List<String> uriList;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
		uriList = new ArrayList<String>();
		
		uriList.add("login.do");
		uriList.add("findId.do");
		uriList.add("findIdResult.do");
		uriList.add("findPwChange.do");
		uriList.add("findPw.do");
		uriList.add("terms.do");
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		logger.info("LogoutCheckFilter doFilter...");
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		String fromUrl = req.getHeader("referer"); // 요청을 하는 uri
		String[] uriArr = req.getRequestURI().split("/"); // ex) {Jboard2, list.do} 
		String uri = uriArr[uriArr.length-1]; // ex) list.do
		UserVO vo = (UserVO)req.getAttribute("reqUser");
		if(uriList.contains(uri)) {
			if(vo != null) {
				if(uri.contains("findPwChange.do") && fromUrl != null && fromUrl.contains("myInfo.do")) {}
				else {
					JSFunction.alertBack(resp, "이미 로그인 되어 있습니다.");
					return;
				} 
			}
		}
		else if(!uriList.contains(uri) && vo == null){
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", req.getContextPath() + "/user/login.do"); // 로그인 뷰로 이동
			return;
		}
		
		// 다음 필터 실행 
		chain.doFilter(request, response);
	}
}
