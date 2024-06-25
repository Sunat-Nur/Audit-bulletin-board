<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Save</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Include Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- Include jQuery Validation Plugin -->
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.3/dist/jquery.validate.min.js"></script>
    <!-- Custom CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fffff;
        }

        .container-custom {
            margin-top: 150px;
        }

        .form-table {
            width: 100%;
            border-collapse: collapse;
        }

        .form-table td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        .form-table input[type="text"], .form-table input[type="password"], .form-table textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }

        .form-table textarea {
            height: 200px; /* Set a specific height for the textarea */
        }

        .btn-back {
            background-color: black;
            color: white;
        }
    </style>
</head>
<body>

    <div class="container container-custom">
        <form id="boardForm">
            <table class="form-table">
                <tr>
                    <td>Title</td>
                    <td><input type="text" name="boardTitle" required></td>
                </tr>
                <tr>
                    <td>Writer</td>
                    <td><input type="text" name="boardWriter" required></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><input type="password" name="boardPassword" required></td>
                </tr>
                <tr>
                    <td>Contents</td>
                    <td><textarea name="boardContents" required></textarea></td>
                </tr>
            </table>
            <button type="submit" class="btn btn-primary mt-3">제출</button>
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary mt-3">Back</a>
        </form>
    </div>

    <script>
        $(document).ready(function() {
            $('#boardForm').validate({
                submitHandler: function(form) {
                    if (confirm('이 양식을 제출하시겠습니까?')) {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/board/save',
                            type: 'POST',
                            data: $(form).serialize(),
                            success: function (response) {
                                alert('데이터가 성공적으로 저장되었습니다!');
                                // Redirect to the home page
                                window.location.href = '${pageContext.request.contextPath}/';
                            },
                            error: function (xhr, status, error) {
                                console.error('Form submission error: ', error);
                            }
                        });
                    }
                }
            });
        });
    </script>
</body>
</html>