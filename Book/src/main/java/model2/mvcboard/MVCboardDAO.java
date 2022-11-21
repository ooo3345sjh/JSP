package model2.mvcboard;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.DBConnPool;

public class MVCboardDAO extends DBConnPool { // 커넥션 풀 상속
	
	public MVCboardDAO() {
		super();
	}
	
	// 검색 조건에 맞는 게시물의 개수를 반환한다.
	public int select(Map<String, Object> map) {
		int totalCount = 0;
		
		// 쿼리문 준비
		String sql = "SELECT COUNT(*) FROM `mvcboard`";
		
		// 검색 조건이 있다면 WHERE절 추가
		if(map.get("searchWord") != null){
			sql += " WHERE " + map.get("searchField") + " "
				+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		try {
			stmt = con.createStatement(); // 쿼리문 생성
			rs = stmt.executeQuery(sql); // 쿼리문 실행
			rs.next();
			totalCount = rs.getInt(1); // 검색괸 게시물 개수 저장
			
		} catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount; // 게시물 개수를 서블릿으로 반환
	}
	
	// 검색 조건에 맞는 게시물 목록을 반환한다.(페이징 기능 지원)
	public List<MVCBoardDTO> slectListPage(Map<String, Object> map){

		List<MVCBoardDTO> board = new ArrayList<>();
		
		// 쿼리문 준비
		String sql = "SELECT b.* FROM " 
				     + " (SELECT *, ROW_NUMBER() OVER(ORDER BY idx desc) rnum "
				     + " FROM `mvcboard` ";
		
		// 검색 조건이 있다면 WHERE절 추가
		if(map.get("searchField") != null) {
			sql += " WHERE " + map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		sql += " ) b LIMIT ?, 10"; // 게시물 구간을 인파라미터로 받기
		
		try {
			psmt = con.prepareStatement(sql); // 동적 쿼리문 생성
			psmt.setInt(1, (int)map.get("limitStart")); // 인파라미터 설정
			rs = psmt.executeQuery(); // 쿼리문 실행
			
			// SQL결과 처리
			while(rs.next()) {
				MVCBoardDTO dto = new MVCBoardDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getString(5).substring(0, 10));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDownCount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitCount(rs.getInt(10));
				
				board.add(dto); // 반환한 게시물 목록을 List 컬렉션에 추가
			}
			
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board; // 목록 반환
	}

	/*
	 * P503 글쓰기 처리 메서드 추가
	 * 게시글 데이터를 받아 DB에 추가한다.(파일 업로드 지원)
	 */
	public int insertWrite(MVCBoardDTO dto) {
		int result = 0;
		try {
			String sql = "INSERT INTO `mvcboard` SET "
					   + " `name`=?,"
					   + " `title`=?,"
					   + " `content`=?,"
					   + " `ofile`=?,"
					   + " `sfile`=?,"
					   + " `pass`=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getPass());
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// P510 일려번호로 게시물 조회
	// 주어진 일련번호에 해당하는 게시물을 DTO에 담아 반환합니다.
	public MVCBoardDTO selectView(String idx) {
		MVCBoardDTO dto = new MVCBoardDTO(); // DTO 객체 생성
		String sql = "SELECT * FROM `mvcboard` WHERE idx=?"; // 쿼리문 템플릿 준비
		try {
			psmt = con.prepareStatement(sql); // 쿼리문 준비
			psmt.setString(1, idx); // 인파라미터 설정
			rs = psmt.executeQuery(); // 쿼리문 실행
			
			if(rs.next()) {
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getString(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDownCount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitCount(rs.getInt(10));
			}
		} catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		return dto; // 결과 반환
	}
	
	// 주어진 일련번호에 해당하는 게시물의 조회수를 1 증가시킵니다.
	public void updateVisitCount(String idx) {
		String sql = "UPDATE `mvcboard` SET "
					 + " `visitcount` =`visitcount` + 1 "
					 + " WHERE idx=? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	/* P516 DAO에 메서드 추가 */
	// 다운로드 횟수를 1증가시킵니다.
	public void downCountPlus(String idx) {
		
		try {
			
			String sql = "UPDATE `mvcboard` SET"
					+ " downcount = downcount + 1"
					+ " WHERE idx=? ";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("다운로드 횟수 증가 중 오류 발생");
			e.printStackTrace();
		}
				
	}
	
	/* P524 DAO에 메서드 추가 */
	// 입력한 비밀번호가 지정한 일련번호의 게시물의 비밀번호와 일치하는지 확인합니다.
	public boolean confirmPassword(String pass, String idx) {
		boolean isCorr = true;
		try {
			String sql = "SELECT COUNT(*) FROM `mvcboard` WHERE `pass`=? AND `idx`=? ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, pass);
			psmt.setString(2, idx);
			rs = psmt.executeQuery();
			rs.next();
			if(rs.getInt(1) <= 0) {
				isCorr = false;
			}
			
		} catch (Exception e) {
			isCorr = false;
			e.printStackTrace();
		}
		
		return isCorr;
	}
	
	// 지정한 일련번호의 게시물을 삭제합니다.
	public int deletePost(String idx) {
		int result = 0;
		try {
			String sql = "DELETE FROM `mvcboard` WHERE `idx`=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 게시글 데이터를 받아 DB에 저장되어 있던 내용을 갱신합니다.(파일 업로드 지원)
	public int updatePost(MVCBoardDTO dto) {
		int result = 0;
		
		try {
			// 쿼리문 템플리 준비
			String sql = "UPDATE `mvcboard` SET"
					   + " `title`=?,"
					   + " `name`=?,"
					   + " `content`=?,"
					   + " `ofile`=?,"
					   + " `sfile`=?"
					   + " WHERE `idx`=? AND `pass`=?";
			
			// 쿼리문 준비 
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getIdx());
			psmt.setString(7, dto.getPass());
			
			// 쿼리문 실행
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	
}
