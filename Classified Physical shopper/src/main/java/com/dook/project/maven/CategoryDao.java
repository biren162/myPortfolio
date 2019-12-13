package com.dook.project.maven;

import java.util.ArrayList;

import org.bson.Document;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class CategoryDao {
private ArrayList<Document> list;
MongoCollection<Document> CatCollection;
public CategoryDao(MongoDatabase OwnerDb){
	 CatCollection = OwnerDb.getCollection("Cat");	
}

public boolean save(String catName){
	try{
		CatCollection.insertOne(new Document("catName",catName));
		return true;
	}
	catch(Exception e){
		System.out.println("exception in saving category to db in categoryDao");
		return false;
	}
}
/*public CategoryDao(){
	list=new ArrayList<String>();
	list.add("Electronic");
	list.add("Books");
	list.add("Cameras & Photo");
	list.add("Cell Phones & Accessories");
	list.add("Clothing");
	list.add("Shoes");
	list.add("Computers/Tablets & Networking");
	list.add("Laptop & Desktop Accessories");
	list.add("DVDs & Movies");
	list.add("Health & Beauty");
	list.add("Sporting Goods");
	list.add("Travel");
	list.add("furniture");
}
*/
public ArrayList<Document>getCategory(){
		//return list;
		try{
		list=CatCollection.find().projection(new Document("_id",0).append("catName", 1)).into(new ArrayList<Document>());
		return list;
		}
		catch(Exception e){
			System.out.println("Exception in getcategory in CategoryDao");
			return list;
		}
	}
	
}
