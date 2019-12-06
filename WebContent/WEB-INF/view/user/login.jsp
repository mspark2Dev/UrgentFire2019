<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport"
		  content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>급한불 로그인</title>
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
		<form class="login-form" action="/userLogin.do" method="POST">
			<div class="row">
				<div class="input-field col s12 center">
					<a href="/index.do"><h4><img src="/assets/img/logo.png"></h4></a>
				</div>
			</div>
			<div class="row margin">
				<div class="input-field col s12">

					<i class="material-icons prefix">account_circle</i> <input
						id="userId" name="userId" type="text"/>
					<label for="userId">계정명</label>
				</div>
			</div>

			<div class="row margin">
				<div class="input-field col s12">

					<i class="material-icons prefix">vpn_key</i> <input id="userPassword"
																		name="userPassword" type="password" /> <label for="userPassword">비밀번호</label>
				</div>
			</div>

			<div class="row">
				<div class="input-field col s12">
					<button type="submit" id="loginbtn" class="btn waves-effect waves-light col s12">로그인</button>
				</div>
				<div class="input-field col s12">
					<p class="margin center medium-small sign-up">
						아직 회원이 아니신가요? <a href="/register.do">회원가입</a>
					</p>
				</div>
				<div class="input-field col s12">
					<p class="margin center medium-small sign-up">
						계정을 잊어버리셨나요? <a href="/accsearch.do">계정찾기</a>
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
<script
		src="https://static.codepen.io/assets/editor/live/css_reload-5619dc0905a68b2e6298901de54f73cefe4e079f65a75406858d92924b4938bf.js"></script>
<script src="/assets/js/idCheck.js"></script>
</body>
</html>
