using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Reflection;
using System.Security.Cryptography;
using System.Xml.Linq;

namespace LabManagement.Dashboard
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["strcon"].ConnectionString);
        }

        protected void insertData(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Tbl_Categories(name, description, lastUpdate) VALUES (@name, @dec, @date)", conn);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@name", cName.Text);
                cmd.Parameters.AddWithValue("@dec", cDec.Text);
                cmd.Parameters.AddWithValue("@date", DateTime.Now.ToString());
                conn.Open();
                int k = cmd.ExecuteNonQuery();
                if (k != 0)
                {
                    Response.Redirect("Categories.aspx");
                }
                conn.Close();

            }
            catch (Exception ex)
            {
            }
        }

        protected void gridview_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}