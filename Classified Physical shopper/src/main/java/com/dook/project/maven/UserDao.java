package com.dook.project.maven;
import static com.mongodb.client.model.Filters.eq;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.bson.Document;

import sun.misc.BASE64Encoder;

import com.mongodb.ErrorCategory;
import com.mongodb.MongoWriteException;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class UserDao {
//	private OwnerVo ownerVo;
	private ForgotDao forgotDao;
	private Random random=new SecureRandom();
	MongoCollection<Document> ownerCollection;
	MongoDatabase db;
	public UserDao(MongoDatabase UserDb){
		ownerCollection=UserDb.getCollection("user");
		db=UserDb;
	}
	
	public boolean save(UserVo vo){
		String name=vo.getUserName();
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
	public long getTotalUser(){
		return ownerCollection.count();
	}
	public boolean sendEmailToUser(String email){
		Document user;
        user = ownerCollection.find(eq("email",email)).first();
        if(user==null)
        	return false;
        else{
        String userId=(String) user.get("_id");
        String hashedAndSalted = user.get("password").toString();
        //random string
        SecureRandom random = new SecureRandom();
        String randomStr= new BigInteger(130, random).toString(32);
        System.out.println("randomstr:"+randomStr);
        forgotDao=new ForgotDao(db);
        forgotDao.save(userId, randomStr);
        //random string end
        String link="http://localhost:8080/resetPw?random="+randomStr+"&userId="+userId+"&email="+email;
        	Email(email,userId,link);
        	return true;
        
        }
	}
	public void Email(String email,String userId,String link){
		String to=email;//change accordingly

		//Get the session object
		  Properties props = new Properties();
		  props.put("mail.smtp.host", "smtp.gmail.com");
		  props.put("mail.smtp.socketFactory.port", "465");
		  props.put("mail.smtp.socketFactory.class",
		        	"javax.net.ssl.SSLSocketFactory");
		  props.put("mail.smtp.auth", "true");
		  props.put("mail.smtp.port", "465");
		 
		  Session session = Session.getDefaultInstance(props,
		   new javax.mail.Authenticator() {
		   protected PasswordAuthentication getPasswordAuthentication() {
		   return new PasswordAuthentication("birenvgeccomputer@gmail.com","z95Zvgecgoogle#");//change accordingly
		   }
		  });
		 
		//compose message
		  try {
		   MimeMessage message = new MimeMessage(session);
		   message.setFrom(new InternetAddress("birenvgeccomputer@gmail.com"));//change accordingly
		   message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
		   message.setSubject("classified Physical Shopper – Forgot Password");
		   message.setText("Hi,Here is a verification link to reset your password..........    "+link);
		   
		   //send message
		   Transport.send(message);

		   System.out.println("message sent successfully");
		 
		  } catch (MessagingException e) {throw new RuntimeException(e);}	}
          public boolean savePw(String userId,String pw){
        	  String passwordHash = makePasswordHash(pw, Integer.toString(random.nextInt()));
        	  System.out.println(userId);
        	  try{
        	  ownerCollection.updateOne(new Document("_id",userId),Document.parse("{$set:{'password':'"+passwordHash+"'}}") );
        	  return true;
        	  }
        	  catch(Exception e){
        		  System.out.println("error in savePw query");
        		  return false;
        	  }
        	  
          }
}
