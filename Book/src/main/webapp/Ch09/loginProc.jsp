<%@page import="model1.member.MemberDTO"%>
<%@page import="model1.member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="common.JDBConnect"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	// 전송 데이터 수신
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	// 데이터 베이스 접속
	MemberDAO dao = new MemberDAO(application);
	
	// 로그인 정보 가져오기
	MemberDTO dto = dao.readMember(id, pass);
	
	// 데이터베이스 연결 해제
	dao.close();
	
	if(dto != null){
		session.setAttribute("id", dto.getId());
		session.setAttribute("pass", dto.getPass());
	} else{
		request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
		request.getRequestDispatcher("loginForm.jsp").forward(request, response);
		return;
	}
	
	response.sendRedirect("loginForm.jsp");
%>