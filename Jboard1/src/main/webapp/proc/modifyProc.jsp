<%@page import="java.util.ArrayList"%>
<%@page import="java.awt.font.ImageGraphicAttribute"%>
<%@page import="kr.co.jboard1.bean.FileBean"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.File"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	String title = request.getParameter("title");
	String content = request.getParameter("editorTxt");
	String img = request.getParameter("img"); // 게시글에 게시가된 이미지 주소값들 
	ArticleDAO dao = ArticleDAO.getInstance();
	
	int result = dao.updateArticle(no, title, content);
	
	
	/****** 2. 이미지 파일 삽입시 ******/
	String realPath = application.getRealPath("/");
	File files = new File(realPath, "smartEditor/temp"); // 임시 저장소 디렉터리 주소
	int parent = Integer.parseInt(no); // 게시글 번호
	List<FileBean> fbs = dao.selectImg(no); // DB에 저장된 이미지 파일들 가져오기
	
	if(!img.equals("")){ // 이미지 주소 값이 있다면
		String[] images = img.split("/"); // 이미지 주소값들을 '/'를 기준으로 잘라서 문자열 배열로 반환한다.
		
		if(files.exists()){ // 임시 저장소에 파일이 있다면
			String[] fileNames = files.list(); // 임시 저장소에 저장된 파일들의 이름을 가져온다.
			boolean[] checking = new boolean[fileNames.length]; // 게시글에 삽입되지 않은 쓰레기 파일을 체크하기위한 변수
			List<String> saveFile = new ArrayList<>();
			
			for(int j=0; j<images.length; j++){ // 요청 값으로 가져온 이미지 주소 값들 중
				for(int i=0; i<fileNames.length; i++){ // 임시 저장소에 있는 파일과 이름이 같은 파일은
					if(images[j].equals(fileNames[i])){ // true로 변환한다.
						checking[i] = true;
						saveFile.add(fileNames[i]);
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
			dao.insertFiles(parent, saveFile.toArray(new String[saveFile.size()])); // DB에 파일 등록
			
		} 
			
		// DB에 있는 파일 제거
		if(!fbs.isEmpty()){
			boolean[] checking = new boolean[fbs.size()]; // 전송받은 이미지 주소값과 DB에 저장된 파일들을 비교 체크하기위한 변수
			
			for(int i=0; i<fbs.size(); i++){
				for(int j=0; j<images.length; j++){
					if(fbs.get(i).getNewName().equals(images[j])){
						checking[i] = true; // DB에 저장된 파일과 전송받은 주소값이 같다면 true
					}
				}
			}
			
			for(int k=0; k<checking.length; k++){
				if(checking[k] == false){ // 체크한 값에서 false인 값은 DB에는 존재하지만 전송받은 이미지 주소값에는 없는 데이터로 삭제해준다.
					String fileName = fbs.get(k).getNewName(); 
			
					File file = new File(realPath, "file/" + fileName);
					
					if(file.exists()){
						file.delete();
					}
				}
			}
		}
		dao.deleteSelectedImg(no, images); // 이미지 주소값에 없는데 DB에 있는 데이터는 삭제
		
		
		
	} else{ // 이미지 경로 값이 없다면  
		if(files.exists()){ // 임시 저장소에 파일이 있다면 저장소 및 임시 저장소 파일 제거 
			
			
			String[] fileNames = files.list(); // 임시 저장소에 있는 파일들의 이름을 가져온다.
			
			for(String fileName : fileNames){ // 임시 저장소에 있는 파일 이름과 동일한 이름을 가진 본 저장소에 파일들을 삭제
				File multiFile = new File(realPath, "file/" + fileName);
				multiFile.delete();
			}
			
			FileUtils.deleteDirectory(files); // 임시 저장소 폴더 삭제
		}
	
		// DB에 있는 파일 제거
		if(!fbs.isEmpty()){
			for(FileBean fb : fbs){
				String fileName = fb.getNewName(); 
		
				File file = new File(realPath, "file/" + fb.getNewName());
				
				if(file.exists()){
					file.delete();
				}
			}
		}
		dao.deleteAllImg(no); // 해당 게시글의 DB에 있는 모든 삽입 이미지 삭제
	}

	response.sendRedirect("/Jboard1/view.jsp?no=" + no + "&pg=" + pg+"&result=202");
%>
				  
