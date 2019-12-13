//comment
package com.dook.project.maven;
import static spark.Spark.get;
import static spark.Spark.post;
import static spark.Spark.setPort;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.Part;

import org.apache.commons.lang3.StringEscapeUtils;
import org.bson.Document;

import spark.Request;
import spark.Response;
import spark.Route;
import spark.Spark;

import com.google.gson.Gson;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoDatabase;

import freemarker.template.Configuration;
import freemarker.template.SimpleHash;
import freemarker.template.Template;
import freemarker.template.TemplateException;
public class DookController {
	private OwnerDao ownerDao;
	private ShopDao shopDao; 
	private SessionDao sessionDao;
	private OwnerVo ownerVo;
	private ShopVo shopVo;
	private UserVo userVo;
	private FileDao fileDao;
	private UserDao userDao;
	private AdminDao adminDao;
	private CategoryDao cat;
	private ForgotDao forgotDao;
	private UserSessionDao userSessionDao;
	private final Configuration cfg;
	public DookController(String mongoURIString) throws IOException {
	/*	//open shift start   
		final String IP_ADDRESS = System.getenv("OPENSHIFT_DIY_IP") != null ? System.getenv("OPENSHIFT_DIY_IP") : "localhost";
	    final int PORT = System.getenv("OPENSHIFT_DIY_PORT") != null ? Integer.parseInt(System.getenv("OPENSHIFT_DIY_PORT")) : 8080;
	    String host = System.getenv("OPENSHIFT_MONGODB_DB_HOST");
	    int port = Integer.parseInt(System.getenv("OPENSHIFT_MONGODB_DB_PORT"));
        String dbname = System.getenv("OPENSHIFT_APP_NAME");
        String username = System.getenv("OPENSHIFT_MONGODB_DB_USERNAME");
        String password = System.getenv("OPENSHIFT_MONGODB_DB_PASSWORD");
       // MongoClientOptions mongoClientOptions = MongoClientOptions.builder().build();
        MongoCredential credential = MongoCredential.createCredential(username, dbname, password.toCharArray());
     //   MongoClient mongoClient = new MongoClient(new ServerAddress(host, port), mongoClientOptions);
        MongoClient mongoClient =new MongoClient(new ServerAddress(host, port) , Arrays.asList(credential));
        mongoClient.setWriteConcern(WriteConcern.SAFE);
        
	    //open shift close
 `	*/
    final MongoClient mongoClient = new MongoClient(new MongoClientURI(mongoURIString));   //  uncomment if not openshift
        
        
        
       // final MongoDatabase dookDatabase = mongoClient.getDatabase(dbname); // openshift
    	final MongoDatabase dookDatabase = mongoClient.getDatabase("Dook"); 		//local
        ownerDao=new OwnerDao(dookDatabase);
        sessionDao=new SessionDao(dookDatabase);
        userSessionDao=new UserSessionDao(dookDatabase);
        shopDao=new ShopDao(dookDatabase);
        userDao=new UserDao(dookDatabase);
        cat=new CategoryDao(dookDatabase);
        forgotDao=new ForgotDao(dookDatabase);
        fileDao=new FileDao(mongoClient);
        ownerVo=new OwnerVo();
        shopVo=new ShopVo();
        userVo=new UserVo();
        adminDao=new  AdminDao();
        cfg = createFreemarkerConfiguration();
        setPort(8080);  //  uncomment if not in openshift
   //     setIpAddress(IP_ADDRESS);       //openshift
    //    setPort(PORT);				//openshift	
        initializeRoutes();
    }
	 abstract class FreemarkerBasedRoute extends Route {
	        final Template template;

	        /**
	         * Constructor
	         *
	         * @param path The route path which is used for matching. (e.g. /hello, users/:name)
	         */
	        protected FreemarkerBasedRoute(final String path, final String templateName) throws IOException {
	            super(path);
	            template = cfg.getTemplate(templateName);
	        }

	        @Override
	        public Object handle(Request request, Response response) {
	            StringWriter writer = new StringWriter();
	            try {
	                doHandle(request, response, writer);
	            } catch (Exception e) {
	                e.printStackTrace();
	                response.redirect("/internal_error");
	            }
	            return writer;
	        }

	        protected abstract void doHandle(final Request request, final Response response, final Writer writer)
	        throws IOException, TemplateException;

	    }

	 public static void main(String[] args) throws IOException {
		 Spark.staticFileLocation("/media");
	        if (args.length == 0) {
	            new DookController("mongodb://localhost");
	        }
	        else {
	            new DookController(args[0]);
	        }
	    }
	 private Configuration createFreemarkerConfiguration() {
	        Configuration retVal = new Configuration();
	        retVal.setClassForTemplateLoading(DookController.class, "/freemarker");
	        return retVal;
	    }
	 
	 private void initializeRoutes() throws IOException {
		 Gson gson= new Gson();
		 get(new FreemarkerBasedRoute("/", "index.html") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
	                SimpleHash root = new SimpleHash();
	                response.redirect("userLogin");
	               
	                template.process(root, writer);
	            }
	        });
		 // ionic app api start
		 get(new Route("/test") {
	            @Override
	            public Object handle(Request request, Response response) {
	            	return shopDao.getOwnerShopList("biren162");
	            }
	        });
		 post(new Route("/ownerLoginApi"){
			 @Override
			 public Object handle(Request req,Response res){
				 res.type("application/json");
				 Credential credential=gson.fromJson(req.body(), Credential.class);
				 Document user = ownerDao.validateLogin(credential.getUserName(), credential.getPassword());

	                if (user != null) {

	                    // valid user, let's log them in
	                    String sessionID = sessionDao.startSession(user.get("_id").toString());

	                    if (sessionID == null) {
	                       return  gson.toJson("internalError");
	                    }
	                    else {
	                        // set the cookie for the user's browser
	                      return gson.toJson("success");
	                    }
	                }
	                else {
	                return	gson.toJson("Invalid");
	                }
			 }
		 });
		 post(new Route("/ownerSignupApi"){
			 @Override
			 public Object handle(Request req,Response res){
				 res.type("application/json");
				 ownerVo =gson.fromJson(req.body(), OwnerVo.class);
				 System.out.println(ownerVo.getName()+ownerVo.getEmail());
				 	HashMap<String, String>ownerMap=new HashMap<String, String>();
				//	ownerMap.put("name", StringEscapeUtils.escapeHtml4(name));
				//	ownerMap.put("email", StringEscapeUtils.escapeHtml4(email));
				//	ownerMap.put("mo", StringEscapeUtils.escapeHtml4(mo));
				//	ownerMap.put("fname", StringEscapeUtils.escapeHtml4(fname));
				//	ownerMap.put("lname", StringEscapeUtils.escapeHtml4(lname));
					if (validateSignup(ownerVo.getName(),ownerVo.getFname(),ownerVo.getLname(), ownerVo.getPassword(), ownerVo.getVerifyPw(), ownerVo.getEmail(), ownerVo.getMo(),ownerMap)) {
				  
						if(!ownerDao.save(ownerVo)){
						ownerMap.put("name_error", "name already in use please try another. ");
						System.out.println("error in saving");
						return gson.toJson(ownerMap);
						}
						else
						{
						String sessionId=sessionDao.startSession(ownerVo.getName());
						System.out.println("session Id is:"+sessionId);
						//response.raw().addCookie(new Cookie("session",sessionId ));
						//response.redirect("/addShop");
						return gson.toJson("success");
						}
										
					}
					else {
	                    // bad signup
	                    System.out.println("User Registration did not validate");
	                   return gson.toJson(ownerMap);
	                }			 }
		 });
		 //ionic app api end
		 post(new FreemarkerBasedRoute("/ownerSignUp", "owner/ownerSignUp.jsp") {

			@Override
			protected void doHandle(Request request, Response response,
					Writer writer) throws IOException, TemplateException {
				// TODO Auto-generated method stub
				
				String name=request.queryParams("name");
				String fname=request.queryParams("fname");
				String lname=request.queryParams("lname");
				String password=request.queryParams("password");
				String verify=request.queryParams("verify");
				String email=request.queryParams("email");
				String mo=request.queryParams("mo");
				HashMap<String, String>ownerMap=new HashMap<String, String>();
				ownerMap.put("name", StringEscapeUtils.escapeHtml4(name));
				ownerMap.put("email", StringEscapeUtils.escapeHtml4(email));
				ownerMap.put("mo", StringEscapeUtils.escapeHtml4(mo));
				ownerMap.put("fname", StringEscapeUtils.escapeHtml4(fname));
				ownerMap.put("lname", StringEscapeUtils.escapeHtml4(lname));
				
				if (validateSignup(name,fname,lname, password, verify, email, mo,ownerMap)) {
			  
					ownerVo.setName(name);
					ownerVo.setEmail(email);
					ownerVo.setPassword(password);
					ownerVo.setMo(mo);
					ownerVo.setFname(fname);
					ownerVo.setLname(lname);
					if(!ownerDao.save(ownerVo)){
					ownerMap.put("name_error", "name already in use please try another. ");
					template.process(ownerMap, writer);
					}
					else
					{
					String sessionId=sessionDao.startSession(name);
					System.out.println("session Id is:"+sessionId);
					response.raw().addCookie(new Cookie("session",sessionId ));
					response.redirect("/addShop");
					}
									
				}
				else {
                    // bad signup
                    System.out.println("User Registration did not validate");
                    template.process(ownerMap, writer);
                }				
			}			 	 
	 });
		 get(new FreemarkerBasedRoute("/ownerSignUp","owner/ownerSignUp.jsp") {
			
			@Override
			protected void doHandle(Request request, Response response, Writer writer)
					throws IOException, TemplateException {
				// TODO Auto-generated method stub
				HashMap<String , String >root=new HashMap<String, String>();
				 root.put("name", "");
				 root.put("fname", "");
				 root.put("lname", "");
				 
	                root.put("password", "");
	                root.put("email", "");
	                root.put("password_error", "");
	                root.put("name_error", "");
	                root.put("fname_error", "");
	                root.put("lname_error", "");
	                root.put("email_error", "");
	                root.put("mo", "");
	                root.put("verify_error", "");            

	                template.process(root, writer);
			}
		});
		 get(new FreemarkerBasedRoute("/ownerLogin", "owner/oLogin.jsp") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
	                SimpleHash root = new SimpleHash();

	                root.put("username", "");
	                root.put("login_error", "");

	                template.process(root, writer);
	            }
	        });
		 get(new FreemarkerBasedRoute("/userLogout", "user/userSignUp.jsp") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {

	                String sessionID = getSessionCookie(request);

	                if (sessionID == null) {
	                    // no session to end
	                    response.redirect("/userLogin");
	                }
	                else {
	                    // deletes from session table
	                    userSessionDao.endSession(sessionID);

	                    // this should delete the cookie
	                    Cookie c = getSessionCookieActual(request);
	                    c.setMaxAge(0);

	                    response.raw().addCookie(c);

	                    response.redirect("/userLogin");
	                }
	            }
	        });
		 get(new FreemarkerBasedRoute("/ownerLogout", "owner/ownerSignUp.jsp") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {

	                String sessionID = getSessionCookieOwner(request);

	                if (sessionID == null) {
	                    // no session to end
	                    response.redirect("/ownerLogin");
	                }
	                else {
	                    // deletes from session table
	                    sessionDao.endSession(sessionID);

	                    // this should delete the cookie
	                    Cookie c = getSessionCookieActualOwner(request);
	                    c.setMaxAge(0);

	                    response.raw().addCookie(c);

	                    response.redirect("/ownerLogin");
	                }
	            }
	        });

	        // process output coming from login form. On success redirect folks to the welcome page
	        // on failure, just return an error and let them try again.
	        post(new FreemarkerBasedRoute("/ownerLogin", "owner/oLogin.jsp") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {

	                String username = request.queryParams("username");
	                String password = request.queryParams("password");

	                System.out.println("ownerLogin: User submitted: " + username + "  " + password);

	                Document user = ownerDao.validateLogin(username, password);

	                if (user != null) {

	                    // valid user, let's log them in
	                    String sessionID = sessionDao.startSession(user.get("_id").toString());

	                    if (sessionID == null) {
	                        response.redirect("/internal_error");
	                    }
	                    else {
	                        // set the cookie for the user's browser
	                        response.raw().addCookie(new Cookie("session", sessionID));
	                        response.redirect("ownerHome");
	                    }
	                }
	                else {
	                    SimpleHash root = new SimpleHash();


	                    root.put("username", StringEscapeUtils.escapeHtml4(username));
	                    root.put("password", "");
	                    root.put("login_error", "Invalid Login");
	                    template.process(root, writer);
	                }
	            }
	        });
	        post(new FreemarkerBasedRoute("/userSignUp", "user/userSignUp.jsp") {

				@Override
				protected void doHandle(Request request, Response response,
						Writer writer) throws IOException, TemplateException {
					// TODO Auto-generated method stub
					
					String name=request.queryParams("name");
					String fname=request.queryParams("fname");
					String lname=request.queryParams("lname");
					String password=request.queryParams("password");
					String verify=request.queryParams("verify");
					String email=request.queryParams("email");
					String mo=request.queryParams("mo");
					
					String line1=request.queryParams("line1");
					String area=request.queryParams("area");
					String city=request.queryParams("city");
					String state=request.queryParams("state");
					String country=request.queryParams("country");
					
					HashMap<String, String>ownerMap=new HashMap<String, String>();
					ownerMap.put("name", StringEscapeUtils.escapeHtml4(name));
					ownerMap.put("fname", StringEscapeUtils.escapeHtml4(fname));
					ownerMap.put("lname", StringEscapeUtils.escapeHtml4(lname));
					
					ownerMap.put("email", StringEscapeUtils.escapeHtml4(email));
					ownerMap.put("mo", StringEscapeUtils.escapeHtml4(mo));
					ownerMap.put("line1", StringEscapeUtils.escapeHtml4(line1));
					ownerMap.put("area", StringEscapeUtils.escapeHtml4(area));
					ownerMap.put("city", StringEscapeUtils.escapeHtml4(city));
					ownerMap.put("state", StringEscapeUtils.escapeHtml4(state));
					ownerMap.put("country", StringEscapeUtils.escapeHtml4(country));
					
					if (validateSignup(name,fname,lname, password, verify, email, mo,ownerMap)) {
				  
						userVo.setUserName(name);
						userVo.setEmail(email);
						userVo.setPassword(password);
						userVo.setMo(mo);
						userVo.setFname(fname);
						userVo.setLname(lname);
						if(!userDao.save(userVo)){
						ownerMap.put("name_error", "name already in use please try another. ");
						template.process(ownerMap, writer);
						}
						else
						{
						String sessionId=userSessionDao.startSession(name);
						System.out.println("session Id is:"+sessionId);
						response.raw().addCookie(new Cookie("session",sessionId ));
						response.redirect("/userLogin");
						}
										
					}
					else {
	                    // bad signup
	                    System.out.println("User Registration did not validate");
	                    template.process(ownerMap, writer);
	                }				
				}			 	 
		 });
			 get(new FreemarkerBasedRoute("/userSignUp", "user/userSignUp.jsp") {
				
				@Override
				protected void doHandle(Request request, Response response, Writer writer)
						throws IOException, TemplateException {
					// TODO Auto-generated method stub
					HashMap<String , String >root=new HashMap<String, String>();
					 root.put("name", "");
					 root.put("fname", "");
					 root.put("lname", "");
					 root.put("line1", "");
					 root.put("area", "");
					 root.put("city", "");
					 root.put("state", "");
					 root.put("country", "");
					 
					 
		                root.put("password", "");
		                root.put("email", "");
		                root.put("password_error", "");
		                root.put("name_error", "");
		                root.put("fname_error", "");
		                root.put("lname_error", "");
		                root.put("email_error", "");
		                root.put("mo", "");
		                root.put("mo_error", "");
		                root.put("verify_error", "");            

		                template.process(root, writer);
				}
			});

	        get(new FreemarkerBasedRoute("/userLogin", "user/userLogin.jsp") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
	                SimpleHash root = new SimpleHash();
	                String sessionID=null;
	                sessionID = getSessionCookie(request);
	            	 
		                if (sessionID !=null) {
		                    // no session to end
		                    response.redirect("/userHome");
		                }
	                root.put("username", "");
	                root.put("login_error", "");
	                
	                template.process(root, writer);
	            }
	        });

	        // process output coming from login form. On success redirect folks to the welcome page
	        // on failure, just return an error and let them try again.
	        post(new FreemarkerBasedRoute("/userLogin", "user/userLogin.jsp") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {

	                String username = request.queryParams("username");
	                String password = request.queryParams("password");

	                System.out.println("userLogin: User submitted: " + username + "  " + password);

	                Document user = userDao.validateLogin(username, password);

	                if (user != null) {

	                    // valid user, let's log them in
	                    String sessionID = userSessionDao.startSession(user.get("_id").toString());

	                    if (sessionID == null) {
	                        response.redirect("/internal_error");
	                    }
	                    else {
	                        // set the cookie for the user's browser
	                        response.raw().addCookie(new Cookie("userSession", sessionID));
	                        response.redirect("/userHome");
	                    }
	                }
	                else {
	                    SimpleHash root = new SimpleHash();


	                    root.put("username", StringEscapeUtils.escapeHtml4(username));
	                    root.put("password", "");
	                    root.put("login_error", "Invalid Login");
	                    template.process(root, writer);
	                }
	            }
	        });
	        get(new FreemarkerBasedRoute("/userHome", "user/userHomeT2.jsp") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
	            	 String sessionID=null;
	            	 long totalpage=5;
	            	 sessionID = getSessionCookie(request);
	            	 String lat="",longi="";
		                if (sessionID == null) {
		                    // no session to end
		                    response.redirect("/userLogin");
		                }
		                else{
		                System.out.println("location get:"+request.queryParams("lat")+" "+request.queryParams("longi"));
		                 lat=request.queryParams("lat");
		                 longi=request.queryParams("longi");
		                 if(lat==null)
		                	 lat="-1";
		                 if(longi==null)
		                	 longi="-1";
		                 System.out.println("test"+lat);
		                 		                 
		                 String nextpageS=request.queryParams("page");
		                 int limit=10,skip=0;
		                 if(nextpageS!=null)
		                 skip=(Integer.parseInt(nextpageS)-1)*10;
		                // limit=(Integer.parseInt(nextpageS))*10;
	                SimpleHash root = new SimpleHash();
	                List<Document>docs=new ArrayList<Document>();
	               if(lat.equals("-1")&&longi.equals("-1"))
	            	   {docs=shopDao.getFullShopRecord(skip,limit); root.put("full", 1);
	            	   }
	               else
	                {docs=shopDao.getAbstractShopRecord(skip,limit,longi,lat);root.put("full", 0);
	            	   //make method in shopDao which return total no. of document after longi and lat math	                
	                }
	             //will return total page
	            	  totalpage=(long)Math.ceil(((shopDao.getFullTotal())/10.0));
	                System.out.println("abstract:"+docs.get(0));
	                root.put("shopdocs", docs);                
	               
					Cookie []coo=request.raw().getCookies();
					for(int i=0;i<coo.length;i++)
					{	if(coo[i].getName().equals("userSession")){ sessionID=coo[i].getValue();}}
					String userName=userSessionDao.findUserNameBySessionId(sessionID);
					
					int nextpage, prevpage=1,prevDisable=0;
					if(nextpageS==null){
						nextpage=2;
						prevDisable=1;
					}
					else
						{nextpage=Integer.parseInt(nextpageS)+1;
						prevpage=nextpage-2;
						}
						
	                root.put("name", userName);
	                root.put("lat", lat);
	                root.put("longi", longi);
	                root.put("nextpage", nextpage);
	                root.put("totalpage", totalpage);
	                root.put("prevDisable",prevDisable);
	                root.put("prevpage",prevpage);
	                
	                
	                template.process(root, writer);
	            }
	            }
	        });
	        post(new FreemarkerBasedRoute("/userHome", "user/userHomeT2.jsp") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
	            	 System.out.println("location post:"+request.queryParams("lat")+" "+request.queryParams("longi"));
	            }
	            });
	    
	        

		 get(new FreemarkerBasedRoute("/internal_error", "errorTemplet.ftl") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
	                SimpleHash root = new SimpleHash();

	                root.put("error", "System has encountered an error.");
	                template.process(root, writer);
	            }
	        });
		 post(new FreemarkerBasedRoute("/deleteShop", "owner/deleteShop.jsp") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
	                SimpleHash root = new SimpleHash();
	                String shopLink=request.queryParams("shopLink");
	                System.out.println(shopLink);
	                if(shopDao.deleteShop(shopLink))
	                	 root.put("msg", "successfully deleted");
	                else
	                	 root.put("msg", "something went wrong!");
	                
	                template.process(root, writer);
	            }
	        });
		 post(new FreemarkerBasedRoute("/deleteProduct", "owner/deleteProduct.jsp") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
	                SimpleHash root = new SimpleHash();
	                String shopLink=request.queryParams("shopLink");
	                String pCategory=request.queryParams("productCategory");
	                String productName=request.queryParams("productName");
	                
	                //System.out.println(shopLink);
	                if(shopDao.deleteProduct(shopLink,pCategory,productName))
	                	 root.put("msg", "successfully deleted");
	                else
	                	 root.put("msg", "something went wrong!");
	                
	                template.process(root, writer);
	            }
	        });


		 get (new FreemarkerBasedRoute("addShop","owner/addShop.jsp") {
			
			@Override
			protected void doHandle(Request request, Response response, Writer writer)
					throws IOException, TemplateException {
				// TODO Auto-generated method stub
				 String sessionID=null;
            	 sessionID = getSessionCookieOwner(request);
	                if (sessionID == null) {
	                    // no session to end
	                    response.redirect("/ownerLogin");
	                }
	                else{
				
				ArrayList<Document >list=cat.getCategory();
				//HashMap<String , ArrayList<String>>map=new HashMap<String, ArrayList<String>>();
				SimpleHash map=new SimpleHash();
				map.put("CategoryList", list);
				map.put("name_error", "");
				map.put("category_error", "");
				map.put("line1_error", "");
				map.put("area_error", "");
				map.put("city_error", "");
				map.put("state_error", "");
				map.put("country_error", "");
				map.put("shopname", "");
				map.put("line1", "");
				map.put("area", "");
				map.put("city", "");
				map.put("state", "");
				map.put("country", "");
				
				
				
				
				
				template.process(map, writer);
	                }
				
			}
		});
		 post(new FreemarkerBasedRoute("addShop","owner/addShop.jsp") {

				@Override
				protected void doHandle(Request request, Response response,
						Writer writer) throws IOException, TemplateException {
					
					// TODO Auto-generated method stub
					
					String sessionID=null;
					boolean error=false;
					Cookie []coo=request.raw().getCookies();
					System.out.println("total cookies"+coo.length);
					for(int i=0;i<coo.length;i++)
					{String name=coo[i].getName();System.out.println("coo name:"+coo[i].getName());
						if(name.equals("session")){ sessionID=coo[i].getValue();
					System.out.println("session==sessionID"+sessionID);
					}
					
					}
					String ownerName=sessionDao.findUserNameBySessionId(sessionID);
					
					
				/*	List  items = .parseRequest(request);
					// Process the uploaded items
					Iterator iter = items.iterator();
					while (iter.hasNext()) {
					    FileItem item = (FileItem) iter.next();

					    if (item.isFormField()) {

					      String name = item.getFieldName();//text1
					      String value = item.getString();

					    } else {
					        processUploadedFile(item);
					    }
					}
					
*/							
					
					System.out.println(ownerName +" owner is posting shop..");
					//String shopName=request.queryParams("shopname");
					String shopName="",line1="",area="",city="",state="",country="",shopLink="",lat="",longi="";
					/*String line1=request.queryParams("line1");
					String area=request.queryParams("area");
					String city=request.queryParams("city");
					String state=request.queryParams("state");
					String country=request.queryParams("country");*/
					
					String url=null;
					Part filePart=null;
					try {
						MultipartConfigElement multipartConfigElement = new MultipartConfigElement("/tmp");
					    request.raw().setAttribute("org.eclipse.multipartConfig", multipartConfigElement);
					    //map output
					   // System.out.println("***lat:"+getValue(request.raw().getPart("lat"))+"long"+getValue(request.raw().getPart("long")));
					    lat=getValue(request.raw().getPart("lat"));
					    longi=getValue(request.raw().getPart("long"));
						filePart = request.raw().getPart("img");
						shopName = getValue(request.raw().getPart("shopname"));
						line1 = getValue(request.raw().getPart("line1"));
						area = getValue(request.raw().getPart("area"));
						city = getValue(request.raw().getPart("city"));
						state = getValue(request.raw().getPart("state"));
						country = getValue(request.raw().getPart("country"));
						shopLink = (shopName+ownerName).replaceAll("\\s", "_"); // whitespace becomes _
				        shopLink = shopLink.replaceAll("\\W", ""); // get rid of non alphanumeric
				        shopLink = shopLink.toLowerCase();				
						
					} catch (ServletException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
							/*fos.write(b);  */
					
					SimpleHash map=new SimpleHash();
					map.put("shopname", StringEscapeUtils.escapeHtml4(shopName));
					map.put("line1", StringEscapeUtils.escapeHtml4(line1));
					map.put("area", StringEscapeUtils.escapeHtml4(area));
					map.put("city", StringEscapeUtils.escapeHtml4(city));
					map.put("state", StringEscapeUtils.escapeHtml4(state));
					map.put("country", StringEscapeUtils.escapeHtml4(country));
								
					//CategoryDao cat=new CategoryDao();
					ArrayList<Document>list=cat.getCategory();
					//HashMap<String , ArrayList<String>>map=new HashMap<String, ArrayList<String>>();
					map.put("CategoryList", list);
					
					String category=request.queryParams("category");
					if(shopName.equals(""))
					{	map.put("name_error","enter shopName");error=true;}
					else map.put("name_error", "");
					if((line1.equals(""))  ){
						map.put("line1_error", "enter line1");error=true;
					}else map.put("line1_error", "");
					if (area.equals("")){ map.put("area_error", "enter area name");error=true;} else map.put("area_error", ""); 
					 if (city.equals("")){map.put("city_error", "enter city name");error=true;} else map.put("city_error", "");
					if (state.equals("")){map.put("state_error", "enter state name");error=true;}else map.put("state_error", ""); 
					if (country.equals("")){map.put("country_error", "enter country name");error=true;} else map.put("country_error", "");
					if(error)
					template.process(map,writer);
					else{
					url=fileDao.saveImage(filePart,shopLink);
					if(url==null){
						url="-1";
					}	
						
					
					
					shopVo.setShopCategory(category);
					shopVo.setOwnerName(ownerName);
					shopVo.setShopName(shopName);
					shopVo.setLine1(line1);
					shopVo.setArea(area);
					shopVo.setCity(city);
					shopVo.setState(state);
					shopVo.setCountry(country);
					shopVo.setUrl(url);	
					shopVo.setLocation(lat,longi);
				//	ownerDao =new OwnerDao(dookDatabase);
					 
						
						
							if(!shopDao.save(shopVo)){
								System.out.println("coding error1");
								}
							else
						response.redirect("ownerHome");
						
										
					
					}			
				}			 	 
		 });
		
		 get (new FreemarkerBasedRoute("/addvShop","owner/addvShop2.jsp") {
				
				@Override
				protected void doHandle(Request request, Response response, Writer writer)
						throws IOException, TemplateException {
					// TODO Auto-generated method stub
	//				CategoryDao cat=new CategoryDao();
					 String sessionID=null;
	            	 sessionID = getSessionCookieOwner(request);
		                if (sessionID == null) {
		                    // no session to end
		                    response.redirect("/ownerLogin");
		                }
		                String ownerName=sessionDao.findUserNameBySessionId(sessionID);
					String shopLink= request.queryParams("shopLink");
					List<Document> list2=shopDao.getOwnerShopList(ownerName);		                
	                if(shopLink==null && list2!=null && list2.size()!=0)
	                shopLink=(String) list2.get(0).get("shopLink");
	                if(list2.size()==0)
	                	response.redirect("addShop");
	                else{
					Document doc=shopDao.getItemCategoryList(shopLink);
					ArrayList<String>list;
					if(doc!=null){
					list= new ArrayList<String>((ArrayList<String>)doc.get("cat"));}
					else{list=new ArrayList<String>();}
					list.add(0, "select");
					list.add("addNew");
					/*System.out.println("catList^^:"+list1);
					ArrayList<String >list=new ArrayList<String>();
					list.add("select");
					list.add("mobile");list.add("computer");list.add("addNew");*/
					//HashMap<String , ArrayList<String>>map=new HashMap<String, ArrayList<String>>();
					String oName=getOwner(request);
	                List<Document> list3=shopDao.getOwnerShopList(oName);
					SimpleHash map=new SimpleHash();
					 map.put("shopList", list3);
					map.put("itemCategoryList", list);
					map.put("shopLink", shopLink);
					map.put("itemName", "");
					map.put("itemPrice", "");
					map.put("itemName_error", "");
					map.put("itemPrice_error", "");
					map.put("itemCat_error", "");
					map.put("itemImg_error", "");
					
					
					template.process(map, writer);
	                }
				}
			});

		 post(new FreemarkerBasedRoute("/addvShop","owner/addvShop2.jsp") {

				@Override
				protected void doHandle(Request request, Response response,
						Writer writer) throws IOException, TemplateException {
					
					// TODO Auto-generated method stub
					
					String sessionID=null;
					boolean error=false;
					Cookie []coo=request.raw().getCookies();
					for(int i=0;i<coo.length;i++)
					{String name=coo[i].getName();System.out.println("coo name:"+coo[i].getName());
						if(name.equals("session")){ sessionID=coo[i].getValue();
					System.out.println("session==sessionID"+sessionID);
					}
					
					}
					String ownerName=sessionDao.findUserNameBySessionId(sessionID);						
					System.out.println(ownerName +" owner is adding product in addvproduct ..");			
					String itemCat="",itemName="",itemPrice="",itemImg="",shopLink="";
					ArrayList<String>urllist=new ArrayList<String>();
					
					
					
					//validation
					
					//Part filePart;
					Collection<Part>partCollection=null;
					try {
						MultipartConfigElement multipartConfigElement = new MultipartConfigElement("/tmp");
					    request.raw().setAttribute("org.eclipse.multipartConfig", multipartConfigElement);					    
						
					    shopLink=getValue(request.raw().getPart("shopLink"));
						itemCat= getValue(request.raw().getPart("itemCat"));
						if(itemCat.equals("addNew")) itemCat=getValue(request.raw().getPart("itemCat2"));
						itemName = getValue(request.raw().getPart("itemName"));
						itemPrice= getValue(request.raw().getPart("itemPrice"));
						partCollection=request.raw().getParts();
						//Part P=request.raw().getPart("itemImg");
						//fileDao.saveImage(P, shopLink);
				/*		url=fileDao.saveImage(filePart,shopLink);
						if(url==null){
							url="-1";
						}
				*/		
						
						
					} catch (ServletException e) {
						// TODO Auto-generated catch ;block
						System.out.println("exception here");
						e.printStackTrace();
					}
							/*fos.write(b);  */
					
					SimpleHash map=new SimpleHash();
					map.put("shopLink", StringEscapeUtils.escapeHtml4(shopLink));
					//map.put("itemCat", StringEscapeUtils.escapeHtml4(itemCat));
					map.put("itemName", StringEscapeUtils.escapeHtml4(itemName));
					map.put("itemPrice", StringEscapeUtils.escapeHtml4(itemPrice));
					
	//				CategoryDao cat=new CategoryDao();
					ArrayList<String >list=new ArrayList<String>();
					list.add("select");
					list.add("mobile");list.add("computer");list.add("addNew");
					//HashMap<String , ArrayList<String>>map=new HashMap<String, ArrayList<String>>();
					map.put("itemCategoryList", list);
					
					//String category=request.queryParams("itemCat");
					if((itemCat.equals(""))||(itemCat.equals("select"))||(itemCat==null))
					{	map.put("itemCat_error","enter itemCategory name");error=true;}
					else map.put("itemCat_error", "");
					if((itemName.equals(""))  ){
						map.put("itemName_error", "enter item name");error=true;
						System.out.println("itemName error");
					}else map.put("itemName_error", "");					
					
					if(error)
						{
						template.process(map,writer);
						}
					else{					
					urllist= new ArrayList<String>(fileDao.saveItemImages(partCollection,shopLink));
					System.out.println("In controller: total "+urllist.size()+"file uploaded");
				
					shopVo.setItemCat(itemCat);
					shopVo.setItemName(itemName);
					if(itemPrice.equals(""))itemPrice="-1";
					shopVo.setItemPrice(Integer.parseInt(itemPrice));
					shopVo.setItemUrlList(urllist);
				
				//	ownerDao =new OwnerDao(dookDatabase);
					 
							if(!shopDao.saveItem(shopVo,shopLink)){
								System.out.println("error in savItem shopdao");
								}
							else
						response.redirect("ownerHome");
					}			
				}	 	 
		 });
		
		 get(new FreemarkerBasedRoute("ownerHome", "owner/ownerHome.jsp") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
	                SimpleHash root = new SimpleHash();
	                String sessionID=null;
	            	 sessionID = getSessionCookieOwner(request);
	            	 System.out.println("sId:"+sessionID);
		                if (sessionID == null) {
		                    // no session to end
		                    response.redirect("/ownerLogin");
		                }
		                else{
		                String oName=getOwner(request);
		                System.out.println(oName);
		                List<Document> list=shopDao.getOwnerShopList(oName);
		                System.out.println("ownershopList"+list);
		                String shopLink="";
		                shopLink=request.queryParams("shopLink");
		                
		                if(shopLink==null && list!=null && list.size()!=0)
		                shopLink=(String) list.get(0).get("shopLink");
		                if(list.size()==0)
		                {	shopLink="";
		                	response.redirect("addShop");}
		               else{
		                Map<String,List<Document>>shopMap=shopDao.getVirtualShop(shopLink);
		                Document doc = shopDao.findByShopLink(shopLink);
		                System.out.println("V-shop:"+shopMap);
		            
		                root.put("shopMap", shopMap);
		                root.put("doc", doc);
			                root.put("userName", oName);
			                root.put("shopLink", shopLink);
			                root.put("shopList", list);
		            /*    root.put("shopMap", shopMap);
		                root.put("doc", doc);*/	         
		                template.process(root, writer);
		                }
	            }
	            }
	        });
		 get (new FreemarkerBasedRoute("manageShop","owner/manageShop.jsp") {
				
				@Override
				protected void doHandle(Request request, Response response, Writer writer)
						throws IOException, TemplateException {
					// TODO Auto-generated method stub
					 String sessionID=null;
	            	 sessionID = getSessionCookieOwner(request);
		                if (sessionID == null) {
		                    // no session to end
		                    response.redirect("/ownerLogin");
		                }
		                String ownerName=sessionDao.findUserNameBySessionId(sessionID);
		                String shopLink="";
		                shopLink=request.queryParams("shopLink");


		                List<Document> list2=shopDao.getOwnerShopList(ownerName);		                
		                if(shopLink==null && list2!=null && list2.size()!=0)
		                shopLink=(String) list2.get(0).get("shopLink");
		                if(list2.size()==0)
		                	response.redirect("addShop");
		                else{
		                
		                
		                SimpleHash map=new SimpleHash();
		                map.put("shopLink", shopLink);
		               List<Document> docs=shopDao.findByOwner(ownerName);
		               Map<String,List<Document>>shopMap=shopDao.getVirtualShop(shopLink);
		               String shopName="";
		                Document doc = shopDao.findByShopLink(shopLink);
		                if(doc!=null)
		                	shopName=(String) doc.get("shopName");
		                
		                System.out.println("V-shop in manage Shop:"+shopMap);
		                String oName=getOwner(request);
		                List<Document> list=shopDao.getOwnerShopList(oName);
		                map.put("shopMap", shopMap);
		                map.put("shopName", shopName);
		                map.put("docs", docs);
		                map.put("shopList", list);
				/*	CategoryDao cat=new CategoryDao();
					ArrayList<String >list=cat.getCategory();
					//HashMap<String , ArrayList<String>>map=new HashMap<String, ArrayList<String>>();
					
					map.put("CategoryList", list);
					map.put("name_error", "");
					map.put("category_error", "");
					map.put("line1_error", "");
					map.put("area_error", "");
					map.put("city_error", "");
					map.put("state_error", "");
					map.put("country_error", "");
					map.put("shopname", "");
					map.put("line1", "");
					map.put("area", "");
					map.put("city", "");
					map.put("state", "");
					map.put("country", "");
					
					
*/					
					
					
					template.process(map, writer);
		                }
				}
			});

		 get(new FreemarkerBasedRoute("/shopDetails", "user/shopDetails.jsp") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
	                SimpleHash root = new SimpleHash();
	                String sessionID=null;
	                sessionID = getSessionCookie(request);
	                if (sessionID == null) {
	                    // no session to end
	                    response.redirect("/userLogin");
	                }
	                else{
	                String shopLink=request.queryParams("shopLink");
	                Map<String,List<Document>>shopMap=shopDao.getVirtualShop(shopLink);
	                Document doc = shopDao.findByShopLink(shopLink);
	                System.out.println("V-shop:"+shopMap);
	            	 sessionID = getSessionCookie(request);
		                if (sessionID == null) {
		                    // no session to end
		                    response.redirect("/userLogin");
		                }
		                String uName=getUser(request);
		                root.put("userName", uName);
	                root.put("shopMap", shopMap);
	                root.put("doc", doc);	         
	                root.put("msg", "");
	                template.process(root, writer);
	            }}
	        });
		  post(new FreemarkerBasedRoute("/shopDetails", "user/shopDetails.jsp") {
	            @Override
	            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
	            String shopLink=request.queryParams("shopLink");
	            System.out.println("shopLink to which review is to be updated:"+shopLink);
	            String userName=request.queryParams("userName");
	            System.out.println("username who post review"+userName);
	             String r=request.queryParams("review");
	             String RComment=request.queryParams("RComment");
	             System.out.println("RComment:"+RComment); 
	            int review=Integer.parseInt(r);
	            System.out.println("review:"+review);
	            SimpleHash map=new SimpleHash();
	            int v=shopDao.update(shopLink, userName, review,RComment);
	            	 String uName=getUser(request);
	            	 if(v==-1)
	            	map.put("msg", "Oops! "+uName+", you have already reviewed this shop.");
	            	 else
	            		 map.put("msg", "");
	            	
	            	Document doc = shopDao.findByShopLink(shopLink);
	            	Map<String,List<Document>>shopMap=shopDao.getVirtualShop(shopLink);
	            	
	               
	                map.put("userName", uName);
	                map.put("doc", doc);
	                map.put("shopMap", shopMap);
	            	template.process(map, writer);
	            
	            	
	            }
	        });
		  get(new FreemarkerBasedRoute("/admin162","admin/dashboard.jsp") {
				
				@Override
				protected void doHandle(Request request, Response response, Writer writer)
						throws IOException, TemplateException {
					// TODO Auto-generated method stub
					String sessionID=null;
	           	 sessionID = getSessionCookieAdmin(request);
		                if (sessionID == null) {
		                    // no session to end
		                    response.redirect("/aLogin162");
		                }
					SimpleHash map=new SimpleHash();
					
					long Tuser=userDao.getTotalUser();
					long Tshop=shopDao.getTotalProperties();
					map.put("Tuser", Tuser);
					map.put("Tshop", Tshop);
					
					template.process(map, writer);
				}
			});
			  get(new FreemarkerBasedRoute("/aLogin162", "admin/aLogin.jsp") {
		            @Override
		            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
		                SimpleHash root = new SimpleHash();
		                String sessionID=null;
		                sessionID = getSessionCookieAdmin(request);
		            	 
			                if (sessionID!=null) {
			                    // no session to end
			                	if(sessionID.equals("biren162"))
			                    response.redirect("/admin162");
			                }
		                root.put("username", "");
		                root.put("login_error", "");

		                template.process(root, writer);
		            }
		        });
			  post(new FreemarkerBasedRoute("/aLogin162", "admin/aLogin.jsp") {
		            @Override
		            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {

		                String username = request.queryParams("username");
		                String password = request.queryParams("password");

		                System.out.println("adminLogin: User submitted: " + username + "  " + password);

		              boolean result = adminDao.validateLogin(username, password);

		                if (result) {

		                    // valid user, let's log them in
		                   	                        // set the cookie for the user's browser
		                        response.raw().addCookie(new Cookie("adminSession", "biren162"));
		                        response.redirect("/admin162");
		                   
		                }
		                else {
		                    SimpleHash root = new SimpleHash();


		                    root.put("username", StringEscapeUtils.escapeHtml4(username));
		                    root.put("password", "");
		                    root.put("login_error", "Invalid Login");
		                    template.process(root, writer);
		                }
		            }
		        });
			  get(new FreemarkerBasedRoute("/adminLogout", "admin/aLogin.jsp") {
		            @Override
		            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {

		                String sessionID = getSessionCookieAdmin(request);

		                if (sessionID == null) {
		                    // no session to end
		                    response.redirect("/aLogin162");
		                }
		                else {
		                    // deletes from session table
		                 //   userSessionDao.endSession(sessionID);

		                    // this should delete the cookie
		                    Cookie c = getSessionCookieActualAdmin(request);
		                    c.setMaxAge(0);

		                    response.raw().addCookie(c);

		                    response.redirect("aLogin162");
		                }
		            }
		        });
			  get(new FreemarkerBasedRoute("manageCat", "admin/manageCat.jsp") {
		            @Override
		            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
		                SimpleHash root = new SimpleHash();
		                String sessionID=null;
		                sessionID = getSessionCookieAdmin(request);
		            	 
			                if (sessionID==null|| (!sessionID.equals("biren162"))) {
			                    response.redirect("/aLogin162");
			                }
		                template.process(root, writer);
		            }
		        });
			  post(new FreemarkerBasedRoute("manageCat", "admin/manageCat.jsp") {
		            @Override
		            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
		                SimpleHash root = new SimpleHash();
		                String sessionID=null;
		                sessionID = getSessionCookieAdmin(request);
		            	 
			                if (sessionID==null|| (!sessionID.equals("biren162"))) {
			                    response.redirect("/aLogin162");
			                }
			                String catName=request.queryParams("catName");
			                	if(!cat.save(catName)){
									System.out.println("error in sav categoryDao");
									}
								else
							response.redirect("manageCat");
			                	
		                template.process(root, writer);
		            }
		        });
			  get(new FreemarkerBasedRoute("userForgot", "user/forgot.jsp") {
		            @Override
		            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
		                SimpleHash root = new SimpleHash();
		               
		               
		                template.process(root, writer);
		            }
		        });
			  post(new FreemarkerBasedRoute("userForgot", "user/forgot.jsp") {
		            @Override
		            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
		                SimpleHash root = new SimpleHash();
		               
			                String email=request.queryParams("email");
			                	if(!userDao.sendEmailToUser(email)){
									System.out.println("error in sav categoryDao");
									}
								else
							response.redirect("userForgot");
			                	
		                template.process(root, writer);
		            }
		        });
			  get(new FreemarkerBasedRoute("resetPw", "user/resetPw.jsp") {
		            @Override
		            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
		                SimpleHash root = new SimpleHash();
		                String random=request.queryParams("random");
		                String userId=request.queryParams("userId");
		                String email=request.queryParams("email");
		                String user=forgotDao.getUserIdFromRandom(random);
		                if(!user.equals(userId)){
		                	response.redirect("resetPwError");
		                }
		                else{
		                root.put("verify_error", "");
		                root.put("userId", userId);
		                template.process(root, writer);
		                }
		            }
		        });
			  post(new FreemarkerBasedRoute("resetPw", "user/resetPw.jsp") {
		            @Override
		            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
		                SimpleHash root = new SimpleHash();
		               
			                String pw=request.queryParams("password");
			                String pw2=request.queryParams("password2");
			                String userId=request.queryParams("userId");
			                if(!pw.equals(pw2)){
			                	root.put("verify_error", "password doesn't match");
			                	template.process(root, writer);
			                }
			                else
			                {
			                	if(!userDao.savePw(userId,pw)){
			                		System.out.println("error in savePw in userDao");
			                	}
			                	else{
			                	response.redirect("userLogin");
			                	}
			                }
			                
			                /*	if(!user.sendEmailToUser(email)){
									System.out.println("error in  resetPw controller");
									}
								else
							response.redirect("userForgot");
							*/
		            }
		        });
			  get(new FreemarkerBasedRoute("resetPwError", "user/resetPwError.jsp") {
		            @Override
		            protected void doHandle(Request request, Response response, Writer writer) throws IOException, TemplateException {
		                SimpleHash root = new SimpleHash();
		               
		                template.process(root, writer);
		               
		            }
		        });

		 }

	 

	 private static String getValue(Part part) throws IOException {
		    BufferedReader reader = new BufferedReader(new InputStreamReader(part.getInputStream(), "UTF-8"));
		    StringBuilder value = new StringBuilder();
		    char[] buffer = new char[1024];
		    for (int length = 0; (length = reader.read(buffer)) > 0;) {
		        value.append(buffer, 0, length);
		    }
		    return value.toString();
		}
	 public String getUser(Request request){
		 String sessionID=null;
		 Cookie []coo=request.raw().getCookies();
			for(int i=0;i<coo.length;i++)
			{	System.out.println("sessionName:"+coo[i].getName());
				if(coo[i].getName().equals("userSession")){ sessionID=coo[i].getValue();
												System.out.println("sessionID:"+sessionID);	}
				}
			String userName=userSessionDao.findUserNameBySessionId(sessionID);
			return userName;
	 }
	 public String getOwner(Request request){
		 String sessionID=null;
		 Cookie []coo=request.raw().getCookies();
			for(int i=0;i<coo.length;i++)
			{	System.out.println("sessionName:"+coo[i].getName());
				if(coo[i].getName().equals("session")){ sessionID=coo[i].getValue();
												System.out.println("sessionID:"+sessionID);	}
				}
			String userName=sessionDao.findUserNameBySessionId(sessionID);
			return userName;
	 }
	 private String getSessionCookie(final Request request) {
	        if (request.raw().getCookies() == null) {
	            return null;
	        }
	        for (Cookie cookie : request.raw().getCookies()) {
	            if (cookie.getName().equals("userSession")) {
	                return cookie.getValue();
	            }
	        }
	        return null;
	    }
	 private String getSessionCookieOwner(final Request request) {
	        if (request.raw().getCookies() == null) {
	            return null;
	        }
	        for (Cookie cookie : request.raw().getCookies()) {
	            if (cookie.getName().equals("session")) {
	                return cookie.getValue();
	            }
	        }
	        return null;
	    }
	 private String getSessionCookieAdmin(final Request request) {
	        if (request.raw().getCookies() == null) {
	            return null;
	        }
	        for (Cookie cookie : request.raw().getCookies()) {
	            if (cookie.getName().equals("adminSession")) {
	                return cookie.getValue();
	            }
	        }
	        return null;
	    }

	    // helper function to get session cookie as string
	    private Cookie getSessionCookieActual(final Request request) {
	        if (request.raw().getCookies() == null) {
	            return null;
	        }
	        for (Cookie cookie : request.raw().getCookies()) {
	            if (cookie.getName().equals("userSession")) {
	                return cookie;
	            }
	        }
	        return null;
	    }
	    private Cookie getSessionCookieActualOwner(final Request request) {
	        if (request.raw().getCookies() == null) {
	            return null;
	        }
	        for (Cookie cookie : request.raw().getCookies()) {
	            if (cookie.getName().equals("session")) {
	                return cookie;
	            }
	        }
	        return null;
	    }
	    private Cookie getSessionCookieActualAdmin(final Request request) {
	        if (request.raw().getCookies() == null) {
	            return null;
	        }
	        for (Cookie cookie : request.raw().getCookies()) {
	            if (cookie.getName().equals("adminSession")) {
	                return cookie;
	            }
	        }
	        return null;
	    }

	 public boolean validateSignup(String username,String fname,String lname, String password, String verify, String email, String mo,
             HashMap<String, String> errors) {
		 String USER_RE = "^[a-zA-Z0-9_-]{1,20}$";
		 String PASS_RE = "^.{3,20}$";
		 String EMAIL_RE = "^[\\S]+@[\\S]+\\.[\\S]+$";
		 String MO_RE ="\\+?\\d[\\d -]{8,12}\\d$";
		 errors.put("name_error", "");
		 errors.put("password_error", "");
		 errors.put("verify_error", "");
		 errors.put("email_error", "");
		 errors.put("mo_error", "");
		 errors.put("fname_error", "");
		 errors.put("lname_error", "");

		 if (!username.matches(USER_RE)) {
			 errors.put("name_error", "invalid username. try just letters and numbers");
			 return false;
		 }
		 
		 if (!password.matches(PASS_RE)) {
			 errors.put("password_error","invalid password");
			 return false;
		 }
		 if (!password.equals(verify)) {
			 errors.put("verify_error", "password must match");
			 return false;
		 }
		 if (!email.equals("")) {
		 if (!mo.matches(MO_RE) ) {
			 errors.put("mo_error", "Invalid mobile number");
			 return false;
		 }
		 }
		 if(fname.equals(""))
		 { errors.put("fname_error","firstname can not be empty"); return false;}
		 if(lname.equals(""))
		 { errors.put("lname_error","lastname can not be empty"); return false;}
		 
		 if (!email.equals("")) {
			 if (!email.matches(EMAIL_RE)) {
				 errors.put("email_error", "Invalid Email Address");
				 return false;
			 }
		 }
		 return true;
	 }
}