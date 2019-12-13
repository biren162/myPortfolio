<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
  <head>
    <meta charset="UTF-8">
    <title>Classified Physical shopper</title>    
	 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" type="text/css" /> 
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.11/css/dataTables.bootstrap.min.css" type="text/css" />

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/1.10.11/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<style>
#menu-toggle{
position: relative;
    z-index: 10;
float:left;}
</style>
<script type="text/javascript"><!-- to include another page-->
$(document).ready(function() {
$( "#dookHeader" ).load( "dookHeaderOwner.html" );
});
</script>	
<!-- Custom CSS -->
    <link href="owner/css/simple-sidebar.css" rel="stylesheet">
       
  </head>
  <body>
  <!-- header included by Jquery biren -->
<div id="dookHeader" ></div>
<!-- header end -->
<div id="wrapper">
<a href="#menu-toggle" class="btn btn-default btn-sm" id="menu-toggle">
          <span class="glyphicon glyphicon-menu-hamburger"></span>
        </a>
        <!-- Sidebar -->
        <div id="sidebar-wrapper">
		<div id="sidebar-wrapper-wrapper">	
            <ul class="sidebar-nav sidebar-nav-inverse">
                <li class="sidebar-brand">
                    <a href="addShop">
                        Add NewShop
                    </a>
                </li>
                <li>
                    <a href="ownerHome">Myshop</a>
                </li>
                <li>
                  <a href="manageShop">ManageShop</a>
                </li>
                <li>
                    <a href="#">Overview</a>
                </li>
                <li>
                    <a href="#">Events</a>
                </li>
                <li>
                    <a href="#">About</a>
                </li>
                <li>
                    <a href="#">Services</a>
                </li>
                <li>
                    <a href="#">Contact</a>
                </li>
            </ul>
			</div>
        </div>
        <!-- /#sidebar-wrapper -->

        <!-- Page Content -->
        <div id="page-content-wrapper">
        	
        	<style>
      #map {
        height: 50%;
        width:80%;
      }
    </style>
<script>
// Note: This example requires that you consent to location sharing when
// prompted by your browser. If you see the error "The Geolocation service
// failed.", it means you probably did not give permission for the browser to
// locate you.

function initMap() {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 15
  });
  var infoWindow = new google.maps.InfoWindow({map: map});

  // Try HTML5 geolocation.
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
	document.getElementById("lat1").value=position.coords.latitude;
	document.getElementById("long1").value=position.coords.longitude;
      infoWindow.setPosition(pos);
      infoWindow.setContent('Location found.');
      map.setCenter(pos);
    }, function() {
      handleLocationError(true, infoWindow, map.getCenter());
    });
  } else {
    // Browser doesn't support Geolocation
    document.getElementById("lat1").value=-1;
    document.getElementById("long1").value=-1;
    handleLocationError(false, infoWindow, map.getCenter());
  }
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infoWindow.setPosition(pos);
  
  infoWindow.setContent(browserHasGeolocation ?
                        'Error: The Geolocation service failed.' :
                        'Error: Your browser doesn\'t support geolocation.');
}

    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCurrIGsqh0q7G6pepNXR1uMsuoXnuk5PM&signed_in=true&callback=initMap"
        async defer>
    </script>
   <#-- map end -->    
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
        	<div class="container">
    	<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-6">
								<a href="#" class="active" id="login-form-link">Add Shop</a>
							</div>
						</div>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
								<form id="login-form"  method="post" enctype="multipart/form-data" role="form" name="form1" style="display: block;" >
								 <input type="hidden" id="long1" name="long" value="-1.0"/> 
   								 <input type="hidden" id="lat1"  name="lat" value="-1.0"/>  
									<div class="form-group">
										<input type="text" name="shopname" value="${shopname}" tabindex="1" class="form-control" placeholder="shopName *" >
										<center><p class="error">${ name_error}</p></center>
									</div>
									<h4>shopCategory:</h4>
									<div class="form-group">
									  <select class="form-control" name="category">
        								  <#if CategoryList?has_content>
          
		  										<#list CategoryList as list>
  											<option name="category" value="${list['catName']}">${list['catName']}</option>
  											</#list>
  											</#if>
										</select>
									</div>
									
									<fieldset>
									<legend>shop address:</legend>
									<div class="form-group">
										<input type="text" name="line1" value="${line1}" tabindex="2" class="form-control" placeholder="Line1 *">
										<center><p class="error">${line1_error} </p></center>
									</div>
									<div class="form-group">
										<input type="text" name="area" value="${area}"  tabindex="2" class="form-control" placeholder="Area name *">
										<center><p class="error">${area_error} </p></center>
									</div>
									<div class="form-group">
										<input  type="text" name="city" value="${city}" tabindex="2" class="form-control" placeholder="city *"> 
										<center><p class="error"> ${city_error}</p></center>
									</div>
									<div class="form-group">
										<input type="text" name="state" value="${state}"  tabindex="2" class="form-control" placeholder="state *">
										<center><p class="error">${state_error} </p></center>
									</div>
									<div class="form-group">
										<input type="text" name="country" value="${country}"  tabindex="2" class="form-control" placeholder="country *">
										<center><p class="error">${country_error} </p></center>
									</div>
									<legend></legend>
									</fieldset>
									<h4>shop Image:</h4>
									<div class="form-group">
										<input type="file" required name="img"/> 
									</div>
									 
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="Submit">
											</div>
										</div>
									</div>
								</form>
								
							</div>
						</div>
					</div>
				</div>					<div class="row">
											<div class="col-lg-12">
												<div class="text-center">
													 Already a user? <a href="/userLogin">UserLogin</a><p>
												</div>
											</div>
										</div>
			</div>
		</div>
	</div>
        	
        	
 	        </div>
        <!-- /#page-content-wrapper -->
<div id="map" >map</div>
    </div>
    <!-- /#wrapper -->
	
    <!-- Menu Toggle Script -->
    <script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
    </script>
 <div id="space" ><br/><br/><br/> <br/><br/><br/> <br/><br/><br/><br/><br/><br/><br/><br/> <br/><br/><br/><br/><br/></div>
   
   <!-- Footer included by Jquery biren -->
<div id="dookFooter" ></div>
<!-- footer end --> 
    <script>
	$( "#dookFooter" ).load( "dookFooterOwner.html" );
	</script>
  </body>
</html>
