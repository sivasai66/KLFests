<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javax.sql.*, java.util.Date, java.sql.*, java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>KLU Fests</title>
</head>
<body>
<%
	String name = request.getParameter("name");
	if(name != null) {
		String Classname = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String username = "ep";
		String password = "ep";
	  		try {
	  		Connection con = null;
    		Class.forName(Classname);
    		con = DriverManager.getConnection(url, username, password);
    		Date d = new Date();
    		int year = d.getYear()+1900;
		    PreparedStatement infostmt = con.prepareStatement("select * from festdetails where name=? and year=?");
		    infostmt.setString(1, name);
		    infostmt.setInt(2, year);
			ResultSet infoSet = infostmt.executeQuery();
			if(infoSet.next())
			{
				String path="festimg.jsp?festid="+infoSet.getString(1);
			 %>
			 <h1>Name: <%=infoSet.getString(1)%></h1>
			 <img src=<%=path%> />
			 <h3>Tag Line: <%=infoSet.getString(4) %></h3>
			 <h4>Description: <%=infoSet.getString(5) %></h4>
			 <%
			}
			con.close();
		}
		catch(Exception e) {
			%>
			<h1
			align="center"
			style = "color: red"
			>Data Not Found Error</h1>
			
			<a href="main.jsp">Go to Main Page</a>
			<%
		}
	}
	else {
		response.sendRedirect("main.jsp");
	}
%>
</body>
</html>