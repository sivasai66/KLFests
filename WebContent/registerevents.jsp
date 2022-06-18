<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javax.sql.*, java.util.Date, java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./registerevents.css" />
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
      integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
      crossorigin="anonymous"
    />
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
        	if(session.getAttribute("role") == "admin")
        	{
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
            <span class="border">|</span>
            <i
              onclick="menutoggle()"
              class="fa fa-caret-down fa-lg angle"
              aria-hidden="true"
            ></i>
          </a>
          <div class="account-dropdown" id="">
            <ul>
              <li>
                <a href="./profile.jsp"> <i class="fa fa-user"></i> Profile </a>
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
    <!-- Fest Registration Form Starts Starts -->
    <section class="loginForm">
      <div class="logBox">
        <h3 class="logTitle">We're Happy To invite You</h3>
        <br />
        <%
        	String eid = request.getParameter("eventid");
        	if(eid!=null) {
            	int eventid = Integer.parseInt(eid);
        		String Classname = "oracle.jdbc.driver.OracleDriver";
	        	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	        	String username = "ep";
	        	String password = "ep";
    		  	Connection con = null;
        		Class.forName(Classname);
        		con = DriverManager.getConnection(url, username, password);
			    PreparedStatement searchstmt = con.prepareStatement("select eventname, festname from eventsdetails where id=?");
			    searchstmt.setInt(1, eventid);
			    ResultSet eventdetail = searchstmt.executeQuery();
			    if(eventdetail.next()) {
			    	session.setAttribute("eventid", eid);
				    String eventname = eventdetail.getString(1);
				    String festname = eventdetail.getString(2);
        		%>
        		<form
	                method="post"
	                action="registerEvent"
	                onsubmit="return festValidate()"
	                name="log"
	                class="logForm"
              	>
                <label for="festname">Fest Name<span class="req">*</span></label>
                <input
                  type="text"
                  name="festname"
                  id="festname"
                  style="background: white;"
                  value= " <%=festname %> "
                  disabled
                />
              	  <label for="eventname">Event Name<span class="req">*</span></label>
                  <input
                    type="text"
                    name="eventname"
                    id="eventname"
                    style="background: white;"
                    value="<%=eventname %>"
                    disabled
                  />
                 <label hidden for="eventid">Event Id<span class="req">*</span></label>
                 <input
                   type="text"
                   name="eventid"
                   id="eventid"
                   style="background: white;"
                   value=<%=eid %>
                   hidden
                 />
                <label for="mob">Mobile Number<span class="req">*</span></label>
                <input
                  type="number"
                  name="mob"
                  id="mob"
                  placeholder="Enter Mobile Number"
                  required="required"
                />
                <div class="submitbtn">
                  <input type="submit" value="Register" />
                </div>
              </form>
        		<%
			    }
			    else {
			    	response.sendRedirect("main.jsp");
			    }
			    con.close();
        	}
        	else {
        		response.sendRedirect("main.jsp");
        	}
          %>
      </div>
    </section>
    <script type="text/javascript">
			
		/* ------------------------------- Menu Toggle Start ------------------------------- */
		
		function menutoggle() {
		  try {
		    const togglemenu = document.querySelector(".account-dropdown");
		    togglemenu.classList.toggle("active");
		  } catch (error) {
		    console.log(error);
		  }
		}
		
		/* ------------------------------- Menu Toggle End ------------------------------- */
		function festValidate() {
			var mob = document.getElementById("mob").value;
			var phoneno = /^\d{10}$/;
			if(mob.match(phoneno)) {
				return true;
			}
			alert("Enter Valid Mobile Number");
			return false;
		}
		
      </script>
  </body>
</html>