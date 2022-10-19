package util;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;

public class JSFunction {
	
	// 메시지 알림창을 띄운 후 명시한 URL로 이동합니다.
	public static void alertLocationn(String msg, String url, JspWriter out) {
		String script = "" // 삽입할 자바스크립트 코드
				      + "<script>"
				      + "	alert('"+ msg + "');"
				      + " 	location.href='" + url + "';" 
				      + "</script>";
		
		try {
			out.println(script); // 자바스크립트 코드를 out 내장 객체로 출력(삽입)
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 메시지 알림창을 띄운 후 이전 페이지로 돌아갑니다.
	public static void alertBack(String msg, JspWriter out) {
		String script = ""
				      + "<script>"
				      + "	alery('" + msg + "');"
				      + " 	history.back();"
				      + "</script>";
		try {
			out.println(script);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
