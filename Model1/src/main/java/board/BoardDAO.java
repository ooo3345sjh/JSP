package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;

import config.DBCP;

public class BoardDAO {
	
	private PreparedStatement psmt;
	private Statement stmt;
	private Connection con;
	private ResultSet rs;
	
	public BoardDAO() {
		try {
			con = DBCP.getConnection();
		} catch (NamingException | SQLException e) {
			System.out.println("DB 접속 실패");
			e.printStackTrace();
		}
	}
	
	// 검색 조건에 맞는 게시물의 개수를 반환합니다.
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0; // 결과(게시물 수)를 담을 변수
		
		// 게시물 수를 얻어오는 쿼리문 작성
		String sql = "SELECT COUNT(*) FROM `board` ";
		if(map.get("searchWord") != null) {
			sql += " WHERE " + map.get("searchField") + " " 
				+ " LIKE '%"+ map.get("searchWord") + "%'";
		}
		
		try {
			stmt = con.createStatement(); // 쿼리문 생성
			rs = stmt.executeQuery(sql); // 쿼리 실행
			rs.next(); // 커서를 첫 번째 행으로 이동
			totalCount = rs.getInt(1); // 첫 번째 컬럼 값을 가져옴
			
		} catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	// 검색 조건에 맞는 게시물 목록을 반환합니다.
	public List<BoardDTO> selectList(Map<String, Object> map){
		List<BoardDTO> bbs = new ArrayList<>(); // 결과(게시물 목록)을 담을 변수
		
		String sql = "SELECT * FROM `board`";
		if(map.get("searchWord") != null) {
			sql += "WHERE " + map.get("searchField") + " "
				+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		sql += " ORDER BY num DESC";
		
		try {
			stmt = con.createStatement(); // 쿼리문 생성
			rs =  stmt.executeQuery(sql); // 쿼리 실행
			
			while(rs.next()) { // 결과를 순회하며...
				// 한 행(게시물 하나)의 내용을 DTO에 저장
				BoardDTO dto = new BoardDTO(); 
				
				dto.setNum(rs.getInt("num")); // 일련번호
				dto.setTitle(rs.getString("title")); // 제목
				dto.setContent(rs.getString("content")); // 내용
				dto.setId(rs.getString("id")); // 작성일
				dto.setPostdate(rs.getString("postdate")); // 작성자 아이디
				dto.setVisitCount(rs.getInt("visitcount")); // 조회수
				
				bbs.add(dto); // 결과 목록에 저장
			}
			
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	// 게시글을 추가하는 메서드
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		try {
			String sql = "INSERT INTO `board`(`title`, `content`, `id`, `visitcount`) VALUES(?,?,?,0)";
			psmt = con.prepareStatement(sql);
			
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 게시글 번호에 맞는 게시글을 가져오는 메서드
	public BoardDTO selectView(String num) {
		
		BoardDTO dto = null;
		
		try {
			String sql = "SELECT b.*, m.name "
					   + " FROM `board` b join `member` m "
					   + " on b.id = m.id WHERE b.num=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setId(rs.getString(4));
				dto.setPostdate(rs.getString(5));
				dto.setVisitCount(rs.getInt(6));
				dto.setName(rs.getString("name"));
			}
		} catch (Exception e) {
			System.out.println("게시글 보기 중 에러 발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	// 지정한 게시물의 조회수를 1 증가시킵니다.
	public int updateVisitCount(String num) {
		int result = 0;
		
		try {
			String sql = "UPDATE `board` SET `visitcount`=`visitcount`+1 WHERE `num`=?";
			psmt = con.prepareStatement(sql);
			
			psmt.setString(1, num);
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("조회수 증가중 에러 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	
	// 연결을 해제하는 메서드
	public void close() {
		try {
			if(con != null) con.close();
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(psmt != null) psmt.close();
			
		} catch (Exception e) {
			System.out.println("연결 해제중 에러 발생");
			e.printStackTrace();
		}
		System.out.println("연결 해제 완료");
		System.out.println("연결 해제 완료");
	}

}
