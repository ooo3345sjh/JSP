package kr.co.jboard1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.co.jboard1.bean.ArticleBean;
import kr.co.jboard1.db.DBCP;
import kr.co.jboard1.db.Sql;

// DAO(Data Access Object) : 데이터베이스 처리 클래스
public class ArticleDAO {
	
	private static ArticleDAO instance = new ArticleDAO();
	
	public static ArticleDAO getInstance() {
		return instance;
	}
	
	private ArticleDAO() {}
	
	// 기본 CRUD
	public void insertArticle() {}
	public void selectArticle() {}
	
	// 모든 게시물의 수를 가져오는 메서드
	public int selectCountTotal() {

		int total = 0;
		try{
			Connection con = DBCP.getConnection();
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(Sql.SELECT_COUNT_TOTAL);
			
			if(rs.next()){
				total = rs.getInt(1);
			}
			
			con.close();
			rs.close();
			stmt.close();
			
		} catch(Exception e){
			e.printStackTrace();	
		}
		return total;
	}
	
	// 모든 게시물을 가져오는 메서드
	public List<ArticleBean> selectArticles(int limitStart) {
		
		List<ArticleBean> articles = null;
		
		try{
			Connection con = DBCP.getConnection();
			PreparedStatement psmt = con.prepareStatement(Sql.SELECT_ARTICLE);
			psmt.setInt(1,  limitStart);
			ResultSet rs = psmt.executeQuery();
			
			articles = new ArrayList<>();
			
			while(rs.next()){
				ArticleBean ab = new ArticleBean();
				ab.setNo(rs.getInt("no"));
				ab.setParent(rs.getInt("parent"));
				ab.setComment(rs.getInt("comment"));
				ab.setCate(rs.getString("cate"));
				ab.setContent(rs.getString("content"));
				ab.setTitle(rs.getString("title"));
				ab.setUid(rs.getString("uid"));
				ab.setRdate(rs.getDate("rdate"));
				ab.setHit(rs.getInt("hit"));
				ab.setFile(rs.getInt("file"));
				ab.setRegip(rs.getString("regip"));
				ab.setNick(rs.getString("nick"));
				
				
				articles.add(ab);			
			}
			
			con.close();
			rs.close();
			psmt.close();
			
		} catch(Exception e){
			e.printStackTrace();	
		}
		return articles;
	}
	
	public void updateArticle() {}
	public void deleteArticle() {}
}
