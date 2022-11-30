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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmStory2.utils.JSFunction;
import kr.co.farmStory2.vo.UserVO;

public class LoginCheckFilter implements Filter {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	private List<String> boardUriList;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		logger.info("LoginCheckFilter init...");
		
		boardUriList = new ArrayList<String>();
		
		boardUriList.add("write.do");
		boardUriList.add("modify.do");
		boardUriList.add("delete.do");
		
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		logger.info("LoginCheckFilter doFilter...");
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		HttpSession sess = req.getSession();
		
		String[] uriArr = req.getRequestURI().split("/"); // ex) {Jboard2, list.do} 
		String uri = uriArr[uriArr.length-1]; // ex) list.do
		UserVO vo = null;
		
		vo = (UserVO)sess.getAttribute("sessUser");
		
		/*** a-1.로그인이 되어있지 않다면 ***/
		if(vo == null) { 
			
			/*** List 컬렉션에 포함된 uri라면 (로그인 후에 접속가능) ***/
			if(boardUriList.contains(uri)) { // 
				JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", req.getContextPath() + "/user/login.do"); // 로그인 뷰로 이동
				return;
			} 
		} 
		
		// 다음 필터 실행 
		chain.doFilter(request, response);
	}
}
