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
<link rel="stylesheet"
    href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
<style>
body {
    font-family: Arial, sans-serif;
    background-color: white; /* Set the background color to white */
    font-size: 16px; /* Increase the base font size */
}

#gridContainer {
    width: 1300px;
    height: 500px;
    margin: 20px auto;
}

.ui-jqgrid .ui-jqgrid-htable th div {
    height: auto;
    padding: 10px; /* Increase padding */
    font-size: 18px; /* Increase header font size */
    color: black; /* Make the header text color black */
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
    font-size: 18px; /* Increase custom header font size */
}

.custom-header .buttons {
    display: flex;
    gap: 10px;
}

.custom-header button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 10px; /* Increase button padding */
    border-radius: 3px;
    font-size: 16px; /* Increase button font size */
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
    font-size: 16px; /* Increase label font size */
}

.custom-search select, .custom-search input {
    padding: 10px; /* Increase padding */
    border-radius: 3px;
    border: 1px solid #ced4da;
    font-size: 16px; /* Increase input and select font size */
}

.custom-search button {
    padding: 10px; /* Increase button padding */
    border-radius: 3px;
    border: 1px solid #ced4da;
    background-color: #5b5b5b;
    color: white;
    font-size: 16px; /* Increase button font size */
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
    padding: 10px; /* Increase padding */
    border-radius: 3px;
    color: white;
    text-decoration: none;
    font-size: 16px; /* Increase font size */
}

.button-group .excelBtn i {
    color: white;
    font-size: 16px; /* Increase icon font size */
}

.button-group .excelBtn {
    background-color: #62b0ea;
    padding: 10px; /* Increase padding */
    color: white;
    border-radius: 3px;
    text-decoration: none;
    font-size: 16px; /* Increase font size */
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
    font-size: 16px; /* Increase the title font size */
}

a.clickable-title:hover {
    text-decoration: none; /* Ensure no underline on hover */
    color: black; /* Keep the title black on hover */
}

.comment-item {
    margin-left: 7%;
    color: black; /* Set the text color to black */
    padding: 5px 0;
    border-radius: 3px;
    cursor: pointer;
    margin-bottom: 5px;
    padding-left: 5px; /* Add padding inside the box */
}

.comment-item a {
    color: black;
    text-decoration: none;
}

.comment-item a:hover {
    text-decoration: underline;
}

.jqGrid-col-title {
    font-size: 18px; /* Set the font size to 18px */
    font-weight: bold; /* Make the header bold */
    color: black; /* Make the header text color black */
}

.jqGrid-col-others {
    font-size: 16px; /* Set the font size to 16px */
    font-weight: bold; /* Make the text bold */
    color: black; /* Make the text color black */
}

/* Indentation for nested comments */
.comment-item.level-1 {
    margin-left: 10px;
}

.comment-item.level-2 {
    margin-left: 15px;
}

.comment-item.level-3 {
    margin-left: 20px;
}

.comment-item.level-4 {
    margin-left: 25px;
}

.comment-item.level-5 {
    margin-left: 30px;
}

.comment-item.level-6 {
    margin-left: 35px;
}

.comment-item.level-7 {
    margin-left: 40px;
}

.comment-item.level-8 {
    margin-left: 45px;
}

.comment-item.level-9 {
    margin-left: 50px;
}

/* Add more levels if needed */

.toggle-comments {
    display: none; /* Hide the toggle button but still make it functional */
}
</style>
</head>
<body>
    <div id="gridContainer">
    <h4>1. 메인 페이지</h4>
        <div class="custom-header">
            <div class="search-container">
                <div class="custom-search">
                    <label for="searchField">검색조건</label> <select id="searchField">
                        <option value="title">제목</option>
                        <option value="writer">작성자</option>
                        <option value="registration_date">작성일</option>
                    </select> <input type="text" id="searchValue">
                    <button id="searchBtn">
                        <i class="fa fa-search"></i> 확인
                    </button>
                </div>
            </div>
        </div>
        <div class="button-group">
            <a href="${pageContext.request.contextPath}/board/save"
                class="newBtn"> <i class="fa fa-plus"></i> 신규
            </a> <a href="#" id="excelBtn" class="excelBtn"> <i
                class="fa fa-download"></i> 엑셀
            </a>
        </div>
        <table id="jqGrid"></table>
        <div id="jqGridPager"></div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script
        src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
    <script
        src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
  <script>
    $(document).ready(function() {
        $("#jqGrid").jqGrid({
            url: '${pageContext.request.contextPath}/board/fetchBoardList',
            datatype: "json",
            colModel: [
                { label: '번호', name: 'id', width: 100, align: 'center', classes: 'jqGrid-col-others' },
                { label: '제목', name: 'boardTitle', width: 450, formatter: function(cellvalue, options, rowObject) {
                    let commentsHtml = '<div class="comment-grid">';
                    if (rowObject.commentList) {
                        rowObject.commentList.reverse().forEach((comment, index) => {
                            let levelClass = 'level-' + (index + 1);
                            commentsHtml += '<div class="comment-item ' + levelClass + '"><a href="${pageContext.request.contextPath}/board/recommend?id=' + comment.id + '&boardId=' + comment.boardId + '"><span style="color: black;">[Re]</span> <span style="color: black;">' + comment.commentWriter + '</span></a></div>';
                        });
                    }
                    commentsHtml += '</div>';
                    return '<span class="toggle-comments"><i class="fa fa-comments"></i></span> <a class="clickable-title" href="${pageContext.request.contextPath}/board?id=' + rowObject.id + '">' + cellvalue + '</a><br>' + commentsHtml;
                }},
                { label: '작성자', name: 'boardWriter', width: 200, align: 'center', classes: 'jqGrid-col-others' },
                { label: '작성일자', name: 'boardCreatedTime', width: 200, align: 'center', formatter: 'date', formatoptions: { newformat: 'Y-m-d' }, classes: 'jqGrid-col-others' },
                { label: '조회수', name: 'boardHits', width: 100, align: 'center', classes: 'jqGrid-col-others' }
            ],
            viewrecords: true,
            width: 1300,
            height: 'auto',
            rowNum: 50,
            pager: "#jqGridPager",
            caption: "FAQ List"
        });

        // Toggle comments visibility
        $(document).on('click', '.toggle-comments', function() {
            const $comments = $(this).closest('tr').find('.comment-item');
            const $row = $(this).closest('tr');
            $comments.toggle();
            if ($comments.is(':visible')) {
                $row.css('background-color', 'white');
            } else {
                $row.css('background-color', '');
            }
            $(this).find('i').toggleClass('fa-comments fa-comments-o');
        });

        // Show all comments by default
        $(".comment-item").show();
    });
</script>
</body>
</html>