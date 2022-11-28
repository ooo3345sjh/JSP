<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <div id="sub">
            <div><img src='<c:url value='/img/sub_top_tit5.png'/>' alt="COMMUNITY"></div>
            <section class="cate5">
                <aside>
                    <img src='<c:url value='/img/sub_aside_cate5_tit.png'/>' alt="커뮤니티"/>

                    <ul class="lnb">
                        <li class='${cate eq 1 ? "on":"off"}'><a href='<c:url value='/board/list.do?group=${group}&cate=1'/>'>공지사항</a></li>
                        <li class='${cate eq 2 ? "on":"off"}'><a href='<c:url value='/board/list.do?group=${group}&cate=2'/>'>오늘의식단</a></li>
                        <li class='${cate eq 3 ? "on":"off"}'><a href='<c:url value='/board/list.do?group=${group}&cate=3'/>'>나도요리사</a></li>
                        <li class='${cate eq 4 ? "on":"off"}'><a href='<c:url value='/board/list.do?group=${group}&cate=4'/>'>1:1고객문의</a></li>
                        <li class='${cate eq 5 ? "on":"off"}'><a href='<c:url value='/board/list.do?group=${group}&cate=5'/>'>자주묻는질문</a></li>
                    </ul>

                </aside>
                <article>
                    <nav>
                        <img src='<c:url value='/img/sub_nav_tit_cate5_tit${cate}.png'/>' alt="나도요리사"/>
                        <p>
                            HOME > 커뮤니티 > 
                            <c:if test="${cate eq 1}"><em>공지사항</em></c:if>
                            <c:if test="${cate eq 2}"><em>오늘의식단</em></c:if>
                            <c:if test="${cate eq 3}"><em>나도요리사</em></c:if>
                            <c:if test="${cate eq 4}"><em>1:1고객문의</em></c:if>
                            <c:if test="${cate eq 5}"><em>자주묻는질문</em></c:if>
                        </p>
                    </nav>

                    <!-- 내용 시작 -->

                    <!-- 내용 끝 -->