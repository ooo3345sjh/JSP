<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");	
	String no =  request.getParameter("no");
	String pg =  request.getParameter("pg");
	
	
	ArticleBean article = ArticleDAO.getInstance().selectArticle(no);
%>
<%@ include file="_header.jsp" %>
<script type="text/javascript" src="/Jboard1/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="/Jboard1/js/smartEditor.js"></script>
<script>
	
	$(function () {
		let oEditors = []
			
	    smartEditor = function() {
	     	console.log("Naver SmartEditor")
	     	nhn.husky.EZCreator.createInIFrame({
	        oAppRef: oEditors,
	        elPlaceHolder: "editorTxt",
	        sSkinURI: "/Jboard1/smartEditor/SmartEditor2Skin.html",
	        fCreator: "createSEditor2"
	        });
	    }
	
	    $(document).ready(function() {
	      smartEditor();
	    })
		
		$('form').submit(function (e) {
			oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", [])
	       	let inputTitle = $('input[name=title]');
	       	let content = $('#editorTxt').val().replace(/<br style="clear:both;">/g, '');
	       	
	       	let arr = content.match(/image.{29}/g); // 이미지 경로값 배열
	       	if(arr != null){
		       	$('input[name=img]').val(arr.join('/')); // 이미지 경로값을 '/'로 이어붙여 input[name=img]의 value값에 대입
	       	}
	       	
			if(inputTitle.val() == ''){
				alert("제목을 입력해주세요.")
				inputTitle.focus();
				return false
			}
				
	 		if(content == '' || content == '<p>&nbsp;</p>') {
	   			alert("내용을 입력해주세요.")
	   			oEditors.getById["editorTxt"].exec("FOCUS")
				return false
	 		} else {
	   			console.log(content)
	   			$('#editorTxt').submit();
				return true;
			 }
			
		});
	});
</script>

        <main id="board">
            <section class="modify">
                <form action="/Jboard1/proc/modifyProc.jsp">
                	<input type="hidden" name="no" value="<%= no %>">
                	<input type="hidden" name="pg" value="<%= pg %>">
                	<input type="hidden"  name="img">
                    <table border="0">
                     <caption>글수정</caption>
                     <tr>
                         <th>제목</th>
                         <td><input type="text" name="title" placeholder="제목을 입력하세요." value="<%= article.getTitle() %>"></td>
                     </tr>
                     <tr>
                         <th>내용</th>
                         <td>
                             <textarea name="editorTxt" id="editorTxt" rows="20" cols="10" 
                            placeholder="내용을 입력해주세요" style="width: 100%"><%= article.getContent() %></textarea>
                         </td>
                     </tr>
                    </table>
                    <div>
                        <a href="/Jboard1/view.jsp?no=<%= no %>&pg=<%= pg %>" class="btn btnCalcel">취소</a>
                        <input type="submit" value="수정완료" class="btn btnComplete">
                    </div>
                </form>
            </section>
        </main>
<%@ include file="_footer.jsp" %>       