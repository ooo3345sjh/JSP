<%@page import="dao.RegisterDAO"%>
<%@page import="dto.RegisterDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="dto.LectureDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.LectureDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	RegisterDAO dao = RegisterDAO.getInstance();
	String searchVal = request.getParameter("searchVal");
	List<RegisterDTO> lectures = null;
	
	if(searchVal == null || searchVal.equals("")){ // 검색 내용이 없다면
		lectures = dao.selectRegisters(); // 전체 목록 출력
	} else { // 검색 내용이 있다면
		lectures = dao.selectRegister(searchVal); // 조건 목록 출력
	}
	
	Gson gson = new Gson();
	String jsonData = gson.toJson(lectures);
	out.print(jsonData);
%>



