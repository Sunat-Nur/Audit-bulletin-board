
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Include Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- Include jqGrid CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/free-jqgrid@4.15.5/css/ui.jqgrid.min.css">
    <!-- Include jqGrid JS -->
    <script src="https://cdn.jsdelivr.net/npm/free-jqgrid@4.15.5/js/jquery.jqgrid.min.js"></script>
    <!-- Include jQuery Validation Plugin -->
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.3/dist/jquery.validate.min.js"></script>
    <!-- Custom CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding-top: 0; /* Removed space between navbar and body */
            padding-bottom: 0;
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

        .ui-jqgrid .ui-jqgrid-view {
            border: 1px solid #ddd;
        }

        .ui-jqgrid .ui-jqgrid-htable th {
            background-color: #f4f4f4;
            border-bottom: 2px solid #ddd;
            color: #333;
        }

        .ui-jqgrid .ui-jqgrid-btable td {
            border-bottom: 1px solid #ddd;
            color: #333;
        }

        .ui-jqgrid .ui-jqgrid-pager {
            background-color: #f9f9f9;
            border-top: 1px solid #ddd;
        }
    </style>
</head>
<body>




<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Include Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- Include jqGrid CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/free-jqgrid@4.15.5/css/ui.jqgrid.min.css">
    <!-- Include jqGrid JS -->
    <script src="https://cdn.jsdelivr.net/npm/free-jqgrid@4.15.5/js/jquery.jqgrid.min.js"></script>
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
        <form id="updateForm">
            <input type="hidden" name="id" value="${board.id}" readonly>
            <div class="form-group">
                <input type="text" class="form-control" name="boardWriter" value="${board.boardWriter}" readonly>
            </div>
            <div class="form-group">
                <input type="password" class="form-control" name="boardPass" id="boardPass" placeholder="비밀번호" required>
            </div>
            <div class="form-group">
                <input type="text" class="form-control" name="boardTitle" value="${board.boardTitle}" required>
            </div>
            <div class="form-group">
                <textarea class="form-control" name="boardContents" cols="30" rows="10" required>${board.boardContents}</textarea>
            </div>
            <button type="submit" class="btn btn-primary">수정</button>
            <button type="button" class="btn btn-danger" id="deleteButton">삭제</button>
        </form>

        <div class="container-custom">
            <table id="jqGrid"></table>
            <div id="jqGridPager"></div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            var table = $("#jqGrid").jqGrid({
                url: '${pageContext.request.contextPath}/board/fetchBoardList', // The URL for the Ajax request
                mtype: "GET", // HTTP method type for the request
                datatype: "json", // The type of data expected from the server
                colModel: [
                    { label: 'ID', name: 'id', key: true, width: 75 },
                    { label: '제목', name: 'boardTitle', width: 150 },
                    { label: '개발자', name: 'boardWriter', width: 150 },
                    { label: '날짜', name: 'boardCreatedTime', width: 150 },
                    { label: '조회수', name: 'boardHits', width: 100 }
                ],
                viewrecords: true, // Display the number of records
                width: 900, // Width of the grid
                height: 250, // Height of the grid
                rowNum: 20, // Number of rows per page
                pager: "#jqGridPager" // Pager element
            });

            // Handle form submission with validation and confirmation
            $('#updateForm').validate({
                submitHandler: function(form) {
                    const passInput = $('#boardPass').val();
                    const passDB = '${board.boardPass}';
                    if (passInput === passDB) {
                        if (confirm('Are you sure you want to update this entry?')) {
                            $.ajax({
                                url: '${pageContext.request.contextPath}/board/update',
                                type: 'POST',
                                data: $(form).serialize(),
                                success: function(response) {
                                    alert('Data updated successfully!');
                                    // Refresh the jqGrid
                                    table.trigger('reloadGrid');
                                    window.location.href = '${pageContext.request.contextPath}/board/paging';
                                },
                                error: function(xhr, status, error) {
                                    console.error('Form submission error: ', error);
                                }
                            });
                        }
                    } else {
                        alert("비밀번호가 일치하지 않습니다!!");
                    }
                }
            });

            $('#deleteButton').on('click', function() {
                const passInput = $('#boardPass').val();
                const passDB = '${board.boardPass}';
                if (passInput === passDB) {
                    if (confirm('Are you sure you want to delete this entry?')) {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/board/delete',
                            type: 'POST',
                            data: { id: $('input[name="id"]').val() },
                            success: function(response) {
                                alert('데이터가 삭제되었습니다!');
                                table.trigger('reloadGrid');
                                window.location.href = '${pageContext.request.contextPath}/';
                            },
                            error: function(xhr, status, error) {
                                console.error('Deletion error: ', error);
                            }
                        });
                    }
                } else {
                    alert("비밀번호가 일치하지 않습니다!!");
                }
            });
        });
    </script>
</body>
</html>