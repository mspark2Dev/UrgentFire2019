var idck = 0;
console.log(idck);

var re = /^[a-zA-Z0-9]{4,12}$/; // userpw
var re2 = /^[a-zA-Z0-9]{4,12}$/; // userid
var re3 = /^[A-Za-z0-9_\.\-\_]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/

$(function() {
    //idck 버튼을 클릭했을 때
    $('#idck').click(function() {

        //userid 를 param.
        var userid =  $("#userId").val();
        console.log(userid);

        if(userid == ""){
            alert("계정을 입력해 주세요.");
        } else if(!re2.test(userid)) {
            alert("계정명은 4~12자의 영문 대소문자와 숫자로만 입력");
            $("#userId").focus();
        } else {
            $.ajax({
                async: true,
                type: 'POST',
                data: {'userid': userid},
                url: "/idCheck.do",
                success: function (data) {
                    if (data > 0) {

                        alert("계정이 존재합니다. 다른 계정을 입력해주세요.");
                        $("#userId").focus();


                    } else {
                        alert("사용가능한 아이디입니다.");
                        $("#userEmail").focus();
                        //아이디가 중복하지 않으면  idck = 1
                        idck = 1
                    }
                }
                ,
                error: function (error) {
                    alert("error : " + error);
                }
            });
        }
    });
});

$(function() {

    // 회원가입 버튼 클릭 시 유효성
    $('#reg_submit').click(function() {

        console.log(idck)

        // 이메일 유효성
        if($("#userEmail").val() == ""){
            alert("이메일을 입력 해 주세요.");
            return false;
            $("#userEmail").focus();
        }
        else if(!re3.test(($("#userEmail")).val())){
            alert("이메일을 올바르게 입력해 주세요.");
            return false;
            $("#userEmail").focus();
        }

        // 비밀번호 유효성
        else if($("#userPassword").val()==""){
            alert("비밀번호를 입력해 주세요.");
            return false;
            $("#userPassword").focus();
        } else if(!re.test($("#userPassword").val())){
            alert("패스워드는 4~12자의 영문 대소문자와 숫자로만 입력 하세요.");
            return false;
            $("#userPassword").focus();
        }

        // 비밀번호 같은지
        else if($("#password_a").val()==""){
            alert("비밀번호 확인을 입력해 주세요.");
            return false;
            $("#password_a").focus();
        } else if(!($("#userPassword").val() == ($("#password_a").val()))) {
            alert("비밀번호 확인이 다릅니다.");
            return false;
            $("#password_a").focus();
        }

        else if (confirm("회원가입을 하시겠습니까?")) {
            if (idck == 0) {
                alert('아이디 중복체크를 해주세요');
                return false;

            } else {
                alert("회원가입을 축하합니다");
                $("#reg_submit").submit();
            }
        }
    });

    $('#passwd_update').click(function() {

        // 현재 비밀번호 유효성
        if($("#current-password").val()==""){
            alert("비밀번호를 입력해 주세요.");
            return false;
            $("#current-password").focus();
        } else if(!re.test($("#new-password").val())){
            alert("패스워드는 4~12자의 영문 대소문자와 숫자로만 입력 하세요.");
            return false;
            $("#current-password").focus();
        }

        // 새 비밀번호 유효성
        if($("#new-password").val()==""){
            alert("비밀번호를 입력해 주세요.");
            return false;
            $("#new-password").focus();
        } else if(!re.test($("#new-password").val())){
            alert("패스워드는 4~12자의 영문 대소문자와 숫자로만 입력 하세요.");
            return false;
            $("#new-password").focus();
        }

        // 비밀번호 같은지
        else if($("#confirm-password").val()==""){
            alert("비밀번호 확인을 입력해 주세요.");
            return false;
            $("#confirm-password").focus();
        } else if(!($("#new-password").val() == ($("#confirm-password").val()))) {
            alert("비밀번호 확인이 다릅니다.");
            return false;
            $("#confirm-password").focus();
        }
    });

    $('#email_update').click(function() {

        // 이메일 유효성
        if($("#new-email").val() == ""){
            alert("이메일을 입력해 주세요.");
            return false;
            $("#new-email").focus();
        }
        else if(!re3.test(($("#new-email")).val())){
            alert("이메일을 올바르게 입력해 주세요.");
            return false;
            $("#new-email").focus();
        }
    });

    $('#loginbtn').click(function() {

        // 이메일 유효성
        if($("#userId").val() == ""){
            alert("계정을 입력해 주세요.");
            return false;
            $("#userId").focus();
        }
        else if($('#userPassword').val() == ""){
            alert("비밀번호를 입력해 주세요.");
            return false;
            $("#userPassword").focus();
        }
    });
});