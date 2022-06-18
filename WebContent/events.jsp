<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javax.sql.*, java.util.Date, java.sql.*, java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Fests</title>
</head>
<body>

</body>
</html><meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./events.css" />
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
      integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
      crossorigin="anonymous"
    />
    <title>KLU Fests</title>
  </head>
  <body>
  <%
  if(session.getAttribute("email") == null) {
	  response.sendRedirect("login.jsp");
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
        <%
        if(session.getAttribute("role") == "admin") {
        %>
        <li class="li" id="AddFests">
			<a href="#">Add Fests</a>
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
        
      </ul>
    </header>
    <!-- Login Form Starts -->
    <section class="">
    <div class="fests">
      <div class="fests-boxes">
      <%
      	String Classname = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String username = "ep";
		String password = "ep";
		
		//String name = request.getParameter("name");
		String festname = request.getParameter("festname");
		if(festname == null) {
			response.sendRedirect("main.jsp");
		}
		Date d = new Date();
      	int year = 1900+d.getYear();
        try {
    		Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement festdetails = con.prepareStatement("select eventname, id, EVENTDATE, EVENTTIME from eventsdetails where festname=? and year=?");
            festdetails.setString(1, festname);
            festdetails.setInt(2, year);
            ResultSet festSet = festdetails.executeQuery();
            while(festSet.next()) {
            	int id = festSet.getInt(2);
            	String eventname = festSet.getString(1);
            	String path = "eventpic.jsp?eventid="+id;
            	String anctag = "eventinfo.jsp?eventname="+eventname;
            	String act = "registerevents.jsp?eventid="+id;
            %>
            <div>
            <a href=<%=act %>>
              <div class="fest-box">
                <div class="fest-double-box">
                  <h2><%= eventname%></h2>
                  <img
                    style="width: 386px; height: 250px"
                    src=<%=path %>
                    alt=""
                  />
                  <p class="fest-details">
                    <%=festSet.getString(3) %>
                  <br>
                  <a href=<%=act %> style="z-index: 1000;">Register Now</a>
                  </p>
                </div>
              </div>
            </a>
            <br />
            </div>
            <%
            }
            con.close();
        }
        catch(Exception e) {
        }
        %>
	        </div>
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