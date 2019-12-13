package com.dook.project.maven;

import java.util.ArrayList;

import org.bson.Document;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class ForgotDao {
private ArrayList<Document> list;
MongoCollection<Document> ForgotCollection;
public ForgotDao(MongoDatabase OwnerDb){
	 ForgotCollection = OwnerDb.getCollection("forgotUser");	
}

public boolean save(String userId,String randomStr){
	try{
		ForgotCollection.insertOne(new Document("userId",userId).append("randomStr", randomStr));
		return true;
	}
	catch(Exception e){
		System.out.println("exception in saving random str to db in RandomDao");
		return false;
	}
}
public String getUserIdFromRandom(String random){
	try{
		Document doc=ForgotCollection.find(new Document("randomStr",random)).first();
		
		return doc.get("userId").toString();
	}
	catch(Exception e){
		System.out.println("exception in getUserIdFromRandom in RandomDao");
		return null;
	}
	}

	
}
