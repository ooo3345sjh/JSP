package kr.co.FarmStory1.dao;

import java.util.ArrayList;
import java.util.List;

import kr.co.FarmStory1.db.DBHelper;
import kr.co.FarmStory1.vo.ArticleVO;

public class BoardDAO extends DBHelper {
	
	private static BoardDAO instance = new BoardDAO();
	
	public static BoardDAO getInstance() {
		return instance;
	}
	private BoardDAO() {}
	
	public int selectArticleCountTotal(String cate) {
		cate = "free";
		int total = 0;
		
		try {
			con = getConnection();
			String sql = "SELECT COUNT(`no`) FROM `board_article` "
					   + " WHERE `cate`=? ";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, cate);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				total = rs.getInt(1);
			}
			close();
			
		} catch (Exception e) {
			System.out.println("전체 게시물 개수 조회 중 에러 발생");
			e.printStackTrace();
		}
		return total;
		
	}
	public List<ArticleVO> selectArticles(String cate, int limitStart) {
		cate = "free";
		List<ArticleVO> articles = null;
		
		try {
			con = getConnection();
			String sql = "SELECT a.*, u.nick FROM `board_article` a "
					   + " JOIN `board_user` u "
					   + " ON a.uid = u.uid "
					   + " WHERE a.cate=? "
					   + " limit ?, 10 ";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, cate);
			psmt.setInt(2, limitStart);
			rs = psmt.executeQuery();
			articles = new ArrayList<>();
			
			while(rs.next()) {
				ArticleVO vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRegip(rs.getString(10));
				vo.setRdate(rs.getString(11));
				vo.setNick(rs.getString(12));
				
				articles.add(vo);
			}
			close();
			
		} catch (Exception e) {
			System.out.println("전체 게시물 조회 중 에러 발생");
			e.printStackTrace();
		}
		return articles;
	}
	public void selectArticle() {}
	public void insertArticle() {}
	public void deleteArticle() {}
	public void updateArticle() {}
}
