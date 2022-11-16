<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.co.FarmStory1.dao.BoardDAO"%>
<%@page import="kr.co.FarmStory1.vo.ArticleVO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	// multipart 폼 데이터 수신
	int maxSize = 1024 * 1024 * 10; // 10MB
	String savePath = application.getRealPath("/file");
	MultipartRequest mr = new MultipartRequest(request, savePath, maxSize, 
						"utf-8", new DefaultFileRenamePolicy());
	
 	String group = mr.getParameter("group");
 	String cate = mr.getParameter("cate");
 	String title = mr.getParameter("title");
 	String content = mr.getParameter("content");
 	String fname = mr.getFilesystemName("file");
 	String regip = request.getRemoteAddr();
 	String uid = mr.getParameter("uid");
 	
 	
 	ArticleVO vo = new ArticleVO();
 	vo.setTitle(title);
 	vo.setCate(cate);
 	vo.setContent(content);
 	vo.setRegip(regip);
 	vo.setFname(fname);
 	vo.setUid(uid);
 	
 	BoardDAO dao = BoardDAO.getInstance();
 	
 	// 글등록
 	int parent = dao.insertArticle(vo);
 	
 	//=========== 선택 옵션 항목 ===========//
 			
 	/******* 파일 첨부시 *******/
 	if(fname != null){
		int i = fname.lastIndexOf("."); // ex) xxxx.txt에서 확장자 앞의 .의 인덱스 번호를 가져온다.
	 	String ext = fname.substring(i); // ex) .txt를 문자열로 저장한다.
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_"); // yyyyMMddHHmmss_ 형식의 포맷
		String now = sdf.format(new Date()); // new Date()로 오늘 날짜의 객체를 생성후 포맷 형식에 맞퉈서 문자열로 저장
		String newName = now + uid + ext; // ex) 20221115105923_sjh940520.txt
		
		File f1 = new File(savePath, fname); // file 디렉터리안에 존재하는 객체
		File f2 = new File(savePath, newName); // 가상의 파일 객체
		
		f1.renameTo(f2); // f1의 파일 이름을 f2의 가상객체의 파일이름으로 변경한다.
		
		// 파일 테이블 Insert
		dao.insertFile(parent, newName, fname);
 	}
 	
	response.sendRedirect("/FarmStory1/board/list.jsp?group=" + group + "&cate=" + cate);
%>