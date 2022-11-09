package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/*
 * 날짜 : 2022/11/09
 * 이름 : 서정현
 * 내용 : 필터 실습하기
 * 
 */
public class ThirdFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		System.out.println("ThirdFilter...");
		
		// 전송 데이터 인코딩 설정
		request.setCharacterEncoding("utf-8");
		
		chain.doFilter(request, response);
	}
	
	

}
