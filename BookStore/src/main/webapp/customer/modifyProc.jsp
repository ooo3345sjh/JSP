<%@page import="customer.CustomerDAO"%>
<%@page import="customer.CustomerDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String custId = request.getParameter("custId");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String phone = request.getParameter("phone");
	
	// 데이터 베이스 작업
	CustomerDTO dto = new CustomerDTO();
	dto.setCustId(Integer.parseInt(custId));
	dto.setName(name);
	dto.setAddress(address);
	dto.setPhone(phone);
	
	CustomerDAO dao = new CustomerDAO();
	dao.updateCustomer(dto);
	
	dao.close();

	// 리다이렉트
	response.sendRedirect("list.jsp");
%>