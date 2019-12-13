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
$( "#dookHeader" ).load( "dookHeaderAdmin.html" );
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
                    <a href="admin162/manageShop">
                        ManageShop
                    </a>
                </li>
                <li>
                    <a href="admin162">DashBoard</a>
                </li>
                <li>
                  <a href="manageCat">Manage Category</a>
                </li>
                <li>
                    <a href="#">Manage owner</a>
                </li>
                <li>
                    <a href="#">manage Orders</a>
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
.hero-widget { text-align: center; padding-top: 10px; padding-bottom: 10px; }
.hero-widget .icon { display: block; font-size: 35px; line-height: 35px; margin-bottom: 10px; text-align: center; }
.hero-widget var { display: block; height: 35px; font-size: 35px; line-height: 35px; font-style: normal; }
.hero-widget label { font-size: 14px; }
.hero-widget .options { margin-top: 0px; }
</style>
<script>
$('document').ready(function(){
$('.count').each(function () {
    $(this).prop('Counter',0).animate({
        Counter: $(this).text()
    }, {
        duration: 1000,
        easing: 'swing',
        step: function (now) {
            $(this).text(Math.ceil(now));
        }
    });
});
});
</script>
<div class="container">
	<div class="row rowBiren">
		<div class="col-sm-3 ">
    	    <div class="hero-widget well well-sm">
                <div class="icon">
                     <i class="glyphicon glyphicon-user"></i>
                </div>
                <div class="text">
                    <var class="count">${Tuser}</var>
                    <label class="text-muted">Total User</label>
                </div>
                <div class="options">
                    <a href="javascript:;" class="btn btn-default btn-sm"><i class="glyphicon glyphicon-wrench"></i> Manage</a>
                </div>
            </div>
		</div>
        <div class="col-sm-3">
            <div class="hero-widget well well-sm">
                <div class="icon">
                     <i class="glyphicon glyphicon-star"></i>
                </div>
                <div class="text">
                    <var class="count">${Tshop }</var>
                    <label class="text-muted">Total properties</label>
                </div>
                <div class="options">
                    <a href="javascript:;" class="btn btn-default btn-sm"><i class="glyphicon glyphicon-wrench"></i> Manage</a>
                </div>
            </div>
		</div>
        
	</div>
</div>
</div>
        <!-- /#page-content-wrapper -->

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
	$( "#dookFooter" ).load( "dookFooterAdmin.html" );
	</script>
  </body>
</html>
