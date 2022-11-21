<%@page import="java.io.File"%>
<%@page import="kr.co.FarmStory1.vo.FileVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.FarmStory1.utils.JSFunction"%>
<%@page import="kr.co.FarmStory1.vo.UserVO"%>
<%@page import="kr.co.FarmStory1.dao.BoardDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String uid = request.getParameter("uid"); // 게시글을 작성한 회원 아이디

	UserVO vo = (UserVO)session.getAttribute("user"); // 로그인 회원정보

	// 로그인 체크
	if(vo == null){
		JSFunction.alertLocation("해당 페이지는 로그인이 필요합니다.", "/FarmStory1/user/login.jsp", out);	
		return;
	}
	
	// 로그인 회원 아이디와 게시글 작성 회원 아이디 일치여부 체크
	if(!uid.equals(vo.getUid())){
		JSFunction.alertBack("게시물에 대한 삭제 권한이 없습니다. ", out);
		return;
	}
	
	request.setCharacterEncoding("utf-8");
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String no = request.getParameter("no");
	
	BoardDAO dao = new BoardDAO();
	
	
	// 파일 이름 가져오기
		List<FileVO> files = dao.selectFile(no);
		
		// 글 삭제 + 댓글 삭제 + 파일 삭제 + 삽입 이미지 삭제
		dao.deleteArticle(no);
		
		// 파일 삭제(디렉터리)
		if(!files.isEmpty()){
			String savePath = application.getRealPath("/file");
			
			for(FileVO fb : files){
				String fileName = fb.getNewName(); 
		
				File file = new File(savePath, fileName);
				
				if(file.exists()){
					file.delete();
				}
			}
		}
	
	response.sendRedirect("/FarmStory1/board/list.jsp?group=" + group + "&cate=" + cate);
%>