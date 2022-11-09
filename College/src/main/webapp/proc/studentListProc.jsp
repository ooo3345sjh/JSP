<%@page import="dto.StudentDTO"%>
<%@page import="dao.StudentDAO"%>
<%@page import="dao.RegisterDAO"%>
<%@page import="dto.RegisterDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="dto.LectureDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.LectureDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String stdNo = request.getParameter("stdNo");
	StudentDAO dao = StudentDAO.getInstance();
	List<StudentDTO> lectures = null;
	if(stdNo == null || stdNo.equals("")){ // 검색 내용이 없다면
		lectures = dao.selectStudents();
	} else {
		lectures = dao.selectStudent(stdNo);
	}
	
	Gson gson = new Gson();
	String jsonData = gson.toJson(lectures);
	out.print(jsonData);
%>