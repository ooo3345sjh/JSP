package kr.co.farmStory2.controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmStory2.service.board.ArticleService;
import kr.co.farmStory2.utils.JSFunction;
import kr.co.farmStory2.vo.FileVO;

@WebServlet("/board/download.do")
public class DownloadController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("DownloadController doGet...");
		String fromUrl = req.getHeader("referer"); // 요청을 하는 uri
		
		if(fromUrl == null || !fromUrl.contains("view.do")) { 
			JSFunction.alertBack(resp, "비정상적인 접근입니다.");
			return;
		}
		
		int no = Integer.parseInt(req.getParameter("no"));
		FileVO vo = service.selectFile(no); // 파일 정보를 가져온다.
		service.plusDownload(no);           // 다운로드 횟수 +1
		service.downloadFile(req, resp, "/file", vo.getNewName(), vo.getOriName()); // 파일을 다운로드한다.
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}

}
