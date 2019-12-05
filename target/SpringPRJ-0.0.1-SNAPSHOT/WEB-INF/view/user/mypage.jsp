<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.BoardDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="poly.dto.PageDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userId = CmmUtil.nvl((String) session.getAttribute("userId"));
    String userGroup = CmmUtil.nvl((String) session.getAttribute("userGroup"));
    List<BoardDTO> bList = (List<BoardDTO>) request.getAttribute("bList");
    PageDTO paging = (PageDTO) request.getAttribute("paging");
    System.out.println(paging.getListSize());
%>
<!DOCTYPE html>
<html lang="en">
<head>

    <!-- SITE TITTLE -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>급한불 - 마이페이지</title>


    <!-- Bootstrap -->
    <link href="/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="/assets/mypage/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="/assets/css/Navigation-with-Button.css" rel="stylesheet">
    <link href="/assets/css/Pretty-Footer.css" rel="stylesheet">

    <link href="/assets/mypage/css/style.css" rel="stylesheet">

    <!-- FAVICON -->
    <link href="img/favicon.png" rel="shortcut icon">

    <!-- mypage CSS -->
    <link rel="stylesheet" href="/assets/css/mypage.css">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
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

        .listTitle a {
            display: block;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            width: 100%;
            text-align: left;
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

<body class="body-wrapper">
<jsp:include page="/WEB-INF/view/header/normal.jsp"></jsp:include>

<!--==================================
=            User Profile            =
===================================-->
<section class="dashboard section">
    <!-- Container Start -->
    <div class="container">
        <!-- Row Start -->
        <div class="row">
            <div class="col-md-10 offset-md-1 col-lg-4 offset-lg-0">
                <div class="sidebar">
                    <!-- User Widget -->
                    <div class="widget user-dashboard-profile">
                        <!-- User Image -->
                        <%--                        <div class="profile-thumb">--%>
                        <%--                            <img src="/assets/img/user-thumb.jpg" alt="" class="rounded-circle">--%>
                        <%--                        </div>--%>
                        <!-- User Name -->
                        <h5 class="text-center"><%= userId %>
                        </h5>
                        <p>
                            <% if (userGroup.equals("1")) { %>
                            사용자
                            <% } else { %>
                            관리자
                            <% } %>
                        </p>
                        <a href="/inform.do" class="btn btn-main-sm">회원정보 수정</a>
                    </div>
                    <!-- Dashboard Links -->
                    <div class="widget user-dashboard-menu">
                        <ul>
                            <li class="active"><a href=""><i class="fa fa-user"></i> 내가 작성한 글</a></li>
                            <li><a href="/deluser.do"><i class="fa fa-power-off"></i>회원탈퇴</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">
                <div class="widget dashboard-container my-adslist">
                    <h3 class="widget-header">작성한 게시글</h3>
                    <div id="mainWrapper" style="width: 100%;">
                        <div class="listHead">
                            <div class="listNum">#</div>
                            <div class="listTitle">제목</div>
                            <div class="listWriter">작성자</div>
                            <div class="listWhen">작성일</div>
                        </div>
                        <%
                            if(bList.size() > 0){
                            for (int i = 0; i < bList.size(); i++) {
                                String Title = bList.get(i).getTitle();
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
                                    href="/Board/BoardDetail.do?seq=<%=bList.get(i).getSeq()%>"><%=Title.replaceAll("<", "&lt;").replaceAll("&gt;",">")%></a></div>
                            <div class="listWriter"><%=bList.get(i).getRegId()%></div>
                            <div class="listWhen"><%=bList.get(i).getUpdDate().substring(5, 16)%>
                            </div>
                        </div>
                        <% }} else { %>
                        <span style="color: #082de1; display: block; text-align: center;">게시글이 존재하지 않습니다.</span>
                        <% } %>
                    </div>
                    <div id="pNumWraaper" style="display: flex; width: 100%; margin-top: 10px;">
                        <div style="margin: 0 auto; display: flex">
                            <%
                                if (paging.isPrev() == true) { %>
                            <a style="margin: 0px 2px 0px 2px;" class="pNumStart" href="/mypage.do?Pno=<%=paging.getStartPage()-10%>"><i class="fa fa-arrow-left" style="position: relative; top: 2px;"></i></a>
                            <%} %>

                            <% for (int a = paging.getStartPage(); a <= paging.getEndPage(); a++) {
                                if (paging.getPage() == a) { %>
                            <div class='pNum' style="border: 1px solid gray; padding: 0 5px 0 5px; margin: 0 5px 0 5px; background-color: #56c6c6; color: white"><%=a%>
                            </div>
                            <%} else {%>
                            <a style="border: 1px solid gray; padding: 0 5px 0 5px; margin: 0 5px 0 5px; color: black" class='pNum' href="/mypage.do?Pno=<%=a%>"><%=a%>
                            </a>
                            <%
                                    }
                                }
                            %>
                            <%
                                if (paging.isNext() == true) { %>
                            <a style="margin: 0px 2px 0px 2px;" class="pNumEnd" href="/adminboard.do?Pno=<%=paging.getEndPage()+1%>"><i class="fa fa-arrow-right" style="position: relative; top: 2px;"></i></a>
                            <%} %>
                        </div>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Row End -->
    </div>
    <!-- Container End -->
</section>

<jsp:include page="/WEB-INF/view/footer/footer.jsp"></jsp:include>

<script src="assets/js/jquery.min.js"></script>
<script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>

</html>