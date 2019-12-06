<%@ page import="poly.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
//    String emailcord = CmmUtil.nvl((String)request.getAttribute("contents"));
//    emailcord.replaceAll("\\[", "");
//    emailcord.replaceAll("]", "");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>급한불 비밀번호초기화</title>
    <link rel='stylesheet'
          href='https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css'>
    <link rel='stylesheet'
          href='https://fonts.googleapis.com/icon?family=Material+Icons'>
    <link rel="stylesheet" href="/assets/css/user.css">
    <script>
        window.console = window.console || function (t) {
        };
    </script>
    <script>
        if (document.location.search.match(/type=embed/gi)) {
            window.parent.postMessage("resize", "*");
        }
    </script>
    <script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
</head>
<body translate="no">
<div id="login-page" class="row">
    <div class="col s12 z-depth-4 card-panel">
        <form class="login-form" action="/resetpasswd.do" id="search_frm">
            <div class="row">
                <div class="input-field col s12 center">
                    <a href="/index.do"><h4><img src="/assets/img/logo.png"></h4></a>
                </div>
            </div>
            <div class="row margin">
                <div class="input-field col s12">

                    <i class="material-icons prefix">account_circle</i> <input id="userId" class="Id"
                                                                      type="text" name="userId"
                                                                      style="cursor: auto;"/>
                    <label for="userEmail">계정을 입력해 주세요.</label>
                </div>
                <div class="input-field col s12">

                    <i class="material-icons prefix">email</i> <input id="userEmail" class="email"
                                                                      name="userEmail" type="email"
                                                                      style="cursor: auto;"/>
                    <label for="userEmail">이메일을 입력해 주세요.</label>
                </div>
                <div class="input-field col s12">
                    <button type="button" class="btn waves-effect waves-light col s12" id="email_check">이메일인증</button>
                </div>
            </div>
            <div class="input-field col s12" style="display: none" id="cordField">

                <i class="material-icons prefix">vpn_key</i> <input id="emailCord"
                                                                    name="evaild" type="text" style="cursor: auto;"/>
                <label for="emailCord">인증번호를 입력해주세요.</label>
                <div class="input-field col s12">
                    <button type="button" class="btn waves-effect waves-light col s12" id="vail_check">인증번호 확인</button>
                </div>
            </div>
            <div class="input-field col s12" style="display: none" id="re_passwd">

                <i class="material-icons prefix">vpn_key</i> <input id="reset_pass" name="reset_pass"
                                                                    type="password" style="cursor: auto;"/>
                <label for="emailCord">새 비밀번호를 입력해 주세요.</label>
            </div>
            <div class="input-field col s12" style="display: none" id="re_passwd2">

                <i class="material-icons prefix">vpn_key</i> <input id="reset_pass2"
                                                                    type="password" style="cursor: auto;"/>
                <label for="emailCord">비밀번호 확인을 입력해 주세요.</label>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <button type="button" class="btn waves-effect waves-light col s12" id="pwreset">비밀번호초기화</button>
                </div>
                <div class="input-field col s12">
                    <p class="margin center medium-small sign-up">
                        계정을 모르시나요? <a href="/accsearch.do">계정찾기</a>
                    </p>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    $('#email_check').click(function () {
        var email = $('#userEmail').val();
        var re = /^[A-Za-z0-9_\.\-\_]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/
        var re2 = /^[a-zA-Z0-9]{4,12}$/; // userpw

        if (email == "") {
            alert("이메일을 입력해 주세요.");
            $('#userEmail').focus();
            return false;
        } else {
            if (!re.test(email)) {
                alert("이메일 형식이 올바르지 않습니다.");
                $('#userEmail').focus();
                return false;
            } else {
                $.ajax({
                    type: "POST",
                    url: "/mail/sendMail.do",
                    data: {"userEmail": email},
                    success: function(data){
                        if(data>0){
                            alert("메일이 전송되었습니다.");
                            var e_check = document.getElementById("email_check");
                            e_check.style.display = "none";

                            var e_cord = document.getElementById("cordField");
                            e_cord.style.display = "block";

                            // console.log(data);

                            $('#vail_check').click(function () {
                                var cordinput = $('#emailCord').val();

                                if(data==cordinput){
                                    alert("인증되었습니다.");
                                    var cordck = document.getElementById("vail_check");
                                    cordck.style.display = "none";
                                    var passck = document.getElementById("re_passwd");
                                    passck.style.display = "block";
                                    var passck2 = document.getElementById("re_passwd2");
                                    passck2.style.display = "block";
                                    var ecord = document.getElementById("cordField");
                                    ecord.style.display = "none";
                                    $('#pwreset').click(function () {
                                        if($('#reset_pass').val()==""){
                                            alert("비밀번호를 입력해 주세요.");
                                        } else {
                                            if(!re2.test($('#reset_pass').val())){
                                                alert("비밀번호 형식이 올바르지 않습니다.");
                                            } else {
                                                if(!$('#reset_pass').val() == $('#reset_pass2').val()){
                                                    alert("비밀번호 확인이 다릅니다.");
                                                } else {
                                                    $('#search_frm').submit();
                                                }
                                            }
                                        }
                                    })
                                } else {
                                    alert("인증번호가 올바르지 않습니다.");
                                    return false;
                                    $('#emailCord').focus();
                                }
                            })
                        } else {
                            alert("메일 전송에 실패했습니다.");
                        }
                    }
                });

            }
        }

    });
</script>
<script
        src="https://static.codepen.io/assets/common/stopExecutionOnTimeout-de7e2ef6bfefd24b79a3f68b414b87b8db5b08439cac3f1012092b2290c719cd.js"></script>
<script
        src='https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js'></script>

<script src='/assets/js/idCheck.js'></script>
<script
        src="https://static.codepen.io/assets/editor/live/css_reload-5619dc0905a68b2e6298901de54f73cefe4e079f65a75406858d92924b4938bf.js"></script>
</body>
</html>
