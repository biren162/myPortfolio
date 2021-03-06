<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><title>Classified physical shopper</title>
 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<style>
 .error {color: red}
.panel-login {
	border-color: #ccc;
	-webkit-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
	-moz-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
	box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
}
.panel-login>.panel-heading {
	color: #00415d;
	background-color: #fff;
	border-color: #fff;
	text-align:center;
}
.panel-login>.panel-heading a{
	text-decoration: none;
	color: #666;
	font-weight: bold;
	font-size: 15px;
	-webkit-transition: all 0.1s linear;
	-moz-transition: all 0.1s linear;
	transition: all 0.1s linear;
}
.panel-login>.panel-heading a.active{
	color: #029f5b;
	font-size: 18px;
}
.panel-login>.panel-heading hr{
	margin-top: 10px;
	margin-bottom: 0px;
	clear: both;
	border: 0;
	height: 1px;
	background-image: -webkit-linear-gradient(left,rgba(0, 0, 0, 0),rgba(0, 0, 0, 0.15),rgba(0, 0, 0, 0));
	background-image: -moz-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
	background-image: -ms-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
	background-image: -o-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
}
.panel-login input[type="text"],.panel-login input[type="email"],.panel-login input[type="password"] {
	height: 45px;
	border: 1px solid #ddd;
	font-size: 16px;
	-webkit-transition: all 0.1s linear;
	-moz-transition: all 0.1s linear;
	transition: all 0.1s linear;
}
.panel-login input:hover,
.panel-login input:focus {
	outline:none;
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
	box-shadow: none;
	border-color: #ccc;
}
.btn-login {
	background-color: #59B2E0;
	outline: none;
	color: #fff;
	font-size: 14px;
	height: auto;
	font-weight: normal;
	padding: 14px 0;
	text-transform: uppercase;
	border-color: #59B2E6;
}
.btn-login:hover,
.btn-login:focus {
	color: #fff;
	background-color: #4ca750;
	border-color: #4ca750;
}
.forgot-password {
	text-decoration: underline;
	color: #888;
}
.forgot-password:hover,
.forgot-password:focus {
	text-decoration: underline;
	color: #666;
}

</style>
<script>
$(function() {

    $('#login-form-link').click(function(e) {
		$("#login-form").delay(100).fadeIn(100);
 		$("#register-form").fadeOut(100);
		$('#register-form-link').removeClass('active');
		$(this).addClass('active');
		e.preventDefault();
	});
	

});

</script>
 <script type="text/javascript">
$(document).ready(function() {
$( "#dookFooter" ).load( "dookFooter.html" );
});
</script>
</head>
<body>

 <!-- header-->
 <style>
 .title{
color:white;
}
.well{
background:#4ca750
}

 </style>
<div>
<div class="well well-sm">
<div class="container-fluid">
  <div class="row-fluid">
    <div class="offset1 span8 pull-right">
    <h4 class="textMobile"><i>are you owner?</i></h4>
    <h2 class="textMobile"><a href="ownerLogin" class="btn btn-info btnMobile" role="button">Register Your Shop</a></h2>
    </div>
   <!--    another content  -->
   <div class="span8 pull-left" style="bottom:0;margin-left: 0;">
      <h2 class="title"> Classified Physical Shopper</h2>
   </div>
  </div>
</div><!--/.fluid-container-->
</div>
</div> 
<style>
@media only screen and (max-width: 768px) {
.title{
font-size:20px;
font-weight:bold;
}
.textMobile{
    font-size: 15px;
    margin-top: 4px;
    margin-bottom: 4px;
}
.pull-left{
float:none;
}
.container-fluid{
    padding-right: 5px;
    padding-left: 0px;
}
.btnMobile{
    padding: 5px 5px;
    font-size: 10px;
    line-height: 1.2;
    border-radius: 3px;}
}
</style>
<!-- header end -->

<div class="container">
    	<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-6">
								<a href="#" class="active" id="login-form-link">passwordRecovery</a>
							</div>
						</div>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<h3>something went wrong try again to recover your password</h3>
								<a href="userLogin" >login here</a>				
							</div>
						</div>
					</div>
				</div>
										<div class="row">
											<div class="col-lg-12">
												<div class="text-center">
													 Need to Create an account? <a href="/userSignUp">Signup</a>
												</div>
											</div>
										</div>
			</div>
		</div>
	</div>
	 <!-- Footer included by Jquery biren -->
<div id="dookFooter" ></div>
<!-- footer end --> 
	</body>