
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><title>classified physical shoppper</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.11/css/dataTables.bootstrap.min.css" type="text/css" />

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="https://cdn.datatables.net/1.10.11/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<style>
.shopImg{
height:100px;
width:100px;
}

@media only screen and (max-width: 768px) {
    /* For mobile phones: */
	.shopImg{
	height:50px;
	width:50px;
	}
	#example{
	font-size:small;
	}
	#example td,th{
	font-size:8px;
	padding:0;
	font-weight:bold;
	}
	.location{
	display:none;
	}
	.navv{
	font-size:8px;
	font-weight:bold;
	padding:0;
	}
  
}
</style>
<script>
$(document).ready(function() {
	$('#example').DataTable({
		"paging":false
		//,"lengthChange": true
		}
	);
} );
</script>
<script type="text/javascript"><!-- to include another page-->
$(document).ready(function() {
$( "#dookHeader" ).load( "dookHeader.jsp" );
$( "#dookFooter" ).load( "dookFooter.html" );
});
</script>
<style>
body{
background:#ededf7;
}
span.stars, span.stars span {
    display: block;
    background: url(stars.png) 0 -16px repeat-x;
    width: 80px;
    height: 16px;
}

span.stars span {
    background-position: 0 0;
}

</style>
<script>
$.fn.stars = function() {
    return $(this).each(function() {
        // Get the value
        var val = parseFloat($(this).html());
        if(val==-1)
        	val=0;
        // Make sure that the value is in 0 - 5 range, multiply to get width
        var size = Math.max(0, (Math.min(5, val))) * 16;
        // Create stars holder
        var $span = $('<span />').width(size);
        // Replace the numerical value with stars
        $(this).html($span);
    });
}
$(document).ready(function(){	
	    $('span.stars').stars();	
	});
</script>
</head>
<body >
<!-- header included by Jquery biren -->
<div id="dookHeader" ></div>
<!-- header end -->

<!-- start location code-->
<p id="demo"></p>
<form method="get">
<input type="hidden" id="lat1" name="lat" value="-1"/>
<input type="hidden" id="longi1" name="longi" value="-1"/>
<script>
var pos;


function showDistance(id1,lat3,longi3){
	x1=${lat};
	y1=${longi};
	//document.getElementById(id1).innerHTML=x1+" "+y1+" "+lat3+" "+longi3;
	document.getElementById(id1).innerHTML=getDistanceFromLatLonInKm(x1,y1,lat3,longi3).toFixed(2)+" km";
}
function getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
	  var R = 6371; // Radius of the earth in km
	  var dLat = deg2rad(lat2-lat1);  // deg2rad below
	  var dLon = deg2rad(lon2-lon1); 
	  var a = 
	    Math.sin(dLat/2) * Math.sin(dLat/2) +
	    Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * 
	    Math.sin(dLon/2) * Math.sin(dLon/2)
	    ; 
	  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
	  var d = R * c; // Distance in km
	  return d;
	}

	function deg2rad(deg) {
	  return deg * (Math.PI/180)
	}
	
	
</script>
<!-- location script  -->
	<script>
	var x= document.getElementById("lat1");
	var y= document.getElementById("longi1");
	function showPosition(position) {
		
		pos = {
		        lat: position.coords.latitude,
		        lng: position.coords.longitude
		      };
		    /* x.innerHTML = "Latitude***: " + pos.lat + 
		    "<br>Longitude: " + pos.lng; */
		   x.value=pos.lat;
		   y.value=pos.lng;
	}
	function getLocation() {
		
	    if (navigator.geolocation) {
	        navigator.geolocation.getCurrentPosition(showPosition);
	        ////alert("get location called");  
	    } else { 
	       // x.innerHTML = "Geolocation is not supported by this browser.";
	    }
	   
	}

	$(document).ready(function() {
		////alert("inside ready jquery");
	   getLocation();
	   //alert("2 inside ready jquery");
	  
	} );
	</script>
	<!-- location script end -->

<button type="submit" class="btn btn-primary">show distance</button>
</form>

<!--  end location code --> 

<div class="container-fluid">
<ul class="breadcrumb">
	You are Here:
	<li><a href="#">userHome</a></li>
	<li class="active">Search Result<a href="#"></a></li>
</ul>

<table id="example" class="table  table-bordered table-hover table-condensed table-responsive" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th></th>
                <th>Title</th>
                <th>Category</th>
                <th class="location">Location</th>
                <th>Review</th>
				<th>Distance</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                 <th></th>
                <th>Title</th>
                <th>Category</th>
                <th class="location">Location</th>
                <th>Review</th>
				<th>Distance</th>
            </tr>
        </tfoot>
        
           <tbody>
        	<#list shopdocs as shop>
            <tr><td><img class="shopImg img-rounded"  src="${shop['url']}" alt ="leather-sofa.1" /></td>
                <td><strong><a href="/shopDetails?shopLink=${shop['shopLink']}" >${shop["shopName"]}</a></strong></td>
                <td>${shop["shopCategory"]}</td>
                <td class="location">${shop["Address"]["city"]},${shop["Address"]["state"]},${shop["Address"]["country"]}</td>
                <td><span class="stars">${shop["reviewC"]}</span></td>
                <#if full == 1>
 				 <td><div class="dis"> distance</div></td>
				<#else>
                <td>${shop["distance"]/1000}km <!-- or<div class="dis" id=${shop["shopLink"]}> distance</div>--></td>
                </#if>
                <script type="text/javascript">
                <#assign x =shop["location"]["coordinates"]?first >
                <#assign y =shop["location"]["coordinates"]?last >
                
       		showDistance("${shop['shopLink']}",${y},${x});
				</script>
            </tr>
           </#list>
        </tbody>
    </table>
     <#if nextpage==(totalpage+1)>
        <script>
        $(document).ready(function() {
$("#nextP").addClass( "disabled" );
$("#num2").addClass( "disabled" );
$("#nexta").attr("href", "#");
$("#num2a").attr("href", "#");

});</script>   
        </#if>
        <#if prevDisable==1 || ((nextpage-1)==1) >
        <script>
        $(document).ready(function() {
$("#prevP").addClass( "disabled" );
$("#num3").addClass( "disabled" );
$("#preva").attr("href", "#");
$("#num3a").attr("href", "#");

});</script>
        </#if>
    <div class="text-center">
	<ul class="pagination">
	
  <li class="navv" id="prevP"><a id="preva" href="userHome?page=${prevpage}&lat=${lat}&longi=${longi}">Pre</a></li>
   <!-- <li><a href="userHome?page=${nextpage-1}">${nextpage-1}</a></li> --> 
  <li class="navv" id="num2"><a id="num2a" href="userHome?page=${nextpage}&lat=${lat}&longi=${longi}">${nextpage}</a></li>
  <li class="navv"><a href="#">.</a></li>
  <li class="navv"><a href="#">.</a></li>
  <li class="navv"  id="num3"><a id="num3a" href="userHome?page=${totalpage-1}&lat=${lat}&longi=${longi}">${totalpage-1 }</a></li>
  <li class="navv"><a href="userHome?page=${totalpage}&lat=${lat}&longi=${longi}">${totalpage}</a></li>
  <li class="navv" id="nextP"><a id="nexta" href="userHome?page=${nextpage}&lat=${lat}&longi=${longi}">Next</a></li>
	</ul>
	</div>
    
	</div>
	
<!-- Footer included by Jquery biren -->
<div id="dookFooter" ></div>
<!-- footer end -->


</body>
</html>