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
	
	// 검색 조건에 맞는 게시물 목록을 반환합니다.(페이징 기능 지원)
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
}
