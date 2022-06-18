import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/addEvents")
public class AddEventsServlet extends HttpServlet {
//	String Classname = "com.mysql.jdbc.Driver";
//	String url = "jdbc:mysql://localhost:3306/epproject";
//	String username = "root";
//	String password = "abhinav";
	
	String Classname = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String username = "ep";
	String password = "ep";
	
	
	public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();
		try {
			Connection con = null;
			Class.forName(Classname);
			con = DriverManager.getConnection(url, username, password);
			/*
			 eventsdetails Table:
			 1. FESTNAME
			 2. EVENTNAME
			 3. EVENTPIC
			 4. ORGANIZEDBY
			 5. EVENTDATE
			 6. EVENTTIME
			 7. DESCRIPTION
			*/
			String path1 = "D:\\Images\\";
			String insert = "insert into eventsdetails values(EVENTNO.nextval,?,?,?,?,?,?,?,?)";
			String select = "select festname, eventname, description, year from eventsdetails where FESTNAME=? and EVENTNAME=? and year=?";
			PreparedStatement pstmt = con.prepareStatement(insert);
			PreparedStatement pstmt2 = con.prepareStatement(select);
			
			String festname = req.getParameter("festName").toLowerCase();
			String eventname = req.getParameter("eventName").toLowerCase();
			String imagepath = req.getParameter("eventImg");
			String organisedby = req.getParameter("organisedBy");
			String eventdate = req.getParameter("date");
			String eventtime = req.getParameter("time");
			String description = req.getParameter("desc");
			
			String path=path1+imagepath;
			File imagefile=new File(path);
			FileInputStream fis=new FileInputStream(imagefile);
			
			//---------------------------------------------------
			
			Date d = new Date();
			int year = 1900+d.getYear();
			
			//------------------------------------------------
			
			pstmt.setString(1, festname);
			pstmt.setString(2, eventname);
			pstmt.setBinaryStream(3, (InputStream)fis, (int)(imagefile.length()));
//			pstmt.setBlob(2, null);
			pstmt.setString(4, organisedby);
			pstmt.setString(5, eventdate);
			pstmt.setString(6, eventtime);
			pstmt.setString(7, description);
			pstmt.setInt(8, year);
			
			pstmt2.setString(1, festname);
			pstmt2.setString(2, eventname);
			pstmt2.setInt(3, year);
			
			ResultSet rs = pstmt2.executeQuery();
			if(!rs.next()) {
				int n = pstmt.executeUpdate();
				if(n > 0) {
					RequestDispatcher rd = req.getRequestDispatcher("addevents.jsp");
					rd.include(req, res);
					out.println("<script>alert('Event Added Successfully')</script>");
	            }
				else {
					RequestDispatcher rd = req.getRequestDispatcher("addevents.jsp");
					rd.include(req, res);
					out.println("<script>alert('Error Adding The Event Details')</script>");
	            }
			}
            else {
              RequestDispatcher rd = req.getRequestDispatcher("addevents.jsp");
              rd.include(req, res);
              out.println("<script>alert('Event Already Added')</script>");
            }
		}
		catch(Exception e) {
			out.println(e);
		}
	}
}
