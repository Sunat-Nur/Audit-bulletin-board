<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Reply</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
    <style>
        .comment-container {
            margin-top: 20px;
        }
        .container {
            margin-top: 100px;
        }
        .comment-form {
            margin-top: 20px;
        }
        
    </style>
</head>
<body>
    <div class="container">
        <h4>3. 페이지에서 답변</h4>
        <form id="commentForm">
            <input type="hidden" id="postId" name="postId" value="${board.id}">
            <table class="table table-bordered">
                <tr>
                    <th>제목</th>
                    <td>
                        <input type="text" class="form-control" id="title" name="title" value=" [RE] ${board.boardTitle}" readonly>
                    </td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>
                        <input type="text" class="form-control" id="writer" name="writer" required>
                    </td>
                </tr>
                <tr>
                    <th>콘텐츠</th>
                    <td>
                        <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="text-right">
                        <button type="submit" class="btn btn-primary">제출</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        $(document).ready(function() {
            $('#commentsTable').DataTable();
            console.log('postId:', $('#postId').val());

            
            $('#commentForm').on('submit', function(event) {
                event.preventDefault();
                const postId = $('#postId').val();
                const writer = $('#writer').val();
                const content = $('#content').val();

                console.log('Submitting comment:', { postId, writer, content });

                $.ajax({
                    type: 'POST',
                    url: '${pageContext.request.contextPath}/comment/save',
                    data: {
                        boardId: postId,
                        commentWriter: writer,
                        commentContents: content
                    },
                     success: function(commentList) {
                    	 alert('답글을 성공적으로 추가했습니다!');
                         // Redirect to the home page
                         window.location.href = '${pageContext.request.contextPath}/';
                    }, 
                    error: function() {
                        alert('Failed to add comment');
                    }
                });
            });
        });

    </script>
</body>
</html>