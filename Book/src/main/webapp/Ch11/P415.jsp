<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JSTL - xml</title>
		<%--
			날짜 : 2022/10/27
			이름 : 서정현
			내용 : XML 태그 사용하기
		--%>
	</head>
	<body>
		<c:import url="P414.xml" var="booklist" charEncoding="UTF-8"/>
		
		<x:parse xml="${ booklist }" var="blist"/>
		
		<h4>파싱 1</h4>
		제목 : <x:out select="$blist/booklist/book[1]/name"/> <br/>
		저자 : <x:out select="$blist/booklist/book[1]/author"/> <br/>
		가격 : <x:out select="$blist/booklist/book[1]/price"/> <br/>
		
		<h4>파싱 2</h4>
		<table border="1">
			<tr>
				<th>제목</th>
				<th>저자</th>
				<th>가격</th>
			</tr>
			<%-- 
			<x:forEach select="$blist/booklist/book" var="item">
			<tr>
				<td><x:out select="$item/name"/></td>
				<td><x:out select="$item/author"/></td>
			
				<td>
					<x:choose>
						<x:when select="$item/price >= 20000">
							2만원 이상 <br/>
						</x:when>
						<x:otherwise>
							2만원 미만 <br/>
						</x:otherwise>
					</x:choose>
				</td>
			
			</tr>
			</x:forEach>
			--%>
		</table>
			
	</body>
</html>