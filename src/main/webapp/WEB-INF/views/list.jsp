<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>list</title>
</head>
<body>
    <table>
        <tr>
            <th>ID</th>
            <th>제목</th>
            <th>개발자</th>
            <th>날짜</th>
            <th>조회수</th>
        </tr>
        <c:forEach items="${boardList}" var="board">
            <tr>
                <td>${board.id}</td>
                <td>
                    <a href="/board?id=${board.id}">${board.boardTitle}</a>
                </td>
                <td>${board.boardWriter}</td>
                <td>${board.boardCreatedTime}</td>
                <td>${board.boardHits}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>