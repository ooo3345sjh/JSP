package kr.co.jboard2.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import ch.qos.logback.classic.Logger;
import kr.co.jboard2.service.board.ArticleService;
import kr.co.jboard2.utils.JSFunction;
import kr.co.jboard2.vo.ArticleVO;
import kr.co.jboard2.vo.FileVO;
import kr.co.jboard2.vo.UserVO;

@WebServlet("/write.do")
public class WriteController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/write.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 1. 파일 업로드 처리
		// 업로드 디렉터리의 물리적 경로 확인
		String savePath = getServletContext().getRealPath("/file");
		File saveDirectory = new File(savePath);
		
		if(!saveDirectory.exists()) { // savePath 디렉터리가 존재하지않으면 생성
			saveDirectory.mkdirs();
		}
		
		int maxPostSize = 1024 * 1024 * 10; // 10MB
		
		// 파일 업로드 
		MultipartRequest mr = service.uploadFile(req, savePath, maxPostSize);
		if(mr == null) {
			// 파일 업로드 실패
			JSFunction.alertBack(resp, "첨부 파일이 제한 용량을 초과합니다.");
			return;
		}
		
		// 2. 파일 업로드 외 처리
		// 폼값을 VO에 저장
		ArticleVO aVo = new ArticleVO();
		String uid = ((UserVO)req.getAttribute("reqUser")).getUid();
		aVo.setUid(uid);
		aVo.setTitle(mr.getParameter("title"));
		aVo.setContent(mr.getParameter("content"));
		aVo.setFile(mr.getFilesystemName("oriName") == null? 0 : 1);
		aVo.setRegip(req.getRemoteAddr());
		
		
		// 원본 파일명과 저장된 파일 이름 설정
		String oriName = mr.getFilesystemName("oriName");
		String newName = "";
		FileVO fVo = null;
		
		if(oriName != null) { // 첨부 파일이 있으면
			// 파일명 수정
			int i = oriName.lastIndexOf(".");
			String ext = oriName.substring(i);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
			String now = sdf.format(new Date());
			newName = now + uid + ext; // 새로운 파일 이름 설정
			
			File oriFile = new File(saveDirectory, oriName); // saveDirectory에 실제로 존재하는 객체
			File newFile = new File(saveDirectory, newName); // 가상의 파일 객체
			oriFile.renameTo(newFile);
			
			fVo = new FileVO();
			fVo.setNewName(newName);
			fVo.setOriName(oriName);
		} 
		
		// 작성 글 등록
		int result = service.insertArticleAndFile(aVo, fVo);
		
		if(result > 0) { // 글 및 파일 등록 성공시
			resp.sendRedirect(req.getContextPath() + "/list.do");
			return;
		} else {
			JSFunction.alertBack(resp, "글 등록에 실패 했습니다.");
			File file = new File(savePath, newName);
			file.delete();
			return;
		}
	}
}
