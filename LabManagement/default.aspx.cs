using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabManagement
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // This is just an example, replace with your actual authentication logic
            string username = Request.Form["username"];
            string password = Request.Form["password"];

            // Hardcoded credentials for demo purposes
            string hardcodedUsername = "admin";
            string hardcodedPassword = "password";

            if (username == hardcodedUsername && password == hardcodedPassword)
            {
                // Authentication successful
                // Redirect to the dashboard or perform any necessary actions
                Response.Redirect("~/Dashboard/"); // Replace with your dashboard URL
            }
            else
            {
                // Authentication failed
                // You can display an error message or handle it according to your application's requirements
                Response.Write("<script>alert('Invalid credentials. Please try again.');</script>");
            }
        }
    }
}