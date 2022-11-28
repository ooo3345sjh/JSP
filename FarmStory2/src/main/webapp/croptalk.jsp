<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <div id="sub">
            <div><img src='<c:url value='/img/sub_top_tit3.png'/>' alt="CROP TALK"></div>
            <section class="cate3">
                <aside>
                    <img src='<c:url value='/img/sub_aside_cate3_tit.png'/>' alt="농작물이야기"/>

                    <ul class="lnb">
                        <li class='${cate eq 1 ? "on":"off"}'><a href='<c:url value='/board/list.do?group=${group}&cate=1'/>'>농작물이야기</a></li>
                        <li class='${cate eq 2 ? "on":"off"}'><a href='<c:url value='/board/list.do?group=${group}&cate=2'/>'>텃밭가꾸기</a></li>
                        <li class='${cate eq 3 ? "on":"off"}'><a href='<c:url value='/board/list.do?group=${group}&cate=3'/>'>귀농학교</a></li>
                    </ul>
                </aside>
                <article>
                    <nav>
                        <img src='<c:url value='/img/sub_nav_tit_cate3_tit${cate}.png'/>' alt="텃밭가꾸기"/>
                        <p>
                            HOME > 농작물이야기 > 
                            <c:if test="${cate eq 1}"><em>농작물이야기</em></c:if>
                            <c:if test="${cate eq 2}"><em>텃밭가꾸기</em></c:if>
                            <c:if test="${cate eq 3}"><em>귀농학교</em></c:if>
                        </p>
                    </nav>
