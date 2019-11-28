<%@ page import="poly.util.CmmUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userId = CmmUtil.nvl((String)session.getAttribute("userId"));
    String userGroup = CmmUtil.nvl((String)session.getAttribute("userGroup"));
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
        .btn-outline-primary{
            padding: 5px;
            font-size: 10pt;
            margin-top: 10px;
        }

        .inputPasswd{
            width: 200px;
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
                        <h5 class="text-center"><%= userId %></h5>
                        <p>
                            <% if(userGroup.equals("1")){ %>
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
                            <li class="" ><a href="/mypage.do"><i class="fa fa-user"></i> 내가 작성한 글</a></li>
                            <li class="active"><a href="#"><i class="fa fa-power-off"></i>회원탈퇴</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">
                <div class="widget dashboard-container my-adslist">
                    <h3 class="widget-header">회원탈퇴</h3>
                    <h4><strong>정말로 계정을 삭제하시겠습니까?</strong></h4>
                    <br>
                    <p style="font-size: 10pt;">비밀번호를 입력해주세요.</p>
                    <form action="/delUserProc.do" method="post">
                        <input type="password" name="userPassword" class="inputPasswd col-form-label-sm" placeholder="비밀번호 입력">
                        <div>
                        <button class="btn btn-outline-primary" type="submit">회원탈퇴</button>
                        </div>
                    </form>
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