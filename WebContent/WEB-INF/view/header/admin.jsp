<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav
        class="navbar navbar-light navbar-expand-md navigation-clean-button">
    <div class="container">
        <a class="navbar-brand" href="/index.do"><img
                src="/assets/img/logo.png"></a>
        <button data-toggle="collapse" class="navbar-toggler"
                data-target="#navcol-1">
            <span class="sr-only">Toggle navigation</span><span
                class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navcol-1">
            <ul class="nav navbar-nav mr-auto">
                <li class="dropdown nav-item"><a
                        class="dropdown-toggle nav-link" data-toggle="dropdown"
                        aria-expanded="false" href="#">공중화장실 찾기 </a>
                    <div class="dropdown-menu" role="menu">
                        <a class="dropdown-item" role="presentation"
                           href="/toilet_auto.do">내 주변 공중화장실</a> <a class="dropdown-item"
                                                                    role="presentation" href="/toilet_manual.do">공중화장실
                        찾기</a>
                    </div>
                </li>
                <li class="nav-item" role="presentation"><a class="nav-link"
                                                            href="/Board/BoardList.do?Pno=1">어땠나요 ?</a></li>
            </ul>
            <span class="navbar-text actions" id="navbar-user-text"> <a
                    class="login" href="/logout.do">로그아웃</a> <a
                    class="btn btn-light action-button" role="button"
                    href="/admin.do">관리페이지</a>
				</span>
        </div>
    </div>
</nav>