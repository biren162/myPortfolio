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
.itemImage  img {
  max-height: 50px;
  max-width: 100%;
}
#menu-toggle{
position: relative;
    z-index: 10;
float:left;}
</style>
<style>
.shopImg{
height:80px;
width:80px;
}
.itemImage{
height:50px;
width:50px;
}

@media only screen and (max-width: 768px) {
    /* For mobile phones: */
	.shopImg{
	height:40px;
	width:40px;
	}
	.itemImage{
	height:45px;
	width:45px;
	}
	
	.tableMobile td,th{
	font-size:8px;
	padding:0;
	font-weight:bold;
	}
	.location{
	display:none;
	}
}
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
                  <a href="#">Manage Shop</a>
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
        	
        	<style>

.table-editable {
  position: relative;
  
  .glyphicon {
    font-size: 20px;
  }
}

.table-remove {
  color: #700;
  cursor: pointer;
  
  &:hover {
    color: #f00;
  }
}

.table-up, .table-down {
  color: #007;
  cursor: pointer;
  
  &:hover {
    color: #00f;
  }
}

.table-add {
  color: #070;
  cursor: pointer;
  position: absolute;
  top: 8px;
  right: 0;
  
  &:hover {
    color: #0b0;
  }
}
</style>
</head>
<body>

<div class="container">
<!-- HTML5 Editable Table -->
  <h1>My shops:</h1>
   <div class="col-md-12">
  <div id="table" class="table-editable tableMobile">
    
    <table class="table table-condensed table-hover">
      <tr>
        <th>image</th>
        <th>ShopName</th>
        <th>Address</th>
        <th>Category</th>
        <th></th>
        <th></th>
      </tr>
      <#list docs as doc>
      <tr>
   	    <td><img class="shopImg" src='${doc["url"]}' /></td>
        <td>${doc["shopName"]} </td>
        <td>${doc["Address"]["city"]}</td>
		<td>${doc["shopCategory"]}</td>
        <td></td>
        
        <td>
          <span class="table-remove glyphicon glyphicon-remove"></span>
        </td>
        <td>
          <span class="table-up glyphicon glyphicon-arrow-up"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <span class="table-down glyphicon glyphicon-arrow-down"></span>
        </td>
      </tr>
       			<script>
        		$('.table-remove').click(function () {

    		var x;
    		if (confirm("are you sure? you are going to delete your shop") == true) {
    	
    	 		$.post("deleteShop",
    		    		    {
    				          shopLink:"${doc['shopLink']}"
    		        		},
    		        		function(data,status){   		        	
    		            		alert("Data: " + data + "\nStatus: " + status);
    		    		    });
        		$(this).parents('tr').detach();
    		} else {
        
    		}
    		document.getElementById("demo").innerHTML = x;
  
			});
        		</script>
      
      </#list>
	  
      
    </table>
  </div>
  </div>
  
</div>
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
<div class="container">
<!-- HTML5 Editable Table -->
  <h1>Products of  ${shopName}</h1>
   <#assign keys = shopMap?keys>
	<#list keys as key>
	<div class="col-md-12">
	   <div class="panel panel-default">
    			<div class="panel-heading"><h2>${key}</h2></div>
    		<div class="panel-body">
    		
  <div id="table" class="table-editable">
    
    <table class="table table-hover">
     <tr>
        <th>image</th>
        <th>Name</th>
        <th>Price</th>
        <th></th>
        <th></th>
      </tr>
    
    <#list shopMap[key] as product>
           
      <tr>
   	    <td><img class="itemImage"  src=" ${product['images'][0] } " alt="Image" class="img-responsive"/></td>
        <td>${product['name']} </td>
        <td contenteditable="true">${product['price']}</td>        
        <td>
          <span class="table-remove2 glyphicon glyphicon-remove"></span>
        </td>
        <td>
          <span class="table-up glyphicon glyphicon-arrow-up"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <span class="table-down glyphicon glyphicon-arrow-down"></span>
        </td>
      </tr>
       
   
       			<script>
        		$('.table-remove2').click(function () {

    		var x;
    		if (confirm("are you sure? you are going to delete a product") == true) {
    	
    	 		$.post("deleteProduct",
    		    		    {
    				          shopLink:"${shopLink}",
    				          productCategory:"${key}",
    				          productName:"${product['name']}"
    				          
    		        		},
    		        		function(data,status){   		        	
    		            		alert("Data: " + data + "\nStatus: " + status);
    		    		    });
        		$(this).parents('tr').detach();
    		} else {
        
    		}
    		document.getElementById("demo").innerHTML = x;
  
			});
        		</script>
      
         </#list>
    </table>
      </div>
     
  			</div>
  			 
  			</div>
       
  </div>
  </#list>
  
</div>
<script>
var $TABLE = $('#table');
var $BTN = $('#export-btn');


$('.table-add').click(function () {
  var $clone = $TABLE.find('tr.hide').clone(true).removeClass('hide table-line');
  $TABLE.find('table').append($clone);
});


$('.table-up').click(function () {
  var $row = $(this).parents('tr');
  if ($row.index() === 1) return; // Don't go above the header
  $row.prev().before($row.get(0));
});

$('.table-down').click(function () {
  var $row = $(this).parents('tr');
  $row.next().after($row.get(0));
});

// A few jQuery helpers for exporting only

</script>
        	
        	
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
