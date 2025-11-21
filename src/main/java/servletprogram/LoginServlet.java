package servletprogram;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet {
	
//	public void service(HttpServletRequest req, HttpServletResponse res) {
//		
//		
//	}
	public void doPost(HttpServletRequest req ,HttpServletResponse res) throws ServletException, IOException {
		
		String fname= req.getParameter("fname");
		String lname = req.getParameter("lname");
		
		 System.out.println("Received First Name: " + fname);
		    System.out.println("Received Last Name: " + lname);
		    
		
		req.setAttribute("fname",fname);
		req.setAttribute("lname", lname);
		
		  req.getRequestDispatcher("result.jsp").include(req, res);
		
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
		
		PrintWriter pw=res.getWriter();
		pw.println("Kiran");
	}

}
