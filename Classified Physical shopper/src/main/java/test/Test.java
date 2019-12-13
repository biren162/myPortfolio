package test;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStream;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoDatabase;
import com.mongodb.gridfs.GridFS;
import com.mongodb.gridfs.GridFSDBFile;
import com.mongodb.gridfs.GridFSInputFile;

public class Test {
	public static void main(String args[]){
		 final MongoClient mongoClient = new MongoClient(new MongoClientURI("mongodb://localhost"));
	        final DB db = mongoClient.getDB("test");
	        FileInputStream is=null;
	        GridFS imgs=new GridFS(db, "imgs");
	        try{
	        	is=new FileInputStream("img.jpg");
	        }
	        catch(FileNotFoundException e){
	        	System.out.println("can't open file");
	        }
	        GridFSInputFile img=imgs.createFile(is, "img.jpg");
	  BasicDBObject meta=new BasicDBObject("Description", "shopImage");
	  img.setMetaData(meta);
	  img.save();
	  System.out.println("file saved in Db with ID:"+img.get("_id"));
	        //now reading
	  GridFSDBFile gridFile=imgs.findOne(new BasicDBObject("filename","img.jpg"));
	  try{
	  FileOutputStream fos=new FileOutputStream("img_retrieved.jpg");
	  gridFile.writeTo(fos);
	  }
	  catch(Exception e){
		  
	  }
	 
	  
	        
	        
	}
}
