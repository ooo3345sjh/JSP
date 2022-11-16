<%@page import="kr.co.FarmStory1.utils.JSFunction"%>
<%@page import="kr.co.FarmStory1.vo.UserVO"%>
<%@page import="kr.co.FarmStory1.dao.BoardDAO"%>
<%@page import="kr.co.FarmStory1.vo.ArticleVO"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인 여부 체크
	UserVO user = (UserVO)session.getAttribute("user");
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8"); 
	int parent = Integer.parseInt(request.getParameter("no")); // 게시물 번호
	String comment = request.getParameter("comment"); // 댓글 내용
	String uid = user.getUid(); // 댓글 작성 아이디
	String nick = user.getNick(); // 댓글 작성 닉네임
	String regip = user.getRegip(); // 댓글 작성자 ip주소
	
	// 날짜 생성
	Date date = new Date(); // 현재 날짜 객체를 생성
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 날짜 포맷
	String rdate = sdf.format(date); // ex) 2022-10-28 10:32:22
	
	// ArticleVO 객체 생성
	ArticleVO vo = new ArticleVO();
	vo.setParent(parent);
	vo.setContent(comment);
	vo.setUid(uid);
	vo.setRegip(regip);
	
	// CommentDAO 객체 생성
	BoardDAO dao = BoardDAO.getInstance();
	Map<String, Integer> map = dao.insertComment(vo);
	
	int result = map.get("result"); // 결과값
	int no = map.get("no"); // 댓글 번호
	
	// JSON 데이터 변환 및 전송
	JsonObject jsonData = new JsonObject();
	jsonData.addProperty("result", result); // DB 전송 성공여부 값
	jsonData.addProperty("no", no);  // 데이터에 저장한 댓글 번호 
	jsonData.addProperty("nick", nick); // 댓글을 작성한 유저의 닉네임
	jsonData.addProperty("rdate", rdate.substring(2, 10)); // 댓글을 저장한 날짜
	String data = jsonData.toString();
	
	out.print(data);
%>