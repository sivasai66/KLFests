import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/registerEvent")
public class EventRegistrationServlet extends HttpServlet {
//	String MySQL_Classname = "com.mysql.jdbc.Driver";
//	String MySQL_url = "jdbc:mysql://localhost:3306/epproject";
//	String MySQL_username = "ep";
//	String MySQL_password = "ep";
	/*
	 eventsregistered Table:
	 1. FESTNAME
	 2. EVENTNAME
	 3. EMAIL
	 4. MOBILE
	 5. YEAR
	  */
	String Classname = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String username = "ep";
	String password = "ep";
	
	public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
		HttpSession session=req.getSession();
		String email = (String)session.getAttribute("email");
//		String eid = (String)session.getAttribute("eventid");
		String eid = req.getParameter("eventid");
		int eventid = Integer.parseInt(eid);
		String mob = (String)req.getParameter("mob");
		Date d = new Date();
		int year = 1900+d.getYear();
		
		try {
			Connection con = null;
			Class.forName(Classname);
			con = DriverManager.getConnection(url, username, password);
			PreparedStatement pstmt1 = con.prepareStatement("insert into eventsregistered values(EVENTREGNO.nextval,?,?,?,?,?,?)");
			PreparedStatement pstmt2 = con.prepareStatement("select * from eventsregistered where eventid=? and email=?");
			PreparedStatement pstmt3 = con.prepareStatement("select festname,eventname from eventsdetails where id=?");
			pstmt3.setString(1, eid);
			ResultSet eventSet = pstmt3.executeQuery();
			String festname = "", eventname = "";
			if(eventSet.next()) {
				festname = eventSet.getString(1);
				eventname = eventSet.getString(2);
			}
			
			pstmt1.setString(1, festname);
			pstmt1.setString(2, eventname);
			pstmt1.setInt(3, eventid);
			pstmt1.setString(4, email);
			pstmt1.setString(5, mob);
			pstmt1.setInt(6, year);
			
			pstmt2.setInt(1, eventid);
			pstmt2.setString(2, email);
			
			ResultSet rs = pstmt2.executeQuery();
			PrintWriter out = res.getWriter();
			if(!rs.next()) {
				int n = pstmt1.executeUpdate();
				if(n > 0) {
					RequestDispatcher rd = req.getRequestDispatcher("main.jsp");
					rd.include(req, res);
					out.println("<script>alert('Event Registered Successfully')</script>");
				}
				else {
					RequestDispatcher rd = req.getRequestDispatcher("main.jsp");
					rd.include(req, res);
					out.println("<script>alert('Event Registration Failed')</script>");
				}
			}
			else {
				RequestDispatcher rd = req.getRequestDispatcher("main.jsp");
				rd.include(req, res);
				String EventName = eventname.substring(0, 1).toUpperCase() + eventname.substring(1);
				out.println("<script>alert('Already Registered For "+ EventName +" Event')</script>");
			}
			con.close();
		}
		catch(Exception e) {
			PrintWriter out = res.getWriter();
			out.println(e);
		}
	}
}
