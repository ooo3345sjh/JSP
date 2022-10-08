<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String popupMode = "on"; //레이어 팝업창 띄울지 여부
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>쿠키를 이용한 팝업 관리 ver 0.1</title>
		<!-- 
			날짜 : 2022/10/08
			이름 : 서정현
			내용 : 레이어 팝업창 관리(ver 0.1)
		-->
		<style>
			div#popup {
				position: absolute; top:100px; left:50px;
				width: 270px; color: yellow; background: gray;
				border: 1px solid black;
				overflow: hidden;
			}
			div#popup>div {
				width:100%; background: #fff; color: black;
				border-top: 1px solid black; padding: 10px; 
				box-sizing: border-box;
			}
		</style>
		<script src="../js/jquery.js"></script>
		<script>
			$(function () {
				$('#closeBtn').click(function() {
					$('#popup').hide();	
				});
			});
		</script>
	</head>
	<body>
		<h2>팝업 메인 페이지(ver 0.1)</h2>
		<%
			for(int i=1; i<=10; i++){
				out.print("현재 팝업창은 " + popupMode + " 상태입니다.<br/>");
			}
		
		if(popupMode.equals("on")){ //popupMode 값이 "on"일 때만 팝업창 표시
		%>
		
		<div id="popup"> <!-- 공지사항 팝업 화면-->
			<h2 align="center">공지사항 팝업니다.</h2>
			<div align="right"><form name="popFrm">
				<input type="checkbox" id="inactiveToday" value="1"/> <!-- 체크박스 -->
				하루 동안 열지 않음
				<input type="button" value="닫기" id="closeBtn"> <!-- 닫기 버튼 -->
			</form></div>
		</div>
		<%
		}
		%>
		
		
	</body>
</html>