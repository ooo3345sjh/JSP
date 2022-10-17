<%@page import="book.BookDAO"%>
<%@page import="customer.CustomerDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String bookId = request.getParameter("bookId");
	
	// 데이터베이스 작업
	BookDAO dao = new BookDAO();
	dao.deleteBook(bookId);
	
	dao.close();
	
	response.sendRedirect("list.jsp");
%>