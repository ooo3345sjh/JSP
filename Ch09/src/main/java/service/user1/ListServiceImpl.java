package service.user1;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 *	날짜 : 2022/11/10	
 *	이름 : 서정현
 *	내용 : JSP MVC 모델 실습하기 
 */
public class ListServiceImpl implements CommonService {
	
	private static ListServiceImpl instance = new ListServiceImpl();
	public static ListServiceImpl getInstance() {
		return instance;
	}
	private ListServiceImpl() {}
	
	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		return "/user1/list.jsp"; 
	}
}
