<%@ page import="poly.util.CmmUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="poly.dto.BoardDTO" %>
<%@ page import="poly.dto.PageDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userId = CmmUtil.nvl((String) session.getAttribute("userId"));
    String userGroup = CmmUtil.nvl((String) session.getAttribute("userGroup"));
    String userEmail = CmmUtil.nvl((String) session.getAttribute("userEmail"));
    List<BoardDTO> bList = (List<BoardDTO>)request.getAttribute("bList");
    String usercnt = CmmUtil.nvl((String) session.getAttribute("usercnt"));
    String boardcnt = CmmUtil.nvl((String) session.getAttribute("boardcnt"));
    PageDTO paging = (PageDTO) request.getAttribute("paging");
%>
<html>
<head>
    <title>급한불 - 관리자</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
          name='viewport'/>
    <link rel="stylesheet" href="/admin_assets/assets/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">
    <link rel="stylesheet" href="/admin_assets/assets/css/ready.css">
    <link rel="stylesheet" href="/admin_assets/assets/css/demo.css">
    <link rel="stylesheet" href="/assets/fonts/font-awesome.min.css">
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
<body>
<div class="wrapper">
    <div class="main-header">
        <div class="logo-header">
            <a href="/admin.do" class="logo">
                급한불 관리페이지
            </a>
            <button class="navbar-toggler sidenav-toggler ml-auto" type="button" data-toggle="collapse"
                    data-target="collapse" aria-controls="sidebar" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <button class="topbar-toggler more"><i class="la la-ellipsis-v"></i></button>
        </div>
        <nav class="navbar navbar-header navbar-expand-lg">
            <div class="container-fluid">
                <ul class="navbar-nav topbar-nav ml-md-auto align-items-center">
                    <li class="nav-item dropdown">
                        <a class="dropdown-toggle profile-pic" data-toggle="dropdown" href="#"
                           aria-expanded="false"><span><%=userId%></span></span> </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li>
                                <div class="user-box">
                                    <div class="u-text">
                                        <h4><%=userId%></h4>
                                        <p class="text-muted"><%=userEmail%></p>
                                    </div>
                                </div>
                            </li>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/index.do" style=""><i class="la la-home"
                                                                                  aria-hidden="true"></i> 메인페이지</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#" style="color: red;"><i class="fa fa-power-off" aria-hidden="true"></i> 로그아웃</a>
                        </ul>
                        <!-- /.dropdown-user -->
                    </li>
                </ul>
            </div>
        </nav>
    </div>
    <div class="sidebar">
        <div class="scrollbar-inner sidebar-wrapper">
            <div class="user">
                <div class="info">
                    <a class="" data-toggle="collapse" href="#collapseExample" aria-expanded="true">
								<span>
									<%=userId%>
									<span class="user-level">관리자</span>
									<span class="caret"></span>
								</span>
                    </a>
                    <div class="clearfix"></div>

                    <div class="collapse in" id="collapseExample" aria-expanded="true" style="">
                        <ul class="nav">
                            <li>
                                <a href="/admin/info.do">
                                    <span class="link-collapse">내정보</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <ul class="nav">
                <li class="nav-item">
                    <a href="/admin.do">
                        <i class="la la-users"></i>
                        <p>회원관리</p>
                        <span class="badge badge-count"><%=usercnt%></span>
                    </a>
                </li>
                <li class="nav-item active">
                    <a href="/adminboard.do">
                        <i class="la la-pencil-square"></i>
                        <p>게시글 관리</p>
                        <span class="badge badge-count"><%=boardcnt%></span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="main-panel">
        <div class="content">
            <div class="container-fluid">
                <h4 class="page-title">전체게시글</h4>
                <div class="row" style="font-size: 10pt">
                    <div class="listHead">
                        <div class="listNum">#</div>
                        <div class="listTitle">제목</div>
                        <div class="listWriter">작성자</div>
                        <div class="listWhen">작성일</div>
                    </div>
                    <%
                        if(bList.size() > 0) {
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
                                href="/Board/BoardDetail.do?seq=<%=bList.get(i).getSeq()%>"><%=Title.replaceAll("<", "&lt;").replaceAll(">","&gt;")%></a></div>
                        <div class="listWriter"><%=bList.get(i).getRegId()%></div>
                        <div class="listWhen"><%=bList.get(i).getUpdDate().substring(5, 16)%>
                        </div>
                    </div>
                    <% }} else { %>
                    <span style="color: #082de1; display: block; text-align: center; margin: 0 auto;">게시글이 존재하지 않습니다.</span>
                    <% } %>
                </div>
                    <div id="pNumWraaper" style="display: flex; width: 100%;">
                        <div style="margin: 0 auto; display: flex">
                            <%
                                if (paging.isPrev() == true) { %>
                            <a style="margin: 0px 2px 0px 2px;" class="pNumStart" href="/adminboard.do?Pno=<%=paging.getStartPage()-10%>"><i class="fa fa-arrow-left" style="position: relative; top: 2px;"></i></a>
                            <%} %>

                            <% for (int a = paging.getStartPage(); a <= paging.getEndPage(); a++) {
                                if (paging.getPage() == a) { %>
                            <div class='pNum' style="margin: 0px 2px 0px 2px; font-weight: bolder; color: #082de1">- <%=a%> -
                            </div>
                            <%} else {%>
                            <a style="margin: 0px 2px 0px 2px; color: black" class='pNum' href="/adminboard.do?Pno=<%=a%>"><%=a%>
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
</div>
</body>
<script src="/admin_assets/assets/js/core/jquery.3.2.1.min.js"></script>
<script src="/admin_assets/assets/js/plugin/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="/admin_assets/assets/js/core/popper.min.js"></script>
<script src="/admin_assets/assets/js/core/bootstrap.min.js"></script>
<script src="/admin_assets/assets/js/plugin/chartist/chartist.min.js"></script>
<script src="/admin_assets/assets/js/plugin/chartist/plugin/chartist-plugin-tooltip.min.js"></script>
<script src="/admin_assets/assets/js/plugin/bootstrap-toggle/bootstrap-toggle.min.js"></script>
<script src="/admin_assets/assets/js/plugin/jquery-mapael/jquery.mapael.min.js"></script>
<script src="/admin_assets/assets/js/plugin/jquery-mapael/maps/world_countries.min.js"></script>
<script src="/admin_assets/assets/js/plugin/chart-circle/circles.min.js"></script>
<script src="/admin_assets/assets/js/ready.min.js"></script>
<script src="/admin_assets/assets/js/demo.js"></script>
</html>
