<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.BoardDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userId = CmmUtil.nvl((String) session.getAttribute("userId"));
    String userGroup = CmmUtil.nvl((String) session.getAttribute("userGroup"));
    BoardDTO bDTO = (BoardDTO) request.getAttribute("bDTO");
    int num = Integer.parseInt(bDTO.getSeq());
    String num2 = Integer.toString(num);
    System.out.println(num2);
    String maxseq = CmmUtil.nvl((String) session.getAttribute("maxseq"));
    System.out.println("maxseq : " + maxseq);
    String notice_yn = bDTO.getNotice_yn();
    String Title = bDTO.getTitle();
    Title = Title.replaceAll("& lt;script& gt;", "<script>").replaceAll("& lt;& #47;script& gt;", "</script>");
    Title = Title.replaceAll("&#34;", "\"").replaceAll("&#47;", "/");
    Title = Title.replaceAll("&lt;", "<").replaceAll("&gt;", ">");
    Title = Title.replaceAll("&#40;", "\\(").replaceAll("&#41;", "\\)");
    Title = Title.replaceAll("&#39;", "'");
    String Content = bDTO.getContent();
    Content = Content.replaceAll("& lt;", "&lt;").replaceAll("& gt;", "&gt;");
    String res = CmmUtil.nvl((String) request.getAttribute("res"));
    System.out.println(res);
%>
<html>
<head>
    <title>어땠나요 ? - 리뷰</title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
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
    <script src="https://kit.fontawesome.com/56dcc4fdd8.js" crossorigin="anonymous"></script>
    <style>
        @media screen and (max-width: 430px) {
            #navbar-user-text {
                position: relative;
                left: 25%;
            }
        }
    </style>

</head>
<body>
<% if (userId == "") { %>
<jsp:include page="/WEB-INF/view/header/default.jsp"></jsp:include>
<% } else if (userGroup.equals("2")) {%>
<jsp:include page="/WEB-INF/view/header/admin.jsp"></jsp:include>
<% } else { %>
<jsp:include page="/WEB-INF/view/header/normal.jsp"></jsp:include>
<% } %>

<section class="ftco-section goto-here" style="width: 55%; margin: 0 auto; min-height: 100vh;">
    <div class="container">
        <input type="hidden" id="bseq" value="<%=num%>">
        <script>
            $(document).ready(function(){
                var seq = $('#bseq').val();
                $.ajax({
                    type: "POST",
                    url: "/nlp/wordAnalysis.do",
                    data: {"seq": seq},
                    success: function (data) {
                        if(data > 0){
                            var title = document.getElementById("smile");
                            title.style.display = "block";
                        } else if(data == 0) {
                            var title = document.getElementById("usally");
                            title.style.display = "block";
                        } else {
                            var title = document.getElementById("angry");
                            title.style.display = "block"
                        }
                    }
                });
            });
        </script>

        <!-- Page Heading/Breadcrumbs -->
        <h4 class="mt-4 mb-3" style="display: flex">
            <c:out value="<%=Title%>" escapeXml="true"/>
            <i class="fa fa-smile-wink" id="smile" style="display: none; color: lightseagreen; margin-left: 10px;"></i>
            <i class="fas fa-meh-blank" id="usally" style="display: none; color: black; margin-left: 10px;"></i>
            <i class="fas fa-angry" id="angry" style="display: none; color: darkred; margin-left: 10px;"></i>
        </h4>
        <%
            if (userGroup.equals("2")) {
        %>
        <div style="display: flex">
            <% if (notice_yn.equals("N")) {
            %>
            <form action="/Board/BoardNoticeY.do" style="margin-right: 5px;">
                <input type="hidden" name="seq" value="<%=num%>">
                <input type="submit" class="btn btn-outline-dark" value="공지등록">
            </form>
            <% } else { %>
            <form action="/Board/BoardNoticeN.do" style="margin-right: 5px;">
                <input type="hidden" name="seq" value="<%=num%>">
                <input type="submit" class="btn btn-outline-dark" value="공지해제">
            </form>
            <% } %>
            <form action="/Board/BoardModify.do" style="margin-right: 5px">
                <input type="hidden" name="seq" value="<%=num%>">
                <input type="submit" class="btn btn-outline-dark" value="수정">
            </form>
            <form action="/Board/BoardDeleteProc.do">
                <input type="hidden" name="seq" value="<%=num%>">
                <input type="submit" class="btn btn-outline-dark" value="삭제">
            </form>
        </div>
        <%
        } else if (bDTO.getRegId().equals(userId)) {
        %>
        <div style="display: flex">
            <form action="/Board/BoardModify.do" style="margin-right: 5px;">
                <input type="hidden" name="seq" value="<%=num%>">
                <input type="submit" class="btn btn-outline-dark" value="수정">
            </form>
            <form action="/Board/BoardDeleteProc.do">
                <input type="hidden" name="seq" value="<%=num%>">
                <input type="submit" class="btn btn-outline-dark" value="삭제">
            </form>
        </div>
        <%} %>
        <!-- Post Content Column -->
        <div class="col_lg_8">


            <hr>

            <!-- Date/Time -->
            <p>
                <%=bDTO.getUpdDate().substring(5, 16)%>
                <small>by <%=bDTO.getRegId()%>
                </small>
            </p>

            <hr>

            <!-- Post Content -->
            <div id="notice_content" style="width: 100%; overflow-wrap: break-word"><%=Content%>
            </div>

            <hr>

            <div style="margin: 0 auto; width: 100%;">
                <a href="/Board/BoardList.do?Pno=1"><input type="submit" class="btn btn-outline-dark" value="목록"></a>
            </div>


        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/view/footer/footer.jsp"></jsp:include>
</body>
</html>
