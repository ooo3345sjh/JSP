<%@page import="fileupload.MyfileDAO"%>
<%@page import="fileupload.MyfileDTO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%
	String saveDirectory = application.getRealPath("/Uploads");
	int maxPostSize = 1024 * 1000; // 파일 최대 크기(1MB)
	String encoding = "UTF-8"; // 인코딩 방식
	
	try {
	
		// 1. MutipartRequest 객체 생성
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, 
				maxPostSize, encoding);
	
		// 2. 새로운 파일명 생성
		String fileName = mr.getFilesystemName("attachedFile"); // 현재 파일 이름
		String ext = fileName.substring(fileName.lastIndexOf(".")); // 파일 확장자
		String now = new SimpleDateFormat("yyyyMMddhhmmss_").format(new Date());
		String newFileName = now + ext; // 새로운 파일 이름 ("업로드일시.확장자")
		
		// 3. 파일명 변셩
		File oldFile = new File(saveDirectory + "/" + fileName);
		File newFile = new File(saveDirectory + File.separator + newFileName);
		oldFile.renameTo(newFile);
		
		// 4. 다른 폼값 받기
		String name = mr.getParameter("name");
		String title = mr.getParameter("title");
		String[] cateArray = mr.getParameterValues("cate");
		String cate = null;
		if(cateArray == null){
			cate ="선택 없음";
		} else {
			cate = String.join(", ", cateArray);
		}
		
		// 5. DTO 생성
		MyfileDTO dto =  new MyfileDTO();
		dto.setName(name);
		dto.setTitle(title);
		dto.setCate(cate);
		dto.setOfile(fileName);
		dto.setSfile(newFileName);
		
		// 6. DAO를 통해 데이터베이스에 반영
		MyfileDAO dao = new MyfileDAO();
		dao.insertFile(dto);
		dao.close();
		
		// 7. 파일 목록 JSP로 리다이렉션
		response.sendRedirect("P437.jsp");
		
	}catch(Exception e){
		e.printStackTrace();
		request.setAttribute("errorMessage", "파일 업로드 오류");
		request.getRequestDispatcher("P422.jsp").forward(request, response);
	
	}
	
%>

<%--
	날짜 : 2022/10/27
	이름 : 서정현
	내용 : 파일 업로드 처리 JSP
--%>