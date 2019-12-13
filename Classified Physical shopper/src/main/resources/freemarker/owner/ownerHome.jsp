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
<script type="text/javascript"><!-- to include another page-->
$(document).ready(function() {
$( "#dookHeader" ).load( "dookHeaderOwner.html" );
});
</script>
<script>
$(document).ready(function() {
$('.owl-carousel').owlCarousel({
    loop:false,
    margin:10,
    nav:true,
	
    responsive:{
	0:{
	items:1
	},
        768:{
            items:2
        },
        992:{
            items:3
        },
        1200:{
            items:4
        }
    }
});
$("#myNext").click(function(){
 $("#owl-carousel").trigger('owl.next');
});
});
</script>
<style>

#menu-toggle{
position: relative;
    z-index: 10;
float:left;}
</style>
	
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
                    <a href="manageShop?shopLink=${shopLink}">manageShop</a>
                </li>
                <li>
                    <a href="addvShop?shopLink=${shopLink}">add product</a>
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
        	
		<hr/>
 			<form method="get">       
         	select shop:
         	<select name="shopLink">
          	<#if shopList?has_content>
         	
          
		  <#list shopList as list>
  			<option name="category" value="${list['shopLink']}">${list['shopName']}</option>
  			</#list>
  			</#if>
  			</select>
  			<input type="submit"/>
            </form>
				<center><p><h3>${doc["shopName"]} <small>,${doc["Address"]["city"]}</small></h3></p><hr/></center>
				<div class="container">
   
    <#assign keys = shopMap?keys>
<#list keys as key>
	 <div class="col-md-12">
     
      <div class="panel panel-default">
    <div class="panel-heading"><h2>${key}</h2></div>
    <div class="panel-body">
			<!-- slider start -->
			<style>
			
			.item{
			background:#FFF;
			height:300px;
			}
			.itemImgs{
			height:70.6%;
			}
			@media only screen and (max-width: 768px) {
    		/* For mobile phones: */
    		.item{
    			height:200px;
    			}
    		}
			</style>
			<script src="js/slider/owl.carousel.js">
			</script>
			<script src="js/slider/owl.carousel.min.js">
			</script>
			<link rel="stylesheet"  href="css/slider/owl.carousel.css" type="text/css" />
			<link rel="stylesheet"  href="css/slider/themeDefault.css" type="text/css" />

			<div class="container"><div class="col-lg-11 col-md-11 col-sm-11 col-xs-11">
			<div class="owl-carousel">
				<#list shopMap[key] as product>
 			<div class="item" ><p style="text-align:center;padding-top:0px;"><b>${product['name']}</b></p><img class="itemImgs"  src=" ${product['images'][0] }" /><p style="text-align:center;padding-top:10px;"><b><#if product?size==3><#else>${product['price']} Rs.</#if></b></p></div>
				 </#list> 
			</div>
			</div>
			</div>
			<!-- slider end -->
         
  </div>
  </div>
  </div>
        </#list> 
        <!--/well-->
    
</div>  
				

			<br/><br/><br/><br/><br/><br/>
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
