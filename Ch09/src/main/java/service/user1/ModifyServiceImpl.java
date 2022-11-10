package service.user1;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 *	날짜 : 2022/11/10	
 *	이름 : 서정현
 *	내용 : JSP MVC 모델 실습하기 
 */
public class ModifyServiceImpl implements CommonService {
	
	private static ModifyServiceImpl instance = new ModifyServiceImpl();
	public static ModifyServiceImpl getInstance() {
		return instance;
	}
	private ModifyServiceImpl() {}
	
	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		return "/user1/modify.jsp"; 
	}
}
