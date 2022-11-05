<%@page import="java.nio.file.StandardCopyOption"%>
<%@page import="java.nio.file.Files"%>
<%@page import="kr.co.jboard1.bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.io.*"%>
<%@page import="java.util.UUID"%>
<%@page import="java.text.SimpleDateFormat"%>
 
<%
    //파일정보
    String sFileInfo = "";
    //파일명을 받는다 - 일반 원본파일명
    String filename = request.getHeader("file-name");
    //파일 확장자
    String filename_ext = filename.substring(filename.lastIndexOf(".") + 1);
    //확장자를소문자로 변경
    filename_ext = filename_ext.toLowerCase();
 
    //이미지 검증 배열변수
    String[] allow_file = { "jpg", "png", "bmp", "gif" };
 
    //돌리면서 확장자가 이미지인지 
    int cnt = 0;
    for (int i = 0; i < allow_file.length; i++) {
        if (filename_ext.equals(allow_file[i])) {
            cnt++;
        }
    }
 
    //이미지가 아님
    if (cnt == 0) {
        out.println("NOTALLOW_" + filename);
    } else {
        //이미지이므로 신규 파일로 디렉토리 설정 및 업로드   
        //파일 기본경로
        String dftFilePath = request.getSession().getServletContext().getRealPath("/");
        //파일 기본경로 _ 상세경로
        String filePath = dftFilePath + "file" + File.separator;
        String tempFilePath = dftFilePath + "smartEditor" + File.separator + "temp" + File.separator; // 임시 저장소 경로
        File file = new File(filePath);
        if (!file.exists()) {
            file.mkdirs();
        }
        String realFileNm = "";
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmssSSSS");
        String today = formatter.format(new java.util.Date());
        String random = String.valueOf((int)(Math.random()*9000000 + 1000000));
        realFileNm = "image" + today+ random + filename.substring(filename.lastIndexOf("."));
        String rlFileNm = filePath + realFileNm;
        ///////////////// 서버에 파일쓰기 ///////////////// 
        InputStream is = request.getInputStream();
        OutputStream os = new FileOutputStream(rlFileNm);
        int numRead;
        byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
        while ((numRead = is.read(b, 0, b.length)) != -1) {
            os.write(b, 0, numRead);
        }
        if (is != null) {
            is.close();
        }
        os.flush();
        os.close();
        
        // 임시 저장소에 파일 복사
        File ofile = new File(filePath, realFileNm);
        File tmpFile = new File(tempFilePath, realFileNm);
        File tmpFolder = new File(tempFilePath);
        
        if(!tmpFolder.exists()){
        	tmpFolder.mkdir();
        }
        Files.copy(ofile.toPath(), tmpFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
        
        ///////////////// 서버에 파일쓰기 /////////////////
 
        session.setAttribute("realFileNm", realFileNm);
        // 정보 출력
        sFileInfo += "&bNewLine=true";    
        sFileInfo += "&sFileName=" + filename;    
        sFileInfo += "&sFileURL=/Jboard1/file/"+realFileNm;
        out.println(sFileInfo);
    }
%>