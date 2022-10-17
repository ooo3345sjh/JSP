<%@page import="customer.CustomerDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String custId = request.getParameter("custId");
	
	// 데이터베이스 작업
	CustomerDAO dao = new CustomerDAO();
	dao.deleteCustomer(custId);
	
	dao.close();
	
	response.sendRedirect("list.jsp");
%>