<%@page import="com.google.gson.Gson"%>
<%@page import="dto.LectureDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.LectureDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	LectureDAO dao = LectureDAO.getInstance();

	List<LectureDTO> lectures = dao.selectLectures();
	
	
	Gson gson = new Gson();
	String jsonData = gson.toJson(lectures);
	out.print(jsonData);
%>
