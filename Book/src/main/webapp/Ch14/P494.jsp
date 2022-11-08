<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>파일 첨부형 게시판</title>
		<%--
			날짜 : 2022/10/30
			이름 : 서정현
			내용 : 뷰(JSP) 코드
		--%>
		<style>
			#wrapper { width: 800px; height: auto; margin: auto; }
			form {width: 100%;}
			table {width: 100%;}
		</style>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function () {
				$('input[type=submit]').click(function () {
					if($('input[name=searchWord]').val() != ''){
						$('input[type=hidden]').val('true');
					}
				});
			})
		</script>
	</head>
	<body>
		<div id="wrapper">
			<h2>파일 첨부형 게시판 - 목록 보기(List)</h2>
			
			<!-- 검색 폼 -->
			<form method="get">
				<input type="hidden" name="check" value="false">
				<table border="1">
					<tr>
						<td align="center">
							<select name="searchField">
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select>
							
							<input type="text" name="searchWord">
							<input type="submit" value="검색하기">
						</td>
					</tr>
				</table>
			</form>
			
			<!-- 목록 테이블 -->
			<table border="1">
				<tr>
					<th width='10%'>번호</th>
					<th width='*'>제목</th>
					<th width='15%'>작성자</th>
					<th width='10%'>조회수</th>
					<th width='15%'>작성일</th>
					<th width='8%'>첨부</th>
				</tr>
			<c:choose>
				<c:when test="${ empty map.boards }">
					<tr>
						<td colspan="6" align="center">
							등록된 게시물이 없습니다.^^*
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${ map.boards }" var="row" varStatus="loop">
					<tr> <!-- 번호 -->
						<td align="center">
							${ map.pageStartNum - loop.index }
						</td>
						<td align="left"> <!-- 제목(링크) -->
							<a href="/Book/Ch14/view.do">${ row.title }</a>
						</td>
						<td align="center">${ row.name }</td> <!-- 작성자 -->
 						<td align="center">${ row.visitCount }</td> <!-- 조회수 -->
						<td align="center">${ row.postdate }</td> <!-- 작성일 -->
						<td align="center">
						<c:if test="${ not empty row.ofile }">
							<a href="#"> ${ row.ofile } </a> <!-- 첨부 파일 -->
						</c:if>
						</td>
					</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			</table>
			
			<!-- 하단 메뉴(바로가기, 글쓰기) -->
			<table border="1">
				<tr>
					<td align="center">
						${ map.pageTags }
					</td>
					<td align="center" width='10%'>
						<button type="button" onclick="location.href='/Book/mvcboard/write.do';">글쓰기</button>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>