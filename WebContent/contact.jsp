<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
      integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
      crossorigin="anonymous"
    />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
    integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.1.1/css/mdb.css" integrity="sha512-mL6Qcv5J1HdxKyFqlpXXeJN8kbqlbBG7yJO4DXpDJN0Ecg2qo8Z8bZIMn0z34a83k+3/P0RqqkIpCA0cmlCVOA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    
    
    
    
    <link rel="stylesheet" href="./contact.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.1.1/js/mdb.js" integrity="sha512-DIF8gOgn95Ru8xHhPVd/f5QpSAu7mk1SXga7JLj2A++B0fT6OdBY+s3+ScpytzziLlAFjaKp6PXbSVDSINwqHQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
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
        <li class="li"><a href="#">Fest Registration</a></li>
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
        }
        else {
        	%>
        
        <li class="li" id="account">
          <a href="#"
            >Account
            <span class="abhiborder">|</span>
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
    <section class="abhiSection">
	    <section class="mb-4">
	
		    <!--Section heading-->
		    <h2 class="h1-responsive font-weight-bold text-center my-4">Contact us</h2>
		    <!--Section description-->
		    <p class="text-center w-responsive mx-auto mb-5">Do you have any questions? Please do not hesitate to contact us directly. Our team will come back to you within
		        a matter of hours to help you.</p>
		
		    <div class="row">
		
		        <!--Grid column-->
		        <div class="col-md-9 mb-md-0 mb-5">
		            <form id="contact-form" name="contact-form" action="issues" method="POST">
		                <!--Grid row-->
		                <div class="row">
		
		                    <!--Grid column-->
		                    <div class="col-md-6">
		                        <div class="md-form mb-0">
		                        	<% if(session.getAttribute("email") == null) {
        							%>
			                            <input type="text" style="color:#fff;" required placeholder="Your name" id="name" name="name" class="form-control">
			                            <%
			                            }
			                        else {
			                        	String name = session.getAttribute("name").toString();
			                        	%>
			                        	<input type="text" style="color:#fff;" required placeholder="Your name" id="name" value="<%=name %>" name="name" class="form-control">
			                        	<%
			                        }
			                        %>
		                        </div>
		                    </div>
		                    <!--Grid column-->
		
		                    <!--Grid column-->
		                    <div class="col-md-6">
		                        <div class="md-form mb-0">
		                        <% if(session.getAttribute("email") == null) {
        							%>
		                            <input type="text" style="color:#fff;" id="email" required placeholder="Your Email" name="email" class="form-control">
		                            <%
		                            }
		                        else {
		                        	String email = session.getAttribute("email").toString();
		                        	%>
		                        	<input type="text" id="email" style="color:#fff;" required placeholder="Your Email" name="email" value="<%=email %>" class="form-control">
		                        	<%
		                        }
		                            %>
		                        </div>
		                    </div>
		                    <!--Grid column-->
		
		                </div>
		                <!--Grid row-->
		
		                <!--Grid row-->
		                <div class="row">
		                    <div class="col-md-12">
		                        <div class="md-form mb-0">
		                            <input type="text" style="color:#fff;" required id="subject" placeholder="Subject" name="subject" class="form-control">
		                        </div>
		                    </div>
		                </div>
		                <!--Grid row-->
		
		                <!--Grid row-->
		                <div class="row">
		
		                    <!--Grid column-->
		                    <div class="col-md-12">
		
		                        <div class="md-form">
		                            <textarea type="text" required id="message" placeholder="Your Message" name="message" rows="2" style="color:#fff;" class="form-control md-textarea"></textarea>
		                        </div>
		
		                    </div>
		                </div>
		                <!--Grid row-->
		                <div class="text-center text-md-left">
			                <input class="btn btn-primary" value="Send" type="submit">
			            </div>
		            </form>
		            <div class="status"></div>
		        </div>
		        <!--Grid column-->
		
		        <!--Grid column-->
		        <div class="col-md-3 text-center">
		            <ul class="list-unstyled mb-0">
		                <li><i class="fa fa-map-marker fa-2x"></i>
		                    <p>San Francisco, CA 94126, USA</p>
		                </li>
		
		                <li><i class="fa fa-phone mt-4 fa-2x"></i>
		                    <p><a href="tel:+91123456789" class="anchorHover" style="color:#fff;">+91 123456789</a></p>
		                </li>
		
		                <li><i class="fa fa-envelope mt-4 fa-2x"></i>
		                    <p><a href="mailto:klfests@outlook.com" class="anchorHover" style="color:#fff;">klfests@outlook.com</a></p>
		                </li>
		            </ul>
		        </div>
		        <!--Grid column-->
		
		    </div>
		
		</section>
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
