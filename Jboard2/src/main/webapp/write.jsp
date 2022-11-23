<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="./_header.jsp"/>
        <main id="board">
            <section class="write">

                <form action="#">
                    <table border="0">
                        <caption>글쓰기</caption>
                        <tr>
                            <th>제목</th>
                            <td><input type="text" name="title" placeholder="제목을 입력하세요."/></td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <textarea name="content">${cookie}</textarea>
                            </td>
                        </tr>
                        <tr>
                            <th>파일</th>
                            <td>
                                <input type="file" name="file"/>
                            </td>
                        </tr>
                    </table>
                    
                    <div>
                        <a href='<c:url value="/list.do"/>' class="btn btnCancel">취소</a>
                        <input type="submit" value="작성완료" class="btn btnComplete"/>
                    </div>
                </form>

            </section>
        </main>
<jsp:include page="./_footer.jsp"/>