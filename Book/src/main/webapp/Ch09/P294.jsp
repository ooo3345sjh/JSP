<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ include file="P279.jsp" %> <!-- 로그인 확인 -->
<%
	String num = request.getParameter("num"); // 일련번호 받기
	BoardDAO dao = new BoardDAO(application); // DAO 생성
	BoardDTO dto = dao.selectview(num); 	  // 게시물 가져오기
	String sessionId = (String)session.getAttribute("id"); // 로그인 ID 얻기
	if(!sessionId.equals(dto.getId())){ // 본인인지 확인
		JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
		return;
	}
	dao.close(); // DB 연결 해제
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원제 게시판</title>
		<%--
			날짜 : 2022/10/16
			이름 : 서정현
			내용 : 수정하기 폼
		--%>
		<style>
			*{padding: 0; margin:0;}
		 	#wrapper{ width: 900px; height: auto; margin: auto; }
		 	table {width: 100%; height: auto;}
			textarea{
				width: 95%;
				height: 100px;
				resize: none;
				margin: 5px;
				text-indent: 5px;
			}
			table td > input {
				width: 95%;
				margin: 5px;
				text-indent: 5px;
			}
		</style>
		<script>
			function vaildateForm(form) {
				if(form.title.value == ""){
					alert("제목을 입력하세요.");
					form.title.focus();
					return false;
				}
				if(form.content.value == ""){
					alert("내용을 입력하세요.");
					form.content.focus();
					return false;
				}
			}
		</script>
	</head>
	<body>
		<div id="wrapper">
			<jsp:include page="P225.jsp"/>
			<h2>회원제 게시판 - 수정하기(Edit)</h2>
			<form name="writeFrm" action="P298.jsp" method="post" onsubmit="return vaildateForm(this)">
				<input type="hidden" name="num" value="<%= dto.getNum()%>">
				<table border="1">
					<tr>
						<td align="center">제목</td>
						<td>
							<input type="text" name="title" value="<%= dto.getTitle()%>">
						</td>
					</tr>
					<tr>
						<td align="center">내용</td>
						<td>
							<textarea name="content"><%= dto.getContent() %></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right">
							<button type="submit">작성 완료</button>
							<button type="reset">다시 입력</button>
							<button type="button" onclick="location.href='P273.jsp'">목록보기</button>
						</td>
					</tr>
				</table>
			</form>
		</div>		
	</body>
</html>