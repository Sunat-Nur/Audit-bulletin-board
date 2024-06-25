<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Detail View</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Include Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- Custom CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: white; /* Set white background for the whole page */
        }

        .container-custom {
            margin-top: 20px;
            background-color: white; /* Ensure the container also has a white background */
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .form-table th, .form-table td {
            border: 1px solid #ddd;
            padding: 8px;
            font-size: 0.9em; /* Make text smaller */
        }

        .form-table th {
            background-color: #f2f2f2;
        }

        .form-table input[type="text"], .form-table textarea {
            width: 100%;
            padding: 6px;
            box-sizing: border-box;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 0.9em; /* Make input text smaller */
        }

        .form-table textarea {
            height: 100px; /* Reduce height for the textarea */
        }

        .btn-back {
            background-color: black;
            color: white;
        }

        .form-group input[type="text"], .form-group textarea {
            width: 100%;
            padding: 6px;
            box-sizing: border-box;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 0.9em; /* Make input text smaller */
        }

        .form-group textarea {
            height: 50px; /* Reduce height for the textarea */
        }
    </style>
</head>
<body>
    <div class="container container-custom">
        <h5>페이지 보기</h5>
        <table class="form-table">
            <tr>
                <th>Title</th>
                <td>${board.boardTitle}</td>
            </tr>
            <tr>
                <th>Writer</th>
                <td>${board.boardWriter}</td>
            </tr>
            <tr>
                <th>Writer Date</th>
                <td>${board.boardCreatedTime}</td>
            </tr>
            <tr>
                <th>View Count</th>
                <td>${board.boardHits}</td>
            </tr>
            <tr>
                <th>Contents</th>
                <td>${board.boardContents}</td>
            </tr>
        </table>
        <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">Back</a>
        <!-- <button class="btn btn-warning" onclick="updateFn()">수정</button> -->
        <button class="btn btn-danger" onclick="deleteFn()">삭제</button>

        <h3 class="mt-4">댓글 작성</h3>
        <div class="form-group">
            <input type="text" id="commentTitle" class="form-control mb-2" placeholder="제목">
            <input type="text" id="commentWriter" class="form-control mb-2" placeholder="작성자">
            <textarea id="commentContents" class="form-control mb-2" placeholder="내용"></textarea>
            <button id="comment-write-btn" class="btn btn-primary" onclick="commentWrite()">댓글작성</button>
        </div>

        <h3 class="mt-4">댓글 목록</h3>
        <div id="comment-list">
            <table class="form-table">
                <thead>
                    <tr>
                        <th>댓글번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>작성시간</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${commentList}" var="comment">
                        <tr>
                            <td>${comment.id}</td>
                            <td>${comment.commentTitle}</td>
                            <td>${comment.commentWriter}</td>
                            <td>${comment.commentContents}</td>
                            <td>${comment.commentCreatedTime}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        const listFn = () => {
            const page = '${page}';
            location.href = "${pageContext.request.contextPath}/board/paging?page=" + page;
        }
        const updateFn = () => {
            const id = '${board.id}';
            location.href = "${pageContext.request.contextPath}/board/update?id=" + id;
        }
        const deleteFn = () => {
            const id = '${board.id}';
            location.href = "${pageContext.request.contextPath}/board/delete?id=" + id;
        }

        const commentWrite = () => {
            const title = document.getElementById("commentTitle").value;
            const writer = document.getElementById("commentWriter").value;
            const contents = document.getElementById("commentContents").value;
            const board = '${board.id}';
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/comment/save",
                data: {
                    commentTitle: title,
                    commentWriter: writer,
                    commentContents: contents,
                    boardId: board
                },
                dataType: "json",
                success: function(commentList) {
                    console.log("작성성공");
                    console.log(commentList);
                    let output = "<table class='form-table'>";
                    output += "<thead><tr><th>댓글번호</th>";
                    output += "<th>제목</th>";
                    output += "<th>작성자</th>";
                    output += "<th>내용</th>";
                    output += "<th>작성시간</th></tr></thead><tbody>";
                    for(let i in commentList){
                        output += "<tr>";
                        output += "<td>"+commentList[i].id+"</td>";
                        output += "<td>"+commentList[i].commentTitle+"</td>";
                        output += "<td>"+commentList[i].commentWriter+"</td>";
                        output += "<td>"+commentList[i].commentContents+"</td>";
                        output += "<td>"+commentList[i].commentCreatedTime+"</td>";
                        output += "</tr>";
                    }
                    output += "</tbody></table>";
                    document.getElementById('comment-list').innerHTML = output;
                    document.getElementById('commentTitle').value='';
                    document.getElementById('commentWriter').value='';
                    document.getElementById('commentContents').value='';
                },
                error: function() {
                    console.log("실패");
                }
            });
        }
    </script>
</body>
</html>