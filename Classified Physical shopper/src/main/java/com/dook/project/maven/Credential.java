package com.dook.project.maven;

public class Credential {
	private String userName;
	private String password;
	public Credential(){
		
	}
	public Credential(String userName, String pw){
		super();
		this.userName=userName;
		this.password=pw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
