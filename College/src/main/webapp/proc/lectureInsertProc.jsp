<%@page import="com.google.gson.JsonObject"%>
<%@page import="dto.LectureDTO"%>
<%@page import="dao.LectureDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int lecNo = Integer.parseInt(request.getParameter("lecNo"));
	String lecName = request.getParameter("lecName");
	int lecCredit = Integer.parseInt(request.getParameter("lecCredit"));
	int lecTime = Integer.parseInt(request.getParameter("lecTime"));
	String lecClass = request.getParameter("lecClass");
	int result = 0;
	
	LectureDTO dto = new LectureDTO();
	dto.setLecNo(lecNo);
	dto.setLecName(lecName);
	dto.setLecCredit(lecCredit);
	dto.setLecTime(lecTime);
	dto.setLecClass(lecClass);
	
	LectureDAO dao = LectureDAO.getInstance();
	result = dao.insertLecture(dto);
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	out.print(json.toString());

%>

