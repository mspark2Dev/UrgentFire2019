<%@ page import="poly.util.CmmUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userId = CmmUtil.nvl((String) session.getAttribute("userId"));
    String userGroup = CmmUtil.nvl((String) session.getAttribute("userGroup"));
%>
<html>
<head>
    <title>어땠나요 ? - 리뷰 작성</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<%--        <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">--%>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
    <!-- include summernote css/js-->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
    <link rel="stylesheet" href="/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/assets/fonts/font-awesome.min.css">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Cookie">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Nanum+Gothic">
    <link rel="stylesheet"
          href="/assets/css/Background-Image---Parallax---No-Text.css">
    <link rel="stylesheet" href="/assets/css/Navigation-with-Button.css">
    <link rel="stylesheet" href="/assets/css/Pretty-Footer.css">
    <link rel="stylesheet" href="/assets/css/styles.css">
    <script src="/assets/js/jquery.min.js"></script>
    <script src="/assets/bootstrap/js/bootstrap.min.js"></script>
    <!-- include summernote css/js-->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
    <script src="/assets/js/summernote-bs4.js"></script>
    <script src="/assets/js/summernote-bs4.min.js"></script>
<%--    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">--%>
    <style>
        @media screen and (max-width: 430px) {
            #navbar-user-text {
                position: relative;
                left: 25%;
            }
        }

        table {
            font-size: 1rem;
        }

        thead tr th {
            text-align: center;
        }


    </style>
    <script>
        $(document).ready(function () {
            $('#summernote').summernote({
                placeholder: '내용을 입력해 주세요.',
                minHeight: 370,
                maxHeight: null,
                focus: true,
                lang: 'ko-KR',
                // codeviewFilter: true,
                // codeviewIframeFilter: true,
                onImageUpload : function(files, editor, welEditable) {
                    sendFile(files[0], editor, welEditable);
                }
            });

            function sendFile(file, editor, welEditable) {
                data = new FormData();
                data.append("uploadFile", file);
                $.ajax({
                    data : data,
                    type : "POST",
                    url : "/imageUpload",
                    cache : false,
                    contentType : false,
                    processData : false,
                    success : function (data) {
                        editor.insertImage(welEditable, data.url);
                    }
                })
            }
        });

    </script>
</head>
<body>
<% if (userId == "") { %>
<jsp:include page="/WEB-INF/view/header/default.jsp"></jsp:include>
<% } else if (userGroup.equals("2")) {%>
<jsp:include page="/WEB-INF/view/header/admin.jsp"></jsp:include>
<% } else { %>
<jsp:include page="/WEB-INF/view/header/normal.jsp"></jsp:include>
<% } %>

<div id="main" style="width: 55%; margin: 0 auto; min-height: 100vh;">
    <div style="text-align: left; margin-bottom: 2%;">
        <hr>
        <strong>어땠나요? - 글 작성하기</strong>
    </div>
    <div style="width: 100%; margin: auto;">
        <form method="post" action="/Board/BoardRegProc.do">
            <input type="text" name="title" style="width: 100%;" placeholder="제목"/>
            <br><br>
            <textarea id="summernote" name="content"></textarea>
            <input id="subBtn" class="btn btn-primary" type="submit" value="글 작성" style="float: right; margin: 10px;"/>
            <input id="returnBtn" class="btn btn-outline-secondary" type="button" value="돌아가기"
                   style="float: right; margin: 10px;"
                   onclick="window.history.back()"/>
        </form>
    </div>
</div>

<script>
    $('#subBtn').click(function () {
        var title = $('#title').val();
        var content = $('#summernote').val();

        if(title==""){
            alert("제목을 입력해 주세요.");
            return false;
            $('#title').focus();
        // } else if(content.match(/&lt;script&gt;/)){
        //     alert("내용에 부적절한 문자가 포함되어 있습니다.");
        //     return false;
        // }
    });
</script>

<jsp:include page="/WEB-INF/view/footer/footer.jsp"></jsp:include>
</body>
</html>
