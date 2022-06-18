import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
//	String Classname = "com.mysql.jdbc.Driver";
//	String url = "jdbc:mysql://localhost:3306/epproject";
//	String username = "root";
//	String password = "abhinav";
	
	String Classname = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String username = "ep";
	String password = "ep";
	
	public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		String email = req.getParameter("email");
		String pwd = req.getParameter("pwd");
		try {
			Connection con = null;
			Class.forName(Classname);
			con = DriverManager.getConnection(url, username, password);
			PreparedStatement pstmt = con.prepareStatement("select * from users where email=? and  password=?");
			pstmt.setString(1, email);
			PrintWriter out = res.getWriter();
			pstmt.setString(2, pwd);
			HttpSession session=req.getSession();
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
              session.setAttribute("email", email);
              session.setAttribute("role", "user");
              session.setAttribute("name", rs.getString(1));
              con.close();
              res.sendRedirect("main.jsp");
            }
            else {
            	con.close();
            	RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
            	rd.include(req, res);
            	out.println("<script>alert('Email Or password Is Incorrect')</script>");
            }
		}
		catch(Exception e) {
			System.out.println(e);
			res.sendRedirect("login.jsp");
		}
	}
}