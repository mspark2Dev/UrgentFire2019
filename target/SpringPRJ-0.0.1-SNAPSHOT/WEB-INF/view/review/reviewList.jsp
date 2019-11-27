<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.BoardDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="poly.dto.PageDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String userId = CmmUtil.nvl((String) session.getAttribute("userId"));
    String userGroup = CmmUtil.nvl((String) session.getAttribute("userGroup"));
    List<BoardDTO> bList = (List<BoardDTO>) request.getAttribute("bList");
    PageDTO paging = (PageDTO) request.getAttribute("paging");
%>

<html>
<head>
    <title>어땠나요 ? - 리뷰게시판</title>
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

        /*footer {*/
        /*    position: absolute;*/
        /*    bottom: 0;*/
        /*}*/
        .listWrapper {
            width: 100%;
            margin: 0 auto;
        }

        .listTag {
            padding: 5px 0px;
            width: 100%;
            margin: 0px;
            text-align: center;
            display: flex;
            color: rgba(0, 0, 0, 0.8);
            border-bottom: 1px solid #c8cbcf;
            font-size: 0.9rem;
        }

        .listHead {
            width: 100%;
            margin: 0px;
            text-align: center;
            display: flex;
            padding: 3px 0px;
            border-top: 1px solid #c8cbcf;
            border-bottom: 1px solid #c8cbcf;
            font-size: 0.9rem;
            color: black;
        }

        .listNum {
            width: 10%;
        }

        .listTitle {
            width: 50%;
            cursor: pointer;
        }

        .listTitle a:link {
            color: black;
        }

        .listTitle a:visited {
            color: black;
        }

        .listTitle a:hover {
            color: black;
        }

        .listWriter {
            width: 20%;
        }

        .listWhen {
            width: 20%;
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

<div style="width: 55%; margin: 0 auto; min-height: 100vh;">
    <div style="text-align: left; margin-bottom: 2%;">
        <hr>
        <strong>어땠나요? - 리뷰게시판</strong>
    </div>
    <div class="listWrapper">
    <% if (userId != "") { %>
    <a class="btn btn-primary" href="/Board/BoardReg.do" role="button" style="float: right; margin-bottom: 2%;">글작성</a>
    <% } %>

    <div class="listHead">
        <div class="listNum">#</div>
        <div class="listTitle">제목</div>
        <div class="listWriter">작성자</div>
        <div class="listWhen">작성일</div>
    </div>
    <%
        for (int i = 0; i < bList.size(); i++) {
            String Title = bList.get(i).getTitle();
            System.out.println(bList.get(i).getNotice_yn());
    %>

    <div class="listTag">
        <%if(bList.get(i).getNotice_yn().equals("Y")){ %>
        <div class="listNum" style="font-weight: bold; color: red">공지사항
        </div>
        <%}else {%>
        <div class="listNum"><%=bList.get(i).getSeq()%>
        </div>
        <%} %>
        <div class="listTitle"><a
                href="/Board/BoardDetail.do?seq=<%=bList.get(i).getSeq()%>"><%=Title.replaceAll("<", "&lt;").replaceAll(">","&gt;")%></a></div>
        <div class="listWriter"><%=bList.get(i).getRegId()%></div>
        <div class="listWhen"><%=bList.get(i).getUpdDate().substring(5, 16)%>
        </div>
    </div>
    <% } %>
</div>


    <div id="pNumWraaper" style="display: flex; width: 100%; margin-top: 10px;">
        <div style="margin: 0 auto; display: flex">
            <%
                if (paging.isPrev() == true) { %>
            <a style="margin: 0px 2px 0px 2px;" class="pNumStart"
               href="/Board/BoardList.do?Pno=<%=paging.getStartPage()-10%>"><i class="fa fa-arrow-left"
                                                                               style="position: relative; top: 2px;"></i></a>
            <%} %>

            <% for (int a = paging.getStartPage(); a <= paging.getEndPage(); a++) {
                if (paging.getPage() == a) { %>
            <div class='pNum' style="margin: 0px 2px 0px 2px; font-weight: bolder; color: #082de1">- <%=a%> -
            </div>
            <%} else {%>
            <a style="margin: 0px 2px 0px 2px; color: black" class='pNum' href="/Board/BoardList.do?Pno=<%=a%>"><%=a%>
            </a>
            <%
                    }
                }
            %>
            <%
                if (paging.isNext() == true) { %>
            <a style="margin: 0px 2px 0px 2px;" class="pNumEnd"
               href="/Board/BoardList.do?Pno=<%=paging.getEndPage()+1%>"><i class="fa fa-arrow-right"
                                                                            style="position: relative; top: 2px;"></i></a>
            <%} %>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/view/footer/footer.jsp"></jsp:include>
</body>
</html>
