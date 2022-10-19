<%@page import="DB.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<script>
	// 동의 체크박스 체크가 되어있지 않으면 다음으로 진행 못하게 하는 함수
	$(function() {
		$('.btnNext').click(function() {
			let isChecked1 = $('input[class=terms]').is(':checked');
			let isChecked2 = $('input[class=privacy]').is(':checked');
			if(isChecked1 && isChecked2){
				return true;
			} else {
				alert('동의 체크를 하셔야 합니다.');
				return false;
			}
		});
	});
</script>
<%
	String terms = null; // 사이트 이용약관
	String privacy = null; // 개인정보 취급방침

	try{
		// 1, 2단계 - JDBC 드라이버 로드 및 DB 접속
		Connection con = DBCP.getConnection();
		
		// 3단계 - SQL실행 객체 생성
		String sql = "SELECT * FROM `board_terms`";
		Statement stmt = con.createStatement();
		
		// 4단계 -  SQL실행
		ResultSet rs = stmt.executeQuery(sql);
		
		// 5단계 - SQL결과 처리
		if(rs.next()){
			terms = rs.getString(1);
			privacy = rs.getString(2);
		}
		
		// 6단계 - 연결해제
		con.close();
		stmt.close();
		rs.close();
		
	} catch(Exception e){
		e.printStackTrace();
	}
%>
        <main id="user">
            <section class="terms">
                <table border="1">
                    <caption>사이트 이용약관</caption>
                    <tr>
                        <td>
                            <textarea name="terms" readonly><%= terms %></textarea>
                            <label><input type="checkbox" class="terms">&nbsp;동의합니다.</label>
                        </td>
                    </tr>
                </table>
                <table border="1">
                    <caption>개인정보 취급방침</caption>
                    <tr>
                        <td>
                            <textarea name="privacy" readonly><%= privacy %></textarea>
                            <label><input type="checkbox" class="privacy">&nbsp;동의합니다.</label>
                        </td>
                    </tr>
                </table>
                <p>
                    <a href="/Jboard1/user/login.jsp" class="btn btnCancel">취소</a>
                    <a href="/Jboard1/user/register.jsp" class="btn btnNext">다음</a>
                </p>
            </section>
        </main>
<%@ include file="./_footer.jsp" %>