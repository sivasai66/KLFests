<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javax.sql.*, java.util.Date, java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
      integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
      crossorigin="anonymous"
    />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
    integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" href="./profile.css" />
    <title>KLU Fests</title>
  </head>
  <body>
    <header>
      <a href="./main.html" class="logo"
        ><img src="./images/logo2.png" alt="KL Fests"
      /></a>
      <ul class="mynav">
        <li class="li">
          <a href="./main.jsp">Home</a>
        </li>
        <li class="li"><a href="./fest.jsp">Fest Registration</a></li>
        <li class="li"><a href="./team.jsp">Our Team</a></li>
        <% if(session.getAttribute("email") == null) {
        	%>
	        <li class="li" id="login">
	          <a href="./login.jsp">Log in</a>
	        </li>
	        <li class="li" id="signup">
	          <a href="./register.jsp" action="logout">Sign Up</a>
	        </li>
        <%
        response.sendRedirect("login.jsp");
        }
        else {
        	if(session.getAttribute("role") == "admin") {
        		%>
        		<li class="li" id="AddFests">
		          <a href="./addfests.jsp">Add Fests</a>
		        </li>
		        <li class="li" id="AddFests">
		          <a href="./addevents.jsp">Add Events</a>
		        </li>
        		<%
        	}
        	%>
        
        <li class="li" id="account">
          <a href="#"
            >Account
            <span class="abhiborder">|</span>
            <i
              onclick="menutoggle()"
              class="fa fa-caret-down fa-lg angle"
              aria-hidden="true"
            ></i>
          </a>
          <div class="account-dropdown" id="">
            <ul>
              <li>
                <a href="#"> <i class="fa fa-user"></i> Profile </a>
              </li>
              <li>
                <a href="./settings.jsp"> <i class="fa fa-gear"></i> Settings </a>
              </li>
              <li>
                <span onclick="window.location.href='signout'" >
                  <i class="fa fa-sign-out"></i> Sign Out
                </span>
              </li>
            </ul>
          </div>
        </li>
        <% 
              }
              %>
      </ul>
    </header>
    
    <section class="profile">
    	<%
    	String Classname = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String username = "ep";
		String password = "ep";
    	Date d = new Date();
      	int year = 1900+d.getYear();
        try {
        	Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement userDetails;
            String email = session.getAttribute("email").toString();
            PreparedStatement festdetails, issueDetails, eventdetails;
            if(session.getAttribute("role") == "admin") {
            	userDetails = con.prepareStatement("select name, email from admins where email=?");
            	festdetails = con.prepareStatement("select * from festsregistered order by year DESC");
            	issueDetails = con.prepareStatement("select * from issue order by id DESC");
            	eventdetails = con.prepareStatement("select * from eventsregistered order by year DESC");
            }
            else {
            	userDetails = con.prepareStatement("select name, email from users where email=?");
            	festdetails = con.prepareStatement("select * from festsregistered where email=? order by year DESC");
            	eventdetails = con.prepareStatement("select * from eventsregistered where email=? order by year DESC");
            	issueDetails = con.prepareStatement("select * from issue where email=? order by id DESC");
                festdetails.setString(1, email);
                issueDetails.setString(1, email);
                eventdetails.setString(1, email);
            }
            userDetails.setString(1, email);
            ResultSet userset = userDetails.executeQuery();
            ResultSet issueSet = issueDetails.executeQuery();
            ResultSet festSet = festdetails.executeQuery();
            ResultSet eventSet = eventdetails.executeQuery();
            if(userset.next()) {
            	String name = userset.getString(1);
            	%>
            	<div class="detailsBox">
				    <div class="details">
				      <div class="userInfo">
				        <span class="name"><%=name %></span><br />
				        <span class="email"><%=email %></span>
			           </div>
				    </div>
				 </div>
            	<%
            }
    	%>
    	<div class="info">
    	<div class="userOrders"></div>
    	<div class="middle">
    	<div style="margin-top: 20px;">
    	<% if(session.getAttribute("role") == "admin") {
	            	%>
	            	<h2 style="text-align:center;color: #ffa500;fontweight: 700;">Users Registered Fests</h2>
	            	<% }
	      else {
	      %>
    		<h2 style="text-align:center;color: #ffa500;fontweight: 700;">Your Registered Fests</h2>
    		<%
    		}
    		%>
    	<table class="table table-striped table-hover">
	        <thead class="thead-dark">
	          <tr>
	            <th scope="col">ID</th>
	            <% if(session.getAttribute("role") == "admin") {
	            	%>
		            <th scope="col">Email</th>
	            <%
	            }
	            %>
	            <th scope="col">Fest Name</th>
	            <th scope="col">Mobile</th>
	            <th scope="col">Year</th>
	          </tr>
	        </thead>
	        <tbody>
	        <%
	        while(festSet.next()) {
            	int id = festSet.getInt(1);
            	String festname = festSet.getString(2);
            	String userEmail = festSet.getString(3);
            	String mobile = festSet.getString(4);
            	String registeredYear = festSet.getString(5);
	        %>
	          <tr class="myRow" scope="row">
	            <td><%=id %></td>
	            <% if(session.getAttribute("role") == "admin") {
	            	%>
		            <td><%=userEmail %></td>
	            <%
	            }
	            %>
	            <td><%=festname %></td>
	            <td><%=mobile %></td>
	            <td><%=registeredYear %></td>
	          </tr>
	          <%
	          }
	          %>
	        </tbody>
	      </table>
	      </div>
	      
	      <div style="margin-top: 5rem;margin-bottom: 5rem;">
    	<% if(session.getAttribute("role") == "admin") {
	            	%>
	            	<h2 style="text-align:center;color: #ffa500;fontweight: 700;">Users Registered Events</h2>
	            	<% }
	      else {
	      %>
    		<h2 style="text-align:center;color: #ffa500;fontweight: 700;">Your Registered Events</h2>
    		<%
    		}
    		%>
    	<table class="table table-striped table-hover">
	        <thead class="thead-dark">
	          <tr>
	            <th scope="col">ID</th>
	            <% if(session.getAttribute("role") == "admin") {
	            	%>
		            <th scope="col">Email</th>
	            <%
	            }
	            %>
	            <th scope="col">Fest Name</th>
	            <th scope="col">Event Name</th>
	            <th scope="col">Mobile</th>
	            <th scope="col">Year</th>
	          </tr>
	        </thead>
	        <tbody>
	        <%
	        while(eventSet.next()) {
            	int id = eventSet.getInt(1);
            	String festname = eventSet.getString(2);
            	String eventname = eventSet.getString(3);
            	String userEmail = eventSet.getString(5);
            	String mobile = eventSet.getString(6);
            	String registeredYear = eventSet.getString(7);
	        %>
	          <tr class="myRow" scope="row">
	            <td><%=id %></td>
	            <% if(session.getAttribute("role") == "admin") {
	            	%>
		            <td><%=userEmail %></td>
	            <%
	            }
	            %>
	            <td><%=festname %></td>
	            <td><%=eventname %></td>
	            <td><%=mobile %></td>
	            <td><%=registeredYear %></td>
	          </tr>
	          <%
	          }
	          %>
	        </tbody>
	      </table>
	      </div>
	      <div style="margin-top: 20px;">
	      <% if(session.getAttribute("role") == "admin") {
	            	%>
	            	<h2 style="text-align:center;color: #ffa500;fontweight: 700;">User Issues</h2>
	            	<% }
	      else {
	      %>
    		<h2 style="text-align:center;color: #ffa500;fontweight: 700;">Your Issues</h2>
    		<%
    		}
    		%>
	      <table class="table table-striped table-hover">
	        <thead class="thead-dark">
	          <tr>
	            <th scope="col">ID</th>
	            <% if(session.getAttribute("role") == "admin") {
	            	%>
		            <th scope="col">Name</th>
		            <th scope="col">Email</th>
	            <%
	            }
	            %>
	            <th scope="col">Subject</th>
	            <th scope="col">Message</th>
		        <th scope="col">Status</th>
	          </tr>
	        </thead>
	        <tbody>
	        <%
	        while(issueSet.next()) {
            	int id = issueSet.getInt(1);
            	String userName = issueSet.getString(2);
            	String userEmail = issueSet.getString(3);
            	String subject = issueSet.getString(4);
            	String message = issueSet.getString(5);
            	String status = issueSet.getString(6);
	        %>
	          <tr class="myRow" scope="row">
	            <td><%=id %></td>
	            <% if(session.getAttribute("role") == "admin") {
	            	%>
		            <td><%=userName %></td>
		            <td><%=userEmail %></td>
	            <%
	            }
	            %>
	            <td><%=subject%></td>
	            <td><%=message %></td>
		        <td><%=status %></td>
	          </tr>
	          <%
	          }
	          %>
	        </tbody>
	      </table>
	      </div>
	      </div>
	      <div class="totalOrders"></div>
	    </div>
    	<%
            con.close();
        }
        catch(Exception e) {
        	out.println(e);
        }
        %>
    </section>
    <script type="text/javascript">
	   function menutoggle() {
	       try {
	         const togglemenu = document.querySelector(".account-dropdown");
	         togglemenu.classList.toggle("active");
	       } catch (error) {
	         console.log(error);
	       }
	     }
    </script>
</body>
</html>