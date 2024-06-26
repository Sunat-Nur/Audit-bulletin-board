<%-- 
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>detail.jsp</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body, .container-custom {
            background-color: white;
        }
        .container-custom {
            margin-top: 100px;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .table-custom {
            width: 100%;
            background-color: white;
            border: 1px solid #ddd;
        }
        .table-custom th, .table-custom td {
            vertical-align: middle;
            padding: 10px;
            border: 1px solid #ddd;
        }
        .table-custom th {
            background-color: #f5f5f5;
            font-weight: bold;
        }
        .btn-custom {
            margin-right: 5px;
        }
        .table-custom input, .table-custom textarea {
            background-color: white;
            border: none;
            width: 100%;
            resize: none;
            box-shadow: none;
            outline: none;
        }
        .table-custom textarea {
            height: 150px; /* Adjust the height as needed */
        }
        .btn-container {
            display: flex;
            justify-content: flex-end;
        }
    </style>
</head>
<body>
    <div class="container container-custom">
        <h4>2. 페이지 보기</h4>
        <table class="table table-bordered table-custom">
            <tr>
                <th>제목</th>
                <td>
                    <input type="text" class="form-control" value="${board.boardTitle}" readonly>
                </td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>
                    <input type="text" class="form-control" value="${board.boardWriter}" readonly>
                </td>
            </tr>
            <tr>
                <th>등록일짜</th>
                <td>
                    <input type="text" class="form-control" value="${board.boardCreatedTime}" readonly>
                </td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>
                    <input type="text" class="form-control" value="${board.boardHits}" readonly>
                </td>
            </tr>
            <tr>
                <th>콘텐츠</th>
                <td>
                    <textarea class="form-control" readonly>${board.boardContents}</textarea>
                </td>
            </tr>
        </table>
        <div class="btn-container">
            <button class="btn btn-primary btn-custom" onclick="replyFn()">답글</button>
        </div>
    </div>
        <!-- Load jQuery first -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- Load Bootstrap and other dependencies after jQuery -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        const listFn = () => {
            location.href = "${pageContext.request.contextPath}/";
        }

        const deleteFn = () => {
            const id = '${board.id}';
            location.href = "${pageContext.request.contextPath}/board/delete?id=" + id;
        }

        const replyFn = () => {
            const id = '${board.id}';
            location.href = "${pageContext.request.contextPath}/board/reply?id=" + id;
        }
    </script>
</body>
</html> --%>




<%-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>detail.jsp</title>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    
</head>
<body>
    <table>
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
    <button onclick="listFn()">목록</button>
    <button onclick="updateFn()">수정</button>
    <button onclick="deleteFn()">삭제</button>

<div>
    <input type="text" id="commentWriter" placeholder="작성자">
    <input type="text" id="commentContents" placeholder="내용">
    <button id="comment-write-btn" onclick="commentWrite()">댓글작성</button>
</div>

<div id="comment-list">
    <table>
        <tr>
            <th>댓글번호</th>
            <th>작성자</th>
            <th>내용</th>
            <th>작성시간</th>
        </tr>
        <c:forEach items="${commentList}" var="comment">
            <tr>
                <td>${comment.id}</td>
                <td>${comment.commentWriter}</td>
                <td>${comment.commentContents}</td>
                <td>${comment.commentCreatedTime}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
<script>
    const listFn = () => {
        const page = '${page}';
        location.href = "/board/paging?page=" + page;
    }
    const updateFn = () => {
        const id = '${board.id}';
        location.href = "/board/update?id=" + id;
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
            url: "/comment/save",
            data: {
                commentWriter: writer,
                commentContents: contents,
                boardId: board
            },
            dataType: "json",
            success: function(commentList) {
                console.log("작성성공");
                console.log(commentList);
                let output = "<table>";
                output += "<tr><th>댓글번호</th>";
                output += "<th>작성자</th>";
                output += "<th>내용</th>";
                output += "<th>작성시간</th></tr>";
                for(let i in commentList){
                    output += "<tr>";
                    output += "<td>"+commentList[i].id+"</td>";
                    output += "<td>"+commentList[i].commentWriter+"</td>";
                    output += "<td>"+commentList[i].commentContents+"</td>";
                    output += "<td>"+commentList[i].commentCreatedTime+"</td>";
                    output += "</tr>";
                }
                output += "</table>";
                document.getElementById('comment-list').innerHTML = output;
                document.getElementById('commentWriter').value='';
                document.getElementById('commentContents').value='';
            },
            error: function() {
                console.log("실패");
            }
        });
    }
</script>
</html>
 --%>
 
 
 
 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>detail.jsp</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <!-- Include Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- Include DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
    <!-- Include DataTables JS -->
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <!-- Include jQuery Validation Plugin -->
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.3/dist/jquery.validate.min.js"></script>
    <!-- Custom CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        .navbar-custom {
            background-color: #007bff;
            margin-bottom: 20px;
        }

        .navbar-custom .navbar-nav .nav-link {
            color: #ffffff;
        }

        .navbar-custom .navbar-nav .nav-link:hover {
            color: #cccccc;
        }

        .container-custom {
            margin-top: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button {
            padding: 0 !important;
            margin: 0 !important;
        }

        .dataTables_wrapper .dataTables_info, 
        .dataTables_wrapper .dataTables_paginate {
            padding-top: 10px;
        }

        .clickable-name {
            cursor: pointer; /* Cursor change on hover */
            color: blue; /* Optional: change the text color to indicate it's clickable */
        }

        .clickable-name:hover {
            text-decoration: underline; /* Optional: underline on hover */
        }

        table.dataTable thead th, table.dataTable thead td {
            border-bottom: 1px solid #ddd;
        }

        table.dataTable.no-footer {
            border-bottom: 1px solid #ddd;
        }

        table.dataTable tbody tr {
            background-color: #fff;
        }
    </style>
</head>
<body>
    <!-- Navbar Code -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">집 <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/board/save">추가</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/board/paging">페이징</a>
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="찾" aria-label="Search">
                <button class="btn btn-outline-light my-2 my-sm-0" type="submit">찾</button>
            </form>
        </div>
    </nav>

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
        <button class="btn btn-warning" onclick="updateFn()">수정</button>
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

    <script>
        const listFn = () => {
            const page = '${page}';
            location.href = "${pageContext.request.contextPath}/board/paging?page=" + page;
        }
        const updateFn = () => {
            const id = '${board.id}';
            location.href = "${pageContext.request.contextPath}/board/update?id=" + id;
        }
        
         script>
        const listFn = () => {
            const page = '${page}';
            location.href = "/board/paging?page=" + page;
        }
        const updateFn = () => {
            const id = '${board.id}';
            location.href = "/board/update?id=" + id;
        }
        
        const deleteFn = () => {
            const id = '${board.id}';
            location.href = "/board/delete?id=" + id;
        }
        
         const deleteFn = () => {
            const id = '${board.id}';
            if (confirm('이 게시물을 삭제하시겠습니까?')) {
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/board/delete",
                    data: { id: id },
                    success: function(response) {
                        alert('삭제되었습니다.');
                        location.href = "${pageContext.request.contextPath}/";
                    },
                    error: function(xhr, status, error) {
                        console.error('삭제 오류: ', error);
                        alert('삭제 실패: ' + error);
                    }
                });
            }
        } */

        /* const commentWrite = () => {
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