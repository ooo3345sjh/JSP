package controller.book;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BookDAO;
import vo.BookVO;

@WebServlet("/modify.do")
public class ModiftyController extends HttpServlet {
	@Override
	public void init() throws ServletException {}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String bookID = req.getParameter("bookID");
		
		BookVO book = BookDAO.getInstance().selectBook(bookID);
		
		req.setAttribute("book", book);
		req.getRequestDispatcher("./book/modify.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String bookID = req.getParameter("bookID");
		String bookName = req.getParameter("bookName");
		String publisher = req.getParameter("publisher");
		String price = req.getParameter("price");
		
		BookVO vo = new BookVO();
		vo.setBookID(bookID);
		vo.setBookName(bookName);
		vo.setPublisher(publisher);
		vo.setPrice(price);
		
		BookDAO.getInstance().updateBook(vo);
		
		resp.sendRedirect("/BookStore2/list.do");
		
	}

}
