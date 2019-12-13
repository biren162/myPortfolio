package com.dook.project.maven;

import static com.mongodb.client.model.Filters.eq;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Random;

import org.bson.Document;

import sun.misc.BASE64Encoder;

import com.mongodb.ErrorCategory;
import com.mongodb.MongoWriteException;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class OwnerDao {
//	private OwnerVo ownerVo;
	private Random random=new SecureRandom();
	MongoCollection<Document> ownerCollection;
	public OwnerDao(MongoDatabase OwnerDb){
		ownerCollection=OwnerDb.getCollection("owner");	
	}
	
	public boolean save(OwnerVo vo){
		String name=vo.getName();
		String email=vo.getEmail();
		String password=vo.getPassword();
		String mo=vo.getMo();
		 String passwordHash = makePasswordHash(password, Integer.toString(random.nextInt()));
		 
		 Document owner=new Document();
		 owner.append("_id", name).append("password", passwordHash);

	        if (email != null && !email.equals("")) {
	            // the provided email address
	            owner.append("email", email);
	        }
	        if (mo != null && !mo.equals("")) {
	            // the provided email address
	            owner.append("mo", mo);
	        }
	        
	        try {
	            ownerCollection.insertOne(owner);
	            return true;
	        } catch (MongoWriteException e) {
	            if (e.getError().getCategory().equals(ErrorCategory.DUPLICATE_KEY)) {
	                System.out.println("Username already in use: " + name);
	                return false;
	            }
	            throw e;
	        }
	}
	
	
	public Document validateLogin(String username, String password) {
        Document user;

        user = ownerCollection.find(eq("_id", username)).first();

        if (user == null) {
            return null;
        }

        String hashedAndSalted = user.get("password").toString();

        String salt = hashedAndSalted.split(",")[1];

        if (!hashedAndSalted.equals(makePasswordHash(password, salt))) {
            System.out.println("Submitted password is not a match");
            return null;
        }

        return user;
    }

	
	private String makePasswordHash(String password, String salt) {
        try {
            String saltedAndHashed = password + "," + salt;
            MessageDigest digest = MessageDigest.getInstance("MD5");
            digest.update(saltedAndHashed.getBytes());
            BASE64Encoder encoder = new BASE64Encoder();
            byte hashedBytes[] = (new String(digest.digest(), "UTF-8")).getBytes();
            return encoder.encode(hashedBytes) + "," + salt;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5 is not available", e);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("UTF-8 unavailable?  Not a chance", e);
        }
    }
}
