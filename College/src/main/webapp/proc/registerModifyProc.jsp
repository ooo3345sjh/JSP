<%@page import="com.google.gson.JsonObject"%>
<%@page import="dao.RegisterDAO"%>
<%@page import="dto.RegisterDTO"%>
<%@page import="dto.LectureDTO"%>
<%@page import="dao.LectureDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String regStdNo = request.getParameter("regStdNo");
	int regLecNo = Integer.parseInt(request.getParameter("regLecNo"));
	int regMidScore = Integer.parseInt(request.getParameter("regMidScore"));
	int regFinalScore = Integer.parseInt(request.getParameter("regFinalScore"));
	int regTotalScore =  regMidScore + regFinalScore;
	
	// 학점 계산
	String regGrade = "";
	switch(regTotalScore/20){
		case 10:
		case 9:
			regGrade = "A";
			break;
		case 8:
			regGrade = "B";
			break;
		case 7:
			regGrade = "C";
			break;
		case 6:
			regGrade = "D";
			break;
		default:
			regGrade = "F";
			break;
	}
	
	int result = 0;
	
	RegisterDTO dto = new RegisterDTO();
	dto.setRegStdNo(regStdNo);
	dto.setRegLecNo(regLecNo);
	dto.setRegMidScore(regMidScore);
	dto.setRegFinalScore(regFinalScore);
	dto.setRegTotalScore(regTotalScore);
	dto.setRegGrade(regGrade);
	
	RegisterDAO dao = RegisterDAO.getInstance();
	result = dao.updateRegister(dto);
	
	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	json.addProperty("regTotalScore", regTotalScore);
	json.addProperty("regGrade", regGrade);
	out.print(json.toString());
	
%>

