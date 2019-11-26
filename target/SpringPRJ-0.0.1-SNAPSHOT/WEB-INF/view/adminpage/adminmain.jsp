<%@ page import="poly.util.CmmUtil" %>
<%@ page import="poly.dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userId = CmmUtil.nvl((String) session.getAttribute("userId"));
    String userGroup = CmmUtil.nvl((String) session.getAttribute("userGroup"));
    String userEmail = CmmUtil.nvl((String) session.getAttribute("userEmail"));
    String res = CmmUtil.nvl((String) request.getAttribute("result"));
    List<UserDTO> uList = (List<UserDTO>) request.getAttribute("uList");
    String usercnt = CmmUtil.nvl((String) session.getAttribute("usercnt"));
    String boardcnt = CmmUtil.nvl((String) session.getAttribute("boardcnt"));
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
            max-height: 50px;
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
            max-height: 50px;
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

        .listId {
            width: 25%;
        }

        .listEmail {
            width: 25%;
        }

        .listWhen {
            width: 20%;
        }

        .listAuth {
            width: 10%;
        }

        .listSet {
            width: 10%;
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
                                        <h4><%=userId%>
                                        </h4>
                                        <p class="text-muted"><%=userEmail%>
                                        </p>
                                    </div>
                                </div>
                            </li>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/index.do" style=""><i class="la la-home"
                                                                                  aria-hidden="true"></i> 메인페이지</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="/logout.do" style="color: red;"><i class="fa fa-power-off"
                                                                                              aria-hidden="true"></i>
                                로그아웃</a>
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
                <li class="nav-item active">
                    <a href="/admin.do">
                        <i class="la la-users"></i>
                        <p>회원관리</p>
                        <span class="badge badge-count"><%=usercnt%></span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/adminboard.do?Pno=1">
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
                <h4 class="page-title">회원목록</h4>
                <div class="row">
                    <div class="listHead">
                        <div class="listNum">#</div>
                        <div class="listId">계정</div>
                        <div class="listEmail">이메일</div>
                        <div class="listWhen">생성일</div>
                        <div class="listAuth">구분</div>
                        <div class="listSet">관리</div>
                    </div>
                    <%--                        <tbody style="text-align: center;">--%>
                    <%--                        <%for(BoardDTO bDTO : bList){ %>--%>
                    <%--                        <%--%>
                    <%--                            String notice_yn = bDTO.getNotice_yn();--%>
                    <%--                            System.out.println(notice_yn);--%>
                    <%--                            if(notice_yn.equals("Y")){--%>
                    <%--                        %>--%>
                    <%--                        <tr class="table-warning">--%>
                    <%--                            <td><strong style="color: red">공지사항</strong></td>--%>
                    <%--                                <% } else { %>--%>
                    <% int i = 0;
                        for (UserDTO uDTO : uList) {
                            i++;
                            System.out.println(i);
                    %>
                    <form style="width: 100%; margin: 0;">
                    <div class="listTag">
                        <input type="hidden" id="userNo<%=i%>" value="<%=uDTO.getUserNo()%>">
                            <div class="listNum"><%=uDTO.getUserNo()%>
                            </div>
                            <div class="listId"><%=uDTO.getUserId()%>
                            </div>
                            <div class="listEmail"><%=uDTO.getUserEmail()%>
                            </div>
                            <div class="listWhen"><%=uDTO.getRegDate().substring(5, 16)%>
                            </div>
                            <%if (uDTO.getUserGroup().equals("2")) {%>
                            <div class="listAuth">관리자</div>
                            <% } else if (uDTO.getUserGroup().equals("1")) { %>
                            <div class="listAuth">사용자</div>
                            <% } else if (uDTO.getUserGroup().equals("3")) {%>
                            <div class="listAuth">정지</div>
                            <% } %>
                            <div class="listSet">
                                <select id="userGroup<%=i%>" name="userGroup" style="min-width: 60px;"
                                        onchange="return group<%=i%>()">
                                    <option value="" selected disabled>선택</option>
                                    <% if (uDTO.getUserGroup().equals("1")) {%>
                                    <option value="2">관리자</option>
                                    <option value="3">정지</option>
                                    <%} else if (uDTO.getUserGroup().equals("2")) {%>
                                    <option value="1">사용자</option>
                                    <%} else if (uDTO.getUserGroup().equals("3")) {%>
                                    <option value="1">사용자</option>
                                    <%} %>
                                </select>
                            </div>

                    </div>
                    </form>


                    <script>
                        function group<%=i%>() {
                            console.log("i : " + <%=i%>);
                            var groupval = $('#userGroup<%=i%>').val();
                            var userseq = $('#userNo<%=i%>').val();

                            if (confirm("권한을 변경하시겠습니까 ?")) {
                                $.ajax({
                                    type: "POST",
                                    url: "/admin/groupupd.do",
                                    data: {
                                        "groupval": groupval,
                                        "userseq": userseq
                                    },
                                    success: function (data) {
                                        if (data > 0) {
                                            alert("변경 성공");
                                            location.href = '/admin.do';
                                        }
                                    }
                                });

                            } else {
                                return false;
                            }
                        };
                    </script>
                <% } %>
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
