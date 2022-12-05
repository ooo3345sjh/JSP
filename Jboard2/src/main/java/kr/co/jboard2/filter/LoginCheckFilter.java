package kr.co.jboard2.filter;

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

import kr.co.jboard2.utils.JSFunction;
import kr.co.jboard2.vo.UserVO;

public class LoginCheckFilter implements Filter {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	private List<String> uriList;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		logger.info("LoginCheckFilter init...");
		
		uriList = new ArrayList<String>();
		
		uriList.add("list.do");
		uriList.add("write.do");
		uriList.add("modify.do");
		uriList.add("view.do");
		uriList.add("download.do");
		uriList.add("delete.do");
		uriList.add("info.do");
		uriList.add("myInfo.do");
		uriList.add("logout.do");
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		logger.info("LoginCheckFilter doFilter...");
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		HttpSession sess = req.getSession(false);
		
		String fromUrl = req.getHeader("referer"); // 요청을 하는 uri
		String[] uriArr = req.getRequestURI().split("/"); // ex) {Jboard2, list.do} 
		String uri = uriArr[uriArr.length-1]; // ex) list.do
		UserVO vo = null;
		
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
			
			/*** a-2.로그인 되어 있다면 ***/
			else {		
				if(uri.contains("info.do") || uri.contains("myInfo.do") || fromUrl.contains("info.do")  || fromUrl.contains("myInfo.do")) {
					System.out.println("A도착");
				}
				
				/*** List 컬렉션에 포함되지 않고, ['logout.do' 'style.css']도 아닌 경우에 ***/
				else if(!uriList.contains(uri) && !uri.equals("logout.do") && !uri.equals("style.css")&& !uri.equals("comment.js")) { 
					resp.sendRedirect(req.getContextPath() + "/list.do"); // 게시판 목록 뷰로 이동
					System.out.println("B도착");
					return;
				}
			}
			
		} 
		
		/*** B.세션이 null이면 ***/
		else {
			
			fromUrl = req.getHeader("referer"); // 요청을 하는 uri
			String toUrl = req.getRequestURI(); 	   // 요청을 받는 uri 
			
			if(fromUrl != null && fromUrl.contains("login.do") && toUrl.contains("list.do")) { 
				if(req.getSession(false) == null) {
					JSFunction.alertBack(resp, "현재 사용하시는 인터넷 브라우저의 쿠키 설정이 차단되어 로그인이 되지 않았습니다. 설정 변경 후 다시 로그인해 주세요.");
					return;
				}
			}
			
			if(uriList.contains(uri)) { // List 컬렉션에 포함된 uri라면 (로그인 후에 이용가능)
				JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", req.getContextPath() + "/user/login.do");
				return;
			} 
		}
		
		// 다음 필터 실행 
		chain.doFilter(request, response);
	}
}
