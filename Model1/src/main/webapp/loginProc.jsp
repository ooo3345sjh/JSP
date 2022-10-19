<%@page import="util.JSFunction"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String auto = request.getParameter("auto");
	
	
	Map<String, String> map = null;
	
	// 수신 받은 id 및 pw가 null일 경우 
	if(id == null || pw == null){
		JSFunction.alertLocationn("비정상적인 접근입니다.", "/Model1/login.jsp", out);
		return;
	}
	
	map	= new HashMap<>();
	map.put("id", id);
	map.put("pw", pw);

	// 회원 정보 확인
	MemberDAO dao = new MemberDAO();
	MemberDTO dto = new MemberDTO();
	
	dto = dao.selectMember(map);

	if(dto == null){
		request.setAttribute("loginErorr", "로그인에 실패했습니다.");
		pageContext.forward("login.jsp");
		return;
	} else {
		session.setAttribute("id", dto.getId());
		session.setAttribute("pw", dto.getPass());
		
		// 자동 로그인 쿠키 생성
		if(auto != null){
			Cookie cookie = new Cookie("id", dto.getId());
			cookie.setMaxAge(60*3);
			response.addCookie(cookie);
		}
		
		response.sendRedirect("login.jsp");
	}
%>