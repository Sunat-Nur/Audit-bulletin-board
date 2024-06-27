<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                <th>작성일자</th>
                <td>
                    <input type="text" class="form-control" value="<fmt:formatDate value='${board.boardCreatedTime}' pattern='yyyy-MM-dd' />" readonly>
                </td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>
                    <input type="text" class="form-control" value="${board.boardHits}" readonly>
                </td>
            </tr>
            <tr>
                <th>콘텐트</th>
                <td>
                    <textarea class="form-control" readonly>${board.boardContents}</textarea>
                </td>
            </tr>
        </table>
        <div class="btn-container">
            <button class="btn btn-primary btn-custom" onclick="replyFn()">답글</button>
        </div>
    </div>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
</html>