package com.dook.project.maven;

import java.util.ArrayList;

public class ShopVo {
private String shopName;
private String shopCategory;
private String ownerName;
private String shopLink,url,lat,longi;
private int review;
	private class Address{
	private String line1;
	private String area;
	private String city;
	private String state,country;	
	}
	private class Product{
	private String itemCat,itemName;
	private int itemPrice;
	ArrayList<String>urlList=new ArrayList<String>();
	}
Address add=new Address();
Product pro=new Product();

public String getUrl() {
	return url;
}

public void setUrl(String url) {
	this.url = url;
}
public  String getLine1() {
	return add.line1;
}

public void setLine1(String l){
	add.line1=l;
}
public   String getArea() {
	return add.area;
}
public   void setArea(String area) {
	add.area = area;
}
public   String getCity() {
	return add.city;
}
public   void setCity(String city) {
	add.city = city;
}
public   String getState() {
	return add.state;
}
public   void setState(String state) {
	add.state = state;
}

public   String getCountry() {
	return add.country;
}
public   void setCountry(String country) {
	add.country = country;
}

public String getShopLink() {
	return shopLink;
}
public void setShopLink(String shopLink) {
	this.shopLink = shopLink;
}
public int getReview() {
	return review;
}
public void setReview(int review) {
	this.review = review;
}
public String getShopName() {
	return shopName;
}
public void setShopName(String shopName) {
	this.shopName = shopName;
}
public String getShopCategory() {
	return shopCategory;
}
public void setShopCategory(String shopCategory) {
	this.shopCategory = shopCategory;
}
public String getOwnerName() {
	return ownerName;
}
public void setOwnerName(String ownerName) {
	this.ownerName = ownerName;
}
public void setLocation(String lat,String longi){
	this.lat=lat;
	this.longi=longi;
}
public String getLat() {
	return lat;
}

public String getLongi() {
	return longi;
}
public   String getItemCat() {
	return pro.itemCat;
}
public   void setItemCat(String s) {
	pro.itemCat = s;
}
public String getItemName(){
	return pro.itemName;
}
public void setItemName(String s){
	pro.itemName=s;
}
public int getItemPrice(){
	return pro.itemPrice;
}
public void setItemPrice(int p){
	pro.itemPrice=p;
}
public ArrayList<String> getItemUrlList(){
	return pro.urlList;
}
public void setItemUrlList(ArrayList<String>l){
	pro.urlList=new ArrayList<String>(l);
}
}
