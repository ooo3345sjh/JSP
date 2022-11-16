package kr.co.FarmStory1.utils;

import javax.servlet.jsp.JspWriter;

public class JSFunction {
	// 메시지 알림창을 띄운 후 명시한 URL로 이동한다.
	public static void alertLocation(String msg, String url, JspWriter out) {
		
		try {
			String script = "" // 삽입할 자바스크립트 코드
					      + "<script>"
					      + "	alert('" + msg + "');"
					      + "	location.href = '" + url + "';"
					      + "</script>";
			out.print(script);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// 메시지 알림창을 띄운 후 이전 페이지로 이동한다.
	public static void alertBack(String msg, JspWriter out) {
		
		try {
			String script = "" // 삽입할 자바스크립트 코드
					+ "<script>"
					+ "	alert('" + msg + "');"
					+ "	location.back();"
					+ "</script>";
			out.print(script);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
