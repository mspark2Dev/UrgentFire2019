<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport"
		  content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>급한불 계정생성</title>
	<link rel='stylesheet'
		  href='https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css'>
	<link rel='stylesheet'
		  href='https://fonts.googleapis.com/icon?family=Material+Icons'>
	<link rel="stylesheet" href="/assets/css/user.css">
	<script>
		window.console = window.console || function(t) {
		};
	</script>
	<script>
		if (document.location.search.match(/type=embed/gi)) {
			window.parent.postMessage("resize", "*");
		}
	</script>
	<script src='https://code.jquery.com/jquery-3.2.1.min.js'></script>
<%--	<script src="/assets/js/idCheck.js"></script>--%>
</head>
<body translate="no">
<div id="login-page" class="row">
	<div class="col s12 z-depth-4 card-panel">
		<form class="login-form" action="/userRegProc.do" method="POST">
			<div class="row">
				<div class="input-field col s12 center">
					<a href="/index.do"><h4><img src="/assets/img/logo.png"></h4></a>
				</div>
			</div>
			<div class="row margin">
				<div class="input-field col s12" style="margin-bottom: -25px;">

					<i class="material-icons prefix">account_circle</i> <input
						id="userId" name="userId" type="text"/>
					<input type="button" class="btn-check" id="idck" value="중복확인" style="width:60px; height: 15px;">
					<label for="userId">계정명</label>
				</div>
			</div>

			<div class="row margin">
				<div class="input-field col s12">

					<i class="material-icons prefix">email</i> <input id="userEmail" class="email"
																	  name="userEmail" type="email" style="cursor: auto;"/>
					<input type="button" class="btn-check" id="emcheck" value="중복확인" style="width:60px; height: 15px;">
					<label for="userEmail">이메일</label>
				</div>
			</div>
			<div class="row margin">
				<div class="input-field col s12">

					<i class="material-icons prefix">vpn_key</i> <input id="userPassword"
																		name="userPassword" type="password" /> <label for="userPassword">비밀번호</label>
				</div>
			</div>
			<div class="row margin">
				<div class="input-field col s12">

					<i class="material-icons prefix">vpn_key</i> <input
						id="password_a" name="cpassword" type="password" /> <label
						for="password_a">비밀번호 재입력</label>
				</div>
			</div>
			<div class="row">
				<div class="input-field col s12">
					<button type="submit" class="btn waves-effect waves-light col s12" id="reg_submit">계정생성</button>
				</div>
				<div class="input-field col s12">
					<p class="margin center medium-small sign-up">
						이미 계정이 있으신가요? <a href="/login.do">로그인하기</a>
					</p>
				</div>
			</div>
		</form>
	</div>
</div>
<script>
	var idck = 0;
	var emck = 0;
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

	$(function () {
		//emck 버튼을 클릭했을 때
		$('#emcheck').click(function() {

			//userid 를 param.
			var useremail =  $("#userEmail").val();
			console.log(useremail);

			if(useremail == ""){
				alert("이메일을 입력해주세요.");
			} else if(!re3.test(useremail)) {
				alert("이메일 형식이 올바르지 않습니다.");
				$("#userEmail").focus();
			} else {
				$.ajax({
					async: true,
					type: 'POST',
					data: {'useremail': useremail},
					url: "/emCheck.do",
					success: function (data) {
						if (data > 0) {

							alert("이메일이 존재합니다. 다른 이메일을 입력해주세요.");
							$("#userEmail").focus();


						} else {
							alert("사용가능한 이메일입니다.");
							$("#userPassword").focus();
							//아이디가 중복하지 않으면  idck = 1
							emck = 1
						}
					}
					,
					error: function (error) {
						alert("error : " + error);
					}
				});
			}
		});
	})
	$(function() {

		// 회원가입 버튼 클릭 시 유효성
		$('#reg_submit').click(function() {

			console.log(idck)
			// 비밀번호 유효성
			if($("#userPassword").val()==""){
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
					if(emck == 0){
						alert('이메일 중복체크를 해주세요');
						return false;
					} else {
						alert("회원가입을 축하합니다");
						$("#reg_submit").submit();
					}
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
</script>
<script
		src="https://static.codepen.io/assets/common/stopExecutionOnTimeout-de7e2ef6bfefd24b79a3f68b414b87b8db5b08439cac3f1012092b2290c719cd.js"></script>
<script
		src='https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js'></script>
<script
		src="https://static.codepen.io/assets/editor/live/css_reload-5619dc0905a68b2e6298901de54f73cefe4e079f65a75406858d92924b4938bf.js"></script>
</body>
</html>
