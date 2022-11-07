<%@page import="dao.StudentDAO"%>
<%@page import="dto.StudentDTO"%>
<%@page import="dao.RegisterDAO"%>
<%@page import="dto.RegisterDTO"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="dto.LectureDTO"%>
<%@page import="dao.LectureDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String stdNo = request.getParameter("stdNo");
	String stdName = request.getParameter("stdName");
	String stdHp = request.getParameter("stdHp");
	int stdYear = Integer.parseInt(request.getParameter("stdYear"));
	String stdAddress = request.getParameter("stdAddress");
	int result = 0;
	
	StudentDTO dto = new StudentDTO();
	dto.setStdNo(stdNo);
	dto.setStdName(stdName);
	dto.setStdHp(stdHp);
	dto.setStdYear(stdYear);
	dto.setStdAddress(stdAddress);
	
	
	StudentDAO dao = StudentDAO.getInstance();
	result = dao.insertStudent(dto);
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	out.print(json.toString());
%>