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
		List<ArticleVO> articles = null;
		
		try {
			con = getConnection();
			String sql = "SELECT a.*, u.nick FROM `board_article` a "
					   + " JOIN `board_user` u "
					   + " ON a.uid = u.uid "
					   + " WHERE a.cate=? "
					   + " ORDER BY a.`no` desc"
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
	
	public ArticleVO selectArticle(String no) {
		
		ArticleVO vo = null;
		try {
			con = getConnection();
			String sql = "SELECT a.*, f.`oriName` FROM `board_article` a "
				       + "LEFT JOIN `board_file` f "
				       + "ON a.`no`= f.`parent` "
				       + "WHERE `no`=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, no);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new ArticleVO();
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
				vo.setFname(rs.getString(12));
			}
			
			close();
		} catch (Exception e) {
			System.out.println("조건에 해당하는 게시물 조회 중 에러발생");
			e.printStackTrace();
		}
		return vo;
	}
	
	public void insertFile(int parent, String newName, String oriName) {
		try {
			con = getConnection();
			String sql = "INSERT INTO `board_file` SET"
					   + "	`parent` = ?, "
					   + "	`newName` = ?, "
					   + "	`oriName` = ?";
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, parent);
			psmt.setString(2, newName);
			psmt.setString(3, oriName);
			
			psmt.executeUpdate();
			
			close();
		} catch (Exception e) {
			System.out.println("파일 정보 추가 중 에러 발생");
			e.printStackTrace();
		}
	}
	public int insertArticle(ArticleVO vo) {
		int no = 0;
		
		try {
			con = getConnection();
			con.setAutoCommit(false);
			String sql = "INSERT INTO `board_article` SET "
					   + " `cate`=?, "
					   + " `title`=?, "
					   + " `content`=?, "
					   + " `uid`=?, "
					   + " `regip`=?, "
					   + " `rdate`=NOW() ";
			
			String MaxNoSql = "SELECT MAX(`no`) FROM `board_article`";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, vo.getCate());
			psmt.setString(2, vo.getTitle());
			psmt.setString(3, vo.getContent());
			psmt.setString(4, vo.getFname() == null ? "0":"1");
			psmt.setString(4, vo.getUid());
			psmt.setString(5, vo.getRegip());
			
			stmt = con.createStatement();
			
			psmt.executeUpdate();
			rs = stmt.executeQuery(MaxNoSql);
			
			con.commit();
			
			if(rs.next()) {
				no = rs.getInt(1);
			}
			
			close();
		} catch (Exception e) {
			System.out.println("게시물 추가중 에러발생");
			e.printStackTrace();
		}
		return no;
	}
	
	public void deleteArticle(String no) {
		try {
			con = getConnection();
			String sql = "DELETE a.*, f.* FROM `board_article` a "
					   + "LEFT JOIN `board_file` f "
					   + "ON a.`no` = f.`parent` "
					   + "WHERE a.`no`=? or a.`parent`=? ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, no);
			psmt.setString(2, no);
			
			psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 삭제 중 에러 발생");
			e.printStackTrace();
		}
	}
	public void updateArticle() {}
}
