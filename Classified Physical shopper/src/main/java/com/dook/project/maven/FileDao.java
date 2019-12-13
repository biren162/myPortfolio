package com.dook.project.maven;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

import javax.servlet.http.Part;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.MongoClient;
import com.mongodb.gridfs.GridFS;
import com.mongodb.gridfs.GridFSDBFile;
import com.mongodb.gridfs.GridFSInputFile;

public class FileDao {
	private	DB db;
	FileDao(MongoClient mc){
		db=mc.getDB("Dook");
	}
	 
	public String saveImage(Part p,String shopLink){
		//Path path=Paths.get("/images");
		System.out.println("part2:"+p);	
		String disposition = p.getHeader("Content-Disposition");
		String fileName = disposition.replaceFirst("(?i)^.*filename=\"([^\"]+)\".*$", "$1");
		
		try{
			InputStream fileContent=p.getInputStream();	
			//cloud start
			//File file=new File("cc.jpg");
			FileOutputStream fos=new FileOutputStream("cc.jpg");
			/*if (!file.exists()) {
			     file.createNewFile();
			  }*/
			byte[] buffer = new byte[4096];
			  long count = 0L;
			  int n = 0;
			  while (-1 != (n = fileContent.read(buffer))) {
			   fos.write(buffer, 0, n);
			   count += n;
			  }
		
					Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
							  "cloud_name", "biren162",
							  "api_key", "814699947691913",
							  "api_secret", "nBDJhrBsSEMzCGylEQ7N15JvzgI"));
					
					File file=new File("cc.jpg");
					
					Map uploadResult= cloudinary.uploader().upload(file, ObjectUtils.emptyMap());
					String url=(String) uploadResult.get("url");
					System.out.println("url:"+url);
					//cloud end.
			
		
			
		/*	GridFS imgs=new GridFS(db, "shopImg");
			GridFSInputFile img=imgs.createFile(fileContent, fileName);
		
			  BasicDBObject meta=new BasicDBObject("Description", "shopImage").append("shopLink", shopLink).append("url", url);
			  img.setMetaData(meta);
			  img.save();
			  System.out.println("file saved in Db with ID:"+img.get("_id"));
			 // fos.close();
			  return true;*/
			  return url;
		}catch(Exception e){System.out.println("error in fileDao");return null;}
		
		
		
	/*	byte[] buffer = new byte[1024];
		int len = fileContent.read(buffer);
		while (len != -1) {
		    fos.write(buffer, 0, len);
		    len = fileContent.read(buffer);
		    fos.close();
		}   return true;*/	

	}
	public ArrayList<String> saveItemImages(Collection<Part> parts,String shopLink){
		System.out.println("collectoin size:"+parts.size());                         	
		ArrayList<String>urlList=new ArrayList<String>();
		try{
		long count;
		int n;
		Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
				  "cloud_name", "biren162",
				  "api_key", "814699947691913",
				  "api_secret", "nBDJhrBsSEMzCGylEQ7N15JvzgI"));
		File file;
		
		 for (Part p : parts) {
				
			 byte[] buffer= new byte[4096];
			 FileOutputStream fos=new FileOutputStream("dd.jpg");			 
		String disposition = p.getHeader("Content-Disposition");
		if(disposition.contains("itemImg")){
		String fileName = disposition.replaceFirst("(?i)^.*filename=\"([^\"]+)\".*$", "$1");
			InputStream fileContent=p.getInputStream();	
			//cloud start
				
			if(p.getSize()!=0){
			   count = 0L;
			  n = 0;
			  while (-1 != (n = fileContent.read(buffer))) {
			   fos.write(buffer, 0, n);
			   count += n;
			  }
				
			  file=new File("dd.jpg");
			 
					Map uploadResult= cloudinary.uploader().upload(file, ObjectUtils.asMap("folder", "dook/items"));
					String url=(String) uploadResult.get("url");
					urlList.add(url);
					//cloud end.	
			
			file.delete();
			}
			
			
			fos.close();
		}
		}
			return urlList;
		 }catch(Exception e){System.out.println("error in fileDao");return null;}
	
	}
	public GridFSDBFile getImage(String shopLink){
		GridFS imgs=new GridFS(db, "shopImg");
	
		GridFSDBFile gridFile=imgs.findOne(new BasicDBObject("metadata.shopLink",shopLink));
		System.out.println("retrieved img:"+gridFile);
		return gridFile;
		
		
	}
}

	

