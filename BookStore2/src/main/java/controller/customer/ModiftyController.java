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
import vo.CustomerVO;

@WebServlet("/customer/modify.do")
public class ModiftyController extends HttpServlet {
	@Override
	public void init() throws ServletException {}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String bookID = req.getParameter("custID");
		
		CustomerVO cust = CustomerDAO.getInstance().selectCustomer(bookID);
		
		req.setAttribute("cust", cust);
		req.getRequestDispatcher("./modify.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String custID = req.getParameter("custID");
		String name = req.getParameter("name");
		String address = req.getParameter("address");
		String phone = req.getParameter("phone");
		
		CustomerVO vo = new CustomerVO();
		vo.setCustID(custID);
		vo.setName(name);
		vo.setAddress(address);
		vo.setPhone(phone);
		
		CustomerDAO.getInstance().updateCustomer(vo);
		
		resp.sendRedirect("/BookStore2/customer/list.do");
		
	}

}
