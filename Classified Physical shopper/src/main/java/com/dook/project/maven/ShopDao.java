package com.dook.project.maven;

import static com.mongodb.client.model.Filters.eq;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.bson.Document;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class ShopDao {
	MongoCollection<Document> shopCollection;
	public ShopDao(MongoDatabase OwnerDb){
		 shopCollection = OwnerDb.getCollection("shop");	
	}
	public int update(String shopLink,String userName,int review,String RComment){
		{
			//shopCollection.up
			try{
			 Document reviewDoc = new Document("reviewCount", review).append("userName", userName).append("rComment",RComment );
//String filter="{shopLink:\""+shopLink+"\"}";
//System.out.println(filter);
//shopCollection.updateOne(Document.parse(filter),
  //                  new Document("$addToSet", new Document("review", reviewDoc)));

List<Document>pipe;
pipe=Arrays.asList(Document.parse("{$unwind:'$review'}"),Document.parse("{$match:{$and:[{shopLink:\""+shopLink+"\"},{'review.userName':\""+userName+"\"}]}}"),Document.parse("{$limit:1}"));
Document matchedDoc=shopCollection.aggregate(pipe).first();
System.out.println("matchedDoc:"+matchedDoc);
if(matchedDoc==null){
	shopCollection.updateOne(eq("shopLink", shopLink),
	        new Document("$addToSet", new Document("review", reviewDoc)));
}
else{
/*Object id=matchedDoc.get("_id");
String filter="{_id:\""+id+"\"}";
shopCollection.updateOne(eq("_id", id),
        new Document("$Set", new Document("review.reviewCount", review).append("review.userName", userName)));
        */
	return -1;
}


return 1;
			}
			catch(Exception e){
				return 0;
			}
			
			
			
			//db.shop.update({shopLink:shopLink},{review.reviewCount:review ,review.userName:userName});
		}
	}
	public boolean save(ShopVo vo){
		String shopName=vo.getShopName();
		String category=vo.getShopCategory();
		String ownerName=vo.getOwnerName();
		String line1=vo.getLine1();
		String area,city,state,country,imgUrl,lat,longi;
		area=vo.getArea();
		city=vo.getCity();
		state=vo.getState();
		country=vo.getCountry();
		imgUrl=vo.getUrl();
		lat=vo.getLat();
		longi=vo.getLongi();
		String shopLink = (shopName+ownerName).replaceAll("\\s", "_"); // whitespace becomes _
        shopLink = shopLink.replaceAll("\\W", ""); // get rid of non alphanumeric
        shopLink = shopLink.toLowerCase();

		Document doc=new Document("shopName",shopName);
		doc.append("shopLink", shopLink);
		
	
		doc.append("Address", new Document("line1",line1).append("area", area).append("city", city).append("state", state).append("country", country));
		doc.append("shopCategory", category).append("ownerName", ownerName).append("url", imgUrl);
		doc.append("location",Document.parse("{type: 'Point',coordinates: ["+longi+", "+lat+"]}"));
		//Document location=Document.parse("{location: {type: 'Point',coordinates: ["+longi+", "+lat+"]},shopLink:"+shopLink+"};)");
		
		try{
		shopCollection.insertOne(doc);
		return true;
		}
		catch(Exception e)
		{	System.out.println("error in inserting doc in shop collection in shopDao");
			e.printStackTrace();
			return false;
		}
		
		
	}
	public boolean saveItem(ShopVo vo,String shopLink){
		String itemCat,itemName;
		int itemPrice;
		ArrayList<String>urllist;
		itemCat=vo.getItemCat();
		itemName=vo.getItemName();
		itemPrice=vo.getItemPrice();
		urllist=new ArrayList<String>(vo.getItemUrlList());
		Document innerDoc=new Document("category",itemCat).append("name", itemName);
		if(itemPrice!=-1)
		innerDoc.append("price", itemPrice);
		
		innerDoc.append("images", urllist);
		Document doc=new Document("$addToSet",new Document("product",innerDoc));
		
		try{
		//	shopCollection.insertOne(doc);
			shopCollection.updateOne(new Document("shopLink",shopLink), doc);
			return true;
			}
			catch(Exception e)
			{	System.out.println("error in updating doc in saveItem method in shopDao");
				e.printStackTrace();
				return false;
			}
	}
	public ArrayList<String> getCategory(){
		return null;
	}
	public long getFullTotal(){
		return shopCollection.count();
	}
	public List<Document> getFullShopRecord(int skip,int i) {
		List<Document> pipe;
		pipe=Arrays.asList( Document.parse("{$project:{_id:0,shopName:1,shopCategory:1,Address:1,ownerName:1,shopLink:1,url:1,location:1}}"),
							Document.parse("{$skip:"+skip+"}"),
							Document.parse("{$limit:"+i+"}")
							);
		List<Document> list,list2;//=new ArrayList<Document>();
		list= shopCollection.aggregate(pipe).into(new ArrayList<Document>());
		
		pipe=Arrays.asList(Document.parse("{$unwind:'$review'}"),
							Document.parse("{$group:{_id:{'shopLink':'$shopLink'},reviewC:{$avg:'$review.reviewCount'}}}"),
							Document.parse("{$project:{_id:0,shopLink:'$_id.shopLink',Address:1,shopCategory:1,ownerName:1,reviewC:1}}")
							);
		list2=shopCollection.aggregate(pipe).into(new ArrayList<Document>());
		for(int j=0;j<list.size();j++){
			Document d=list.get(j);
			String link=d.getString("shopLink");
			Double r=getReview(link,list2);
			list.get(j).append("reviewC", r);
			}
		//System.out.println("--->list:"+list);
		
		
		return list;
	}
	public boolean deleteShop(String shopLink){
		try{
		shopCollection.deleteOne(new Document("shopLink",shopLink));
		return true;
		}
		catch(Exception e){
			System.out.println("error in deleteShop method in shopdao");
			return false;
			
		}
	}
	public boolean deleteProduct(String shopLink,String pCategory,String pName){
		try{
		shopCollection.updateOne(eq("shopLink", shopLink), Document.parse("{$pull: {product: {name :\""+pName+"\" ,category:\""+pCategory+"\"}}}"));
		
		return true;
		}
		catch(Exception e){
			System.out.println("error in deleteproduct method in shopdao");
			return false;
			
		}
	}
public Double getReview(String shopLink,List<Document>list2){
	for(int k=0;k<list2.size();k++){
		Document d=list2.get(k);
		String link=d.getString("shopLink");
		if(link.equals(shopLink))
			return d.getDouble("reviewC");
		
	}return -1.0;}
	public List<Document> getAbstractShopRecord(int skip,int i,String longi,String lat) {
		
	double METERS_PER_MILE = 1609.34;
	METERS_PER_MILE*=5;
	//			db.restaurants.find({ location: { $nearSphere: { $geometry: { type: "Point", coordinates: [ -73.93414657, 40.82302903 ] }, $maxDistance: 5 * METERS_PER_MILE } } })
		List<Document> pipe;
		System.out.println("##long"+longi+" "+"lat"+lat);
		pipe=Arrays.asList(Document.parse("{   $geoNear: { near: { type: 'Point', coordinates: [ "+longi+","+lat+" ] },distanceField: 'distance', spherical: true }}"),
							Document.parse("{$project:{_id:0,shopName:1,shopCategory:1,Address:1,ownerName:1,shopLink:1,url:1,location:1,distance:1}}"),
							Document.parse("{ $sort : { distance: 1 } }"),
							Document.parse("{$skip:"+skip+"}"),
							Document.parse("{$limit:"+i+"}")
							);
		List<Document> list,list2;//=new ArrayList<Document>();
		list= shopCollection.aggregate(pipe).into(new ArrayList<Document>());
		
		pipe=Arrays.asList(Document.parse("{$unwind:'$review'}"),
				Document.parse("{$group:{_id:{'shopLink':'$shopLink'},reviewC:{$avg:'$review.reviewCount'}}}"),
				Document.parse("{$project:{_id:0,shopLink:'$_id.shopLink',Address:1,shopCategory:1,ownerName:1,reviewC:1}}")
				);
list2=shopCollection.aggregate(pipe).into(new ArrayList<Document>());
for(int j=0;j<list.size();j++){
Document d=list.get(j);
String link=d.getString("shopLink");
Double r=getReview(link,list2);
list.get(j).append("reviewC", r);
}

		
		return list;
	}
	public Document findByShopLink(String shopLink) {
		/*List<Document> pipe;
		pipe=Arrays.asList(Document.parse("{$project:{_id:0,shopName:1,shopCategory:1,Address:1,ownerName:1,shopLink:1}}"),
							Document.parse("{$limit:10}")
							);
		List<Document> list;//=new ArrayList<Document>();
		list= shopCollection.aggregate(pipe).into(new ArrayList<Document>());
		return list;*/
		Document doc=shopCollection.find().filter(new Document("shopLink",shopLink)).first();
		
		return doc;
	}
	public List<Document> findByOwner(String name){
		List<Document> doc=shopCollection.find().filter(new Document("ownerName",name)).into(new ArrayList<Document>());
		return doc;
	}
	public Document getItemCategoryList(String shopLink){
		List<Document>pipe;
		pipe=Arrays.asList(Document.parse("{$match:{shopLink:'"+shopLink+"'}}"),
							Document.parse("{$unwind:'$product'}"),
							Document.parse("{$group:{_id:0,cat:{$addToSet:'$product.category'}}}"),
							Document.parse("{$project:{_id:0,'cat':1}}")
						  );
		Document doc=shopCollection.aggregate(pipe).first();
		return doc;
	}
	public Map<String, List<Document>> getVirtualShop(String shopLink) {
		List<Document>pipe;
		List<Document> doclist;
		Document d=new Document();
		d=getItemCategoryList(shopLink);
		Map<String,List<Document>> map=new HashMap<String, List<Document>>();
		if(d==null){}
		else{
		ArrayList<String >catList=new ArrayList<String>((ArrayList<String>)getItemCategoryList(shopLink).get("cat"));
	
		for(int i=0;i<catList.size();i++){
			pipe=Arrays.asList(
					Document.parse("{$match:{shopLink:'"+shopLink+"'}}"),
					Document.parse("{$unwind:'$product'}"),
					Document.parse("{$match:{'product.category':'"+catList.get(i)+"'}}"),
					Document.parse("{$project:{_id:0,'category':'$product.category','name':'$product.name','price':'$product.price','images':'$product.images'}}")
					);
			doclist=shopCollection.aggregate(pipe).into(new ArrayList<Document>());
			map.put(catList.get(i), doclist);
		}
			
		}
	return map;
	}
	public List<Document> getOwnerShopList(String oName) {
		List<Document> pipe;
		pipe=Arrays.asList( Document.parse("{$match:{ownerName:'"+oName+"'}}"), 
				Document.parse("{$project:{_id:0,shopName:1,shopLink:1}}")
							);
		List<Document> list;//=new ArrayList<Document>();
		list= shopCollection.aggregate(pipe).into(new ArrayList<Document>());
		//System.out.println("--->list:"+list);
		return list;
	}
	public long getTotalProperties(){
		return shopCollection.count();
	}
}
