<%-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>save</title>
</head>
<body>
    <form action="/board/save" method="post">
        <input type="text" name="boardWriter" placeholder="작성자">
        <input type="text" name="boardPass" placeholder="비밀번호">
        <input type="text" name="boardTitle" placeholder="제목">
        <textarea name="boardContents" cols="30" rows="10" placeholder="내용을 입력하세요"></textarea>
        <input type="submit" value="작성">
    </form>
</body>
</html> --%>








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
                <%-- <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/board/">글목록</a>
                </li> --%>
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
        <form id="boardForm">
            <div class="form-group">
                <input type="text" class="form-control" name="boardWriter" placeholder="작성자" required>
            </div>
            <div class="form-group">
                <input type="password" class="form-control" name="boardPass" placeholder="비밀번호" required>
            </div>
            <div class="form-group">
                <input type="text" class="form-control" name="boardTitle" placeholder="제목" required>
            </div>
            <div class="form-group">
                <textarea class="form-control" name="boardContents" cols="30" rows="10" placeholder="내용을 입력하세요" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">작성</button>
        </form>

        <div class="container-custom">
            <table id="dataTable" class="display">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>제목</th>
                        <th>개발자</th>
                        <th>날짜</th>
                        <th>조회수</th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Initialize DataTable
             var table = $('#dataTable').DataTable({
                ajax: {
                    url: '${pageContext.request.contextPath}/board/fetchBoardList',
                    dataSrc: ''
                },
                columns: [
                    { data: 'id' },
                    { data: 'boardTitle' },
                    { data: 'boardWriter', render: function(data, type, row) {
                        return '<a href="${pageContext.request.contextPath}/board?id=' + row.id + '&page=${paging.page}" class="clickable-name">' + data + '</a>';
                    }},
                    { data: 'boardCreatedTime' },
                    { data: 'boardHits' }
                ],
                pagingType: 'full_numbers',
                pageLength: 10,
                lengthChange: false,
                info: true,
                autoWidth: false,
                responsive: true
            }); 

            $('#boardForm').validate({
                submitHandler: function(form) {
                    if (confirm('이 양식을 제출하시겠습니까?')) {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/board/save',
                            type: 'POST',
                            data: $(form).serialize(),
                            success: function (response) {
                                alert('Data saved successfully!');
                                table.ajax.reload(null, false);
                                $('#boardForm')[0].reset();
                                // Redirect to the paging list page
                                window.location.href = '${pageContext.request.contextPath}/board/paging';
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