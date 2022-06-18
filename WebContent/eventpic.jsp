<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="javax.sql.*, java.util.Date, java.sql.*, java.io.*" %>
<%      //Date d = new Date();
      	//int year = 1900+d.getYear();
      	
      	int id = Integer.parseInt(request.getParameter("eventid"));
        try {
        	Date d = new Date();
        	int year = 1900 + d.getYear();
        	String Classname = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@localhost:1521:XE";
			String username = "ep";
			String password = "ep";
    		Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement festdetails = con.prepareStatement("select EVENTPIC, EVENTDATE, EVENTTIME from eventsdetails where id=? ");
            festdetails.setInt(1, id);
            ResultSet festSet = festdetails.executeQuery();
            Blob image = null;
            byte[] imgData = null;
            if(festSet.next()) {
            	image = festSet.getBlob(1);
            	imgData = image.getBytes(1,(int)image.length());
                response.setContentType("image/jpg");
                OutputStream o = response.getOutputStream();
                o.write(imgData);
                o.flush();
                o.close();
              }
              else 
				{
				out.println("Display Blob Example");
				out.println("image not found for given ID");
				return;
				}
            con.close();
           }
           catch(Exception e) {
           }
%>