<%@ page import="poly.util.CmmUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userId = CmmUtil.nvl((String)session.getAttribute("userId"));
    String userGroup = CmmUtil.nvl((String)session.getAttribute("userGroup"));
    String userEmail = CmmUtil.nvl((String)session.getAttribute("userEmail"));
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

    </style>
</head>

<body class="body-wrapper">
<jsp:include page="/WEB-INF/view/header/normal.jsp"></jsp:include>

<!--==================================
=            User Profile            =
===================================-->
<section class="dashboard section" style="min-height: 100vh;">
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
                        <h5 class="text-center"><%= userId %></h5>
                        <p>
                            <% if(userGroup.equals("1")){ %>
                            사용자
                            <% } else { %>
                            관리자
                            <% } %>
                        </p>
                        <a href="" class="btn btn-main-sm">회원정보 수정</a>
                    </div>
                    <!-- Dashboard Links -->
                    <div class="widget user-dashboard-menu">
                        <ul>
                            <li><a href="/mypage.do"><i class="fa fa-user"></i> 내가 작성한 글</a></li>
                            <li><a href="/deluser.do"><i class="fa fa-power-off"></i>회원탈퇴</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">
                <!-- Edit Personal Info -->
                <div class="widget personal-info">
                    <h3 class="widget-header user">회원정보</h3>
                    <!-- First Name -->
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
                <!-- Change Password -->
                <div class="widget change-password">
                    <h3 class="widget-header user">비밀번호 변경</h3>
                    <form action="/updatePasswd.do" method="post">
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
                        <button type="submit" id="passwd_update" class="btn btn-transparent">비밀번호 변경</button>
                    </form>
                </div>
                <!-- Change Email Address -->
                <div class="widget change-email mb-0">
                    <h3 class="widget-header user">이메일 변경</h3>
                    <form action="/updateEmail.do" method="post">
                        <!-- New email -->
                        <div class="form-group">
                            <label for="new-email">새 이메일</label>
                            <input type="email" class="form-control" id="new-email" name="userEmail">
                        </div>
                        <!-- Submit Button -->
                        <button type="submit" id="email_update" class="btn btn-transparent">이메일 변경</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/view/footer/footer.jsp"></jsp:include>

<script src="/assets/js/jquery.min.js"></script>
<script src="/assets/bootstrap/js/bootstrap.min.js"></script>
<script src="/assets/js/idCheck.js"></script>
</body>

</html>