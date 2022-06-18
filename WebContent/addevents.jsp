<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javax.sql.*, java.util.Date, java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Fests</title>
</head>
<body>

</body>
</html><meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./addevents.css" />
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
      integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
      crossorigin="anonymous"
    />
    <title>KLU Fests</title>
  </head>
  <body>
  <% if(session.getAttribute("email") == null) {
	  response.sendRedirect("login.jsp");
  }
  else if(session.getAttribute("role") != "admin") {
	  response.sendRedirect("main.jsp");
  }
        	%>
    <header>
      <a href="./main.jsp" class="logo"
        ><img src="./images/logo2.png" alt="KL Fests"
      /></a>
      <ul class="mynav">
        <li class="li">
          <a href="./main.jsp">Home</a>
        </li>
        <li class="li"><a href="./fest.jsp">Fest Registration</a></li>
        <li class="li"><a href="./team.jsp">Our Team</a></li>
        <li class="li" id="AddFests">
			<a href="./addfests.jsp">Add Fests</a>
		</li>
		<li class="li" id="AddFests">
          <a href="#">Add Events</a>
        </li>
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
        
      </ul>
    </header>
    <!-- Login Form Starts -->
    <section class="loginForm">
      <div class="logBox">
        <h3 class="logTitle">Come Let's Add The Events</h3>
        <br />
        <form
          action="addEvents"
          onsubmit="return festValidate()"
          method="post"
          name="log"
          class="logForm"
        >
        <label for="festname">Select Fest</label>
          <select name="festName" id="fest">
          	  <option value="">Select</option>
          	  <%
		          	/*String MySQL_Classname = "com.mysql.jdbc.Driver";
		          	String MySQL_url = "jdbc:mysql://localhost:3306/epproject";
		          	String MySQL_username = "ep";
		          	String MySQL_password = "ep";*/
		          	String Classname = "oracle.jdbc.driver.OracleDriver";
		        	String url = "jdbc:oracle:thin:@localhost:1521:XE";
		        	String username = "ep";
		        	String password = "ep";
          	  		Connection con = null;
	        		Class.forName(Classname);
	        		con = DriverManager.getConnection(url, username, password);
				    PreparedStatement searchstmt = con.prepareStatement("select name from festdetails");
					ResultSet searchSet = searchstmt.executeQuery();
					while(searchSet.next())
					{
					 %>
					 <option value="<%=searchSet.getString(1)%>"><%=searchSet.getString(1)%></option>
					 <%
					}
					con.close();
				 %>
		  </select>
          
          
          <label for="email">Event Name</label>
          <input
            type="text"
            name="eventName"
            placeholder="Event Name"
            required="required"
          />
          <label for="pwd">Event Image</label>
          <input
            type="file"
            name="eventImg"
            required="required"
          />
          <label for="tagline">Event Organised By</label>
          <input
            type="text"
            name="organisedBy"
            placeholder="Enter The Club Name"
            required="required"
          />
          
          <label for="date">Event Date</label>
          <input
            type="date"
            name="date"
            placeholder="Enter The Event Date"
            required="required"
          />
          
          <label for="time">Event Time</label>
          <input
            type="time"
            name="time"
            placeholder="Enter The Event Time"
            required="required"
          />
          
          <label for="desc">Event Description</label>
          <textarea
            type="text"
            name="desc"
            placeholder="Description"
            required="required"
          ></textarea>
          <div class="content">
            <div class="submitbtn">
              <input type="submit" value="Add Event" />
            </div>
          </div>
        </form>
      </div>
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