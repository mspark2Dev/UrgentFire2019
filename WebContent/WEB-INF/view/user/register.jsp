<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport"
		  content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>급한불 계정생성</title>
	<link rel="shortcut icon" type="image/x-icon"
		  href="https://static.codepen.io/assets/favicon/favicon-aec34940fbc1a6e787974dcd360f2c6b63348d4b1f4e06c77743096d55480f33.ico" />
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
					<input type="hidden" id="idck_value" value="0">
					<label for="userId">계정명</label>
				</div>
			</div>

			<div class="row margin">
				<div class="input-field col s12">

					<i class="material-icons prefix">email</i> <input id="userEmail" class="email"
																	  name="userEmail" type="email" style="cursor: auto;"/>
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
<script
		src="https://static.codepen.io/assets/common/stopExecutionOnTimeout-de7e2ef6bfefd24b79a3f68b414b87b8db5b08439cac3f1012092b2290c719cd.js"></script>
<script
		src='https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js'></script>

<script src='/assets/js/idCheck.js'></script>
<script
		src="https://static.codepen.io/assets/editor/live/css_reload-5619dc0905a68b2e6298901de54f73cefe4e079f65a75406858d92924b4938bf.js"></script>
</body>
</html>
