<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
  <head>
    <meta charset="UTF-8">
    <title>Home</title>    
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
    <style>
.carousel-control {
  padding-top:10%;
  width:5%;
}


.itemImage  img {
  max-height: 250px;
  max-width: 100%;
}
</style>
<script>
$(document).ready(function() {
	$('.biren').carousel({
	interval: 10000,
	wrap:false
	})
    
    $('#myCarousel').on('slid.bs.carousel', function() {
    	//alert("slid");
	});
    
    
});
</script>
    
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
                    <a href="#">
                        Start Bootstrap
                    </a>
                </li>
                <li>
                    <a href="ownerHome">Myshop</a>
                </li>
                <li>
                    <a href="manageShop.html">manageShop</a>
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
            <center><p><h3>${doc["shopName"]} <small>,${doc["Address"]["city"]}</small></h3></p><hr/></center>
<div class="container">
   
    <#assign keys = shopMap?keys>
<#list keys as key>
	 <div class="col-md-12">
     
      <div class="panel panel-default">
    <div class="panel-heading"><h2>${key}</h2></div>
    <div class="panel-body">

        <div class="well">
            <div id="myCarousel${key_index}" class="carousel slide biren">
                
                <!-- Carousel items -->
                <div class="carousel-inner">
                <#assign x=0 y=0>
                
                  <#list shopMap[key] as product>
                    
                    <#if x%4 == 0><#assign y=0> <#if x==0><div class="item active"><div class="row">
                    				<#else><div class="item"><div class="row"></#if>
                       </#if>
							 <div class="col-sm-3 "><a href="#x"><div class="itemImage" ><img height='250' width='250' src=" ${product['images'][0] } " alt="Image" class="img-responsive"></div></a><center><p style="padding-top:7px"><b><#if product?size==3><#else>${product['price']} Rs.</#if></b></p></center></div>
                               <#assign y=y+1>
                       <#if product_index == shopMap[key]?size-1></div></div></#if>        
                      <#if y==4></div></div></#if>
                       
                    <#assign x=x+1>
               </#list>                
                </div>
             
                <!--/carousel-inner--> <a class="left carousel-control" href="#myCarousel${key_index}" data-slide="prev">‹</a>

                <a class="right carousel-control" href="#myCarousel${key_index}" data-slide="next">›</a>
            </div>
            <!--/myCarousel-->
        </div>
  </div>
  </div>
  </div>
        </#list> 
        <!--/well-->
    
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
	$( "#dookFooter" ).load( "dookFooterOwner.html" );
	</script>
  </body>
</html>
