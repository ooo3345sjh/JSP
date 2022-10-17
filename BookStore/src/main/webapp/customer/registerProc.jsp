<%@page import="customer.CustomerDAO"%>
<%@page import="customer.CustomerDTO"%>
<%@page import="book.BookDTO"%>
<%@page import="book.BookDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String phone = request.getParameter("phone");
	
	// 데이터 베이스 작업
	CustomerDTO dto = new CustomerDTO();
	dto.setName(name);
	dto.setAddress(address);
	dto.setPhone(phone);
	
	CustomerDAO dao = new CustomerDAO();
	dao.insertCustomer(dto);
	
	dao.close();
	
	// 리다이렉트
	response.sendRedirect("list.jsp");
%>