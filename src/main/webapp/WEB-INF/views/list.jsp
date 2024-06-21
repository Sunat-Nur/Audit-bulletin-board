<%--  <%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
 --%>
 
 
 
 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>list</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/free-jqgrid@4.15.5/css/ui.jqgrid.min.css">
    <script src="https://cdn.jsdelivr.net/npm/free-jqgrid@4.15.5/js/jquery.jqgrid.min.js"></script>
    <!-- Custom CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
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

        .ui-jqgrid .ui-jqgrid-titlebar {
            background-color: #f4f4f4;
            border-bottom: 2px solid #ddd;
            color: #333;
        }

        .container-custom {
            margin-top: 100px; /* Space between navbar and content */
        }

        .clickable-name {
            cursor: pointer; /* Cursor change on hover */
            color: blue; /* Optional: change the text color to indicate it's clickable */
        }

        .clickable-name:hover {
            text-decoration: underline; /* Optional: underline on hover */
        }
    </style>
</head>
<body>
    <!-- Navbar Code -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mr-auto">
                <%-- <li class="nav-item active">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">Home <span class="sr-only">(current)</span></a>
                </li> --%>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/board/save">추가</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/board/">글목록</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/board/paging">페이징</a>
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
    </nav>

    <div class="container container-custom">
        <table id="jqGrid"></table>
        <div id="jqGridPager"></div>
    </div>

    <script>
        $(document).ready(function () {
            $("#jqGrid").jqGrid({
                url: '${pageContext.request.contextPath}/board/fetchBoardList', 
                mtype: "GET", 
                datatype: "json",
                colModel: [
                    { label: 'ID', name: 'id', key: true, width: 75 },
                    { label: '성', name: 'boardTitle', width: 150 },
                    { label: '직', name: 'boardWriter', width: 150, formatter: function (cellValue, options, rowObject) {
                        return '<a href="#" class="clickable-name" data-id="' + rowObject.id + '">' + cellValue + '</a>';
                    }},
                    { label: '날짜', name: 'boardCreatedTime', width: 150 },
                    { label: '조회수', name: 'boardHits', width: 100 }
                ],
                viewrecords: true, 
                width: 900, 
                height: 280,
                rowNum: 20 
            });

            
            $(document).on('click', '.clickable-name', function (event) {
                event.preventDefault();
                var id = $(this).data('id');
                alert('Clicked on name with ID: ' + id);
            });
        });
    </script>
</body>
</html>


