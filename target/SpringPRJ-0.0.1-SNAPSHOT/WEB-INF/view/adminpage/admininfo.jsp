<%@ page import="poly.util.CmmUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="poly.dto.BoardDTO" %>
<%@ page import="poly.dto.PageDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userId = CmmUtil.nvl((String) session.getAttribute("userId"));
    String userGroup = CmmUtil.nvl((String) session.getAttribute("userGroup"));
    String userEmail = CmmUtil.nvl((String) session.getAttribute("userEmail"));
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
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
                            <a class="dropdown-item" href="#" style="color: red;"><i class="fa fa-power-off"
                                                                                     aria-hidden="true"></i> 로그아웃</a>
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
                            <li class="active">
                                <a href="#">
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
                <li class="nav-item">
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
                <h4 class="page-title">내정보</h4>
                <div class="row" style="font-size: 10pt">
                    <div class="form-group">
                        <label for="first-name">계정명</label>
                        <input type="text" class="form-control" id="first-name" readonly value="<%= userId%>">
                    </div>
                    <!-- Last Name -->
                    <div class="form-group">
                        <label for="last-name">이메일</label>
                        <input type="text" class="form-control" id="last-name" readonly value="<%= userEmail%>">
                    </div>
                </div>
                <hr>
                <h4 class="page-title">비밀번호 변경</h4>
                <div class="row">

                    <div class="widget change-password">
                        <form id="passup" action="/updatePasswd.do" method="post">
                            <div class="form-group">
                                <label for="current-password">현재 비밀번호</label>
                                <input type="password" class="form-control" id="current-password" name="userPassword">
                            </div>
                            <!-- New Password -->
                            <div class="form-group">
                                <label for="new-password">새 비밀번호</label>
                                <input type="password" class="form-control" id="new-password" name="new-password">
                            </div>
                            <!-- Confirm New Password -->
                            <div class="form-group">
                                <label for="confirm-password">새 비밀번호 확인</label>
                                <input type="password" class="form-control" id="confirm-password">
                            </div>
                            <!-- Submit Button -->
                            <div class="form-group">
                                <button type="button" id="passwd_update" class="btn btn-transparent">비밀번호 변경</button>
                            </div>
                        </form>
                    </div>
                </div>

                <h4 class="page-title">이메일 변경</h4>
                <div class="row">
                    <!-- Change Email Address -->
                    <div class="widget change-email mb-0">
                        <form id="emup" action="/updateEmail.do" method="post">
                            <!-- New email -->
                            <div class="form-group">
                                <label for="new-email">새 이메일</label>
                                <input type="email" class="form-control" id="new-email" name="userEmail">
                            </div>
                            <!-- Submit Button -->
                            <div class="form-group">
                                <button type="button" id="email_update" class="btn btn-transparent">이메일 변경</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
</div>

<script>
    $('#passwd_update').click(function () {
        var re = /^[a-zA-Z0-9]{4,12}$/; // userpw
        var cpass = $('#current-password').val();
        var npass = $('#new-password').val();
        var npass2 = $('#confirm-password').val();
        if (cpass == "") {
            alert("현재 비밀번호를 입력해 주세요.");
            return false;
        } else if (npass == "") {
            alert("새 비밀번호를 입력해 주세요.");
            return false;
        } else if (npass2 == "") {
            alert("비밀번호 확인을 입력해 주세요.");
            return false;
        } else if (!re.test(npass)) {
            alert("비밀번호 형식이 올바르지 않습니다.");
            return false;
        } else if (npass != npass2) {
            alert("비밀번호 확인이 다릅니다.");
        } else {
            $('#passup').submit();
        }
    });

    $('#email_update').click(function () {
        var re3 = /^[A-Za-z0-9_\.\-\_]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/ // email
        var nmail = $('#new-email').val();

        if (nmail == "") {
            alert("이메일을 입력해 주세요.");
            return false;
        } else if (!re3.test(nmail)) {
            alert("이메일 형식이 올바르지 않습니다.");
        } else {
            $('#emup').submit();
        }
    });

</script>
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
