<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>파일 첨부형 게시판</title>
		<%--
			날짜 : 2022/11/08
			이름 : 서정현
			내용 : 게시물 내용보기 뷰(JSP)
		--%>
		<style>
			#wrapper { width: 800px; height: auto; margin: auto; }
			form {width: 100%;}
			table {width: 100%;}
		</style>
	</head>
	<body>
		<div id="wrapper">
			<h2>파일 첨부형 게시판 - 상세보기(View)</h2>
			<table border="1">
				<colgroup>
					<col width="15%"/><col width="35%"/>
					<col width="15%"/><col width="*"/>
				</colgroup>
				
				<!-- 게시글 정보 -->
				<tr>
					<td>번호</td>
					<td>${ dto.idx }</td>
					<td>작성자</td>
					<td>${ dto.name }</td>
				</tr>
				<tr>
					<td>작성일</td>
					<td>${ dto.postdate }</td>
					<td>조회수</td>
					<td>${ dto.visitCount }</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3">${ dto.title }</td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3" headers="100">${ dto.content }</td>
				</tr>
				
				<!-- 첨부파일 -->
				<tr>
					<td>첨부파일</td>
					<td> 
						<c:if test="${ not empty dto.ofile }">
							${ dto.ofile }<a href="/Book/Ch14/download.do?ofile=${ dto.ofile }
							&sfile=${ dto.sfile }&idx=${dto.idx}">
							다운로드</a>
						</c:if>
					</td>
					<td>다운로드 수</td>
					<td>${ dto.downCount }</td>
				</tr>
				<!-- 하단 메뉴(버튼) -->
				<tr>
					<td colspan="4" align="center">
						<button type="button" onclick="location.href='/Book/Ch14/pass.do?mode=edit&idx=${ param.idx}'">
							수정하기
						</button>
						<button type="button" onclick="location.href='/Book/Ch14/pass.do?mode=delete&idx=${ param.idx}'">
							삭제하기
						</button>
						<button type="button" onclick="location.href='/Book/Ch14/list.do'">
							목록 바로가기
						</button>
					</td>
				</tr>				
			</table>
		</div>
	</body>
</html>