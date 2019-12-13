<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Dook.com</title>
<style type="text/css">
      .label {text-align: right}
      .error {color: red}
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script>
$(document).ready(function() {

    $('#itemDropdown').change(function(){
     if($('#itemDropdown').val()=="addNew")
        { 
    	//$('#itemCat').get(0).type = 'text'; */
    $("#itemCat").show();
	    }
    }); 
});
</script>

</head>
<body>
<form method="post" enctype="multipart/form-data" name="form1">
<input type="hidden" name="shopLink" value="${shopLink}"/>
 <table>
  <tr>
          <td class="label">
            category
          </td>
          <td>
           <select id="itemDropdown" name="itemCat">
          <#if itemCategoryList?has_content>
          
		  <#list itemCategoryList as list>
  			<option value="${list}">${list}</option>
  			</#list>
  			</#if>
		</select>
		<input id="itemCat"  name="itemCat2" style="display:none;" />
          </td>
            <td class="error">
	     ${itemCat_error}
            
          </td>
      <!--   </tr>
        <tr>
          <td class="label">
            Category
          </td>
          <td>
            <select id="itemDropdown" name="itemCat">
  		<option value="mobile">mobile</option>
  		<option value="computer">computer</option>
  		<option id="addNew" value="addNew">addNew</option> 		
			</select>			
			<input id="itemCat"  name="itemCat" style="display:none;" />
        </tr> -->
        <br/><br/>
         <tr>
          <td class="label">
            ItemName
          </td>
          <td>
            <input type="text" name="itemName" value="${itemName}"/>	
            </td>
            <td class="error">
	     ${itemName_error}
            
          </td>		
        </tr>
        <br/><br/>
        <tr>
          <td class="label">
           Image
          </td>
          <td>
          <input type="file" name="itemImg" multiple required>		
          </td>
           <td class="error">
	   
            
          </td>	
        </tr>
        <br/><br/>
        <tr>
          <td class="label">
          price
          </td>
          <td>
             <input type="number" id="test"  name="itemPrice" value="${itemPrice}"/>			
        </tr>
        <br/><br/>
        
  </table>
  <input type="submit" />
</form>

</body>
</html>

