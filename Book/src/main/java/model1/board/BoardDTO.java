package model1.board;

/*
 * 날짜 : 2022/10/16
 * 이름 : 서정현
 * 내용 : 게시물 목록용 DTO
 */
public class BoardDTO {
	// 멤버 변수 선언
	private String num;
	private String title;
	private String content;
	private String id;
	private String postdate;
	private String visitcount;
	private String name;

	// 게터 및 세터
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPostdate() {
		return postdate;
	}
	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}
	public String getVisitcount() {
		return visitcount;
	}
	public void setVisitcount(String vistitcount) {
		this.visitcount = vistitcount;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
	

}
