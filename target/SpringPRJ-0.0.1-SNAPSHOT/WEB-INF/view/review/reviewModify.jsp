<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.BoardDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userId = CmmUtil.nvl((String) session.getAttribute("userId"));
    String userGroup = CmmUtil.nvl((String) session.getAttribute("userGroup"));
    BoardDTO bDTO = (BoardDTO) request.getAttribute("bDTO");
    String Content = bDTO.getContent();
    Content = Content.replaceAll("& lt;", "<");
    Content = Content.replaceAll("& gt;", ">");
    Content = Content.replaceAll("& #40;", "(");
    Content = Content.replaceAll("& #41;", ")");
    Content = Content.replaceAll("& amp;", "&");
%>
<html>
<head>
    <title>어땠나요 ? - 리뷰 수정</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
    <!-- include summernote-ko-KR -->
    <script src="/assets/js/summernote-ko-KR.js"></script>
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
        <strong>어땠나요? - 글 수정하기</strong>
    </div>
    <div style="width: 100%; margin: auto;">
        <form method="post" action="/Board/BoardModifyProc.do">
            <input type="hidden" name="seq" value="<%=bDTO.getSeq()%>">
            <input type="text" id="title" name="title" style="width: 100%;" value="<%=bDTO.getTitle()%>" />
            <br><br>
            <textarea id="summernote" name="content"><%=Content%></textarea>
            <input id="subBtn" class="btn btn-primary" type="submit" value="글 수정" style="float: right; margin: 10px;"/>
            <input id="returnBtn" class="btn btn-outline-secondary" type="button" value="돌아가기"
                   style="float: right; margin: 10px;"
                   onclick="window.history.back()"/>
        </form>
    </div>
</div>

<script>
    $('#subBtn').click(function () {
       var title = $('#title').val();

       if(title==""){
           alert("제목을 입력해 주세요.");
           return false;
           $('#title').focus();
       }
    });
</script>

<jsp:include page="/WEB-INF/view/footer/footer.jsp"></jsp:include>
</body>
</html>
