<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.awt.Taskbar.State"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.jboard1.bean.UserBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	// multipart 폼 데이터 수신(라이브러리 다운 필요 - Maven 저장소 - cos 검색 다운)
	int maxSize = 1024 * 1024 * 10; // 10MB
	String savePath = application.getRealPath("/file");
	MultipartRequest mr = new MultipartRequest(request, savePath, maxSize, 
								    		   "utf-8", new DefaultFileRenamePolicy());
	
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	String uid = mr.getParameter("uid");
	String fname = mr.getFilesystemName("fname");
	System.out.println("fname : " + fname);
	int parent = 0;
	
	try{
		Connection con = DBCP.getConnection();
		
		// 트랜잭션 시작
		con.setAutoCommit(false);
		PreparedStatement psmt = con.prepareStatement(Sql.INSERT_ARTICLE);
		Statement stmt = con.createStatement();
		
		psmt.setString(1, title);
		psmt.setString(2, content);
		psmt.setInt(3, fname == null ? 0 : 1);
		psmt.setString(4, uid);
		psmt.setString(5, request.getRemoteAddr());
		
		psmt.executeUpdate();
		ResultSet rs = stmt.executeQuery(Sql.SELECT_MAX_NO);
		
		con.commit(); // 작업 확정
		// 트랜잭션 종료
		
		if(rs.next()){
			parent = rs.getInt(1);
		}
		
		con.close();
		psmt.close();
		rs.close();
		stmt.close();
		
	}catch(Exception e){
		e.printStackTrace();		
	}
	
	// 파일 첨부했으면
	if(fname != null){
		
		// 파일명 수정
		int i = fname.lastIndexOf("."); // ex) 수업내용.txt에서 확장자 앞의 .의 인덱스 번호를 가져온다.
		String ext = fname.substring(i); // ex) .txt를 문자열로 저장한다.
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_"); // yyyyMMddHHmmss_ 형식의 포맷
		String now = sdf.format(new Date()); // new Date()로 오늘 날짜의 객체를 생성후 포맷 형식에 맞춰서 문자열로 저장
		String newName = now + uid + ext; // ex)20221026100417_syj980520.txt
	
		File f1 = new File(savePath + "/" + fname); // file 디렉터리안에 존재하는 객체
		File f2 = new File(savePath + "/" + newName); // 가상의 파일 객체
		
		f1.renameTo(f2); // f1의 파일 이름을 f2의 가상객체의 파일이름으로 변경한다.
		
		// 파일 테이블 Insert
		
		try{
			Connection con = DBCP.getConnection();
			
			PreparedStatement psmt = con.prepareStatement(Sql.INSERT_FILE);
			psmt.setInt(1, parent);
			psmt.setString(2, newName);
			psmt.setString(3, fname);
			
			psmt.executeUpdate();
			
			psmt.close();
			con.close();
		
		}catch(Exception e){
			e.printStackTrace();
		}
			
	}
	
	response.sendRedirect("/Jboard1/list.jsp");
%>