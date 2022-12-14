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

public class LoginCheckFilter implements Filter {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	private List<String> uriList;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		logger.info("LoginCheckFilter init...");
		
		uriList = new ArrayList<String>();
		
		uriList.add("write.do");
		uriList.add("modify.do");
		uriList.add("delete.do");
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		logger.info("LoginCheckFilter doFilter...");
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		HttpSession sess = req.getSession(false);
		
		
		String[] uriArr = req.getRequestURI().split("/"); // ex) {Jboard2, list.do} 
		String uri = uriArr[uriArr.length-1]; // ex) list.do
		UserVO vo = null;
		
		/*** 필터링 start ***/
		String fromUrl = req.getHeader("referer"); // 요청을 하는 uri
		
		if(uriList.contains(uri) && fromUrl == null) { 
			JSFunction.alertBack(resp, "비정상적인 접근입니다.");
			return;
		}
		/*** 필터링 end ***/
		
		
		/*** A.세션이 null이 아니면 ***/
		if(sess != null) {   
			
			vo = (UserVO)sess.getAttribute("sessUser");
			
			/*** a-1.로그인이 되어있지 않다면 ***/
			if(vo == null) { 
				
				/*** List 컬렉션에 포함된 uri라면 (로그인 후에 접속가능) ***/
				if(uriList.contains(uri)) { // 
					JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", req.getContextPath() + "/user/login.do"); // 로그인 뷰로 이동
					return;
				} 
			} 
			
		} 
		
		/*** B.세션이 null이면 ***/
		else {
			if(uriList.contains(uri)) { // List 컬렉션에 포함된 uri라면 (로그인 후에 이용가능)
				JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", req.getContextPath() + "/user/login.do");
				return;
			} 
		}
		
		// 다음 필터 실행 
		chain.doFilter(request, response);
	}
}
