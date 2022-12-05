package kr.co.farmStory2.controller.board;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet("/fileUpload.do")
public class FileUploadController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("FileUploadController doPost...");
		String return1="";
		String return2="";
		String return3="";
		String name = "";
		 
		if (ServletFileUpload.isMultipartContent(req)){
		    ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
		    uploadHandler.setHeaderEncoding("UTF-8");
		    List<FileItem> items = null;
			try {
				items = uploadHandler.parseRequest(req);
			} catch (FileUploadException e) {
				logger.error(e.getMessage());
			}
		    for (FileItem item : items) {
		        if(item.getFieldName().equals("callback")) {
		            return1 = item.getString("UTF-8");
		        } else if(item.getFieldName().equals("callback_func")) {
		            return2 = "?callback_func="+item.getString("UTF-8");
		        } else if(item.getFieldName().equals("Filedata")) {
		            if(item.getSize() > 0) {
		      
		                name = item.getName().substring(item.getName().lastIndexOf(File.separator)+1);
		                String filename_ext = name.substring(name.lastIndexOf(".")+1);
		                filename_ext = filename_ext.toLowerCase();
		                String[] allow_file = {"jpg","png","bmp","gif"};
		                int cnt = 0;
		                for(int i=0; i<allow_file.length; i++) {
		                    if(filename_ext.equals(allow_file[i])){
		                        cnt++;
		                    }
		                }
		                if(cnt == 0) {
		                    return3 = "&errstr="+name;
		                } else {
		                     
		                    //파일 기본경로
		                    String dftFilePath = req.getSession(false).getServletContext().getRealPath("/");
		                    //파일 기본경로 _ 상세경로
		                    String filePath = dftFilePath + File.separator +"smartEditor/inputImage" + File.separator;
		                     
		                    File file = null;
		                    file = new File(filePath);
		                    if(!file.exists()) {
		                        file.mkdirs();
		                    }
		                     
		                    String realFileNm = "";
		                    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		                    String today= formatter.format(new java.util.Date());
		                    realFileNm = today+UUID.randomUUID().toString() + name.substring(name.lastIndexOf("."));
		                     
		                    String rlFileNm = filePath + realFileNm;
		                    ///////////////// 서버에 파일쓰기 ///////////////// 
		                    InputStream is = item.getInputStream();
		                    OutputStream os=new FileOutputStream(rlFileNm);
		                    int numRead;
		                    byte b[] = new byte[(int)item.getSize()];
		                    while((numRead = is.read(b,0,b.length)) != -1){
		                        os.write(b,0,numRead);
		                    }
		                    if(is != null) {
		                        is.close();
		                    }
		                    os.flush();
		                    os.close();
		                    ///////////////// 서버에 파일쓰기 /////////////////
		                     
		                    return3 += "&bNewLine=true";
		                                // img 태그의 title 옵션에 들어갈 원본파일명
		                    return3 += "&sFileName="+ name;
		                    return3 += "&sFileURL=" + filePath + realFileNm;
		                }
		            }else {
		                  return3 += "&errstr=error";
		            }
		        }
		    }
		}
		resp.sendRedirect(return1+return2+return3);
	}
}
