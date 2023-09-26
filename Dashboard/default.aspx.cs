using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabManagement.Dashboard
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ConnectionString);
            tItem.Text = loadkar("SELECT COUNT(*) FROM Tbl_Items");
            cItem.Text = loadkar("SELECT COUNT(*) FROM Tbl_Items");
            tLowStock.Text = loadkar("SELECT COUNT(*) FROM Tbl_Items");
            tExpored.Text = loadkar("SELECT COUNT(*) FROM Tbl_Items");

        }

        protected String loadkar(String txt)
        {
            string rst;
            conn.Open();
            SqlCommand cmd = new SqlCommand(txt, conn);
            rst = Convert.ToString(cmd.ExecuteScalar());
            conn.Close();
            return rst;
        }
    }
}