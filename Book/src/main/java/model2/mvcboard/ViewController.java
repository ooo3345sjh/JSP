package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * 날짜 : 2022/11/08
 * 이름 : 서정현
 * 내용 : 상세 보기 서블릿 
 */
@WebServlet("/Ch14/view.do")
public class ViewController  extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 게시물 불러오기
		MVCboardDAO dao = new MVCboardDAO();
		String idx = req.getParameter("idx");
		dao.updateVisitCount(idx); // 조회수 1 증가
		MVCBoardDTO dto = dao.selectView(idx);
		dao.close();
		
		// 줄바꿈 처리
		dto.setContent(dto.getContent().replace("\r\n", "<br/>"));
		
		// 게시물(dto) 저장 후 뷰로 포워드
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/Ch14/P513.jsp").forward(req, resp);
	}
}
