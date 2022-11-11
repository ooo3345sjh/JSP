package model2.mvcboard;

import java.util.Map;

public class BoardPage {
	
	// 페이지 태그 문자열을 반환하는 메서드
	public static String getPageTags(Map<String , Object> map) {
		
		int pageGroupStart = (int)map.get("pageGroupStart"); 
		int pageGroupEnd = (int)map.get("pageGroupEnd");
		int pageGroupCurrent = (int)map.get("pageGroupCurrent");
		int currentPage = (int)map.get("currentPage");
		int lastPageNum = (int)map.get("lastPageNum");
		
		int prevPage = pageGroupStart - 1; // 이전 페이지
		int nextPage = pageGroupEnd + 1; // 다음 페이지
		String pageTags = ""; // 페이지 태그 모음
		
		if(pageGroupCurrent > 1) {
			pageTags = "<a href=\"/Book/Ch14/list.do?pageNum=" 
		             + prevPage + "\">이전페이지</a>&nbsp;";
		}
			
		
		for(int i=pageGroupStart; i<=pageGroupEnd; i++) {
			
			if(currentPage == i) { // 현재 페이지와 값이 같다면 링크X 
				pageTags += String.valueOf(i) + "&nbsp;";
			} else { // 현재 페이지와 값이 같다면 링크O 
				pageTags += "<a href=\"/Book/Ch14/list.do?pageNum=" + i + "\">" 
								  + String.valueOf(i) + "</a>&nbsp;";
			}
			
		}
		
		if(pageGroupEnd < lastPageNum ) { // 반복문의 마지막이며 마지막 페이지 번호보다 작을 경우
			pageTags += "<a href=\"/Book/Ch14/list.do?pageNum=" 
					+ nextPage + "\">다음페이지</a>"; 
		}
		
		return pageTags;
	}
	

}
