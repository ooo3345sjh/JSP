<%@page import="java.util.Arrays"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
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
	String content = mr.getParameter("editorTxt");
	String uid = mr.getParameter("uid");
	String fname = mr.getFilesystemName("fname");
	String img = mr.getParameter("img"); // 게시글에 게시가된 이미지 주소값들 
	String regip = request.getRemoteAddr();
	
	ArticleBean ab = new ArticleBean();
	ab.setTitle(title);
	ab.setContent(content);
	ab.setUid(uid);
	ab.setFname(fname);
	ab.setRegip(regip);
	
	ArticleDAO dao = ArticleDAO.getInstance();
	
	// 글 등록
	int parent = dao.insertArticle(ab);
	
	
	//=========== 선 택 옵 션 항 목 ============//
			
	/****** 1. 파일 첨부시 ******/
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
		dao.insertFile(parent, newName, fname);
			
	}
	
	/****** 2. 이미지 파일 삽입시 ******/
	String realPath = application.getRealPath("/");
	File files = new File(realPath, "smartEditor/temp"); // 임시 저장소 디렉터리 주소
	
	if(!img.equals("")){ // 이미지 주소 값이 있다면
		
		String[] images = img.split("/"); // 이미지 주소값들을 '/'를 기준으로 잘라서 문자열 배열로 반환한다.
		String[] fileNames = files.list(); // 임시 저장소에 저장된 파일들의 이름을 가져온다.
		boolean[] checking = new boolean[fileNames.length]; // 게시글에 삽입되지 않은 쓰레기 파일을 체킹하기위한 변수
		
		for(int j=0; j<images.length; j++){ // 요청 값으로 가져온 이미지 주소 값들 중
			for(int i=0; i<fileNames.length; i++){ // 임시 저장소에 있는 파일과 이름이 같은 파일은
				if(images[j].equals(fileNames[i])){ // true로 변환한다.
					checking[i] = true;
				} 
			}
		}
		
		for(int i=0; i<checking.length; i++){ // false로 되어 있는 인덱스 번호는 쓰레기 파일이므로 삭제 해준다.
			if(checking[i] == false){ // 본 저장소에 있는 파일 삭제
				File multiFile = new File(realPath, "file/" + fileNames[i]);
				multiFile.delete();
			}
		}
		
		FileUtils.deleteDirectory(files); // 임시 저장소 폴더 삭제
		dao.insertFiles(parent, images); // DB에 파일 등록
		
	} else{ // 이미지 경로 값이 없다면  
		if(files.exists()){ // 임시 저장소에 파일이 있다면 저장소 및 임시 저장소 파일 제거 
			String[] fileNames = files.list(); // 임시 저장소에 있는 파일들의 이름을 가져온다.
			
			for(String fileName : fileNames){ // 임시 저장소에 있는 파일 이름과 동이한 이름을 가진 본 저장소에 파일들을 삭제
				File multiFile = new File(realPath, "file/" + fileName);
				multiFile.delete();
			}
			
			FileUtils.deleteDirectory(files); // 임시 저장소 폴더 삭제
		}
	}
	
	response.sendRedirect("/Jboard1/list.jsp");
%>