<!DOCTYPE html>

<html>
<head><title>Dook.com</title>
<style type="text/css">
      .label {text-align: right}
      .error {color: red}
    </style>
<#-- location   -->
<style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
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
</head>
 <body>
    
    <h2>shopDetails:</h2>
    <form method="post" enctype="multipart/form-data" name="form1">
    location inputs 
   <input type="hidden" id="long1" name="long" value="-1.0"/> 
    <input type="hidden" id="lat1"  name="lat" value="-1.0"/> 
      <table>
        <tr>
          <td class="label">
            shopName
          </td>
          <td>
            <input type="text" name="shopname" value="${shopname}" />
          </td>
          <td class="error">
	     ${name_error}
            
          </td>
        </tr>
        <br/>
<br/>
        <tr>
          <td class="label">
            category
          </td>
          <td>
           <select name="category">
          <#if CategoryList?has_content>
          
		  <#list CategoryList as list>
  			<option name="category" value="${list}">${list}</option>
  			</#list>
  			</#if>
		</select>
          </td>
          <td class="error">
	 
            
          </td>
        </tr>
   </table>
<fieldset>
	<legend>shop address:</legend>
	<table>
        <tr>
          <td class="label">
            Line1:
          </td>
          <td>
            <input type="text" name="line1" value="${line1}">
          </td>
          <td class="error">
	  		${line1_error}
            
          </td>
        </tr>
<tr>
          <td class="label">
            Area:
          </td>
          <td>
            <input type="text" name="area" value="${area}" >
          </td>
          <td class="error">
	  		${area_error}
            
          </td>
        </tr>
<tr>
          <td class="label">
            CityName:
          </td>
          <td>
            <input type="text" name="city" value="${city}">
          </td>
          <td class="error">
	  		${city_error}
            
          </td>
        </tr>
<tr>
          <td class="label">
            State:
          </td>
          <td>
            <input type="text" name="state" value="${state}">
          </td>
          <td class="error">
	  		${state_error}
            
          </td>
        </tr>
<tr>
          <td class="label">
            Country:
          </td>
          <td>
            <input type="text" name="country" value="${country}">
          </td>
          <td class="error">
	  		${country_error}
            
          </td>
        </tr>
       </table>
</fieldset>
     
     <input type="file" required name="img"/> 
     
     
      <input type="submit"/>
    </form>
    
       <div id="map"></div>
  </body>
  
  