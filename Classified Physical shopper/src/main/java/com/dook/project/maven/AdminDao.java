package com.dook.project.maven;

public class AdminDao {
	public boolean validateLogin(String adminName,String password){
		
		if(adminName.equals("admin")&&password.equals("admin162#")){
			return true;
		}
		else
			return false;
	}
}
