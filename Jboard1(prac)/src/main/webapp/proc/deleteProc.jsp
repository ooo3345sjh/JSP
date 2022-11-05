<%@page import="java.util.List"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="kr.co.jboard1.bean.FileBean"%>
<%@page import="java.io.File"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	
	/* 수업시간 내용
	
	// 글 삭제 + 댓글 삭제
	dao.deleteArticle(no);

	// 파일 삭제(DB)
	String fileName = ArticleDAO.getInstance().deleteFile(no);
	
	// 파일 삭제(디렉터리)
	if(fileName != null){
		
		String savePath = application.getRealPath("/file");

		File file = new File(savePath, fileName);
		
		if(file.exists()){
			file.delete();
		}
	}
	*/
	
	/* 내가 수정한 부분 */

	// 파일 이름 가져오기
	List<FileBean> files = dao.selectFile(no);
	
	// 글 삭제 + 댓글 삭제 + 파일 삭제 + 삽입 이미지 삭제
	dao.deleteArticleFile(no);
	
	// 파일 삭제(디렉터리)
	if(!files.isEmpty()){
		String savePath = application.getRealPath("/file");
		
		for(FileBean fb : files){
			String fileName = fb.getNewName(); 
	
			File file = new File(savePath, fileName);
			
			if(file.exists()){
				file.delete();
			}
		}
	}
	

	response.sendRedirect("/Jboard1/list.jsp?pg=" + pg + "&result=201");
%>