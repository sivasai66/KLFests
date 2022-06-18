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
import javax.servlet.http.HttpSession;


@WebServlet("/issues")
public class AddIssuesServlet extends HttpServlet {
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
			 FestDetails issue:
			 1. id
			 2. name
			 3. email
			 4. subject
			 5. message
			 6. status
			*/
			String insert = "insert into issue values(issues.nextval,?,?,?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(insert);
			HttpSession session=req.getSession();
			
			String name, email;
			if(session.getAttribute("email") == null) {
				name = req.getParameter("name");
				email = req.getParameter("email");
			}
			else {
				email = (String)session.getAttribute("email");
				name = (String)session.getAttribute("name");
			}
			String sub = req.getParameter("subject");
			String msg = req.getParameter("message");
			
			pstmt.setString(1, name);
			pstmt.setString(2, email);
//			pstmt.setBlob(2, null);
			pstmt.setString(3, sub);
			pstmt.setString(4, msg);
			String status = "pending";
			pstmt.setString(5, status);
			
			int n = pstmt.executeUpdate();
			if(n > 0) {
				RequestDispatcher rd = req.getRequestDispatcher("contact.jsp");
				rd.include(req, res);
				out.println("<script>alert('Issue Registered Successfully')</script>");
            }
			else {
				RequestDispatcher rd = req.getRequestDispatcher("contact.jsp");
				rd.include(req, res);
				out.println("<script>alert('Error Registering The Issue')</script>");
            }
		}
		catch(Exception e) {
			out.println(e);
		}
	}
}
