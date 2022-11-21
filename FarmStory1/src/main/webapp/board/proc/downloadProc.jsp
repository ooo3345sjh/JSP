<%@page import="java.util.List"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@page import="kr.co.FarmStory1.vo.FileVO"%>
<%@page import="kr.co.FarmStory1.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("utf-8");
	String parent = request.getParameter("parent");
	
	// 파일 정보 가져오기
	List<FileVO> files = new BoardDAO().selectFile(parent);
	
	FileVO vo = null;
	
	for(FileVO file : files){
		if(!file.getOriName().equals("삽입 이미지")){
			vo = file;
		}
	}
	
	// 파일 다운로드 response 헤더수정
	response.reset();
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", "attacment; filename=" + URLEncoder.encode(vo.getOriName(), "utf-8"));
	
	out.clear();
	
	// 파일을 찾아 입력 스트림 생성
	String savePath = application.getRealPath("/file");
	File file = new File(savePath, vo.getNewName());
	
	// 입력 및 출력 스트림 생성
	BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
	BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
	
	// 출력 스트림에 파일 내용 출력
	while(true){
		int data = bis.read();
		if(data == -1) break;
		
		bos.write(data);
	}
	
	bis.close();
	bos.close();


%>