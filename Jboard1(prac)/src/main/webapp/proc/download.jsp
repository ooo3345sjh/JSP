<%@page import="java.util.List"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.io.InputStream"%>
<%@page import="kr.co.jboard1.bean.FileBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("UTF-8");
	String parent = request.getParameter("parent");
	
	// 파일 정보 가져오기
	ArticleDAO dao = ArticleDAO.getInstance();
	List<FileBean> fbs = dao.selectFile(parent);
	FileBean fb = null;
	
	for(FileBean file : fbs){
		if(!file.getOriName().equals("삽입 이미지")){
			fb = file;
		}
	}

	//파일 다운로드 response 헤더수정
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode(fb.getOriName(), "utf-8"));
	response.setHeader("Content-Transfer-Encoding", "binary");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "private");
	
	// response 객체로 파일 스트림 작업
	String savePath = application.getRealPath("/file");
	
	File file = new File(savePath, fb.getNewName());
	
	// 출력 스트림 초기화
	out.clear();
	
	BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
	BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream()); 	
	
	while(true){
		
		int data = bis.read();
		if(data == -1){
			break;
		}
		
		bos.write(data);
	}
	
	bos.close();
	bis.close();

%>