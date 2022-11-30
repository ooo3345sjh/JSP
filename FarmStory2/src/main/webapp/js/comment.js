/**
 * 
 */

let contextRoot = location.pathname.split('/')[1]; // 컨택트루트 ex) Jboard2

function write(user){
	// 댓글 추가
	$('.btnComplete').click(function (e) {
		e.preventDefault();
		let textarea = $('textarea[name=comment]');
		let comment = textarea.val().replace(/(?:\r\n|\r|\n)/g, '<br />'); // 줄바꿈을 적용해준다.
		

		let no = user.no;
		let nick = user.nick;
		let	uid = user.uid;
		
		if(!uid){
			alert("로그인 후 작성가능합니다.");
			return;
		}
		if(comment == ''){
			alert("댓글을 작성하세요");
			return;
		}
		
		let jsonData = {
				"no" : no,
				"uid" : uid,
				"comment" : comment
		};
		$.ajax({
			url : "/" + contextRoot + "/comment/write.do",
			method : 'post',
			data : jsonData,
			dataType : 'json',
			success : function (data) {
				if(data.result == 1){
					let article = "<article>";
					article += "<input type='hidden' value='" + data.no + "'>";
					article += "<span class='nick'>" + nick + "</span> ";
					article += "<span class='date'>" + data.rdate + "</span>";
					article += "<p class='content'>" + comment + "</p>";
					article += "<div>";
					article += "<a href='#' class='remove' data-no='" + data.no + "'>삭제</a> ";
					article += "<a href='#' class='modify' data-no='" + data.no + "'>수정</a> ";
					article += "</div>";
					article += "</article>";
					
					$('.commentList > .empty').hide();
					$('.commentList').append(article);
					textarea.val('');
				} else{
					alert('댓글 등록에 실패 했습니다.');
					return;
				}
			}
		});
	}) // 댓글 추가 END
	
	$('textarea[name=comment]').on('keydown', function (e) { // ENTER키를 누를때도 댓글 작성완료 버튼을 작동, SHIFT + ENTER 키는 줄바꿈
		if(e.keyCode == 13){
			
			if($(this).val() == ''){ 		  // 댓글 입력 내용이 없으면 이벤트 취소
				e.preventDefault();
			}
			
			if(!e.shiftKey){  				  // SHIFT 키를 클릭 하지 않았으면 실행
				$('.btnComplete').trigger("click"); // 강제로 댓글 수정창의 작성완료 버튼을 누른다.
			}
		}
	});
	
	// 취소 버튼 클릭시 댓글 입력 내용 리셋
	$(document).on('click', '.btnCancel',  function (e) {
		e.preventDefault();
		$(this).parent().prev().val(''); // 댓글쓰기의 내용 값을 없앤다.
	});
}
		
// 댓글 삭제
$(document).on('click', '.remove', function (e) {
	e.preventDefault();
	if(!confirm("정말 삭제 하시겠습니까?")) return; 
	
	let commentNo = $(this).parent().siblings('input[type=hidden]').val(); // 댓글 번호
	
	let jsonData = { 
		"commentNo": commentNo
	};
		
	$.ajax({
		url: "/" + contextRoot + "/comment/delete.do" ,
		type:'post',
		dataType: 'json',
		data: jsonData,
		success: function (data) {
			if(data.result == 0){
				alert('삭제 실패');
			} 
		}	
	});
	
	$(this).parent().parent().remove(); // 해당 삭제 버튼의 article을 삭제
	if($('.commentList > article').length == 0){
		$(".empty").show(); // 댓글이 없으면 empty 클래스를 show 한다.
	}
}) // 댓글 삭제 END
	
function modify(){
	
	// 댓글 수정
	let articleTag; // 수정할 댓글
	let commentNo; // 수정할 댓글 번호
	
	// 댓글 수정 창 띄우기
	$(document).on('click', '.modify', function (e) {
		e.preventDefault();
		
		$('#modifyCancel').trigger('click');
		
		articleTag = $(this).closest('article'); // 댓글 목록의 article 태그를 선택
		commentNo = articleTag.children('input[type=hidden]').val();  // 댓글 번호
		let nick = articleTag.children('span.nick').text();    // 닉네임
		let content = articleTag.children('p.content').html(); // 댓글 내용
		
		let modifyTag = "<section class='commentForm'>"
			+ "  <h3 style='font-weight: bold'>" + nick + "</h3>"
			+ " <form action='#'>"
	        + " <textarea name='content' id='modifyContent'>" + content.replaceAll('<br>', '\n') + "</textarea>"
	    	+ " <div>"
	    	+ " <a href=''#' class='btn btnCancel' id='modifyCancel'>취소</a>"
	    	+ " <input type='submit' value='작성완료'  class='btn btnComplete' id='modifyComplete'>"
	    	+ " </div>"
	    	+ " </form>"
			+ "</section>";
			
		articleTag.hide(); // 댓글창을 숨긴다.
		articleTag.after(modifyTag); // 수정하려는 댓글의 뒤에 modifyTag를 추가한다.
	}) // 댓글 수정 창 띄우기 END
	
	// 댓글 수정 창을 없애고 수정된 댓글을 보여주는 이벤트
	$(document).on('click', '#modifyCancel', function (e) {
		e.preventDefault();
		$('.commentList > .commentForm').remove();
		articleTag.show();
	})
	
	// 댓글 수정 등록
	$(document).on('click', '#modifyComplete', function (e) {
		e.preventDefault();
		
		let textarea = $(this).parent().prev(); // 댓글 수정창의 textarea태그 선택
		let comment = textarea.val().replace(/(?:\r\n|\r|\n)/g, '<br />'); // 개행을 <br/> 태그값으로 변환
		
		if(comment == ''){
			alert('내용을 입력 해주세요.');
			textarea.focus();
			return;
		}
		
		let jsonData = {
			"commentNo" : commentNo,
			"comment" : comment
		}
		
		
		$.ajax({
			url: "/" + contextRoot + "/comment/modify.do",
			type:'post',
			dataType: 'json',
			data: jsonData,
			success: function(data){
				if(data.result == 0){
					alert('수정 실패');
				} else{ // 수정 성공
					articleTag.children('p.content').html(comment); // 수정된 글로 수정한다. 이떄는 text()가 아닌 html()로 저장한다. <br/>를 반영하기위함 
					$('#modifyCancel').trigger('click'); 			// 취소 버튼을 강제 클릭시켜 댓글 수정창 제거
				}
			}
		})
	}) // 댓글 수정 등록 END	
	
	$(document).on('keydown', '#modifyContent', function (e) { // ENTER키를 누를때도 댓글 작성완료 버튼을 작동, SHIFT + ENTER 키는 줄바꿈
			
		if(e.keyCode == 13){
			if($(this).val() == ''){ // 댓글 입력 내용이 없으면 이벤트 취소
				e.preventDefault();
			}
			
			if(!e.shiftKey){ 			  			   // SHIFT 키를 클릭 하지 않았으면 실행
				$('#modifyComplete').trigger("click"); // 강제로 댓글 수정창의 작성완료 버튼을 누른다.
			}
		} 
	});
	
}

		