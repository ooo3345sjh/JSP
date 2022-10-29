package kr.co.jboard1.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.jboard1.bean.CommentBean;
import kr.co.jboard1.db.DBCP;
import kr.co.jboard1.db.Sql;

public class CommentDAO {
	
	private static CommentDAO instance = new CommentDAO();
	private CommentDAO() {}
	
	public static CommentDAO getInstance() {
		return instance;
	}
	
	// 기본 CRUD
	public Map<String, Integer> insertComment(CommentBean cb) {
		
		Map<String, Integer> map = null;
		
		int result = 0; // 업데이트 결과 성공 여부를 전달하는 변수 성공 : 1 / 실패 : 0
		
		try{
			// 1, 2단계 - DB 접속
			Connection con = DBCP.getConnection();
			
			/*** 트랜잭션 시작 ***/
			con.setAutoCommit(false);
			
			// 3단계 - SQL실행 객체 생성
			PreparedStatement updatePsmt = con.prepareStatement(Sql.UPDATE_ARTICLE_COMMENT_PLUSE);
			updatePsmt.setInt(1, cb.getParent());
			
			PreparedStatement insertPsmt = con.prepareStatement(Sql.INSERT_COMMENT);
			insertPsmt.setInt(1, cb.getParent());
			insertPsmt.setString(2, cb.getComment());
			insertPsmt.setString(3, cb.getUid());
			insertPsmt.setString(4, cb.getNick());
			insertPsmt.setString(5, cb.getRegip());
			insertPsmt.setString(6, cb.getRdate());
			
			Statement selectPsmt = con.createStatement();
				
			// 4단계 - SQL실행
			updatePsmt.executeUpdate();
			result = insertPsmt.executeUpdate();
			ResultSet rs = selectPsmt.executeQuery(Sql.SELECT_NO);
			
			map = new HashMap<>();
			
			if(rs.next()) {
				map.put("no", rs.getInt(1));
			}
			
			con.commit(); 
			/*** 트랜잭션 종료 ***/
			
			// 5단계 - 연결 해제
			con.close();
			insertPsmt.close();
			updatePsmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		map.put("result", result);
	
		return map;
	}
	
	public List<CommentBean> selectComments(String parent) {
		
		List<CommentBean> comments = null; // 댓글들을 저장하기위한 변수
		
		try{
			// 1, 2단계 - DB 접속
			Connection con = DBCP.getConnection();
			
			// 3단계 - SQL실행 객체 생성
			PreparedStatement psmt = con.prepareStatement(Sql.SELECT_COMMENTS);
			psmt.setString(1, parent);
			
			// 4단계 - SQL실행
			ResultSet rs = psmt.executeQuery();
			
			// 5단계 - SQL결과 처리
			comments = new ArrayList<>();
			while(rs.next()){
				CommentBean cb = new CommentBean();
				cb.setNo(rs.getInt(1));
				cb.setParent(rs.getInt(2));
				cb.setComment(rs.getString(3));
				cb.setUid(rs.getString(4));
				cb.setNick(rs.getString(5));
				cb.setRegip(rs.getString(6));
				cb.setRdate(rs.getString(7));
				
				comments.add(cb);
			}
			
			// 6단계 - 연결 해제
			con.close();
			psmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return comments;
	}
	public int deleteComment(String no, String commentNo) {
		
		int result = 0; // 업데이트 결과 성공 여부를 전달하는 변수 성공 : 1 / 실패 : 0
		
		try{
			// 1, 2단계 - DB 접속
			Connection con = DBCP.getConnection();
			
			/*** 트랜잭션 시작 ***/
			con.setAutoCommit(false); 
			
			// 댓글 번호에 해당하는 댓글을 삭제하는 쿼리
			String deleteComment = "DELETE FROM `board_comment` WHERE `no`= ? ";
			
			// 댓글이 삭제되었으므로 board_article 테이블의 comment컬럼의 개수도 빼준다.
			String updateHit = "UPDATE `board_article` SET `comment` = `comment`-1 WHERE `no`=?";
			
			PreparedStatement updatePsmt = con.prepareStatement(Sql.UPDATE_ARTICLE_COMMENT_MINUS);
			updatePsmt.setString(1, no);
			
			PreparedStatement deletePsmt = con.prepareStatement(Sql.DELETE_COMMENT);
			deletePsmt.setString(1, commentNo);
			
			// 4단계 - SQL실행
			updatePsmt.executeUpdate();
			result = deletePsmt.executeUpdate();
			
			con.commit(); 
			/*** 트랜잭션 종료 ***/
			
			// 6단계 - 연결 해제
			con.close();
			deletePsmt.close();
			updatePsmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}
	
	public int updateComment(String comment, String no) {
		
		int result = 0; // 업데이트 결과 성공 여부를 전달하는 변수 성공 : 1 / 실패 : 0
		
		try{
			Connection con = DBCP.getConnection();
					
			PreparedStatement psmt = con.prepareStatement(Sql.UPDATE_COMMENT);
			psmt.setString(1, comment);
			psmt.setString(2, no);
			
			result = psmt.executeUpdate();
			
			con.close();
			psmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return result;
	}
}
