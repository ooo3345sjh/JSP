<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	$(function () {
		// 댓글 추가
		$('.btnComplete').click(function (e) {
			e.preventDefault();
			let textarea = $('textarea[name=comment]');
			let comment = textarea.val();
			
			if(comment == ''){
				alert("댓글을 작성하세요");
				return;
			}
			
			let no = '${map.board.no}'
			let nick = '${reqUser.nick}'
			let	uid = '${reqUser.uid}'
			let jsonData = {
					"no" : no,
					"uid" : uid,
					"comment" : comment
			};
			
			$.ajax({
				url : '${pageContext.request.getContextPath()}/comment/write.do',
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
		
		// 댓글 삭제
		$(document).on('click', '.remove', function (e) {
			e.preventDefault();
			if(!confirm("정말 삭제 하시겠습니까?")) return; 
			
			let commentNo = $(this).parent().siblings('input[type=hidden]').val(); // 댓글 번호
			
			let jsonData = { 
				"commentNo": commentNo
			};
				
			$.ajax({
				url: '${pageContext.request.getContextPath()}/comment/delete.do' ,
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
		
		// 댓글 수정
		$(document).on('click', '.modify', function (e) {
			e.preventDefault();
			
			let articleTag = $(this).closest('article'); // 댓글 목록의 article 태그를 선택
			let nick = articleTag.children('span.nick').text(); // 닉네임
			let content = articleTag.children('p.content').html(); // 댓글 내용
			
			console.log(nick);
			console.log(content);
		})			
		
		
	})
</script>