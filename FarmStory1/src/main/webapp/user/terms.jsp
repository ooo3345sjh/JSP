<%@page import="java.util.Map"%>
<%@page import="kr.co.FarmStory1.dao.UserDAO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	Map<String, Object> map = UserDAO.getInstance().selectTerms();
%>
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
<main id="user">
    <section class="terms">
        <table border="1">
            <caption>사이트 이용약관</caption>
            <tr>
                <td>
                    <textarea name="terms" readonly><%= map.get("terms") %></textarea>
                    <label><input type="checkbox" class="terms">&nbsp;동의합니다.</label>
                </td>
            </tr>
        </table>
        <table border="1">
            <caption>개인정보 취급방침</caption>
            <tr>
                <td>
                    <textarea name="privacy" readonly><%= map.get("privacy") %></textarea>
                    <label><input type="checkbox" class="privacy">&nbsp;동의합니다.</label>
                </td>
            </tr>
        </table>
        <p>
            <a href="./login.jsp" class="btn btnCancel">취소</a>
            <a href="./register.jsp" class="btn btnNext">다음</a>
        </p>
    </section>
</main>
<%@ include file="/_footer.jsp" %>