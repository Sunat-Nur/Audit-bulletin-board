<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>detail.jsp</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Include DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
</head>
<body>
    <div class="container container-custom">
        <table class="table table-bordered">
            <tr>
                <th>ID</th>
                <td>${board.id}</td>
            </tr>
            <tr>
                <th>개발자</th>
                <td>${board.boardWriter}</td>
            </tr>
            <tr>
                <th>날짜</th>
                <td>${board.boardCreatedTime}</td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>${board.boardHits}</td>
            </tr>
            <tr>
                <th>제목</th>
                <td>${board.boardTitle}</td>
            </tr>
            <tr>
                <th>내용물</th>
                <td>${board.boardContents}</td>
            </tr>
        </table>
        <button class="btn btn-secondary" onclick="listFn()">목록</button>
        <button class="btn btn-danger" onclick="deleteFn()">삭제</button>

        <div class="mt-4">
            <input type="text" id="commentWriter" class="form-control mb-2" placeholder="작성자">
            <input type="text" id="commentContents" class="form-control mb-2" placeholder="내용">
            <button id="comment-write-btn" class="btn btn-primary" onclick="commentWrite()">댓글작성</button>
        </div>

        <div id="comment-list" class="mt-4">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>댓글번호</th>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>작성시간</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${commentList}" var="comment">
                        <tr>
                            <td>${comment.id}</td>
                            <td>${comment.commentWriter}</td>
                            <td>${comment.commentContents}</td>
                            <td>${comment.commentCreatedTime}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Load jQuery first -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- Load Bootstrap and other dependencies after jQuery -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.3/dist/jquery.validate.min.js"></script>

    <script>
        const listFn = () => {
            const page = '${page}';
            location.href = "${pageContext.request.contextPath}/";
        }
        const updateFn = () => {
            const id = '${board.id}';
            location.href = "${pageContext.request.contextPath}/board/update?id=" + id;
        }
        
        const deleteFn = () => {
            const id = '${board.id}';
            location.href = "/board/delete?id=" + id;
        }

        const commentWrite = () => {
            const writer = document.getElementById("commentWriter").value;
            const contents = document.getElementById("commentContents").value;
            const board = '${board.id}';
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/comment/save",
                data: {
                    commentWriter: writer,
                    commentContents: contents,
                    boardId: board
                },
                dataType: "json",
                success: function(commentList) {
                    console.log("작성성공");
                    console.log(commentList);
                    let output = "<table class='table table-bordered'>";
                    output += "<thead><tr><th>댓글번호</th><th>작성자</th><th>내용</th><th>작성시간</th></tr></thead><tbody>";
                    for (let i in commentList) {
                        output += "<tr>";
                        output += "<td>" + commentList[i].id + "</td>";
                        output += "<td>" + commentList[i].commentWriter + "</td>";
                        output += "<td>" + commentList[i].commentContents + "</td>";
                        output += "<td>" + commentList[i].commentCreatedTime + "</td>";
                        output += "</tr>";
                    }
                    output += "</tbody></table>";
                    document.getElementById('comment-list').innerHTML = output;
                    document.getElementById('commentWriter').value = '';
                    document.getElementById('commentContents').value = '';
                },
                error: function() {
                    console.log("작성 실패");
                    alert('댓글 작성 실패');
                }
            });
        } 
    </script>
</body>
</html>
