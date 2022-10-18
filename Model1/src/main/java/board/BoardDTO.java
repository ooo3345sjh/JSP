package board;

public class BoardDTO {
	
	// 멤버 변수 선언
	private int num;
	private String title;
	private String content;
	private String id;
	private String posdate;
	private int visitCount;
	private String name;

	// 게터/세터
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
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
	public String getPosdate() {
		return posdate;
	}
	public void setPosdate(String posdate) {
		this.posdate = posdate;
	}
	public int getVisitCount() {
		return visitCount;
	}
	public void setVisitCount(int visitCount) {
		this.visitCount = visitCount;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
