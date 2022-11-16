/******* 댓글 삭제 *******/
 function deleteComment(no, deleteBtn){ // 파라미터 - no : 게시글 번호, deleteBtn : 댓글 삭제 버튼 <a>태그
	$(function(){
			
		let commentNo = deleteBtn.parent().siblings('input[type=hidden]').val(); // 댓글 번호
		
		let jsonData = { 
			"no": no,
			"commentNo": commentNo
		};
		
		$.ajax({
			url:'/FarmStory1/comment/deleteProc.jsp',
			type:'get',
			dataType: 'json',
			data: jsonData,
			success: function (data) {
				if(data == 0){
					alert('삭제 실패');
				} 
			}	
		});
			
		
		deleteBtn.parent().parent().remove(); // 해당 삭제 버튼의 article을 삭제
		if($('.commentList > article').length == 0){
			$(".empty").show(); // 댓글이 없으면 empty 클래스를 show 한다.
		}
	});	
}