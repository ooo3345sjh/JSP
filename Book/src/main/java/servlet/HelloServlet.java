package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * 날짜 : 2022/10/28
 * 이름 : 서정현
 * 내용 : 요청을 처리할 서블릿 클래스
 */
public class HelloServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {

		req.setAttribute("message", "Hello Servlet..!!");
		req.getRequestDispatcher("/Ch13/P451.jsp").forward(req, resp);
	}
	
}
