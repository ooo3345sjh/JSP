/*
 * DTO(Data Transger Object)객체
 * VO(Value Object)객체
 * 
 * 자바빈즈 규약
 *  - 자바빈즈는 기본(default)패키지 이외의 패키지에 속해야 합니다.
 *  - 멤버 변수(속성)의 접근 지정자는 private으로 선언합니다.
 *  - 멤버 변수에 접근할 수 있는 getter/setter메서드가 있어야 합니다.
 *  - getter/setter 메서드의 접근 지정자는 public으로 선언합니다. 
 */

package common;  // 기본 패키지 이외의 패키지(규약 1번)

public class Person {
	private String name; // private 멤버 변수(규약 2번)
	private int age; // private 멤버 변수(규약 2번)
	
	public Person() {} // 기본 생성자(규약 3번)
	
	public Person(String name, int age) {
		this.name = name;
		this.age = age;
	}
	
	// public 게터/세터 메서드들(규약 4번, 5번)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

}
