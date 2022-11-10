package service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 *	날짜 : 2022/11/10	
 *	이름 : 서정현
 *	내용 : JSP MVC 모델 실습하기 
 */
public class GreetingServiceImpl implements CommonService {
	
	private static GreetingServiceImpl instance = new GreetingServiceImpl();
	public static GreetingServiceImpl getInstance() {
		return instance;
	}
	private GreetingServiceImpl() {}
	
	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		return "/greeting.jsp"; 
	}
}
