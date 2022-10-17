<%@page import="book.BookDAO"%>
<%@page import="book.BookDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String bookId = request.getParameter("bookId");
	String bookName = request.getParameter("bookName");
	String publisher = request.getParameter("publisher");
	String price = request.getParameter("price");
	
	// 데이터 베이스 작업
	BookDTO dto = new BookDTO();
	dto.setBookId(Integer.parseInt(bookId));
	dto.setBookName(bookName);
	dto.setPublisher(publisher);
	dto.setPrice(Integer.parseInt(price));
	
	BookDAO dao = new BookDAO();
	dao.updateBook(dto);
	
	dao.close();

	// 리다이렉트
	response.sendRedirect("list.jsp");
%>