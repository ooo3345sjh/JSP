package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fileupload.FileUtil;
import utils.JSFunction;

/*
 * 날짜 : 2022/11/11
 * 이름 : 서정현
 * 내용 : 페이지 이동 서블릿
 */
@WebServlet("/Ch14/pass.do")
public class PassController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("mode", req.getParameter("mode"));
		req.getRequestDispatcher("/Ch14/P523.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 매개변수 저장
		String idx = req.getParameter("idx");
		String mode = req.getParameter("mode");
		String pass = req.getParameter("pass");
		
		// 비밀번호 확인
		MVCboardDAO dao = new MVCboardDAO();
		boolean confirmed = dao.confirmPassword(pass, idx);
		System.out.println(pass);
		System.out.println(confirmed);
		dao.close();
		
		if(confirmed) { // 비밀번호 일치
			if(mode.equals("edit")) { // 수정 모드
				HttpSession session = req.getSession();
				session.setAttribute("pass", pass);
				resp.sendRedirect("../Ch14/edit.do?idx=" + idx);
			}
			else if (mode.equals("delete")) { // 삭제 모드
				dao = new MVCboardDAO();
				MVCBoardDTO dto = dao.selectView(idx);
				int result = dao.deletePost(idx); // 게시물 삭제
				dao.close();
				if(result == 1) { // 게시물 삭제 성공시 첨부파일도 삭제
					String saveFileName = dto.getSfile();
					FileUtil.deleteFile(req, "/file", saveFileName);
				}
				JSFunction.alertLocation(resp, "삭제되었습니다.", "../Ch14/list.do");
			}
		} else { // 비밀번호 불일치
			JSFunction.alertBack(resp, "비밀번호 검증에 실패했습니다.");
		}
	}
}
