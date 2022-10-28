package fileupload;

import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;

/*
 * 날짜 : 2022/10/27
 * 이름 : 서정현
 * 내용 : 파일 업로드용 DAO 클래스
 */
public class MyfileDAO extends DBConnPool{
	// 새로운 게시물을 입력합니다.
	public int insertFile(MyfileDTO dto) {
		int applyResult = 0;
		try {
			String sql = "INSERT INTO `myfile` SET "
					   + "name = ?,"
					   + "title = ?,"
					   + "cate = ?,"
					   + "ofile = ?,"
					   + "sfile = ?";
			psmt = con.prepareStatement(sql);
			
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getCate());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			
			applyResult = psmt.executeUpdate();
			
			close();
		} catch (Exception e) {
			System.out.println("INSERT 중 예외 발생");
			e.printStackTrace();
		}
		return applyResult;
	}
	
	// 파일 목록을 반환합니다.
	public List<MyfileDTO> myFileList(){
		List<MyfileDTO> fileList = null;
		
		// 쿼리문 작성
		String sql = "SELECT * FROM `myfile` ORDER BY idx DESC";
		try {
			psmt = con.prepareStatement(sql);
			
			rs = psmt.executeQuery();
			fileList = new ArrayList<>();
			
			while(rs.next()){
				MyfileDTO dto = new MyfileDTO();
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setCate(rs.getString(4));
				dto.setOfile(rs.getString(5));
				dto.setSfile(rs.getString(6));
				dto.setPostdate(rs.getString(7));
				
				fileList.add(dto); // 목록에 추가
			}
			
		} catch (Exception e) {
			System.out.println("SELECT 시 예외 발생");
			e.printStackTrace();
		}
		
		return fileList; // 목록 반환
	}
}
