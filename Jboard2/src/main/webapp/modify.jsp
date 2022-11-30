<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="./_header.jsp"/>
<script>
	function validateForm(form) {
		if(!form.title.value){
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if(!form.content.value){
			alert("내용을 입력하세요.");
			form.content.focus();
			return false;
		}
	}
	$(function () {
		$(document).ready(function () {
			$('input[name=title]').focus();
		})
		
		$('.upload').click(function () {
			$('input[type=file]').trigger("click");
		});
		
		$('input[type=file]').change(function () {
			let file = $('input[type=file]').val();
			let fileName = file.split("\\");
			$('#fname').text(fileName[2]);
			
			$('input[name=changeFile]').val('true');
		})
	});
</script>
        <main id="board">
            <section class="modify">

                <form action="#" method="post" enctype="multipart/form-data" onsubmit="return validateForm(this);">
                    <table border="0">
                        <caption>글수정</caption>
                        <tr>
                            <th>제목</th>
                            <td><input type="text" name="title" placeholder="제목을 입력하세요." value="${title}" /></td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea name="content" placeholder="내용을 입력하세요.">${content}</textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>파일</th>
                            <td>
                            	<input type="hidden" name="no" value="${no}">     <!-- 게시판 번호 -->
                            	<input type="hidden" name="changeFile" value="false">     <!-- 업로드를 하게될 경우 true로 전환 -->
                            	<input type="hidden" name="currentFile" value="${fname}"> <!-- 기존에 저장된 파일 -->
                                <input type="file" name="oriName" style="display:none;"/>
                                <button type="button" class="btn upload">업로드</button>&nbsp;
                                <span id="fname">
                                	<c:choose>
										<c:when test="${empty fname}">
	                                		선택된 파일 없음
										</c:when>
										<c:otherwise>
											${fname}
										</c:otherwise>
                                	</c:choose>
                                </span>
                            </td>
                        </tr>
                    </table>
                    
                    <div>
                        <a href="javascript:history.back();" class="btn btnCancel">취소</a>
                        <input type="submit" value="작성완료" class="btn btnComplete"/>
                    </div>
                </form>

            </section>
        </main>
<jsp:include page="./_footer.jsp"/>