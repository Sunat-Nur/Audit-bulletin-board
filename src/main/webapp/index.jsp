<%-- <%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>index</title>
<style>

</style>
<script>
	console.log('Context Path: ${pageContext.request.contextPath}');
</script>
</head>
<body>
	<br />
	<h2>스프링 프레임워크입니다</h2>
	<!-- writing -->
	<a href="${pageContext.request.contextPath}/board/save">글작성</a>
	<br />
	<!-- Article list -->
	<br />
	<a href="${pageContext.request.contextPath}/board/">글목록</a>
	<br />
	<!-- paging list -->
	<br />
	<a href="${pageContext.request.contextPath}/board/paging">페이징</a>
</body>
</html>
 --%>
 
 
 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>paging</title>
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
    <!-- Custom CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
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
            margin-top: 100px; /* Space between navbar and content */
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
       <!--  <a class="navbar-brand" href="#">Navbar</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button> -->
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
    <h3>게시판</h3>
        <table id="dataTable" class="display">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>이름</th>
                    <th>직겁</th>
                    <th>날짜</th>
                    <th>조회수</th>
                </tr>
            </thead>
        </table>
    </div>

    <script>
        $(document).ready(function() {
            $('#dataTable').DataTable({
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
                pageLength: 5,
                lengthChange: false,
                info: true,
                autoWidth: false,
                responsive: true,
                language: {
                    paginate: {
                        first: '<<',
                        last: '>>',
                        next: '>',
                        previous: '<'
                    }
                }
            });
        });
    </script>
</body>
</html>