package controller.customer;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BookDAO;
import dao.CustomerDAO;
import vo.BookVO;

@WebServlet("/customer/delete.do")
public class DelelteController extends HttpServlet {
	@Override
	public void init() throws ServletException {}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String custID = req.getParameter("custID");
		
		CustomerDAO.getInstance().deleteCustomer(custID);
		
		resp.sendRedirect("/BookStore2/customer/list.do");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

}
