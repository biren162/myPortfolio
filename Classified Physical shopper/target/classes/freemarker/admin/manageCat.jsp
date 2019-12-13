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
        <div class="col-md-6 col-md-offset-3">
        <form id="catForm" method="post"  role="form" name="catForm" style="display: block;" >  
									<div class="form-group">
										<input type="text" name="catName" value="" tabindex="1" class="form-control" placeholder="category name *" required>
										<button  tabindex="4" class="form-control btn btn-login" type="submit">Add</button>
									</div>
									</form>
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
