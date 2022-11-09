<%@page import="java.util.Map"%>
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
	
	RegisterDTO dto = new RegisterDTO();
	dto.setRegStdNo(regStdNo);
	dto.setRegLecNo(regLecNo);
	
	
	RegisterDAO dao = RegisterDAO.getInstance();
	Map<String, Object> map = dao.insertRegister(dto);
	
	int result = (int)map.get("result");
	RegisterDTO rd = (RegisterDTO)map.get("RegisterDTO");
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	json.addProperty("stdNo", rd.getRegStdNo());
	json.addProperty("stdName", rd.getStdName());
	json.addProperty("lecName", rd.getLecName());
	json.addProperty("regLecNo", rd.getRegLecNo());
	out.print(json.toString());
%>

