<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>DataTable Example</title>
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
<style>
body {
    font-family: Arial, sans-serif;
}

#gridContainer {
    width: 1300px;
    height: 500px;
    margin: 20px auto;
}

.ui-jqgrid .ui-jqgrid-htable th div {
    height: auto;
    padding: 5px;
}

.ui-jqgrid-titlebar {
    display: none;
}

.custom-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #f5f5f5;
    color: #333;
    padding: 10px;
    border-bottom: 2px solid #ccc;
    margin-bottom: 10px;
    border-radius: 5px;
}

.custom-header .buttons {
    display: flex;
    gap: 10px;
}

.custom-header button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 5px 10px;
    border-radius: 3px;
}

.custom-header button:hover {
    background-color: #0056b3;
}

.custom-search {
    display: flex;
    align-items: center;
    gap: 10px;
    width: 100%;
}

.search-container {
    width: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.custom-search label {
    margin-right: 10px;
}

.custom-search select, .custom-search input {
    padding: 5px;
    border-radius: 3px;
    border: 1px solid #ced4da;
}

.custom-search button {
    padding: 5px 10px;
    border-radius: 3px;
    border: 1px solid #ced4da;
    background-color: #5b5b5b;
    color: white;
    margin-left: 730px;
}

.custom-search button:hover {
    background-color: #0056b3;
}

.button-group {
    display: flex;
    gap: 10px;
    align-items: flex-end;
    flex-direction: row-reverse;
    margin-top: 15px;
    margin-bottom: 15px;
}

.button-group .newBtn {
    background-color: #007bff;
    padding: 3px;
    border-radius: 3px;
    color: white;
    text-decoration: none;
}

.button-group .excelBtn i {
    color: white;
}

.button-group .excelBtn {
    background-color: #62b0ea;
    padding: 3px;
    color: white;
    border-radius: 3px;
    text-decoration: none;
}

/* Add bottom margin to the grid to create space */
.ui-jqgrid .ui-jqgrid-bdiv {
    margin-bottom: 300px; /* Add a large margin to create space */
}

.container-custom {
    margin-top: 50px; /* Space between jqGrid and DataTable */
}

a.clickable-title {
    text-decoration: none;
    color: black; /* Make the title black */
}

a.clickable-title:hover {
    text-decoration: none; /* Ensure no underline on hover */
    color: black; /* Keep the title black on hover */
}
</style>
</head>
<body>
    <div id="gridContainer">
        <div class="custom-header">
            <div class="search-container">
                <div class="custom-search">
                    <label for="searchField">검색조건</label>
                    <select id="searchField">
                        <option value="title">제목</option>
                        <option value="writer">작성가</option>
                        <option value="registration_date">등록일짜</option>
                    </select>
                    <input type="text" id="searchValue">
                    <button id="searchBtn">
                        <i class="fa fa-search"></i> 확인
                    </button>
                </div>
            </div>
        </div>
        <div class="button-group">
            <a href="${pageContext.request.contextPath}/board/save" class="newBtn">
                <i class="fa fa-plus"></i> 신규
            </a>
            <a href="#" id="excelBtn" class="excelBtn">
                <i class="fa fa-download"></i> 엑셀
            </a>
        </div>
        <table id="jqGrid"></table>
        <div id="jqGridPager"></div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function() {
            // jqGrid initialization
            $("#jqGrid").jqGrid({
                url: '${pageContext.request.contextPath}/board/fetchBoardList',
                datatype: "json",
                colModel: [
                    { label: 'No', name: 'id', width: 100 },
                    { label: '제목', name: 'boardTitle', width: 450, formatter: function(cellvalue, options, rowObject) {
                        return '<a href="${pageContext.request.contextPath}/board?id=' + rowObject.id + '" class="clickable-title">' + cellvalue + '</a>';
                    }},
                    /* { label: 'Writer', name: 'boardWriter', width: 200 }, */
                    
                    { label: '작성자', name: 'boardWriter', width: 200, formatter: function(cellvalue, options, rowObject) {
                        return '<a href="${pageContext.request.contextPath}/board?id=' + rowObject.id + '" class="clickable-title">' + cellvalue + '</a>';
                    }},
                    
                    
                    /* { label: 'Registration Date', name: 'boardCreatedTime', width: 200 }, */
                    
                    { label: '등록일짜', name: 'boardCreatedTime', width: 200, formatter: function(cellvalue, options, rowObject) {
                        return '<a href="${pageContext.request.contextPath}/board?id=' + rowObject.id + '" class="clickable-title">' + cellvalue + '</a>';
                    }},
                    
                    
                    { label: '조회수', name: 'boardHits', width: 100 }
                ],
                viewrecords: true,
                width: 1300,
                height: 'auto',
                rowNum: 50,
                pager: "#jqGridPager",
                caption: "FAQ List"
            });

            // Search button functionality
            $('#searchBtn').click(function() {
                var searchField = $('#searchField').val();
                var searchValue = $('#searchValue').val();
                $("#jqGrid").jqGrid('setGridParam', {
                    postData: {
                        filters: JSON.stringify({
                            groupOp: "AND",
                            rules: [
                                { field: searchField, op: "cn", data: searchValue }
                            ]
                        })
                    },
                    search: true
                }).trigger("reloadGrid");
            });
        });
    </script>
</body>
</html>