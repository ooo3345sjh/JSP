<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<!-- 
	날짜 : 2022/10/09
	이름 : 서정현
	내용 : 로그인 처리 JSP

-->
<%
	// 로그인 폼으로부터 받은 아이디와 패스워드
	String userId =  request.getParameter("user_id");
	String userPwd =  request.getParameter("user_pw");
	
	// web.xml에서 가져온 데이터베이스 연결 정보
	String mysqlDiver = application.getInitParameter("MysqlDriver");
	String mysqlURL = application.getInitParameter("MysqlURL");
	String mysqlId = application.getInitParameter("MysqlId");
	String mysqlPwd = application.getInitParameter("MysqlPwd");

	// 회원 테이블 DAO를 통해 회원 정보 DTO 획득
	MemberDAO dao = new MemberDAO(mysqlDiver, mysqlURL, mysqlId, mysqlPwd);
	MemberDTO memberDTO = dao.getMemberDTO(userId, userPwd);
	dao.close();
	
	// 로그인 성공 여부에 따른 처리
	if(memberDTO.getId() != null){
		// 로그인 성공
		session.setAttribute("UserId", memberDTO.getId());
		session.setAttribute("UserName", memberDTO.getName());
		response.sendRedirect("P216.jsp"); // 로그인 메인 화면으로 redirect
	}
	else {
		// 로그인 실패
		request.setAttribute("LoginErrMsg", "로그인 오류입니다.");
		request.getRequestDispatcher("P216.jsp").forward(request, response);
	}
	
%>