package customer;

public class CustomerDTO {
	// 고객 테이블 컬럼
	private int custId;
	private String name;
	private String address;
	private String phone;
	
	// 게터 및 세터
	public int getCustId() {
		return custId;
	}
	public void setCustId(int cusId) {
		this.custId = cusId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	
}
