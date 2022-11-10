package service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 *	날짜 : 2022/11/10	
 *	이름 : 서정현
 *	내용 : JSP MVC 모델 실습하기 
 */
public class HelloServiceImpl implements CommonService {
	
	private static HelloServiceImpl instance = new HelloServiceImpl();
	public static HelloServiceImpl getInstance() {
		return instance;
	}
	private HelloServiceImpl() {}
	
	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		return "/hello.jsp"; 
	}
}
