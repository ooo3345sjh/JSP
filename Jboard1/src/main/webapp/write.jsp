<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_header.jsp" %>
<script>
	function vaildateForm(form) {
		if(form.title.value == ""){
			alert('제목을 입력해주세요.');
			form.title.focus();
			return false;
		}
	/*	if(form.content.value == ""){
			alert('내용을 입력해주세요.');
			form.content.focus();
			return false;
		}
		return true;*/
	}
	
</script>
<script type="text/javascript" src="/Jboard1/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
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
	    
	    submitPost = function() {
 	    	oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", [])
        	let content = document.getElementById("editorTxt").value

  			if(content == '') {
    			alert("내용을 입력해주세요.")
    			oEditors.getById["editorTxt"].exec("FOCUS")
    			return
  			} else {
    			console.log(content)
 		 	}
		}
	})
 </script>
	<main id="board">
	    <section class="write">
	        <form action="/Jboard1/proc/writeProc.jsp" method="post" onsubmit="return vaildateForm(this)" 
	        enctype="multipart/form-data">
	        	<input type="hidden"  name="uid" value="<%= ub.getUid() %>">
	            <table border="0">
	             <caption>글쓰기</caption>
	             <tr>
	                 <th>제목</th>
	                 <td><input type="text" name="title" placeholder="제목을 입력하세요." autofocus></td>
	             </tr>
	             <tr>
	                 <th>내용</th>
	                 <td>
	                 	  <textarea name="editorTxt" id="editorTxt" rows="20" cols="10" 
                            placeholder="내용을 입력해주세요" style="width: 100%"></textarea>
	                     <!--  <textarea name="content" ></textarea> -->
	                 </td>
	             </tr>
	             <tr>
	                 <th>첨부</th>
	                 <td>
	                     <input type="file" name="fname"/>
	                 </td>
	             </tr>
	            </table>
	            <div>
	                <a href="/Jboard1/list.jsp" class="btn btnCalcel">취소</a>
	                <input type="submit" value="작성완료" class="btn btnComplete">
	            </div>
	        </form>
	    </section>
	</main>
<%@ include file="_footer.jsp" %>