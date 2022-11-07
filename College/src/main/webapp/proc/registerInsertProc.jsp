<%@page import="dao.RegisterDAO"%>
<%@page import="dto.RegisterDTO"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="dto.LectureDTO"%>
<%@page import="dao.LectureDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String regStdNo = request.getParameter("regStdNo");
	int regLecNo = Integer.parseInt(request.getParameter("regLecNo"));
	int result = 0;
	
	RegisterDTO dto = new RegisterDTO();
	dto.setRegStdNo(regStdNo);
	dto.setRegLecNo(regLecNo);
	
	
	RegisterDAO dao = RegisterDAO.getInstance();
	result = dao.insertRegister(dto);
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	out.print(json.toString());
%>

