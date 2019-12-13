<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html >
  <head><title>classified physical shoppper</title>
  <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    
    <title>shopDetails(virtual shop)</title>    
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" type="text/css" /> 
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.11/css/dataTables.bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="css/prettyPhoto/prettyPhoto.css" type="text/css" media="screen" title="prettyPhoto main stylesheet" charset="utf-8" />

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/1.10.11/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script src="js/prettyPhoto/jquery.prettyPhoto.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript"><!-- to include another page-->
$(document).ready(function() {
$( "#dookHeader" ).load( "dookHeader.jsp" );
$( "#dookFooter" ).load( "dookFooter.html" );
});
</script>
<!--  submit review -->
 <script src="js/review.js"></script>
<link href="css/review.css" rel="stylesheet" type="text/css">
<script>
$(document).ready(function() {
$("a[rel^='prettyPhoto']").prettyPhoto();
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
	
  </head>

  <body>
  <!-- header included by Jquery biren -->
<div id="dookHeader" ></div>
<!-- header end -->
<ul class="breadcrumb">
	You are Here:
	<li><a href="/userHome">userHome</a></li>
	<li><a href="/userHome">Search Result</a></li>
	<li class="active"><a href="#">virtualShop</a></li>
</ul>
<hr/>
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
			height:70.6%;  /*old  80 */
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
 			<div class="item" ><p style="text-align:center;padding-top:0px;"><b>${product['name']}</b></p><a  rel="prettyPhoto" href=" ${product['images'][0] }" ><img class="itemImgs"  src=" ${product['images'][0] }" /></a><p style="text-align:center;padding-top:20px;"><b><#if product?size==3><#else>${product['price']} Rs.</#if></b></p></div>
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
<!-- review was here -->

<link href="http://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
<div class="container">
	<div class="row" style="margin-top:30px;">
		<div class="col-md-6">
    	<div class="well">
            <div class="text-right">
                <a class="btn btn-warning btn-lg" href="#submit-review" id="show-review-textarea"><span class="glyphicon glyphicon-comment"></span> Write a Review</a>
            </div>
        
     <div class="row" id="submit-review" style="display:none;">
         <div class="col-md-12">
         <form accept-charset="UTF-8"  method="post">
         <input type="hidden" name="userName" value="${userName}"/>
		 <input type="hidden" name="shopLink" value="${doc["shopLink"]}"/>
         
         <input id="hide-stars" name="review" type="hidden"> 
         <textarea class="form-control transition" cols="100" id="get-review" name="RComment" placeholder="Begin Here..." rows="10"></textarea>
        
         <div class="text-left">
         <div class="review-stars ratings" data-rating="0"></div>
         </div>
         <div class="text-right">
         <a class="btn btn-danger btn-lg" href="#" id="reject-review" style="display:none; margin-right: 10px;">
         <span class="glyphicon glyphicon-remove"></span>Reject</a>
         <button class="btn btn-success btn-lg" type="submit"> <span class="glyphicon glyphicon-send"></span>Send</button>
          
                        </div>
                    </form>
                </div>
            </div>
            <p class="error">
        ${msg}
          </p>
            
         </div> 
      </div>
   </div>
</div>

      

    
   <!-- Footer included by Jquery biren -->
<div id="dookFooter" ></div>
<!-- footer end --> 
    
  </body>
</html>



<!-- <#assign keys = shopMap?keys>
<#list keys as key>
<h3>${key}</h3> <h3>= </h3>
<#list shopMap[key] as product>
${product["name"]}
</#list>
 </#list> -->